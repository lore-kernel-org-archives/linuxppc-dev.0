Return-Path: <arnd@arndb.de>
Message-Id: <20071218175106.596230000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:07 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 15/18] cell: use spu_load_slb for SLB setup
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have a helper function to setup a SPU SLB, use it for
__spu_trap_data_seq.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -169,9 +169,8 @@ static inline void spu_load_slb(struct s
 
 static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
 {
-	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	struct mm_struct *mm = spu->mm;
-	u64 esid, vsid, llp;
+	struct spu_slb slb;
 	int psize;
 
 	pr_debug("%s\n", __FUNCTION__);
@@ -183,7 +182,7 @@ static int __spu_trap_data_seg(struct sp
 		printk("%s: invalid access during switch!\n", __func__);
 		return 1;
 	}
-	esid = (ea & ESID_MASK) | SLB_ESID_V;
+	slb.esid = (ea & ESID_MASK) | SLB_ESID_V;
 
 	switch(REGION_ID(ea)) {
 	case USER_REGION_ID:
@@ -192,21 +191,21 @@ static int __spu_trap_data_seg(struct sp
 #else
 		psize = mm->context.user_psize;
 #endif
-		vsid = (get_vsid(mm->context.id, ea, MMU_SEGSIZE_256M) << SLB_VSID_SHIFT) |
-				SLB_VSID_USER;
+		slb.vsid = (get_vsid(mm->context.id, ea, MMU_SEGSIZE_256M)
+				<< SLB_VSID_SHIFT) | SLB_VSID_USER;
 		break;
 	case VMALLOC_REGION_ID:
 		if (ea < VMALLOC_END)
 			psize = mmu_vmalloc_psize;
 		else
 			psize = mmu_io_psize;
-		vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M) << SLB_VSID_SHIFT) |
-			SLB_VSID_KERNEL;
+		slb.vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M)
+				<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
 		break;
 	case KERNEL_REGION_ID:
 		psize = mmu_linear_psize;
-		vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M) << SLB_VSID_SHIFT) |
-			SLB_VSID_KERNEL;
+		slb.vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M)
+				<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
 		break;
 	default:
 		/* Future: support kernel segments so that drivers
@@ -215,11 +214,9 @@ static int __spu_trap_data_seg(struct sp
 		pr_debug("invalid region access at %016lx\n", ea);
 		return 1;
 	}
-	llp = mmu_psize_defs[psize].sllp;
+	slb.vsid |= mmu_psize_defs[psize].sllp;
 
-	out_be64(&priv2->slb_index_W, spu->slb_replace);
-	out_be64(&priv2->slb_vsid_RW, vsid | llp);
-	out_be64(&priv2->slb_esid_RW, esid);
+	spu_load_slb(spu, spu->slb_replace, &slb);
 
 	spu->slb_replace++;
 	if (spu->slb_replace >= 8)

-- 
