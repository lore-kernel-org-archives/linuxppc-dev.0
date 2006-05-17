Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 May 2006 18:00:45 +1000
Subject: [PATCH 2/5] powerpc: Parse early parameters early,
	rather than sorta early
In-Reply-To: <1147852841.148164.91320074069.qpush@concordia>
Message-Id: <20060517080044.A2214679EF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we have call parse_early_param() earliyish, but not really very
early. In particular, it's not early enough to do things like mem=x or
crashkernel=blah, which is annoying.

So do it earlier. I've checked all the early param handlers, and none of them
look like they should have any trouble with this. I haven't tested the
booke_wdt ones though.

On 32-bit we were doing the CONFIG_CMDLINE logic twice, so don't.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom.c     |    5 +++++
 arch/powerpc/kernel/setup_32.c |   14 ++------------
 arch/powerpc/kernel/setup_64.c |    5 -----
 3 files changed, 7 insertions(+), 17 deletions(-)

Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -1292,6 +1292,11 @@ void __init early_init_devtree(void *par
 	lmb_init();
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+
+	/* Save command line for /proc/cmdline and then parse parameters */
+	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	parse_early_param();
+
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
 
Index: to-merge/arch/powerpc/kernel/setup_32.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_32.c
+++ to-merge/arch/powerpc/kernel/setup_32.c
@@ -131,12 +131,6 @@ void __init machine_init(unsigned long d
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
-	/* Check default command line */
-#ifdef CONFIG_CMDLINE
-	if (cmd_line[0] == 0)
-		strlcpy(cmd_line, CONFIG_CMDLINE, sizeof(cmd_line));
-#endif /* CONFIG_CMDLINE */
-
 	probe_machine();
 
 #ifdef CONFIG_6xx
@@ -237,6 +231,8 @@ void __init setup_arch(char **cmdline_p)
 {
 	extern void do_init_bootmem(void);
 
+	*cmdline_p = cmd_line;
+
 	/* so udelay does something sensible, assume <= 1000 bogomips */
 	loops_per_jiffy = 500000000 / HZ;
 
@@ -290,12 +286,6 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
-	*cmdline_p = cmd_line;
-
-	parse_early_param();
-
 	if (do_early_xmon)
 		debugger(NULL);
 
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -420,11 +420,6 @@ void __init setup_system(void)
 	 */
 	register_early_udbg_console();
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
-
-	parse_early_param();
-
 	if (do_early_xmon)
 		debugger(NULL);
 
