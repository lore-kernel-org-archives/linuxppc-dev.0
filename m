Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D123DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:42:05 +1000 (EST)
Message-ID: <4644AAE7.8050406@am.sony.com>
Date: Fri, 11 May 2007 10:41:59 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix request_irq warning
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix compiler warning:

ps3/smp.c:122: warning: ignoring return value of 'request_irq'

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/smp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/smp.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/smp.c
@@ -118,9 +118,11 @@ static void __init ps3_smp_setup_cpu(int
 		DBG("%s:%d: (%d, %d) => virq %u\n",
 			__func__, __LINE__, cpu, i, virqs[i]);
 
+		result = request_irq(virqs[i], ipi_function_handler,
+			IRQF_DISABLED, names[i], (void*)(long)i);
 
-		request_irq(virqs[i], ipi_function_handler, IRQF_DISABLED,
-			names[i], (void*)(long)i);
+		if (result)
+			virqs[i] = NO_IRQ;
 	}
 
 	ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
