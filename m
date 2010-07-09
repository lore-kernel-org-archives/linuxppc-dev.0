Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A867100852
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:03 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696CoQI016327
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:12:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H3jA1593358
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H26t013238
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/13] powerpc/book3e: Add TLB dump in xmon for Book3E
Date: Fri,  9 Jul 2010 16:16:53 +1000
Message-Id: <1278656215-24705-11-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-10-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-10-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/xmon/xmon.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 152 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8bad7d5..0554445 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -155,6 +155,9 @@ static int do_spu_cmd(void);
 #ifdef CONFIG_44x
 static void dump_tlb_44x(void);
 #endif
+#ifdef CONFIG_PPC_BOOK3E
+static void dump_tlb_book3e(void);
+#endif
 
 static int xmon_no_auto_backtrace;
 
@@ -888,6 +891,11 @@ cmds(struct pt_regs *excp)
 			dump_tlb_44x();
 			break;
 #endif
+#ifdef CONFIG_PPC_BOOK3E
+		case 'u':
+			dump_tlb_book3e();
+			break;
+#endif
 		default:
 			printf("Unrecognized command: ");
 		        do {
@@ -2701,6 +2709,150 @@ static void dump_tlb_44x(void)
 }
 #endif /* CONFIG_44x */
 
+#ifdef CONFIG_PPC_BOOK3E
+static void dump_tlb_book3e(void)
+{
+	u32 mmucfg, pidmask, lpidmask;
+	u64 ramask;
+	int i, tlb, ntlbs, pidsz, lpidsz, rasz, lrat = 0;
+	int mmu_version;
+	static const char *pgsz_names[] = {
+		"  1K",
+		"  2K",
+		"  4K",
+		"  8K",
+		" 16K",
+		" 32K",
+		" 64K",
+		"128K",
+		"256K",
+		"512K",
+		"  1M",
+		"  2M",
+		"  4M",
+		"  8M",
+		" 16M",
+		" 32M",
+		" 64M",
+		"128M",
+		"256M",
+		"512M",
+		"  1G",
+		"  2G",
+		"  4G",
+		"  8G",
+		" 16G",
+		" 32G",
+		" 64G",
+		"128G",
+		"256G",
+		"512G",
+		"  1T",
+		"  2T",
+	};
+
+	/* Gather some infos about the MMU */
+	mmucfg = mfspr(SPRN_MMUCFG);
+	mmu_version = (mmucfg & 3) + 1;
+	ntlbs = ((mmucfg >> 2) & 3) + 1;
+	pidsz = ((mmucfg >> 6) & 0x1f) + 1;
+	lpidsz = (mmucfg >> 24) & 0xf;
+	rasz = (mmucfg >> 16) & 0x7f;
+	if ((mmu_version > 1) && (mmucfg & 0x10000))
+		lrat = 1;
+	printf("Book3E MMU MAV=%d.0,%d TLBs,%d-bit PID,%d-bit LPID,%d-bit RA\n",
+	       mmu_version, ntlbs, pidsz, lpidsz, rasz);
+	pidmask = (1ul << pidsz) - 1;
+	lpidmask = (1ul << lpidsz) - 1;
+	ramask = (1ull << rasz) - 1;
+
+	for (tlb = 0; tlb < ntlbs; tlb++) {
+		u32 tlbcfg;
+		int nent, assoc, new_cc = 1;
+		printf("TLB %d:\n------\n", tlb);
+		switch(tlb) {
+		case 0:
+			tlbcfg = mfspr(SPRN_TLB0CFG);
+			break;
+		case 1:
+			tlbcfg = mfspr(SPRN_TLB1CFG);
+			break;
+		case 2:
+			tlbcfg = mfspr(SPRN_TLB2CFG);
+			break;
+		case 3:
+			tlbcfg = mfspr(SPRN_TLB3CFG);
+			break;
+		default:
+			printf("Unsupported TLB number !\n");
+			continue;
+		}
+		nent = tlbcfg & 0xfff;
+		assoc = (tlbcfg >> 24) & 0xff;
+		for (i = 0; i < nent; i++) {
+			u32 mas0 = MAS0_TLBSEL(tlb);
+			u32 mas1 = MAS1_TSIZE(BOOK3E_PAGESZ_4K);
+			u64 mas2 = 0;
+			u64 mas7_mas3;
+			int esel = i, cc = i;
+
+			if (assoc != 0) {
+				cc = i / assoc;
+				esel = i % assoc;
+				mas2 = cc * 0x1000;
+			}
+
+			mas0 |= MAS0_ESEL(esel);
+			mtspr(SPRN_MAS0, mas0);
+			mtspr(SPRN_MAS1, mas1);
+			mtspr(SPRN_MAS2, mas2);
+			asm volatile("tlbre  0,0,0" : : : "memory");
+			mas1 = mfspr(SPRN_MAS1);
+			mas2 = mfspr(SPRN_MAS2);
+			mas7_mas3 = mfspr(SPRN_MAS7_MAS3);
+			if (assoc && (i % assoc) == 0)
+				new_cc = 1;
+			if (!(mas1 & MAS1_VALID))
+				continue;
+			if (assoc == 0)
+				printf("%04x- ", i);
+			else if (new_cc)
+				printf("%04x-%c", cc, 'A' + esel);
+			else
+				printf("    |%c", 'A' + esel);
+			new_cc = 0;
+			printf(" %016llx %04x %s %c%c AS%c",
+			       mas2 & ~0x3ffull,
+			       (mas1 >> 16) & 0x3fff,
+			       pgsz_names[(mas1 >> 7) & 0x1f],
+			       mas1 & MAS1_IND ? 'I' : ' ',
+			       mas1 & MAS1_IPROT ? 'P' : ' ',
+			       mas1 & MAS1_TS ? '1' : '0');
+			printf(" %c%c%c%c%c%c%c",
+			       mas2 & MAS2_X0 ? 'a' : ' ',
+			       mas2 & MAS2_X1 ? 'v' : ' ',
+			       mas2 & MAS2_W  ? 'w' : ' ',
+			       mas2 & MAS2_I  ? 'i' : ' ',
+			       mas2 & MAS2_M  ? 'm' : ' ',
+			       mas2 & MAS2_G  ? 'g' : ' ',
+			       mas2 & MAS2_E  ? 'e' : ' ');
+			printf(" %016llx", mas7_mas3 & ramask & ~0x7ffull);
+			if (mas1 & MAS1_IND)
+				printf(" %s\n",
+				       pgsz_names[(mas7_mas3 >> 1) & 0x1f]);
+			else
+				printf(" U%c%c%c S%c%c%c\n",
+				       mas7_mas3 & MAS3_UX ? 'x' : ' ',
+				       mas7_mas3 & MAS3_UW ? 'w' : ' ',
+				       mas7_mas3 & MAS3_UR ? 'r' : ' ',
+				       mas7_mas3 & MAS3_SX ? 'x' : ' ',
+				       mas7_mas3 & MAS3_SW ? 'w' : ' ',
+				       mas7_mas3 & MAS3_SR ? 'r' : ' ');
+		}
+	}
+}
+#endif /* CONFIG_PPC_BOOK3E */
+
 static void xmon_init(int enable)
 {
 #ifdef CONFIG_PPC_ISERIES
-- 
1.6.3.3
