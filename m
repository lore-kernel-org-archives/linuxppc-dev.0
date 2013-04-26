Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/7] powerpc/perf: Add an accessor for regs->result
Date: Fri, 26 Apr 2013 15:28:25 +1000
Message-Id: <1366954108-27081-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1366954108-27081-1-git-send-email-michael@ellerman.id.au>
References: <1366954108-27081-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an accessor for regs->result so we can use it to store more flags in
future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2417fe2..5d30001 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -89,6 +89,11 @@ static inline int siar_valid(struct pt_regs *regs)
 
 #endif /* CONFIG_PPC32 */
 
+static bool regs_use_siar(struct pt_regs *regs)
+{
+	return !!(regs->result & 1);
+}
+
 /*
  * Things that are specific to 64-bit implementations.
  */
@@ -162,7 +167,7 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
-	unsigned long use_siar = regs->result;
+	bool use_siar = regs_use_siar(regs);
 
 	if (!use_siar)
 		return perf_flags_from_msr(regs);
@@ -1425,7 +1430,7 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
  */
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	unsigned long use_siar = regs->result;
+	bool use_siar = regs_use_siar(regs);
 
 	if (use_siar && siar_valid(regs))
 		return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
-- 
1.7.10.4
