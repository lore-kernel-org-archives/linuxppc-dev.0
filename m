Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id BEC2DB70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 17/27] KVM: PPC: KVM PV guest stubs
Date: Thu, 29 Jul 2010 14:47:58 +0200
Message-Id: <1280407688-9815-18-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will soon start and replace instructions from the text section with
other, paravirtualized versions. To ease the readability of those patches
I split out the generic looping and magic page mapping code out.

This patch still only contains stubs. But at least it loops through the
text section :).

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - kvm guest patch framework: introduce patch_ins

v2 -> v3:

  - add self-test in guest code
  - remove superfluous new lines in generic guest code
---
 arch/powerpc/kernel/kvm.c |   95 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index a5ece71..e93366f 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -33,6 +33,62 @@
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
 
+#define KVM_MASK_RT		0x03e00000
+
+static bool kvm_patching_worked = true;
+
+static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
+{
+	*inst = new_inst;
+	flush_icache_range((ulong)inst, (ulong)inst + 4);
+}
+
+static void kvm_map_magic_page(void *data)
+{
+	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
+		       KVM_MAGIC_PAGE,  /* Physical Address */
+		       KVM_MAGIC_PAGE); /* Effective Address */
+}
+
+static void kvm_check_ins(u32 *inst)
+{
+	u32 _inst = *inst;
+	u32 inst_no_rt = _inst & ~KVM_MASK_RT;
+	u32 inst_rt = _inst & KVM_MASK_RT;
+
+	switch (inst_no_rt) {
+	}
+
+	switch (_inst) {
+	}
+}
+
+static void kvm_use_magic_page(void)
+{
+	u32 *p;
+	u32 *start, *end;
+	u32 tmp;
+
+	/* Tell the host to map the magic page to -4096 on all CPUs */
+	on_each_cpu(kvm_map_magic_page, NULL, 1);
+
+	/* Quick self-test to see if the mapping works */
+	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
+		kvm_patching_worked = false;
+		return;
+	}
+
+	/* Now loop through all code and find instructions */
+	start = (void*)_stext;
+	end = (void*)_etext;
+
+	for (p = start; p < end; p++)
+		kvm_check_ins(p);
+
+	printk(KERN_INFO "KVM: Live patching for a fast VM %s\n",
+			 kvm_patching_worked ? "worked" : "failed");
+}
+
 unsigned long kvm_hypercall(unsigned long *in,
 			    unsigned long *out,
 			    unsigned long nr)
@@ -69,3 +125,42 @@ unsigned long kvm_hypercall(unsigned long *in,
 	return r3;
 }
 EXPORT_SYMBOL_GPL(kvm_hypercall);
+
+static int kvm_para_setup(void)
+{
+	extern u32 kvm_hypercall_start;
+	struct device_node *hyper_node;
+	u32 *insts;
+	int len, i;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	if (!hyper_node)
+		return -1;
+
+	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);
+	if (len % 4)
+		return -1;
+	if (len > (4 * 4))
+		return -1;
+
+	for (i = 0; i < (len / 4); i++)
+		kvm_patch_ins(&(&kvm_hypercall_start)[i], insts[i]);
+
+	return 0;
+}
+
+static int __init kvm_guest_init(void)
+{
+	if (!kvm_para_available())
+		return 0;
+
+	if (kvm_para_setup())
+		return 0;
+
+	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
+		kvm_use_magic_page();
+
+	return 0;
+}
+
+postcore_initcall(kvm_guest_init);
-- 
1.6.0.2
