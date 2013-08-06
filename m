Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 31/63] powerpc: Little endian SMP IPI demux
Date: Wed,  7 Aug 2013 02:01:48 +1000
Message-Id: <1375804940-22050-32-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add little endian support for demuxing SMP IPIs

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/smp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 98822400..bcdb706 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -210,6 +210,12 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	smp_ops->cause_ipi(cpu, info->data);
 }
 
+#ifdef __BIG_ENDIAN__
+#define IPI_MESSAGE(A) (1 << (24 - 8 * (A)))
+#else
+#define IPI_MESSAGE(A) (1 << (8 * (A)))
+#endif
+
 irqreturn_t smp_ipi_demux(void)
 {
 	struct cpu_messages *info = &__get_cpu_var(ipi_message);
@@ -219,19 +225,14 @@ irqreturn_t smp_ipi_demux(void)
 
 	do {
 		all = xchg(&info->messages, 0);
-
-#ifdef __BIG_ENDIAN
-		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNCTION)))
+		if (all & IPI_MESSAGE(PPC_MSG_CALL_FUNCTION))
 			generic_smp_call_function_interrupt();
-		if (all & (1 << (24 - 8 * PPC_MSG_RESCHEDULE)))
+		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
-		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNC_SINGLE)))
+		if (all & IPI_MESSAGE(PPC_MSG_CALL_FUNC_SINGLE))
 			generic_smp_call_function_single_interrupt();
-		if (all & (1 << (24 - 8 * PPC_MSG_DEBUGGER_BREAK)))
+		if (all & IPI_MESSAGE(PPC_MSG_DEBUGGER_BREAK))
 			debug_ipi_action(0, NULL);
-#else
-#error Unsupported ENDIAN
-#endif
 	} while (info->messages);
 
 	return IRQ_HANDLED;
-- 
1.8.1.2
