Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 294E5DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 12:59:34 +1000 (EST)
Message-ID: <4666230D.4020902@am.sony.com>
Date: Tue, 05 Jun 2007 19:59:25 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [patch 02/18] PS3: Rename IPI symbols
References: <20070606024407.786638029@am.sony.com>>
In-Reply-To: <20070606024407.786638029@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the PS3 static symbol virqs to ps3_ipi_virqs to aid in
debugging.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/smp.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -39,11 +39,11 @@ static irqreturn_t ipi_function_handler(
 }
 
 /**
-  * virqs - a per cpu array of virqs for ipi use
+  * ps3_ipi_virqs - a per cpu array of virqs for ipi use
   */
 
 #define MSG_COUNT 4
-static DEFINE_PER_CPU(unsigned int, virqs[MSG_COUNT]);
+static DEFINE_PER_CPU(unsigned int, ps3_ipi_virqs[MSG_COUNT]);
 
 static const char *names[MSG_COUNT] = {
 	"ipi call",
@@ -62,7 +62,7 @@ static void do_message_pass(int target, 
 		return;
 	}
 
-	virq = per_cpu(virqs, target)[msg];
+	virq = per_cpu(ps3_ipi_virqs, target)[msg];
 	result = ps3_send_event_locally(virq);
 
 	if (result)
@@ -94,13 +94,13 @@ static int ps3_smp_probe(void)
 static void __init ps3_smp_setup_cpu(int cpu)
 {
 	int result;
-	unsigned int *virqs = per_cpu(virqs, cpu);
+	unsigned int *virqs = per_cpu(ps3_ipi_virqs, cpu);
 	int i;
 
 	DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
 
 	/*
-	 * Check assumptions on virqs[] indexing. If this
+	 * Check assumptions on ps3_ipi_virqs[] indexing. If this
 	 * check fails, then a different mapping of PPC_MSG_
 	 * to index needs to be setup.
 	 */
@@ -132,13 +132,13 @@ static void __init ps3_smp_setup_cpu(int
 
 void ps3_smp_cleanup_cpu(int cpu)
 {
-	unsigned int *virqs = per_cpu(virqs, cpu);
+	unsigned int *virqs = per_cpu(ps3_ipi_virqs, cpu);
 	int i;
 
 	DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
 
 	for (i = 0; i < MSG_COUNT; i++) {
-		free_irq(virqs[i], (void*)(long)i);
+		/* Can't call free_irq from interrupt context. */
 		ps3_event_receive_port_destroy(virqs[i]);
 		virqs[i] = NO_IRQ;
 	}

-- 
