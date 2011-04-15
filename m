Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <429163ad3a37365b872741a4cb2fe7ae52c865f8.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 09/15] powerpc: Add TLB size detection for TYPE_3E MMUs
Date: Fri, 15 Apr 2011 18:32:02 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu-book3e.h |   15 +++++++++++++++
 arch/powerpc/mm/mmu_context_nohash.c  |   12 +++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index f6e7d40..3903d0c 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -137,6 +137,21 @@
 #define MMUCSR0_TLB2PS	0x00078000	/* TLB2 Page Size */
 #define MMUCSR0_TLB3PS	0x00780000	/* TLB3 Page Size */
 
+/* MMUCFG bits */
+#define MMUCFG_MAVN_NASK	0x00000003
+#define MMUCFG_MAVN_V1_0	0x00000000
+#define MMUCFG_MAVN_V2_0	0x00000001
+#define MMUCFG_NTLB_MASK	0x0000000c
+#define MMUCFG_NTLB_SHIFT	2
+#define MMUCFG_PIDSIZE_MASK	0x000007c0
+#define MMUCFG_PIDSIZE_SHIFT	6
+#define MMUCFG_TWC		0x00008000
+#define MMUCFG_LRAT		0x00010000
+#define MMUCFG_RASIZE_MASK	0x00fe0000
+#define MMUCFG_RASIZE_SHIFT	17
+#define MMUCFG_LPIDSIZE_MASK	0x0f000000
+#define MMUCFG_LPIDSIZE_SHIFT	24
+
 /* TLBnCFG encoding */
 #define TLBnCFG_N_ENTRY		0x00000fff	/* number of entries */
 #define TLBnCFG_HES		0x00002000	/* HW select supported */
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 4d8fa91..336807d 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -409,7 +409,17 @@ void __init mmu_context_init(void)
 	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
 		first_context = 1;
 		last_context = 65535;
-	} else {
+	} else
+#ifdef CONFIG_PPC_BOOK3E_MMU
+	if (mmu_has_feature(MMU_FTR_TYPE_3E)) {
+		u32 mmucfg = mfspr(SPRN_MMUCFG);
+		u32 pid_bits = (mmucfg & MMUCFG_PIDSIZE_MASK)
+				>> MMUCFG_PIDSIZE_SHIFT;
+		first_context = 1;
+		last_context = (1UL << (pid_bits + 1)) - 1;
+	} else
+#endif
+	{
 		first_context = 1;
 		last_context = 255;
 	}
-- 
1.7.1
