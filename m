Message-ID: <C97ABDA0DC2DD511BA400002A5097413280505@jdry.lanier.com>
From: "Donovan, Chris" <cdonovan@lanier.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Patch to compile for Oak
Date: Tue, 25 Sep 2001 09:06:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been working with the development tree trying to get it to compile for
an oak board. I have been compiling using a cross-compiler under Solaris. If
there is anyone else that is working on this, I would appreciate it if you
could take a look at the following patch and provide me any feedback. Also,
how do I get this merged in with the current development tree? Thanks.
Chris Donovan
Lanier Worldwide

diff -u --recursive --new-file
linuxppc_2_4_devel.orig/arch/ppc/boot/common/relocate.S
linux/arch/ppc/boot/common/relocate.S
--- linuxppc_2_4_devel.orig/arch/ppc/boot/common/relocate.S	Tue Sep 25
08:27:13 2001
+++ linux/arch/ppc/boot/common/relocate.S	Tue Sep 25 08:32:14 2001
@@ -112,8 +112,8 @@
 	mr	r6,r11		/* Residual data */
 	bl	decompress_kernel

-	lis	r6,cmd_line@h
-	ori	r6,r6,cmd_line@l
+	lis	r6,cmd_line2@h
+	ori	r6,r6,cmd_line2@l
 	lwz	r6,0(r6)
 	subi	r7,r6,1
 00:	lbzu	r2,1(r7)
diff -u --recursive --new-file
linuxppc_2_4_devel.orig/arch/ppc/boot/simple/misc-embedded.c
linux/arch/ppc/boot/simple/misc-embedded.c
--- linuxppc_2_4_devel.orig/arch/ppc/boot/simple/misc-embedded.c	Tue
Sep 25 08:27:13 2001
+++ linux/arch/ppc/boot/simple/misc-embedded.c	Tue Sep 25 08:31:46 2001
@@ -51,7 +51,7 @@
  * On these boards, we grab some known memory holes to hold this
information.
  */
 char	cmd_buf[256];
-char	*cmd_line = cmd_buf;
+char	*cmd_line2 = cmd_buf;

 /* Serial port to use.
 */
@@ -123,11 +123,11 @@
 	load_addr = *(uint *)0xfa000020;
 	load_addr += 0x10000;		/* Skip ELF header */

-	cmd_line = (char *)(load_addr - 0x10000);
+	cmd_line2 = (char *)(load_addr - 0x10000);
 #else
-	cmd_line = (char *)(0x200000);
+	cmd_line2 = (char *)(0x200000);
 #endif
-	hold_residual = (bd_t *)(cmd_line + sizeof(cmd_buf));
+	hold_residual = (bd_t *)(cmd_line2 + sizeof(cmd_buf));
 	/* copy board data */
 	if (bp)
 		memcpy(hold_residual,bp,sizeof(bd_t));
@@ -227,31 +227,31 @@
 	puthex((unsigned long)end_avail); puts("\n");
 	puts("\nLinux/PPC load: ");
 	timer = 0;
-	cp = cmd_line;
+	cp = cmd_line2;
 	/* This is where we try and pick the right command line for booting.
 	 * If we were given one at compile time, use it.  It Is Right.
 	 * If we weren't, see if we have a ramdisk.  If so, thats root.
 	 * When in doubt, give them the netroot (root=/dev/nfs rw) -- Tom */
 #ifdef CONFIG_CMDLINE_BOOL
-	memcpy (cmd_line, compiled_string, sizeof(compiled_string));
+	memcpy (cmd_line2, compiled_string, sizeof(compiled_string));
 #else
 	if (initrd_start)
-		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
+		memcpy (cmd_line2, ramroot_string, sizeof(ramroot_string));
 	else
-		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
+		memcpy (cmd_line2, netroot_string, sizeof(netroot_string));
 #endif
 	while ( *cp ) putc(*cp++);
 	while (timer++ < 5*1000) {
 		if (tstc()) {
 			while ((ch = getc()) != '\n' && ch != '\r') {
 				if (ch == '\b' || ch == '\177') {
-					if (cp != cmd_line) {
+					if (cp != cmd_line2) {
 						cp--;
 						puts("\b \b");
 					}
 				} else if (ch == '\030'		/* ^x */
 					   || ch == '\025') {	/* ^u */
-					while (cp != cmd_line) {
+					while (cp != cmd_line2) {
 						cp--;
 						puts("\b \b");
 					}
diff -u --recursive --new-file
linuxppc_2_4_devel.orig/arch/ppc/boot/utils/mktree.c
linux/arch/ppc/boot/utils/mktree.c
--- linuxppc_2_4_devel.orig/arch/ppc/boot/utils/mktree.c	Tue Sep 25
08:27:13 2001
+++ linux/arch/ppc/boot/utils/mktree.c	Tue Sep 25 08:30:43 2001
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <netinet/in.h>

 /* This gets tacked on the front of the image.  There are also a few
  * bytes allocated after the _start label used by the boot rom (see
diff -u --recursive --new-file
linuxppc_2_4_devel.orig/arch/ppc/kernel/Makefile
linux/arch/ppc/kernel/Makefile
--- linuxppc_2_4_devel.orig/arch/ppc/kernel/Makefile	Tue Sep 25 08:27:14
2001
+++ linux/arch/ppc/kernel/Makefile	Tue Sep 25 08:30:03 2001
@@ -41,7 +41,7 @@
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_POWER4)		+= xics.o
 obj-$(CONFIG_TAU)		+= temp.o
-obj-$(CONFIG_4xx)		+= ppc4xx_setup.o ppc4xx_pic.o
ppc4xx_serial.o
+obj-$(CONFIG_4xx)		+= ppc4xx_setup.o ppc4xx_pic.o
ppc4xx_serial.o ep405.o
 obj-$(CONFIG_405_DMA)		+= ppc405_dma.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
 obj-$(CONFIG_EP405)		+= ep405.o
diff -u --recursive --new-file linuxppc_2_4_devel.orig/include/asm-ppc/oak.h
linux/include/asm-ppc/oak.h
--- linuxppc_2_4_devel.orig/include/asm-ppc/oak.h	Tue Sep 25 08:27:38
2001
+++ linux/include/asm-ppc/oak.h	Tue Sep 25 08:29:40 2001
@@ -56,8 +56,10 @@
 	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
 	unsigned int	 bi_memsize;		/* DRAM installed, in bytes
*/
 	unsigned char	 bi_enetaddr[6];	/* Ethernet MAC address */
+	unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address
*/
 	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
 	unsigned int	 bi_busfreq;		/* Bus speed, in Hz */
+	unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
 } bd_t;

 #define PPC4xx_MACHINE_NAME	"IBM Oak"


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
