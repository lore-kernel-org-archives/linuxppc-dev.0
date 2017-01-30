Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBln91RmJzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:05 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 01/20] powerpc/64: Don't try to use radix MMU under a
 hypervisor
Date: Mon, 30 Jan 2017 21:21:34 +1100
Message-Id: <1485771713-24801-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if the kernel is running on a POWER9 processor under a
hypervisor, it will try to use the radix MMU even though it doesn't
have the necessary code to use radix under a hypervisor (it doesn't
negotiate use of radix, and it doesn't do the H_REGISTER_PROC_TBL
hcall).  The result is that the guest kernel will crash when it tries
to turn on the MMU.

This fixes it by looking for the /chosen/ibm,architecture-vec-5
property, and if it exists, clears the radix MMU feature bit,
before we decide whether to initialize for radix or HPT.  This
property is created by the hypervisor as a result of the guest
calling the ibm,client-architecture-support method to indicate
its capabilities, so it will indicate whether the hypervisor
agreed to us using radix.

Systems without a hypervisor may have this property also (for
example, skiboot creates it), so we check the HV bit in the MSR
to see whether we are running as a guest or not.  If we are in
hypervisor mode, then we can do whatever we like including
using the radix MMU.

The reason for using this property is that in future, when we
have support for using radix under a hypervisor, we will need
to check this property to see whether the hypervisor agreed to
us using radix.

Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/init_64.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 93abf8a..4d9481e 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -42,6 +42,8 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -344,12 +346,43 @@ static int __init parse_disable_radix(char *p)
 }
 early_param("disable_radix", parse_disable_radix);
 
+/*
+ * If we're running under a hypervisor, we currently can't do radix
+ * since we don't have the code to do the H_REGISTER_PROC_TBL hcall.
+ * We tell that we're running under a hypervisor by looking for the
+ * /chosen/ibm,architecture-vec-5 property.
+ */
+static void early_check_vec5(void)
+{
+	unsigned long root, chosen;
+	int size;
+	const u8 *vec5;
+
+	root = of_get_flat_dt_root();
+	chosen = of_get_flat_dt_subnode_by_name(root, "chosen");
+	if (chosen == -FDT_ERR_NOTFOUND)
+		return;
+	vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-5", &size);
+	if (!vec5)
+		return;
+	cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
+}
+
 void __init mmu_early_init_devtree(void)
 {
 	/* Disable radix mode based on kernel command line. */
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
+	/*
+	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
+	 * When running bare-metal, we can use radix if we like
+	 * even though the ibm,architecture-vec-5 property created by
+	 * skiboot doesn't have the necessary bits set.
+	 */
+	if (early_radix_enabled() && !(mfmsr() & MSR_HV))
+		early_check_vec5();
+
 	if (early_radix_enabled())
 		radix__early_init_devtree();
 	else
-- 
2.7.4
