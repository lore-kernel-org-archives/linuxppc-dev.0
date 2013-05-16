Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/perf: Add missing SIER support
Date: Thu, 16 May 2013 16:19:31 +1000
Message-Id: <1368685171-1948-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1368685171-1948-1-git-send-email-michael@ellerman.id.au>
References: <1368685171-1948-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8f61aa3 "Add support for SIER" missed updates to siar_valid()
and perf_get_data_addr().

In both cases we need to check the SIER instead of mmcra.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b2f873b..845c867 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -136,22 +136,30 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
  * If we're not doing instruction sampling, give them the SDAR
  * (sampled data address).  If we are doing instruction sampling, then
  * only give them the SDAR if it corresponds to the instruction
- * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC or
- * the [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA.
+ * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC, the
+ * [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA, or the SDAR_VALID bit in SIER.
  */
 static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 {
 	unsigned long mmcra = regs->dsisr;
-	unsigned long sdsync;
+	bool sdar_valid;
 
-	if (ppmu->flags & PPMU_SIAR_VALID)
-		sdsync = POWER7P_MMCRA_SDAR_VALID;
-	else if (ppmu->flags & PPMU_ALT_SIPR)
-		sdsync = POWER6_MMCRA_SDSYNC;
-	else
-		sdsync = MMCRA_SDSYNC;
+	if (ppmu->flags & PPMU_HAS_SIER)
+		sdar_valid = regs->dar & SIER_SDAR_VALID;
+	else {
+		unsigned long sdsync;
+
+		if (ppmu->flags & PPMU_SIAR_VALID)
+			sdsync = POWER7P_MMCRA_SDAR_VALID;
+		else if (ppmu->flags & PPMU_ALT_SIPR)
+			sdsync = POWER6_MMCRA_SDSYNC;
+		else
+			sdsync = MMCRA_SDSYNC;
 
-	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || (mmcra & sdsync))
+		sdar_valid = mmcra & sdsync;
+	}
+
+	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
 		*addrp = mfspr(SPRN_SDAR);
 }
 
@@ -290,8 +298,13 @@ static inline int siar_valid(struct pt_regs *regs)
 	unsigned long mmcra = regs->dsisr;
 	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
 
-	if ((ppmu->flags & PPMU_SIAR_VALID) && marked)
-		return mmcra & POWER7P_MMCRA_SIAR_VALID;
+	if (marked) {
+		if (ppmu->flags & PPMU_HAS_SIER)
+			return regs->dar & SIER_SIAR_VALID;
+
+		if (ppmu->flags & PPMU_SIAR_VALID)
+			return mmcra & POWER7P_MMCRA_SIAR_VALID;
+	}
 
 	return 1;
 }
-- 
1.7.10.4
