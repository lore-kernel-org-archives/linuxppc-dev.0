Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B36EDDF0F
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:38:19 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] arch/powerpc trivial annotations
Message-Id: <E1HFYlL-0006kg-KO@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 09 Feb 2007 16:38:15 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/iommu.c |    5 +++--
 arch/powerpc/platforms/chrp/setup.c |    4 ++--
 arch/powerpc/xmon/spu-dis.c         |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index b43466b..67d617b 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -149,7 +149,8 @@ static int cbe_nr_iommus;
 static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
 		long n_ptes)
 {
-	unsigned long *reg, val;
+	unsigned long __iomem *reg;
+	unsigned long val;
 	long n;
 
 	reg = iommu->xlate_regs + IOC_IOPT_CacheInvd;
@@ -592,7 +593,7 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
 	/* Init base fields */
 	i = cbe_nr_iommus++;
 	iommu = &iommus[i];
-	iommu->stab = 0;
+	iommu->stab = NULL;
 	iommu->nid = nid;
 	snprintf(iommu->name, sizeof(iommu->name), "iommu%d", i);
 	INIT_LIST_HEAD(&iommu->windows);
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index e1f51d4..117c9a0 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -75,7 +75,7 @@ extern irqreturn_t xmon_irq(int, void *);
 extern unsigned long loops_per_jiffy;
 
 /* To be replaced by RTAS when available */
-static unsigned int *briq_SPOR;
+static unsigned int __iomem *briq_SPOR;
 
 #ifdef CONFIG_SMP
 extern struct smp_ops_t chrp_smp_ops;
@@ -267,7 +267,7 @@ void __init chrp_setup_arch(void)
 	} else if (machine && strncmp(machine, "TotalImpact,BRIQ-1", 18) == 0) {
 		_chrp_type = _CHRP_briq;
 		/* Map the SPOR register on briq and change the restart hook */
-		briq_SPOR = (unsigned int *)ioremap(0xff0000e8, 4);
+		briq_SPOR = ioremap(0xff0000e8, 4);
 		ppc_md.restart = briq_restart;
 	} else {
 		/* Let's assume it is an IBM chrp if all else fails */
diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index ee929c6..e5f8983 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -85,7 +85,7 @@ get_index_for_opcode (unsigned int insn)
   if ((index = spu_disassemble_table[opcode & 0x7ff]) != 0)
     return index;
 
-  return 0;
+  return NULL;
 }
 
 /* Print a Spu instruction.  */
-- 
1.5.0-rc2.GIT
