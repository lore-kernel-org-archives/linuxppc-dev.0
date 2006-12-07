Return-Path: <MAILER-DAEMON@rune.sasl.smtp.pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 6D1FD67C88
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 12:51:16 +1100 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id E172F421580
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 19:51:21 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] maple: use RTAS for reboot and halt
Date: Wed,  6 Dec 2006 18:50:46 -0600
Message-Id: <11654526562443-git-send-email-ntl@pobox.com>
In-Reply-To: <11654526533213-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<11654526511379-git-send-email-ntl@pobox.com>
	<11654526533213-git-send-email-ntl@pobox.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On maple, use the RTAS "system-reboot" and "power-off" methods if they
are available.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 094989d..f12d5c6 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -60,6 +60,7 @@
 #include <asm/of_device.h>
 #include <asm/lmb.h>
 #include <asm/mpic.h>
+#include <asm/rtas.h>
 #include <asm/udbg.h>
 
 #include "maple.h"
@@ -166,6 +167,16 @@ struct smp_ops_t maple_smp_ops = {
 };
 #endif /* CONFIG_SMP */
 
+static void __init maple_use_rtas_reboot_and_halt_if_present(void)
+{
+	if (rtas_service_present("system-reboot") &&
+	    rtas_service_present("power-off")) {
+		ppc_md.restart = rtas_restart;
+		ppc_md.power_off = rtas_power_off;
+		ppc_md.halt = rtas_halt;
+	}
+}
+
 void __init maple_setup_arch(void)
 {
 	/* init to some ~sane value until calibrate_delay() runs */
@@ -181,6 +192,7 @@ void __init maple_setup_arch(void)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
+	maple_use_rtas_reboot_and_halt_if_present();
 
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
 }
-- 
1.4.4.1
