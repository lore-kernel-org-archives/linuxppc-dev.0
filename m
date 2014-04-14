Return-Path: <anton@samba.org>
Date: Mon, 14 Apr 2014 21:54:05 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/3] powerpc: Rename duplicate COMMAND_LINE_SIZE define
Message-ID: <20140414215405.319725d5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have two definitions of COMMAND_LINE_SIZE, one for the kernel
and one for the boot wrapper. I assume this is so the boot
wrapper can be self sufficient and not rely on kernel headers.

Having two defines with the same name is confusing, I just
updated the wrong one when trying to bump it.

Make the boot wrapper define unique by calling it
BOOT_COMMAND_LINE_SIZE.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index a28f021..d367a0a 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -139,18 +139,18 @@ static struct addr_range prep_initrd(struct addr_range vmlinux, void *chosen,
  * edit the command line passed to vmlinux (by setting /chosen/bootargs).
  * The buffer is put in it's own section so that tools may locate it easier.
  */
-static char cmdline[COMMAND_LINE_SIZE]
+static char cmdline[BOOT_COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
 static void prep_cmdline(void *chosen)
 {
 	if (cmdline[0] == '\0')
-		getprop(chosen, "bootargs", cmdline, COMMAND_LINE_SIZE-1);
+		getprop(chosen, "bootargs", cmdline, BOOT_COMMAND_LINE_SIZE-1);
 
 	printf("\n\rLinux/PowerPC load: %s", cmdline);
 	/* If possible, edit the command line */
 	if (console_ops.edit_cmdline)
-		console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
+		console_ops.edit_cmdline(cmdline, BOOT_COMMAND_LINE_SIZE);
 	printf("\n\r");
 
 	/* Put the command line back into the devtree for the kernel */
@@ -174,7 +174,7 @@ void start(void)
 	 * built-in command line wasn't set by an external tool */
 	if ((loader_info.cmdline_len > 0) && (cmdline[0] == '\0'))
 		memmove(cmdline, loader_info.cmdline,
-			min(loader_info.cmdline_len, COMMAND_LINE_SIZE-1));
+			min(loader_info.cmdline_len, BOOT_COMMAND_LINE_SIZE-1));
 
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index b3218ce..339e041 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -15,7 +15,7 @@
 #include "types.h"
 #include "string.h"
 
-#define	COMMAND_LINE_SIZE	512
+#define	BOOT_COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
 
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 9954d98..4ec2d86 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -47,13 +47,13 @@ BSS_STACK(4096);
  * The buffer is put in it's own section so that tools may locate it easier.
  */
 
-static char cmdline[COMMAND_LINE_SIZE]
+static char cmdline[BOOT_COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
 static void prep_cmdline(void *chosen)
 {
 	if (cmdline[0] == '\0')
-		getprop(chosen, "bootargs", cmdline, COMMAND_LINE_SIZE-1);
+		getprop(chosen, "bootargs", cmdline, BOOT_COMMAND_LINE_SIZE-1);
 	else
 		setprop_str(chosen, "bootargs", cmdline);
 
