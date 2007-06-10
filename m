Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1F695DDFB9
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 15:54:27 +1000 (EST)
Date: Sat, 9 Jun 2007 23:32:43 -0500
From: Milton Miller <miltonm@bga.com>
To: dale@farnsworth.org, mgreer@mvista.com, paulus@samba.org, paulus@samba.org,
Subject: [PATCH] Don't register udbg_console without udbg_putc
Message-Id: <111814499636b8b45671.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, registering this early console would just result
in dropping early buffered printk output until a udbg_putc
was registered.

However, commit 69331af79cf29e26d1231152a172a1a10c2df511
clears the CON_PRINTBUFFER flag on the main console when a
CON_BOOT (early) console has been registered, resulting in
the buffered messages never being displayed to the user.

Signed-off-by: Milton Miller <miltonm@bga.com>

--- 
Mark and Dale can you test this please?

The call in the common code is made after ->early_init and
before ->setup_arch on both 32 and 64 bit.  If a platform
were to set udbg_putc from the setup_arch hook previosly it
would display output from the point of setting that hook.
After this patch it will not get any output until the main
console registers unless it calls register_early_udbg_console.
I didn't see any platforms that do this in my 5 minute check.

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 87703df..993eedc 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -151,12 +151,18 @@ static struct console udbg_console = {
 
 static int early_console_initialized;
 
-/* called by setup_system */
+/*
+ * Called by setup_system after ppc_md->probe and ppc_md->early_init.
+ * Call it again after setting udbg_putc in ppc_md->setup_arch.
+ */
 void register_early_udbg_console(void)
 {
 	if (early_console_initialized)
 		return;
 
+	if (!udbg_putc)
+		return;
+
 	if (strstr(boot_command_line, "udbg-immortal")) {
 		printk(KERN_INFO "early console immortal !\n");
 		udbg_console.flags &= ~CON_BOOT;
