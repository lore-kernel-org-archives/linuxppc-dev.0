Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/4] powerpc: Clean up zImage handling of the command line
In-Reply-To: <20070321063031.GB30422@localhost.localdomain>
Message-Id: <20070321063150.07154DDE43@ozlabs.org>
Date: Wed, 21 Mar 2007 17:31:50 +1100 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up how the zImage code manipulates the kernel
command line.  Notable improvements from the old handling:
	- Command line manipulation is consolidated into a new
prep_cmdline() function, rather than being scattered across start()
and some helper functions
	- Less stack space use: we use just a single global command
line buffer, which can be initialized by an external tool as before,
we no longer need another command line sized buffer on the stack.
	- Easier to support platforms whose firmware passes a
commandline, but not a device tree.  Platform code can now point new
loader_info fields to the firmware's command line, rather than having
to do early manipulation of the /chosen bootargs property which may
then be rewritten again by the core.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/main.c |   55 +++++++++++++++++------------------------------
 arch/powerpc/boot/ops.h  |    2 +
 2 files changed, 23 insertions(+), 34 deletions(-)

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-21 16:50:55.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-21 16:59:37.000000000 +1100
@@ -206,31 +206,23 @@ static struct addr_range prep_initrd(str
  * edit the command line passed to vmlinux (by setting /chosen/bootargs).
  * The buffer is put in it's own section so that tools may locate it easier.
  */
-static char builtin_cmdline[COMMAND_LINE_SIZE]
+static char cmdline[COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
-static void get_cmdline(char *buf, int size)
+static void prep_cmdline(void)
 {
-	void *devp;
-	int len = strlen(builtin_cmdline);
+	if (cmdline[0] == '\0')
+		dt_path_getprop("/chosen", "bootargs",
+				cmdline, COMMAND_LINE_SIZE-1);
+
+	printf("\n\rLinux/PowerPC load: %s", cmdline);
+	/* If possible, edit the command line */
+	if (console_ops.edit_cmdline)
+		console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
+	printf("\n\r");
 
-	buf[0] = '\0';
-
-	if (len > 0) { /* builtin_cmdline overrides dt's /chosen/bootargs */
-		len = min(len, size-1);
-		strncpy(buf, builtin_cmdline, len);
-		buf[len] = '\0';
-	}
-	else if ((devp = finddevice("/chosen")))
-		getprop(devp, "bootargs", buf, size);
-}
-
-static void set_cmdline(char *buf)
-{
-	void *devp;
-
-	if ((devp = finddevice("/chosen")))
-		setprop(devp, "bootargs", buf, strlen(buf) + 1);
+	/* Put the command line back into the devtree for the kernel */
+	dt_path_setprop_str("/chosen", "bootargs", cmdline);
 }
 
 struct platform_ops platform_ops;
@@ -242,9 +234,15 @@ void start(void *sp)
 {
 	struct addr_range vmlinux, initrd;
 	kernel_entry_t kentry;
-	char cmdline[COMMAND_LINE_SIZE];
 	unsigned long ft_addr = 0;
 
+	/* Do this first, because malloc() could clobber the loader's
+	 * command line.  Only use the loader command line if a
+	 * built-in command line wasn't set by an external tool */
+	if ((loader_info.cmdline_len > 0) && (cmdline[0] == '\0'))
+		memmove(cmdline, loader_info.cmdline,
+			min(loader_info.cmdline_len, COMMAND_LINE_SIZE-1));
+
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
 	if (platform_ops.fixups)
@@ -260,18 +258,7 @@ void start(void *sp)
 	vmlinux = prep_kernel();
 	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
 			     loader_info.initrd_size);
-
-	/* If cmdline came from zimage wrapper or if we can edit the one
-	 * in the dt, print it out and edit it, if possible.
-	 */
-	if ((strlen(builtin_cmdline) > 0) || console_ops.edit_cmdline) {
-		get_cmdline(cmdline, COMMAND_LINE_SIZE);
-		printf("\n\rLinux/PowerPC load: %s", cmdline);
-		if (console_ops.edit_cmdline)
-			console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
-		printf("\n\r");
-		set_cmdline(cmdline);
-	}
+	prep_cmdline();
 
 	printf("Finalizing device tree...");
 	if (dt_ops.finalize)
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-21 16:50:55.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-21 16:59:37.000000000 +1100
@@ -70,6 +70,8 @@ struct serial_console_data {
 struct loader_info {
 	void *promptr;
 	unsigned long initrd_addr, initrd_size;
+	char *cmdline;
+	int cmdline_len;
 };
 extern struct loader_info loader_info;
 
