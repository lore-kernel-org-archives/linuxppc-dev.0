Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 86B19B7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:28 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:12 +1000
Subject: [PATCH 5/20] powerpc/mm: Add more bit definitions for Book3E MMU
	registers
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091528.77935DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds various additional bit definitions for various MMU related
SPRs used on Book3E.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu-book3e.h |  168 ++++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 49 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu-book3e.h	2009-07-22 15:19:22.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-book3e.h	2009-07-22 15:30:58.000000000 +1000
@@ -38,58 +38,128 @@
 #define BOOK3E_PAGESZ_1TB	30
 #define BOOK3E_PAGESZ_2TB	31
 
-#define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
-#define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
-#define MAS0_NV(x)	((x) & 0x00000FFF)
-
-#define MAS1_VALID 	0x80000000
-#define MAS1_IPROT	0x40000000
-#define MAS1_TID(x)	((x << 16) & 0x3FFF0000)
-#define MAS1_IND	0x00002000
-#define MAS1_TS		0x00001000
-#define MAS1_TSIZE(x)	((x << 7) & 0x00000F80)
-
-#define MAS2_EPN	0xFFFFF000
-#define MAS2_X0		0x00000040
-#define MAS2_X1		0x00000020
-#define MAS2_W		0x00000010
-#define MAS2_I		0x00000008
-#define MAS2_M		0x00000004
-#define MAS2_G		0x00000002
-#define MAS2_E		0x00000001
+/* MAS registers bit definitions */
+
+#define MAS0_TLBSEL(x)		((x << 28) & 0x30000000)
+#define MAS0_ESEL(x)		((x << 16) & 0x0FFF0000)
+#define MAS0_NV(x)		((x) & 0x00000FFF)
+#define MAS0_HES		0x00004000
+#define MAS0_WQ_ALLWAYS		0x00000000
+#define MAS0_WQ_COND		0x00001000
+#define MAS0_WQ_CLR_RSRV       	0x00002000
+
+#define MAS1_VALID		0x80000000
+#define MAS1_IPROT		0x40000000
+#define MAS1_TID(x)		((x << 16) & 0x3FFF0000)
+#define MAS1_IND		0x00002000
+#define MAS1_TS			0x00001000
+#define MAS1_TSIZE_MASK		0x00000f80
+#define MAS1_TSIZE_SHIFT	7
+#define MAS1_TSIZE(x)		((x << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
+
+#define MAS2_EPN		0xFFFFF000
+#define MAS2_X0			0x00000040
+#define MAS2_X1			0x00000020
+#define MAS2_W			0x00000010
+#define MAS2_I			0x00000008
+#define MAS2_M			0x00000004
+#define MAS2_G			0x00000002
+#define MAS2_E			0x00000001
 #define MAS2_EPN_MASK(size)		(~0 << (size + 10))
 #define MAS2_VAL(addr, size, flags)	((addr) & MAS2_EPN_MASK(size) | (flags))
 
-#define MAS3_RPN	0xFFFFF000
-#define MAS3_U0		0x00000200
-#define MAS3_U1		0x00000100
-#define MAS3_U2		0x00000080
-#define MAS3_U3		0x00000040
-#define MAS3_UX		0x00000020
-#define MAS3_SX		0x00000010
-#define MAS3_UW		0x00000008
-#define MAS3_SW		0x00000004
-#define MAS3_UR		0x00000002
-#define MAS3_SR		0x00000001
-
-#define MAS4_TLBSELD(x) MAS0_TLBSEL(x)
-#define MAS4_INDD	0x00008000
-#define MAS4_TSIZED(x)	MAS1_TSIZE(x)
-#define MAS4_X0D	0x00000040
-#define MAS4_X1D	0x00000020
-#define MAS4_WD		0x00000010
-#define MAS4_ID		0x00000008
-#define MAS4_MD		0x00000004
-#define MAS4_GD		0x00000002
-#define MAS4_ED		0x00000001
-
-#define MAS6_SPID0	0x3FFF0000
-#define MAS6_SPID1	0x00007FFE
-#define MAS6_ISIZE(x)	MAS1_TSIZE(x)
-#define MAS6_SAS	0x00000001
-#define MAS6_SPID	MAS6_SPID0
-
-#define MAS7_RPN	0xFFFFFFFF
+#define MAS3_RPN		0xFFFFF000
+#define MAS3_U0			0x00000200
+#define MAS3_U1			0x00000100
+#define MAS3_U2			0x00000080
+#define MAS3_U3			0x00000040
+#define MAS3_UX			0x00000020
+#define MAS3_SX			0x00000010
+#define MAS3_UW			0x00000008
+#define MAS3_SW			0x00000004
+#define MAS3_UR			0x00000002
+#define MAS3_SR			0x00000001
+#define MAS3_SPSIZE		0x0000003e
+#define MAS3_SPSIZE_SHIFT	1
+
+#define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
+#define MAS4_INDD		0x00008000	/* Default IND */
+#define MAS4_TSIZED(x)		MAS1_TSIZE(x)
+#define MAS4_X0D		0x00000040
+#define MAS4_X1D		0x00000020
+#define MAS4_WD			0x00000010
+#define MAS4_ID			0x00000008
+#define MAS4_MD			0x00000004
+#define MAS4_GD			0x00000002
+#define MAS4_ED			0x00000001
+#define MAS4_WIMGED_MASK	0x0000001f	/* Default WIMGE */
+#define MAS4_WIMGED_SHIFT	0
+#define MAS4_VLED		MAS4_X1D	/* Default VLE */
+#define MAS4_ACMD		0x000000c0	/* Default ACM */
+#define MAS4_ACMD_SHIFT		6
+#define MAS4_TSIZED_MASK	0x00000f80	/* Default TSIZE */
+#define MAS4_TSIZED_SHIFT	7
+
+#define MAS6_SPID0		0x3FFF0000
+#define MAS6_SPID1		0x00007FFE
+#define MAS6_ISIZE(x)		MAS1_TSIZE(x)
+#define MAS6_SAS		0x00000001
+#define MAS6_SPID		MAS6_SPID0
+#define MAS6_SIND 		0x00000002	/* Indirect page */
+#define MAS6_SIND_SHIFT		1
+#define MAS6_SPID_MASK		0x3fff0000
+#define MAS6_SPID_SHIFT		16
+#define MAS6_ISIZE_MASK		0x00000f80
+#define MAS6_ISIZE_SHIFT	7
+
+#define MAS7_RPN		0xFFFFFFFF
+
+/* TLBnCFG encoding */
+#define TLBnCFG_N_ENTRY		0x00000fff	/* number of entries */
+#define TLBnCFG_HES		0x00002000	/* HW select supported */
+#define TLBnCFG_IPROT		0x00008000	/* IPROT supported */
+#define TLBnCFG_GTWE		0x00010000	/* Guest can write */
+#define TLBnCFG_IND		0x00020000	/* IND entries supported */
+#define TLBnCFG_PT		0x00040000	/* Can load from page table */
+#define TLBnCFG_ASSOC		0xff000000	/* Associativity */
+
+/* TLBnPS encoding */
+#define TLBnPS_4K		0x00000004
+#define TLBnPS_8K		0x00000008
+#define TLBnPS_16K		0x00000010
+#define TLBnPS_32K		0x00000020
+#define TLBnPS_64K		0x00000040
+#define TLBnPS_128K		0x00000080
+#define TLBnPS_256K		0x00000100
+#define TLBnPS_512K		0x00000200
+#define TLBnPS_1M 		0x00000400
+#define TLBnPS_2M 		0x00000800
+#define TLBnPS_4M 		0x00001000
+#define TLBnPS_8M 		0x00002000
+#define TLBnPS_16M		0x00004000
+#define TLBnPS_32M		0x00008000
+#define TLBnPS_64M		0x00010000
+#define TLBnPS_128M		0x00020000
+#define TLBnPS_256M		0x00040000
+#define TLBnPS_512M		0x00080000
+#define TLBnPS_1G		0x00100000
+#define TLBnPS_2G		0x00200000
+#define TLBnPS_4G		0x00400000
+#define TLBnPS_8G		0x00800000
+#define TLBnPS_16G		0x01000000
+#define TLBnPS_32G		0x02000000
+#define TLBnPS_64G		0x04000000
+#define TLBnPS_128G		0x08000000
+#define TLBnPS_256G		0x10000000
+
+/* tlbilx action encoding */
+#define TLBILX_T_ALL			0
+#define TLBILX_T_TID			1
+#define TLBILX_T_FULLMATCH		3
+#define TLBILX_T_CLASS0			4
+#define TLBILX_T_CLASS1			5
+#define TLBILX_T_CLASS2			6
+#define TLBILX_T_CLASS3			7
 
 #ifndef __ASSEMBLY__
 
