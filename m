Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91EEB100ACE
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 13:19:54 +1100 (EST)
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 8 Nov 2011 14:38:21 -0800
Subject: [PATCH 2/2] powerpc/ps3: Fix SMP lockdep boot warning
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <E1RNxlX-0000xO-0e@casper.infradead.org>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
 Andre Heider <a.heider@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the PS3 IPI message setup from ps3_smp_setup_cpu() to ps3_smp_probe().

Fixes startup warnings like these:

  ------------[ cut here ]------------
  WARNING: at kernel/lockdep.c:2649
  Modules linked in:
  ...
  ---[ end trace 31fd0ba7d8756001 ]---

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/smp.c |   64 +++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index f609345..efc1cd8 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -59,48 +59,49 @@ static void ps3_smp_message_pass(int cpu, int msg)
 
 static int ps3_smp_probe(void)
 {
-	return 2;
-}
+	int cpu;
 
-static void __init ps3_smp_setup_cpu(int cpu)
-{
-	int result;
-	unsigned int *virqs = per_cpu(ps3_ipi_virqs, cpu);
-	int i;
+	for (cpu = 0; cpu < 2; cpu++) {
+		int result;
+		unsigned int *virqs = per_cpu(ps3_ipi_virqs, cpu);
+		int i;
 
-	DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
+		DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
 
-	/*
-	 * Check assumptions on ps3_ipi_virqs[] indexing. If this
-	 * check fails, then a different mapping of PPC_MSG_
-	 * to index needs to be setup.
-	 */
+		/*
+		* Check assumptions on ps3_ipi_virqs[] indexing. If this
+		* check fails, then a different mapping of PPC_MSG_
+		* to index needs to be setup.
+		*/
 
-	BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
-	BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
-	BUILD_BUG_ON(PPC_MSG_CALL_FUNC_SINGLE != 2);
-	BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
+		BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
+		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
+		BUILD_BUG_ON(PPC_MSG_CALL_FUNC_SINGLE != 2);
+		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
 
-	for (i = 0; i < MSG_COUNT; i++) {
-		result = ps3_event_receive_port_setup(cpu, &virqs[i]);
+		for (i = 0; i < MSG_COUNT; i++) {
+			result = ps3_event_receive_port_setup(cpu, &virqs[i]);
 
-		if (result)
-			continue;
+			if (result)
+				continue;
 
-		DBG("%s:%d: (%d, %d) => virq %u\n",
-			__func__, __LINE__, cpu, i, virqs[i]);
+			DBG("%s:%d: (%d, %d) => virq %u\n",
+				__func__, __LINE__, cpu, i, virqs[i]);
 
-		result = smp_request_message_ipi(virqs[i], i);
+			result = smp_request_message_ipi(virqs[i], i);
 
-		if (result)
-			virqs[i] = NO_IRQ;
-		else
-			ps3_register_ipi_irq(cpu, virqs[i]);
-	}
+			if (result)
+				virqs[i] = NO_IRQ;
+			else
+				ps3_register_ipi_irq(cpu, virqs[i]);
+		}
 
-	ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
+		ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
 
-	DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
+		DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
+	}
+
+	return 2;
 }
 
 void ps3_smp_cleanup_cpu(int cpu)
@@ -123,7 +124,6 @@ static struct smp_ops_t ps3_smp_ops = {
 	.probe		= ps3_smp_probe,
 	.message_pass	= ps3_smp_message_pass,
 	.kick_cpu	= smp_generic_kick_cpu,
-	.setup_cpu	= ps3_smp_setup_cpu,
 };
 
 void smp_init_ps3(void)
-- 
1.7.0.4
