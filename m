Return-Path: <arnd@arndb.de>
Message-Id: <20060407150743.510771000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Fri, 07 Apr 2006 00:00:03 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/5] spufs: set up correct SLB entries for 64k pages
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spufs currently knows only 4k pages and 16M hugetlb
pages. Make it use the regular methods for deciding on
the SLB bits.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -71,7 +71,7 @@ static int __spu_trap_data_seg(struct sp
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	struct mm_struct *mm = spu->mm;
-	u64 esid, vsid;
+	u64 esid, vsid, llp;
 
 	pr_debug("%s\n", __FUNCTION__);
 
@@ -91,9 +91,14 @@ static int __spu_trap_data_seg(struct sp
 	}
 
 	esid = (ea & ESID_MASK) | SLB_ESID_V;
-	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) | SLB_VSID_USER;
+#ifdef CONFIG_HUGETLB_PAGE
 	if (in_hugepage_area(mm->context, ea))
-		vsid |= SLB_VSID_L;
+		llp = mmu_psize_defs[mmu_huge_psize].sllp;
+	else
+#endif
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
+			SLB_VSID_USER | llp;
 
 	out_be64(&priv2->slb_index_W, spu->slb_replace);
 	out_be64(&priv2->slb_vsid_RW, vsid);
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -718,13 +718,15 @@ static inline void invalidate_slbs(struc
 
 static inline void get_kernel_slb(u64 ea, u64 slb[2])
 {
-	slb[0] = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
-	slb[1] = (ea & ESID_MASK) | SLB_ESID_V;
+	u64 llp;
 
-	/* Large pages are used for kernel text/data, but not vmalloc.  */
-	if (cpu_has_feature(CPU_FTR_16M_PAGE)
-	    && REGION_ID(ea) == KERNEL_REGION_ID)
-		slb[0] |= SLB_VSID_L;
+	if (REGION_ID(ea) == KERNEL_REGION_ID)
+		llp = mmu_psize_defs[mmu_linear_psize].sllp;
+	else
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	slb[0] = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
+		SLB_VSID_KERNEL | llp;
+	slb[1] = (ea & ESID_MASK) | SLB_ESID_V;
 }
 
 static inline void load_mfc_slb(struct spu *spu, u64 slb[2], int slbe)
Index: linus-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linus-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -22,7 +22,7 @@ config SPU_FS
 
 config SPUFS_MMAP
 	bool
-	depends on SPU_FS && SPARSEMEM && !PPC_64K_PAGES
+	depends on SPU_FS && SPARSEMEM
 	default y
 
 endmenu

--
