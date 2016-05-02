Return-Path: <chris@distroguy.com>
Received: from mx-out01.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qytw74ftBzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 16:01:10 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out01.mykolab.com (Postfix) with ESMTPS id 36B306110C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 08:01:04 +0200 (CEST)
Date: Mon, 2 May 2016 16:00:58 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove unnecessary CONFIG_SMP #ifdefs
Message-ID: <20160502060052.GA12822@distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code in machine_restart/power_off/halt() includes #ifdefs around
calls to smp_send_stop(), however these are not required as
include/linux/smp.h includes an empty version of this function for
CONFIG_SMP=n builds.

Signed-off-by: Chris Smart <chris@distroguy.com>
---
 arch/powerpc/kernel/setup-common.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 44c8d03558ac..8ca79b7503d8 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -128,9 +128,7 @@ void machine_restart(char *cmd)
 	machine_shutdown();
 	if (ppc_md.restart)
 		ppc_md.restart(cmd);
-#ifdef CONFIG_SMP
 	smp_send_stop();
-#endif
 	printk(KERN_EMERG "System Halted, OK to turn off power\n");
 	local_irq_disable();
 	while (1) ;
@@ -141,9 +139,7 @@ void machine_power_off(void)
 	machine_shutdown();
 	if (pm_power_off)
 		pm_power_off();
-#ifdef CONFIG_SMP
 	smp_send_stop();
-#endif
 	printk(KERN_EMERG "System Halted, OK to turn off power\n");
 	local_irq_disable();
 	while (1) ;
@@ -159,9 +155,7 @@ void machine_halt(void)
 	machine_shutdown();
 	if (ppc_md.halt)
 		ppc_md.halt();
-#ifdef CONFIG_SMP
 	smp_send_stop();
-#endif
 	printk(KERN_EMERG "System Halted, OK to turn off power\n");
 	local_irq_disable();
 	while (1) ;
-- 
2.5.5
