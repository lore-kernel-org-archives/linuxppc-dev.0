Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG68k68D2zDqtT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 20:21:42 +1100 (AEDT)
Date: Tue, 9 Jan 2018 20:21:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH v2] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
Message-ID: <20180109092120.GC19326@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds three new capabilities that give userspace information about
the underlying machine's level of vulnerability to the Meltdown and
Spectre attacks, and what instructions the hardware implements to
assist software to work around the vulnerabilities.

Each capability is a tri-state, where 0 indicates that the machine is
vulnerable and no workarounds are implement, 1 indicates that the
machine is vulnerable but workaround assist instructions are
available, and 2 indicates that the machine is not vulnerable.

The capabilities are:

KVM_CAP_PPC_SAFE_CACHE reports the vulnerability of the machine to
attacks based on using speculative loads to data in L1 cache which
should not be addressable.  The workaround provided by hardware is an
instruction to invalidate the entire L1 data cache.

KVM_CAP_PPC_SAFE_BOUNDS_CHECK reports the vulnerability of the machine
to attacks based on using speculative loads behind mispredicted bounds
checks.  The workaround provided by hardware is an instruction that
acts as a speculation barrier.

KVM_CAP_PPC_SAFE_INDIRECT_BRANCH reports the vulnerability of the
machine to attacks based on poisoning the indirect branch predictor.
No workaround that requires software changes is provided; the current
hardware fix is to prevent speculation past indirect branches.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
Note: This patch depends on the patch "powerpc/pseries: Add
H_GET_CPU_CHARACTERISTICS flags & wrapper" by Michael Ellerman,
available at http://patchwork.ozlabs.org/patch/856914/ .

 Documentation/virtual/kvm/api.txt |  35 +++++++
 arch/powerpc/kvm/powerpc.c        | 202 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |   3 +
 3 files changed, 240 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 57d3ee9..7107e52 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4369,3 +4369,38 @@ Parameters: none
 This capability indicates if the flic device will be able to get/set the
 AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and allows
 to discover this without having to create a flic device.
+
+8.14 KVM_CAP_PPC_SAFE_CACHE
+
+Architectures: ppc
+
+This capability gives information about the underlying machine's
+vulnerability or otherwise to the Meltdown attack.  Its value is a
+tristate, where 0 indicates the machine is vulnerable, 1 indicates the
+hardware is vulnerable but provides assistance to work around the
+vulnerability (specifically by providing a fast L1 data cache flush
+facility), and 2 indicates that the machine is not vulnerable.
+
+8.15 KVM_CAP_PPC_SAFE_BOUNDS_CHECK
+
+Architectures: ppc
+
+This capability gives information about the underlying machine's
+vulnerability or otherwise to the bounds-check variant of the Spectre
+attack.  Its value is a tristate, where 0 indicates the machine is
+vulnerable, 1 indicates the hardware is vulnerable but provides
+assistance to work around the vulnerability (specifically by providing
+an instruction that acts as a speculation barrier), and 2 indicates
+that the machine is not vulnerable.
+
+8.16 KVM_CAP_PPC_SAFE_INDIRECT_BRANCH
+
+Architectures: ppc
+
+This capability gives information about the underlying machine's
+vulnerability or otherwise to the indirect branch variant of the Spectre
+attack.  Its value is a tristate, where 0 indicates the machine is
+vulnerable and 2 indicates that the machine is not vulnerable.
+(1 would indicate the availability of a workaround that software
+needs to implement, but there is currently no workaround that needs
+software changes.)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1915e86..bef76f8 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -39,6 +39,10 @@
 #include <asm/iommu.h>
 #include <asm/switch_to.h>
 #include <asm/xive.h>
+#ifdef CONFIG_PPC_PSERIES
+#include <asm/hvcall.h>
+#include <asm/plpar_wrappers.h>
+#endif
 
 #include "timing.h"
 #include "irq.h"
@@ -488,6 +492,193 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	module_put(kvm->arch.kvm_ops->owner);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * These functions check whether the underlying hardware is safe
+ * against the Meltdown/Spectre attacks and whether it supplies
+ * instructions for use in workarounds.  The information comes from
+ * firmware, either via the device tree on powernv platforms or
+ * from an hcall on pseries platforms.
+ *
+ * For check_safe_cache() and check_safe_bounds_check(), a return
+ * value of 0 means vulnerable, 1 means vulnerable but workaround
+ * instructions are provided, and 2 means not vulnerable (no workaround
+ * is needed).
+ * For check_safe_indirect_branch(), 0 means vulnerable and 2 means
+ * not vulnerable.
+ */
+static inline bool have_fw_feat(struct device_node *fw_features,
+				const char *state, const char *name)
+{
+	struct device_node *np;
+	bool r = false;
+
+	np = of_get_child_by_name(fw_features, name);
+	if (np) {
+		r = of_property_read_bool(np, state);
+		of_node_put(np);
+	}
+	return r;
+}
+
+#ifdef CONFIG_PPC_PSERIES
+static bool check_pseries_safe_cache(int *rp)
+{
+	struct h_cpu_char_result c;
+	unsigned long rc;
+	int r = 0;
+
+	if (!machine_is(pseries))
+		return false;
+
+	rc = plpar_get_cpu_characteristics(&c);
+	if (rc == H_SUCCESS) {
+		if (!(c.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+			r = 2;
+		else if ((c.character & H_CPU_CHAR_L1D_THREAD_PRIV) &&
+			 ((c.character & H_CPU_CHAR_L1D_FLUSH_ORI30) ||
+			  (c.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)))
+			r = 1;
+	}
+	*rp = r;
+	return true;
+}
+
+static bool check_pseries_safe_bounds_check(int *rp)
+{
+	struct h_cpu_char_result c;
+	unsigned long rc;
+	int r = 0;
+
+	if (!machine_is(pseries))
+		return false;
+
+	rc = plpar_get_cpu_characteristics(&c);
+	if (rc == H_SUCCESS) {
+		if (!(c.behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+			r = 2;
+		else if (c.character & H_CPU_CHAR_SPEC_BAR_ORI31)
+			r = 1;
+	}
+	*rp = r;
+	return true;
+}
+
+static bool check_pseries_safe_indirect_branch(int *rp)
+{
+	struct h_cpu_char_result c;
+	unsigned long rc;
+	int r = 0;
+
+	if (!machine_is(pseries))
+		return false;
+
+	rc = plpar_get_cpu_characteristics(&c);
+	if (rc == H_SUCCESS) {
+		if (c.character & H_CPU_CHAR_BCCTRL_SERIALISED)
+			r = 2;
+	}
+	*rp = r;
+	return true;
+}
+
+#else
+static bool check_pseries_safe_cache(int *rp)
+{
+	return false;
+}
+
+static bool check_pseries_safe_bounds_check(int *rp)
+{
+	return false;
+}
+
+static bool check_pseries_safe_indirect_branch(int *rp)
+{
+	return false;
+}
+#endif
+
+static int check_safe_cache(void)
+{
+	struct device_node *np, *fw_features;
+	int r = 0;
+
+	if (check_pseries_safe_cache(&r))
+		return r;
+
+	np = of_find_node_by_name(NULL, "ibm,opal");
+	if (np) {
+		fw_features = of_get_child_by_name(np, "fw-features");
+		of_node_put(np);
+		if (!fw_features)
+			return 0;
+		if (have_fw_feat(fw_features, "disabled",
+				 "needs-l1d-flush-msr-pr-0-to-1"))
+			r = 2;
+		else if (have_fw_feat(fw_features, "enabled",
+				      "fw-l1d-thread-split") &&
+			 (have_fw_feat(fw_features, "enabled",
+				       "inst-l1d-flush-trig2") ||
+			  have_fw_feat(fw_features, "enabled",
+				       "inst-l1d-flush-ori30,30,0")))
+			r = 1;
+		of_node_put(fw_features);
+	}
+
+	return r;
+}
+
+static int check_safe_bounds_check(void)
+{
+	struct device_node *np, *fw_features;
+	int r = 0;
+
+	if (check_pseries_safe_bounds_check(&r))
+		return r;
+
+	np = of_find_node_by_name(NULL, "ibm,opal");
+	if (np) {
+		fw_features = of_get_child_by_name(np, "fw-features");
+		of_node_put(np);
+		if (!fw_features)
+			return 0;
+		if (have_fw_feat(fw_features, "disabled",
+				 "needs-spec-barrier-for-bound-checks"))
+			r = 2;
+		else if (have_fw_feat(fw_features, "enabled",
+				      "inst-spec-barrier-ori31,31,0"))
+			r = 1;
+		of_node_put(fw_features);
+	}
+
+	return r;
+}
+
+static int check_safe_indirect_branch(void)
+{
+	struct device_node *np, *fw_features;
+	int r = 0;
+
+	if (check_pseries_safe_indirect_branch(&r))
+		return r;
+
+	np = of_find_node_by_name(NULL, "ibm,opal");
+	if (np) {
+		fw_features = of_get_child_by_name(np, "fw-features");
+		of_node_put(np);
+		if (!fw_features)
+			return 0;
+		if (have_fw_feat(fw_features, "enabled",
+				 "fw-bcctrl-serialized"))
+			r = 2;
+		of_node_put(fw_features);
+	}
+
+	return r;
+}
+#endif
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
@@ -646,6 +837,17 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = hv_enabled &&
 		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
 		break;
+#ifdef CONFIG_PPC_BOOK3S_64
+	case KVM_CAP_PPC_SAFE_CACHE:
+		r = check_safe_cache();
+		break;
+	case KVM_CAP_PPC_SAFE_BOUNDS_CHECK:
+		r = check_safe_bounds_check();
+		break;
+	case KVM_CAP_PPC_SAFE_INDIRECT_BRANCH:
+		r = check_safe_indirect_branch();
+		break;
+#endif
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 496e59a..0a480e9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,6 +932,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_PPC_SAFE_CACHE 151
+#define KVM_CAP_PPC_SAFE_BOUNDS_CHECK 152
+#define KVM_CAP_PPC_SAFE_INDIRECT_BRANCH 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
