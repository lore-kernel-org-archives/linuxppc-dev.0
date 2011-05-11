Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 640F71009D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:40 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <bae1a50ee464fb9530bb5c922cb59d7e1f07833d.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:46 -0500
Subject: [PATCH 21/37] powerpc: use bytes instead of bitops in smp ipi
	multiplexing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since there are only 4 messages, we can replace the atomic bit set
(which uses atomic load reserve and store conditional sequence) with
a byte stores to seperate bytes.  We still have to perform a load
reserve and store conditional sequence to avoid loosing messages on
reception but we can do that with a single call to xchg.

The do {} while and __BIG_ENDIAN specific mask testing was chosen by
looking at the generated asm code.  On gcc-4.4, the bit masking becomes
a simple bit mask and test of the register returned from xchg without
storing and loading the value to the stack like attempts with a union
of bytes and an int (or worse, loading single bit constants from the
constant pool into non-voliatle registers that had to be preseved on
the stack).  The do {} while avoids an unconditional branch to the
end of the loop to test the entry / repeat condition of a while loop
and instead optimises for the expected single iteration of the loop.

We have a full mb() at the beginning to cover ordering between send,
ipi, and receive so we can use xchg_local and forgo the further
acquire and release barriers of xchg.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
v4: cast int to char ptr in msg send instead of char[] to int* for xchg/test
v3a: add resend to replace dorbell_check_self
v3: settle on casting from char message[4] __aligned(4) to int ptr
v2: try initialized messages
	(ended up with globals for each check value, increased reg pressure)
v1: initial version, check bytes though pointer to result of xchg
	(resulted in store to stack then byte load / compare / branch)
---
 arch/powerpc/kernel/smp.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a28e945..8321b0a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -180,7 +180,7 @@ int smp_request_message_ipi(int virq, int msg)
 
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 struct cpu_messages {
-	unsigned long messages;		/* current messages bits */
+	int messages;			/* current messages */
 	unsigned long data;		/* data for cause ipi */
 };
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct cpu_messages, ipi_message);
@@ -195,9 +195,9 @@ void smp_muxed_ipi_set_data(int cpu, unsigned long data)
 void smp_muxed_ipi_message_pass(int cpu, int msg)
 {
 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
-	unsigned long *tgt = &info->messages;
+	char *message = (char *)&info->messages;
 
-	set_bit(msg, tgt);
+	message[msg] = 1;
 	mb();
 	smp_ops->cause_ipi(cpu, info->data);
 }
@@ -205,30 +205,35 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 void smp_muxed_ipi_resend(void)
 {
 	struct cpu_messages *info = &__get_cpu_var(ipi_message);
-	unsigned long *tgt = &info->messages;
 
-	if (*tgt)
+	if (info->messages)
 		smp_ops->cause_ipi(smp_processor_id(), info->data);
 }
 
 irqreturn_t smp_ipi_demux(void)
 {
 	struct cpu_messages *info = &__get_cpu_var(ipi_message);
-	unsigned long *tgt = &info->messages;
+	unsigned int all;
 
 	mb();	/* order any irq clear */
-	while (*tgt) {
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt))
+
+	do {
+		all = xchg_local(&info->messages, 0);
+
+#ifdef __BIG_ENDIAN
+		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNCTION)))
 			generic_smp_call_function_interrupt();
-		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt))
+		if (all & (1 << (24 - 8 * PPC_MSG_RESCHEDULE)))
 			reschedule_action(0, NULL); /* upcoming sched hook */
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt))
+		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNC_SINGLE)))
 			generic_smp_call_function_single_interrupt();
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt))
+		if (all & (1 << (24 - 8 * PPC_MSG_DEBUGGER_BREAK)))
 			debug_ipi_action(0, NULL);
+#else
+#error Unsupported ENDIAN
 #endif
-	}
+	} while (info->messages);
+
 	return IRQ_HANDLED;
 }
 #endif /* CONFIG_PPC_SMP_MUXED_IPI */
-- 
1.7.0.4
