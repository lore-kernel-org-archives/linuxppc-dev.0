Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 7B38B67B94
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 00:29:24 +1000 (EST)
Date: Fri, 8 Sep 2006 16:29:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] print backtrace when entering xmon
Message-ID: <20060908142921.GA32758@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


xmon does not print a backtrace per default. This is bad on systems with 
USB keyboard, the most needed info about the crash is lost.
print a backtrace during the very first xmon entry.

Booting with xmon=nobt disables the autobacktrace functionality.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

 arch/powerpc/Kconfig.debug         |    2 ++
 arch/powerpc/kernel/setup-common.c |    4 ++++
 arch/powerpc/xmon/xmon.c           |   10 ++++++++++
 3 files changed, 16 insertions(+)

Index: linux-2.6.18-rc6/arch/powerpc/Kconfig.debug
===================================================================
--- linux-2.6.18-rc6.orig/arch/powerpc/Kconfig.debug
+++ linux-2.6.18-rc6/arch/powerpc/Kconfig.debug
@@ -74,6 +74,8 @@ config XMON
 	  very early during boot. 'xmon=on' will just enable the xmon
 	  debugger hooks.  'xmon=off' will disable the debugger hooks
 	  if CONFIG_XMON_DEFAULT is set.
+	  xmon will print a backtrace on the very first invocation.
+	  'xmon=nobt' will disable this autobacktrace.
 
 config XMON_DEFAULT
 	bool "Enable xmon by default"
Index: linux-2.6.18-rc6/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.18-rc6.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6.18-rc6/arch/powerpc/kernel/setup-common.c
@@ -444,6 +444,8 @@ void __init smp_setup_cpu_maps(void)
 
 int __initdata do_early_xmon;
 #ifdef CONFIG_XMON
+extern int xmon_no_auto_backtrace;
+
 static int __init early_xmon(char *p)
 {
 	/* ensure xmon is enabled */
@@ -452,6 +454,8 @@ static int __init early_xmon(char *p)
 			xmon_init(1);
 		if (strncmp(p, "off", 3) == 0)
 			xmon_init(0);
+		if (strncmp(p, "nobt", 4) == 0)
+			xmon_no_auto_backtrace = 1;
 		if (strncmp(p, "early", 5) != 0)
 			return 0;
 	}
Index: linux-2.6.18-rc6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.18-rc6.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6.18-rc6/arch/powerpc/xmon/xmon.c
@@ -137,10 +137,14 @@ static void bootcmds(void);
 static void proccall(void);
 void dump_segments(void);
 static void symbol_lookup(void);
+static void xmon_show_stack(unsigned long sp, unsigned long lr,
+			    unsigned long pc);
 static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after);
 static const char *getvecname(unsigned long vec);
 
+int xmon_no_auto_backtrace;
+
 extern int print_insn_powerpc(unsigned long, unsigned long, int);
 
 extern void xmon_enter(void);
@@ -736,6 +740,12 @@ cmds(struct pt_regs *excp)
 
 	last_cmd = NULL;
 	xmon_regs = excp;
+
+	if (!xmon_no_auto_backtrace) {
+		xmon_no_auto_backtrace = 1;
+		xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
+	}
+
 	for(;;) {
 #ifdef CONFIG_SMP
 		printf("%x:", smp_processor_id());
