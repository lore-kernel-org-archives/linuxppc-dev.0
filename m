Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDlD2DHwzDr9H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:12 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 77so24220668pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/6] powerpc/64s: move POWER machine check defines into
 mce_power.c
Date: Tue, 14 Mar 2017 22:36:45 +1000
Message-Id: <20170314123648.26068-4-npiggin@gmail.com>
In-Reply-To: <20170314123648.26068-1-npiggin@gmail.com>
References: <20170314123648.26068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mce.h  | 91 ----------------------------------------
 arch/powerpc/kernel/mce_power.c | 92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index ed62efe01e49..e3498b446788 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -24,97 +24,6 @@
 
 #include <linux/bitops.h>
 
-/*
- * Machine Check bits on power7 and power8
- */
-#define P7_SRR1_MC_LOADSTORE(srr1)	((srr1) & PPC_BIT(42)) /* P8 too */
-
-/* SRR1 bits for machine check (On Power7 and Power8) */
-#define P7_SRR1_MC_IFETCH(srr1)	((srr1) & PPC_BITMASK(43, 45)) /* P8 too */
-
-#define P7_SRR1_MC_IFETCH_UE		(0x1 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_PARITY	(0x2 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_MULTIHIT	(0x3 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_SLB_BOTH	(0x4 << PPC_BITLSHIFT(45))
-#define P7_SRR1_MC_IFETCH_TLB_MULTIHIT	(0x5 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_UE_TLB_RELOAD	(0x6 << PPC_BITLSHIFT(45)) /* P8 too */
-#define P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL	(0x7 << PPC_BITLSHIFT(45))
-
-/* SRR1 bits for machine check (On Power8) */
-#define P8_SRR1_MC_IFETCH_ERAT_MULTIHIT	(0x4 << PPC_BITLSHIFT(45))
-
-/* DSISR bits for machine check (On Power7 and Power8) */
-#define P7_DSISR_MC_UE			(PPC_BIT(48))	/* P8 too */
-#define P7_DSISR_MC_UE_TABLEWALK	(PPC_BIT(49))	/* P8 too */
-#define P7_DSISR_MC_ERAT_MULTIHIT	(PPC_BIT(52))	/* P8 too */
-#define P7_DSISR_MC_TLB_MULTIHIT_MFTLB	(PPC_BIT(53))	/* P8 too */
-#define P7_DSISR_MC_SLB_PARITY_MFSLB	(PPC_BIT(55))	/* P8 too */
-#define P7_DSISR_MC_SLB_MULTIHIT	(PPC_BIT(56))	/* P8 too */
-#define P7_DSISR_MC_SLB_MULTIHIT_PARITY	(PPC_BIT(57))	/* P8 too */
-
-/*
- * DSISR bits for machine check (Power8) in addition to above.
- * Secondary DERAT Multihit
- */
-#define P8_DSISR_MC_ERAT_MULTIHIT_SEC	(PPC_BIT(54))
-
-/* SLB error bits */
-#define P7_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_ERAT_MULTIHIT | \
-					 P7_DSISR_MC_SLB_PARITY_MFSLB | \
-					 P7_DSISR_MC_SLB_MULTIHIT | \
-					 P7_DSISR_MC_SLB_MULTIHIT_PARITY)
-
-#define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
-					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
-
-/*
- * Machine Check bits on power9
- */
-#define P9_SRR1_MC_LOADSTORE(srr1)	(((srr1) >> PPC_BITLSHIFT(42)) & 1)
-
-#define P9_SRR1_MC_IFETCH(srr1)	(	\
-	PPC_BITEXTRACT(srr1, 45, 0) |	\
-	PPC_BITEXTRACT(srr1, 44, 1) |	\
-	PPC_BITEXTRACT(srr1, 43, 2) |	\
-	PPC_BITEXTRACT(srr1, 36, 3) )
-
-/* 0 is reserved */
-#define P9_SRR1_MC_IFETCH_UE				1
-#define P9_SRR1_MC_IFETCH_SLB_PARITY			2
-#define P9_SRR1_MC_IFETCH_SLB_MULTIHIT			3
-#define P9_SRR1_MC_IFETCH_ERAT_MULTIHIT			4
-#define P9_SRR1_MC_IFETCH_TLB_MULTIHIT			5
-#define P9_SRR1_MC_IFETCH_UE_TLB_RELOAD			6
-/* 7 is reserved */
-#define P9_SRR1_MC_IFETCH_LINK_TIMEOUT			8
-#define P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT	9
-/* 10 ? */
-#define P9_SRR1_MC_IFETCH_RA			11
-#define P9_SRR1_MC_IFETCH_RA_TABLEWALK		12
-#define P9_SRR1_MC_IFETCH_RA_ASYNC_STORE		13
-#define P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT	14
-#define P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN	15
-
-/* DSISR bits for machine check (On Power9) */
-#define P9_DSISR_MC_UE					(PPC_BIT(48))
-#define P9_DSISR_MC_UE_TABLEWALK			(PPC_BIT(49))
-#define P9_DSISR_MC_LINK_LOAD_TIMEOUT			(PPC_BIT(50))
-#define P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT		(PPC_BIT(51))
-#define P9_DSISR_MC_ERAT_MULTIHIT			(PPC_BIT(52))
-#define P9_DSISR_MC_TLB_MULTIHIT_MFTLB			(PPC_BIT(53))
-#define P9_DSISR_MC_USER_TLBIE				(PPC_BIT(54))
-#define P9_DSISR_MC_SLB_PARITY_MFSLB			(PPC_BIT(55))
-#define P9_DSISR_MC_SLB_MULTIHIT_MFSLB			(PPC_BIT(56))
-#define P9_DSISR_MC_RA_LOAD				(PPC_BIT(57))
-#define P9_DSISR_MC_RA_TABLEWALK			(PPC_BIT(58))
-#define P9_DSISR_MC_RA_TABLEWALK_FOREIGN		(PPC_BIT(59))
-#define P9_DSISR_MC_RA_FOREIGN				(PPC_BIT(60))
-
-/* SLB error bits */
-#define P9_DSISR_MC_SLB_ERRORS		(P9_DSISR_MC_ERAT_MULTIHIT | \
-					 P9_DSISR_MC_SLB_PARITY_MFSLB | \
-					 P9_DSISR_MC_SLB_MULTIHIT_MFSLB)
-
 enum MCE_Version {
 	MCE_V1 = 1,
 };
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 0f35a88e3655..9b3bcd1213bf 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -161,6 +161,98 @@ static int mce_handle_flush_derrors(uint64_t dsisr, uint64_t slb, uint64_t tlb,
 	return 1;
 }
 
+
+/*
+ * Machine Check bits on power7 and power8
+ */
+#define P7_SRR1_MC_LOADSTORE(srr1)	((srr1) & PPC_BIT(42)) /* P8 too */
+
+/* SRR1 bits for machine check (On Power7 and Power8) */
+#define P7_SRR1_MC_IFETCH(srr1)	((srr1) & PPC_BITMASK(43, 45)) /* P8 too */
+
+#define P7_SRR1_MC_IFETCH_UE		(0x1 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_PARITY	(0x2 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_MULTIHIT	(0x3 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_BOTH	(0x4 << PPC_BITLSHIFT(45))
+#define P7_SRR1_MC_IFETCH_TLB_MULTIHIT	(0x5 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_UE_TLB_RELOAD	(0x6 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL	(0x7 << PPC_BITLSHIFT(45))
+
+/* SRR1 bits for machine check (On Power8) */
+#define P8_SRR1_MC_IFETCH_ERAT_MULTIHIT	(0x4 << PPC_BITLSHIFT(45))
+
+/* DSISR bits for machine check (On Power7 and Power8) */
+#define P7_DSISR_MC_UE			(PPC_BIT(48))	/* P8 too */
+#define P7_DSISR_MC_UE_TABLEWALK	(PPC_BIT(49))	/* P8 too */
+#define P7_DSISR_MC_ERAT_MULTIHIT	(PPC_BIT(52))	/* P8 too */
+#define P7_DSISR_MC_TLB_MULTIHIT_MFTLB	(PPC_BIT(53))	/* P8 too */
+#define P7_DSISR_MC_SLB_PARITY_MFSLB	(PPC_BIT(55))	/* P8 too */
+#define P7_DSISR_MC_SLB_MULTIHIT	(PPC_BIT(56))	/* P8 too */
+#define P7_DSISR_MC_SLB_MULTIHIT_PARITY	(PPC_BIT(57))	/* P8 too */
+
+/*
+ * DSISR bits for machine check (Power8) in addition to above.
+ * Secondary DERAT Multihit
+ */
+#define P8_DSISR_MC_ERAT_MULTIHIT_SEC	(PPC_BIT(54))
+
+/* SLB error bits */
+#define P7_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_ERAT_MULTIHIT | \
+					 P7_DSISR_MC_SLB_PARITY_MFSLB | \
+					 P7_DSISR_MC_SLB_MULTIHIT | \
+					 P7_DSISR_MC_SLB_MULTIHIT_PARITY)
+
+#define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
+					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
+
+/*
+ * Machine Check bits on power9
+ */
+#define P9_SRR1_MC_LOADSTORE(srr1)	(((srr1) >> PPC_BITLSHIFT(42)) & 1)
+
+#define P9_SRR1_MC_IFETCH(srr1)	(	\
+	PPC_BITEXTRACT(srr1, 45, 0) |	\
+	PPC_BITEXTRACT(srr1, 44, 1) |	\
+	PPC_BITEXTRACT(srr1, 43, 2) |	\
+	PPC_BITEXTRACT(srr1, 36, 3) )
+
+/* 0 is reserved */
+#define P9_SRR1_MC_IFETCH_UE				1
+#define P9_SRR1_MC_IFETCH_SLB_PARITY			2
+#define P9_SRR1_MC_IFETCH_SLB_MULTIHIT			3
+#define P9_SRR1_MC_IFETCH_ERAT_MULTIHIT			4
+#define P9_SRR1_MC_IFETCH_TLB_MULTIHIT			5
+#define P9_SRR1_MC_IFETCH_UE_TLB_RELOAD			6
+/* 7 is reserved */
+#define P9_SRR1_MC_IFETCH_LINK_TIMEOUT			8
+#define P9_SRR1_MC_IFETCH_LINK_TABLEWALK_TIMEOUT	9
+/* 10 ? */
+#define P9_SRR1_MC_IFETCH_RA			11
+#define P9_SRR1_MC_IFETCH_RA_TABLEWALK		12
+#define P9_SRR1_MC_IFETCH_RA_ASYNC_STORE		13
+#define P9_SRR1_MC_IFETCH_LINK_ASYNC_STORE_TIMEOUT	14
+#define P9_SRR1_MC_IFETCH_RA_TABLEWALK_FOREIGN	15
+
+/* DSISR bits for machine check (On Power9) */
+#define P9_DSISR_MC_UE					(PPC_BIT(48))
+#define P9_DSISR_MC_UE_TABLEWALK			(PPC_BIT(49))
+#define P9_DSISR_MC_LINK_LOAD_TIMEOUT			(PPC_BIT(50))
+#define P9_DSISR_MC_LINK_TABLEWALK_TIMEOUT		(PPC_BIT(51))
+#define P9_DSISR_MC_ERAT_MULTIHIT			(PPC_BIT(52))
+#define P9_DSISR_MC_TLB_MULTIHIT_MFTLB			(PPC_BIT(53))
+#define P9_DSISR_MC_USER_TLBIE				(PPC_BIT(54))
+#define P9_DSISR_MC_SLB_PARITY_MFSLB			(PPC_BIT(55))
+#define P9_DSISR_MC_SLB_MULTIHIT_MFSLB			(PPC_BIT(56))
+#define P9_DSISR_MC_RA_LOAD				(PPC_BIT(57))
+#define P9_DSISR_MC_RA_TABLEWALK			(PPC_BIT(58))
+#define P9_DSISR_MC_RA_TABLEWALK_FOREIGN		(PPC_BIT(59))
+#define P9_DSISR_MC_RA_FOREIGN				(PPC_BIT(60))
+
+/* SLB error bits */
+#define P9_DSISR_MC_SLB_ERRORS		(P9_DSISR_MC_ERAT_MULTIHIT | \
+					 P9_DSISR_MC_SLB_PARITY_MFSLB | \
+					 P9_DSISR_MC_SLB_MULTIHIT_MFSLB)
+
 static long mce_handle_derror_p7(uint64_t dsisr)
 {
 	return mce_handle_flush_derrors(dsisr,
-- 
2.11.0
