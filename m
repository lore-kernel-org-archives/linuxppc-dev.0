Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0nZM6xLXzDrQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 09:07:39 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so4397990pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 16:07:39 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] powerpc: Factor out common code in setup-common.c
Date: Thu, 28 Jul 2016 16:07:16 -0700
Message-Id: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out a small bit of common code in machine_restart(),
machine_power_off() and machine_halt().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

No changes compared to v1.

 arch/powerpc/kernel/setup-common.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 714b4ba..5cd3283 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -130,15 +130,22 @@ void machine_shutdown(void)
 		ppc_md.machine_shutdown();
 }
 
+static void machine_hang(void)
+{
+	pr_emerg("System Halted, OK to turn off power\n");
+	local_irq_disable();
+	while (1)
+		;
+}
+
 void machine_restart(char *cmd)
 {
 	machine_shutdown();
 	if (ppc_md.restart)
 		ppc_md.restart(cmd);
+
 	smp_send_stop();
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
-	local_irq_disable();
-	while (1) ;
+	machine_hang();
 }
 
 void machine_power_off(void)
@@ -146,10 +153,9 @@ void machine_power_off(void)
 	machine_shutdown();
 	if (pm_power_off)
 		pm_power_off();
+
 	smp_send_stop();
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
-	local_irq_disable();
-	while (1) ;
+	machine_hang();
 }
 /* Used by the G5 thermal driver */
 EXPORT_SYMBOL_GPL(machine_power_off);
@@ -162,10 +168,9 @@ void machine_halt(void)
 	machine_shutdown();
 	if (ppc_md.halt)
 		ppc_md.halt();
+
 	smp_send_stop();
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
-	local_irq_disable();
-	while (1) ;
+	machine_hang();
 }
 
 
-- 
2.5.5
