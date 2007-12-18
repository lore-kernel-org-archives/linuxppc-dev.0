Return-Path: <arnd@arndb.de>
Message-Id: <20071218175106.725778000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:08 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 16/18] cell: add spu_64k_pages_available() check
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a function spu_64k_pages_available(), so that we can abstract the
explicity use of mmu_psize_defs() in lssca_alloc.c

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c          |    6 ++++++
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c |    2 +-
 include/asm-powerpc/spu.h                       |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -126,6 +126,12 @@ void spu_associate_mm(struct spu *spu, s
 }
 EXPORT_SYMBOL_GPL(spu_associate_mm);
 
+int spu_64k_pages_available(void)
+{
+	return mmu_psize_defs[MMU_PAGE_64K].shift != 0;
+}
+EXPORT_SYMBOL_GPL(spu_64k_pages_available);
+
 static int __spu_trap_invalid_dma(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
@@ -73,7 +73,7 @@ int spu_alloc_lscsa(struct spu_state *cs
 	int		i, j, n_4k;
 
 	/* Check availability of 64K pages */
-	if (mmu_psize_defs[MMU_PAGE_64K].shift == 0)
+	if (!spu_64k_pages_available())
 		goto fail;
 
 	csa->use_big_pages = 1;
Index: linux-2.6-new/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6-new.orig/include/asm-powerpc/spu.h
+++ linux-2.6-new/include/asm-powerpc/spu.h
@@ -214,6 +214,7 @@ static inline void crash_register_spus(s
 
 extern void spu_invalidate_slbs(struct spu *spu);
 extern void spu_associate_mm(struct spu *spu, struct mm_struct *mm);
+int spu_64k_pages_available(void);
 
 /* Calls from the memory management to the SPU */
 struct mm_struct;

-- 
