Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/20] powerpc/perf: Enable BHRB access for EBB events
Date: Fri, 14 Mar 2014 16:00:34 +1100
Message-Id: <1394773245-18328-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous commit added constraint and register handling to allow
processes using EBB (Event Based Branches) to request access to the BHRB
(Branch History Rolling Buffer).

With that in place we can allow processes using EBB to access the BHRB.
This is achieved by setting BHRBA in MMCR0 when we enable EBB access. We
must also clear BHRBA when we are disabling.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h  |  1 +
 arch/powerpc/perf/core-book3s.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3003472..980e8db 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -664,6 +664,7 @@
 #define   MMCR0_PMXE	0x04000000UL /* performance monitor exception enable */
 #define   MMCR0_FCECE	0x02000000UL /* freeze ctrs on enabled cond or event */
 #define   MMCR0_TBEE	0x00400000UL /* time base exception enable */
+#define   MMCR0_BHRBA	0x00200000UL /* BHRB Access allowed in userspace */
 #define   MMCR0_EBE	0x00100000UL /* Event based branch enable */
 #define   MMCR0_PMCC	0x000c0000UL /* PMC control */
 #define   MMCR0_PMCC_U6	0x00080000UL /* PMC1-6 are R/W by user (PR) */
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1e095fd..4520c93 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -78,6 +78,7 @@ static unsigned int freeze_events_kernel = MMCR0_FCS;
 #define MMCR0_FC56		0
 #define MMCR0_PMAO		0
 #define MMCR0_EBE		0
+#define MMCR0_BHRBA		0
 #define MMCR0_PMCC		0
 #define MMCR0_PMCC_U6		0
 
@@ -546,8 +547,8 @@ static unsigned long ebb_switch_in(bool ebb, unsigned long mmcr0)
 	if (!ebb)
 		goto out;
 
-	/* Enable EBB and read/write to all 6 PMCs for userspace */
-	mmcr0 |= MMCR0_EBE | MMCR0_PMCC_U6;
+	/* Enable EBB and read/write to all 6 PMCs and BHRB for userspace */
+	mmcr0 |= MMCR0_EBE | MMCR0_BHRBA | MMCR0_PMCC_U6;
 
 	/*
 	 * Add any bits from the user MMCR0, FC or PMAO. This is compatible
@@ -1117,11 +1118,12 @@ static void power_pmu_disable(struct pmu *pmu)
 		}
 
 		/*
-		 * Set the 'freeze counters' bit, clear EBE/PMCC/PMAO/FC56.
+		 * Set the 'freeze counters' bit, clear EBE/BHRBA/PMCC/PMAO/FC56
 		 */
 		val  = mmcr0 = mfspr(SPRN_MMCR0);
 		val |= MMCR0_FC;
-		val &= ~(MMCR0_EBE | MMCR0_PMCC | MMCR0_PMAO | MMCR0_FC56);
+		val &= ~(MMCR0_EBE | MMCR0_BHRBA | MMCR0_PMCC | MMCR0_PMAO |
+			 MMCR0_FC56);
 
 		/*
 		 * The barrier is to make sure the mtspr has been
-- 
1.8.3.2
