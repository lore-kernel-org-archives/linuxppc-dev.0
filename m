Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 7C2F71A023F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 09:54:23 +1100 (AEDT)
Message-Id: <c41466af0f1a52447e8d88235307e74480a2aa16.1454538977.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454538974.git.christophe.leroy@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 12/23] powerpc32: remove ioremap_base
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  3 Feb 2016 23:54:19 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ioremap_base is not initialised and is nowhere used so remove it

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: fix comment as well
v4: no change
v5: no change

 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/mm/mmu_decl.h                   |  1 -
 arch/powerpc/mm/pgtable_32.c                 |  3 +--
 arch/powerpc/platforms/embedded6xx/mpc10x.h  | 10 ----------
 4 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index e201600..7808475 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -86,7 +86,7 @@ extern int icache_44x_need_flush;
  * We no longer map larger than phys RAM with the BATs so we don't have
  * to worry about the VMALLOC_OFFSET causing problems.  We do have to worry
  * about clashes between our early calls to ioremap() that start growing down
- * from ioremap_base being run into the VM area allocations (growing upwards
+ * from IOREMAP_TOP being run into the VM area allocations (growing upwards
  * from VMALLOC_START).  For this reason we have ioremap_bot to check when
  * we actually run into our mappings setup in the early boot with the VM
  * system.  This really does become a problem for machines with good amounts
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 3872332..53564a3 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -100,7 +100,6 @@ extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 
 extern int __map_without_bats;
 extern int __allow_ioremap_reserved;
-extern unsigned long ioremap_base;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index db0d35e..815ccd7 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -37,7 +37,6 @@
 
 #include "mmu_decl.h"
 
-unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
@@ -173,7 +172,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	/*
 	 * Choose an address to map it to.
 	 * Once the vmalloc system is running, we use it.
-	 * Before then, we use space going down from ioremap_base
+	 * Before then, we use space going down from IOREMAP_TOP
 	 * (ioremap_bot records where we're up to).
 	 */
 	p = addr & PAGE_MASK;
diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index b290b63..5ad1202 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -24,13 +24,11 @@
  *   Processor: 0x80000000 - 0x807fffff -> PCI I/O: 0x00000000 - 0x007fffff
  *   Processor: 0xc0000000 - 0xdfffffff -> PCI MEM: 0x00000000 - 0x1fffffff
  *   PCI MEM:   0x80000000 -> Processor System Memory: 0x00000000
- *   EUMB mapped to: ioremap_base - 0x00100000 (ioremap_base - 1 MB)
  *
  * MAP B (CHRP Map)
  *   Processor: 0xfe000000 - 0xfebfffff -> PCI I/O: 0x00000000 - 0x00bfffff
  *   Processor: 0x80000000 - 0xbfffffff -> PCI MEM: 0x80000000 - 0xbfffffff
  *   PCI MEM:   0x00000000 -> Processor System Memory: 0x00000000
- *   EUMB mapped to: ioremap_base - 0x00100000 (ioremap_base - 1 MB)
  */
 
 /*
@@ -138,14 +136,6 @@
 #define MPC10X_EUMB_WP_OFFSET		0x000ff000 /* Data path diagnostic, watchpoint reg offset */
 #define MPC10X_EUMB_WP_SIZE		0x00001000 /* Data path diagnostic, watchpoint reg size */
 
-/*
- * Define some recommended places to put the EUMB regs.
- * For both maps, recommend putting the EUMB from 0xeff00000 to 0xefffffff.
- */
-extern unsigned long			ioremap_base;
-#define	MPC10X_MAPA_EUMB_BASE		(ioremap_base - MPC10X_EUMB_SIZE)
-#define	MPC10X_MAPB_EUMB_BASE		MPC10X_MAPA_EUMB_BASE
-
 enum ppc_sys_devices {
 	MPC10X_IIC1,
 	MPC10X_DMA0,
-- 
2.1.0
