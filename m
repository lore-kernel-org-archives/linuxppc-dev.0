Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/perf: Add an accessor for regs->result
Date: Wed, 10 Apr 2013 18:32:43 +1000
Message-Id: <1365582765-6939-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
References: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michaele@au1.ibm.com>

Add an accessor for regs->result so we can use it to store more flags in
future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index cb1618d..770f359 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -132,6 +132,11 @@ static bool regs_sipr(struct pt_regs *regs)
 	return !!(regs->dsisr & sipr);
 }
 
+static bool regs_use_siar(struct pt_regs *regs)
+{
+	return !!(regs->result & 1);
+}
+
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_PR)
@@ -143,7 +148,7 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
-	unsigned long use_siar = regs->result;
+	bool use_siar = regs_use_siar(regs);
 
 	if (!use_siar)
 		return perf_flags_from_msr(regs);
@@ -1413,7 +1418,7 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
  */
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	unsigned long use_siar = regs->result;
+	bool use_siar = regs_use_siar(regs);
 
 	if (use_siar && siar_valid(regs))
 		return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
-- 
1.7.10.4
