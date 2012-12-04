Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09EDB2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 15:36:40 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 4 Dec 2012 14:33:40 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D22A12CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 15:36:30 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB44PZmk5505528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2012 15:25:35 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB44aUZw026986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2012 15:36:30 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Disable relocation on exceptions whenever PR KVM is
 active
Date: Tue,  4 Dec 2012 15:36:13 +1100
Message-Id: <1354595773-17921-1-git-send-email-imunsie@au1.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

For PR KVM we allow userspace to map 0xc000000000000000. Because
transitioning from userspace to the guest kernel may use the relocated
exception vectors we have to disable relocation on exceptions whenever
PR KVM is active as we cannot trust that address.

This issue does not apply to HV KVM, since changing from a guest to the
hypervisor will never use the relocated exception vectors.

Currently the hypervisor interface only allows us to toggle relocation
on exceptions on a partition wide scope, so we need to globally disable
relocation on exceptions when the first PR KVM instance is started and
only re-enable them when all PR KVM instances have been destroyed.

It's a bit heavy handed, but until the hypervisor gives us a lightweight
way to toggle relocation on exceptions on a single thread it's only real
option.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h      |    9 +++++++++
 arch/powerpc/kvm/book3s_pr.c           |   18 ++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |    8 +++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 0975e5c..4bc2c3d 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -395,6 +395,15 @@ static inline unsigned long cmo_get_page_size(void)
 {
 	return CMO_PageSize;
 }
+
+extern long pSeries_enable_reloc_on_exc(void);
+extern long pSeries_disable_reloc_on_exc(void);
+
+#else
+
+#define pSeries_enable_reloc_on_exc()  do {} while (0)
+#define pSeries_disable_reloc_on_exc() do {} while (0)
+
 #endif /* CONFIG_PPC_PSERIES */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 05c28f5..74e25cd3 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
+#include <asm/firmware.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
@@ -1192,12 +1193,21 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 {
 }
 
+static unsigned int kvm_global_user_count = 0;
+static DEFINE_SPINLOCK(kvm_global_user_count_lock);
+
 int kvmppc_core_init_vm(struct kvm *kvm)
 {
 #ifdef CONFIG_PPC64
 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
 #endif
 
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		spin_lock(&kvm_global_user_count_lock);
+		if (++kvm_global_user_count == 1)
+			pSeries_disable_reloc_on_exc();
+		spin_unlock(&kvm_global_user_count_lock);
+	}
 	return 0;
 }
 
@@ -1206,6 +1216,14 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 #ifdef CONFIG_PPC64
 	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
 #endif
+
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		spin_lock(&kvm_global_user_count_lock);
+		BUG_ON(kvm_global_user_count == 0);
+		if (--kvm_global_user_count == 0)
+			pSeries_enable_reloc_on_exc();
+		spin_unlock(&kvm_global_user_count_lock);
+	}
 }
 
 static int kvmppc_book3s_init(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ca55882..1890730 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -375,7 +375,7 @@ static void pSeries_idle(void)
  * to ever be a problem in practice we can move this into a kernel thread to
  * finish off the process later in boot.
  */
-static int __init pSeries_enable_reloc_on_exc(void)
+long pSeries_enable_reloc_on_exc(void)
 {
 	long rc;
 	unsigned int delay, total_delay = 0;
@@ -397,9 +397,9 @@ static int __init pSeries_enable_reloc_on_exc(void)
 		mdelay(delay);
 	}
 }
+EXPORT_SYMBOL(pSeries_enable_reloc_on_exc);
 
-#ifdef CONFIG_KEXEC
-static long pSeries_disable_reloc_on_exc(void)
+long pSeries_disable_reloc_on_exc(void)
 {
 	long rc;
 
@@ -410,7 +410,9 @@ static long pSeries_disable_reloc_on_exc(void)
 		mdelay(get_longbusy_msecs(rc));
 	}
 }
+EXPORT_SYMBOL(pSeries_disable_reloc_on_exc);
 
+#ifdef CONFIG_KEXEC
 static void pSeries_machine_kexec(struct kimage *image)
 {
 	long rc;
-- 
1.7.10.4
