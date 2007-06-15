Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Jun 2007 15:33:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Split out asm-ppc/mmu.h portions for Freescale Book-E
Message-ID: <20070615053309.GA3910@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc still relies on asm-ppc/mmu.h for some 32-bit MMU types.
This patch is another step towards fixing this.  It takes the portions
of asm-ppc/mmu.h related to Freescale Book-E which are still relevant
in arch/powerpc and puts them in a new asm-powerpc/mmu-fsl-booke.h,
included when appropriate from asm-powerpc/mmu.h.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Could someone who actually has a Freescale Book-E board give this a
whirl?  I've compile tested this, but not booted it.

Index: working-2.6/include/asm-powerpc/mmu-fsl-booke.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/include/asm-powerpc/mmu-fsl-booke.h	2007-05-30 16:22:30.000000000 +1000
@@ -0,0 +1,88 @@
+#ifndef _ASM_POWERPC_MMU_FSL_BOOKE_H_
+#define _ASM_POWERPC_MMU_FSL_BOOKE_H_
+/*
+ * Freescale Book-E MMU support
+ */
+
+/* Book-E defined page sizes */
+#define BOOKE_PAGESZ_1K		0
+#define BOOKE_PAGESZ_4K		1
+#define BOOKE_PAGESZ_16K	2
+#define BOOKE_PAGESZ_64K	3
+#define BOOKE_PAGESZ_256K	4
+#define BOOKE_PAGESZ_1M		5
+#define BOOKE_PAGESZ_4M		6
+#define BOOKE_PAGESZ_16M	7
+#define BOOKE_PAGESZ_64M	8
+#define BOOKE_PAGESZ_256M	9
+#define BOOKE_PAGESZ_1GB	10
+#define BOOKE_PAGESZ_4GB	11
+#define BOOKE_PAGESZ_16GB	12
+#define BOOKE_PAGESZ_64GB	13
+#define BOOKE_PAGESZ_256GB	14
+#define BOOKE_PAGESZ_1TB	15
+
+#define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
+#define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
+#define MAS0_NV(x)	((x) & 0x00000FFF)
+
+#define MAS1_VALID 	0x80000000
+#define MAS1_IPROT	0x40000000
+#define MAS1_TID(x)	((x << 16) & 0x3FFF0000)
+#define MAS1_TS		0x00001000
+#define MAS1_TSIZE(x)	((x << 8) & 0x00000F00)
+
+#define MAS2_EPN	0xFFFFF000
+#define MAS2_X0		0x00000040
+#define MAS2_X1		0x00000020
+#define MAS2_W		0x00000010
+#define MAS2_I		0x00000008
+#define MAS2_M		0x00000004
+#define MAS2_G		0x00000002
+#define MAS2_E		0x00000001
+
+#define MAS3_RPN	0xFFFFF000
+#define MAS3_U0		0x00000200
+#define MAS3_U1		0x00000100
+#define MAS3_U2		0x00000080
+#define MAS3_U3		0x00000040
+#define MAS3_UX		0x00000020
+#define MAS3_SX		0x00000010
+#define MAS3_UW		0x00000008
+#define MAS3_SW		0x00000004
+#define MAS3_UR		0x00000002
+#define MAS3_SR		0x00000001
+
+#define MAS4_TLBSELD(x) MAS0_TLBSEL(x)
+#define MAS4_TIDDSEL	0x000F0000
+#define MAS4_TSIZED(x)	MAS1_TSIZE(x)
+#define MAS4_X0D	0x00000040
+#define MAS4_X1D	0x00000020
+#define MAS4_WD		0x00000010
+#define MAS4_ID		0x00000008
+#define MAS4_MD		0x00000004
+#define MAS4_GD		0x00000002
+#define MAS4_ED		0x00000001
+
+#define MAS6_SPID0	0x3FFF0000
+#define MAS6_SPID1	0x00007FFE
+#define MAS6_SAS	0x00000001
+#define MAS6_SPID	MAS6_SPID0
+
+#define MAS7_RPN	0xFFFFFFFF
+
+#ifndef __ASSEMBLY__
+
+#ifndef CONFIG_PHYS_64BIT
+typedef unsigned long phys_addr_t;
+#else
+typedef unsigned long long phys_addr_t;
+#endif
+
+typedef struct {
+	unsigned long id;
+	unsigned long vdso_base;
+} mm_context_t;
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_MMU_FSL_BOOKE_H_ */
Index: working-2.6/include/asm-powerpc/mmu.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu.h	2007-05-30 16:03:50.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu.h	2007-05-30 16:04:22.000000000 +1000
@@ -11,6 +11,9 @@
 #elif defined(CONFIG_44x)
 /* 44x-style software loaded TLB */
 #  include <asm/mmu-44x.h>
+#elif defined(CONFIG_FSL_BOOKE)
+/* Freescale Book-E software loaded TLB */
+#  include <asm/mmu-fsl-booke.h>
 #else
 /* Other 32-bit.  FIXME: split up the other 32-bit MMU types, and
  * revise for arch/powerpc */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
