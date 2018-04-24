Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VVPj6ZpqzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 14:16:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] powerpc/64s: Enable barrier_nospec based on firmware
 settings
Date: Tue, 24 Apr 2018 14:15:57 +1000
Message-Id: <20180424041559.32410-4-mpe@ellerman.id.au>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

Check what firmware told us and enable/disable the barrier_nospec as
appropriate.

We err on the side of enabling the barrier, as it's no-op on older
systems, see the comment for more detail.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h       |  1 +
 arch/powerpc/kernel/security.c         | 60 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c |  1 +
 arch/powerpc/platforms/pseries/setup.c |  1 +
 4 files changed, 63 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 4335cddc1cf2..aeb175e8a525 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,6 +52,7 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index b963eae0b0a0..d1b9639e5e24 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/seq_buf.h>
 
+#include <asm/debugfs.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
 
@@ -22,6 +23,65 @@ static void enable_barrier_nospec(bool enable)
 	do_barrier_nospec_fixups(enable);
 }
 
+void setup_barrier_nospec(void)
+{
+	bool enable;
+
+	/*
+	 * It would make sense to check SEC_FTR_SPEC_BAR_ORI31 below as well.
+	 * But there's a good reason not to. The two flags we check below are
+	 * both are enabled by default in the kernel, so if the hcall is not
+	 * functional they will be enabled.
+	 * On a system where the host firmware has been updated (so the ori
+	 * functions as a barrier), but on which the hypervisor (KVM/Qemu) has
+	 * not been updated, we would like to enable the barrier. Dropping the
+	 * check for SEC_FTR_SPEC_BAR_ORI31 achieves that. The only downside is
+	 * we potentially enable the barrier on systems where the host firmware
+	 * is not updated, but that's harmless as it's a no-op.
+	 */
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
+
+	enable_barrier_nospec(enable);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int barrier_nospec_set(void *data, u64 val)
+{
+	switch (val) {
+	case 0:
+	case 1:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!!val == !!barrier_nospec_enabled)
+		return 0;
+
+	enable_barrier_nospec(!!val);
+
+	return 0;
+}
+
+static int barrier_nospec_get(void *data, u64 *val)
+{
+	*val = barrier_nospec_enabled ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_barrier_nospec,
+			barrier_nospec_get, barrier_nospec_set, "%llu\n");
+
+static __init int barrier_nospec_debugfs_init(void)
+{
+	debugfs_create_file("barrier_nospec", 0600, powerpc_debugfs_root, NULL,
+			    &fops_barrier_nospec);
+	return 0;
+}
+device_initcall(barrier_nospec_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ef8c9ce53a61..e2ca5f77a55f 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -124,6 +124,7 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
+	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b55ad4286dc7..63b1f0d10ef0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -534,6 +534,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_barrier_nospec();
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.14.1
