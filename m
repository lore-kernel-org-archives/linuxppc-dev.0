Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 17BC01A1D1E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:37 +1000 (AEST)
Message-Id: <6a0cd25e465c1faa258db9612ce06225654ca369.1439382638.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 20/20] powerpc32: remove ioremap_base
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:33 +0200 (CEST)
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
 arch/powerpc/mm/mmu_decl.h                  | 1 -
 arch/powerpc/mm/pgtable_32.c                | 1 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h | 8 --------
 3 files changed, 10 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 99e88bc..6f1e7cd 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -100,7 +100,6 @@ extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 
 extern int __map_without_bats;
 extern int __allow_ioremap_reserved;
-extern unsigned long ioremap_base;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 1f2fdbc..dc51ab4 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -37,7 +37,6 @@
 
 #include "mmu_decl.h"
 
-unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index b290b63..8de6104 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -138,14 +138,6 @@
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
