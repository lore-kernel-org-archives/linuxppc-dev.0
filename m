Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjbS9505RzDwPJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 22:40:09 +1100 (AEDT)
Date: Tue, 20 Dec 2016 22:40:02 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64: Don't try to use radix MMU under a hypervisor
Message-ID: <20161220114002.GA19107@fergus.ozlabs.ibm.com>
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

Currently, if the kernel is running on a POWER9 processor under a
hypervisor, it will try to use the radix MMU even though it doesn't
have the necessary code to use radix under a hypervisor (it doesn't
negotiate use of radix, and it doesn't do the H_REGISTER_PROC_TBL
hcall).  The result is that the guest kernel will crash when it tries
to turn on the MMU, because it will still actually be using the HPT
MMU, but it won't have set up any SLB or HPT entries.  It does this
because the only thing that the kernel looks at in deciding to use
radix, on any platform, is the ibm,pa-features property on the cpu
device nodes.

This fixes it by looking for the /chosen/ibm,architecture-vec-5
property, and if it exists, clearing the radix MMU feature bit.
We do this before we decide whether to initialize for radix or HPT.
This property is created by the hypervisor as a result of the guest
calling the ibm,client-architecture-support method to indicate
its capabilities, so it only exists on systems with a hypervisor.
The reason for using this property is that in future, when we
have support for using radix under a hypervisor, we will need
to check this property to see whether the hypervisor agreed to
us using radix.

Fixes: 17a3dd2f5fc7 ("powerpc/mm/radix: Use firmware feature to enable Radix MMU")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/init_64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a000c35..098531d 100644
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
@@ -344,6 +346,28 @@ static int __init parse_disable_radix(char *p)
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
@@ -351,6 +375,9 @@ void __init mmu_early_init_devtree(void)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	if (early_radix_enabled())
+		early_check_vec5();
+
+	if (early_radix_enabled())
 		radix__early_init_devtree();
 	else
 		hash__early_init_devtree();
-- 
2.7.4
