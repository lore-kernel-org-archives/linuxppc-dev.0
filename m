Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:36:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 11/17] bootwrapper: Make set_cmdline non-static,
	and accept a const buffer.
Message-ID: <20070317013610.GI3969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172857.GK29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172857.GK29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:28:57PM -0500, Scott Wood wrote:
> This allows platform code to call set_cmdline to initialize
> /chosen/bootargs with a command line passed by the bootloader.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Ugh, can we hold off on this and the other cmdline related one for a
little.  I had a different approach for cleaning up the cmdline
handling to make it easier for the platform to set the command line.
Um.. patch below.  It won't work, as is, because it depends on my
unfinished device tree utils patch, but with luck the idea will be
clear enough.

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-16 15:09:24.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-16 16:14:46.000000000 +1100
@@ -211,31 +211,22 @@ static struct addr_range prep_initrd(str
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
-
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
+	if (cmdline[0] == '\0')
+		dt_path_getprop("/chosen", "bootargs", cmdline,
+				COMMAND_LINE_SIZE-1);
+
+	printf("\n\rLinux/PowerPC load: %s", cmdline);
+	/* If possible, edit the command line */
+	if (console_ops.edit_cmdline)
+		console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
+	printf("\n\r");
+	/* Put the command line back into the devtree for the kernel */
+	dt_fixup_prop_str("/chosen", "bootargs", cmdline);
 }
 
 struct platform_ops platform_ops;
@@ -247,9 +238,15 @@ void start(void)
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
@@ -260,18 +257,7 @@ void start(void)
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
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-16 15:09:24.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-16 16:12:30.000000000 +1100
@@ -63,6 +63,8 @@ struct serial_console_data {
 struct loader_info {
 	void *promptr;
 	unsigned long initrd_addr, initrd_size;
+	char *cmdline;
+	int cmdline_len;
 };
 extern struct loader_info loader_info;
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
