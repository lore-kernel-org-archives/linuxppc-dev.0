Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 88251DE598
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:54 +1100 (EST)
Message-ID: <45BAC223.7020207@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 12/16] ps3: remove cpuinfo
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the unneded routine ps3_show_cpuinfo().  The common platform code now
prints the same information.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/setup.c |    6 ------
 1 files changed, 6 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -41,11 +41,6 @@
 #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
 #endif
 
-static void ps3_show_cpuinfo(struct seq_file *m)
-{
-	seq_printf(m, "machine\t\t: %s\n", ppc_md.name);
-}
-
 static void ps3_power_save(void)
 {
 	/*
@@ -156,7 +151,6 @@ define_machine(ps3) {
 	.name				= "PS3",
 	.probe				= ps3_probe,
 	.setup_arch			= ps3_setup_arch,
-	.show_cpuinfo			= ps3_show_cpuinfo,
 	.init_IRQ			= ps3_init_IRQ,
 	.panic				= ps3_panic,
 	.get_boot_time			= ps3_get_boot_time,
