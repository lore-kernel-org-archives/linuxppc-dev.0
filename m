Date: Tue, 20 Nov 2001 17:35:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Simon Winwood <sjw@cse.unsw.edu.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boottime issues
Message-ID: <20011120173502.D821@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011121104517.A12111@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011121104517.A12111@cse.unsw.edu.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 21, 2001 at 10:45:17AM +1100, Simon Winwood wrote:

> 	Hi, the latest bitkeeper linuxppc_2_4_devel kernel is broken
> for walnut (and any other board using misc-embedded.c in arch/ppc/boot/simple)
>
> 	Specifically, the ZIMAGE_START and ZIMAGE_SIZE macros are wrong (0)
> and have been replaced by {__image}_{begin, end}.
>
> 	The command line stuff also appears to be broken (the kernel doesn't
> get the command line properly)
>
> 	Is there a fix pending, or should I do it?

Does the following work for you?  I thought I could do the changes
easily w/o breaking 8xx/4xx, but...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/boot/simple/misc-embedded.c 1.21 vs edited =====
--- 1.21/arch/ppc/boot/simple/misc-embedded.c	Tue Nov 13 14:37:01 2001
+++ edited/arch/ppc/boot/simple/misc-embedded.c	Tue Nov 20 14:17:38 2001
@@ -1,11 +1,11 @@
 /*
  * BK Id: %F% %I% %G% %U% %#%
- */
-/*
- * Adapted for PowerPC by Gary Thomas
  *
- * Rewritten by Cort Dougan (cort@cs.nmt.edu)
- * One day to be replaced by a single bootloader for chrp/prep/pmac. -- Cort
+ * Originally adapted by Gary Thomas.  Much additional work by
+ * Cort Dougan <cort@fsmlabs.com>.  On top of that still more work by
+ * Dan Malek <dmalek@jlc.net>.
+ *
+ * Currently maintained by: Tom Rini <trini@kernel.crashing.org>
  */

 #include <linux/config.h>
@@ -22,29 +22,22 @@

 #include "nonstdio.h"

-/*
- * Please send me load/board info and such data for hardware not
- * listed here so I can keep track since things are getting tricky
- * with the different load addrs with different firmware.  This will
- * help to avoid breaking the load/boot process.
- * -- Cort
- */
-char *avail_ram;
-char *end_avail;
+/* The linker tells us where the image is. */
+extern char __image_begin, __image_end;
+extern char __ramdisk_begin, __ramdisk_end;

 /* Because of the limited amount of memory on embedded, it presents
  * loading problems.  The biggest is that we load this boot program
  * into a relatively low memory address, and the Linux kernel Bss often
  * extends into this space when it get loaded.  When the kernel starts
  * and zeros the BSS space, it also writes over the information we
- * save here and pass to the kernel (command line and board info).
+ * save here and pass to the kernel (usually board info).
  * On these boards, we grab some known memory holes to hold this information.
  */
 char	cmd_buf[256];
 char	*cmd_line = cmd_buf;

-/* Serial port to use.
-*/
+/* Serial port to use. */
 unsigned long com_port;

 /* This is the default cmdline that will be given to the user at boot time..
@@ -63,9 +56,11 @@

 bd_t hold_resid_buf;
 bd_t *hold_residual = &hold_resid_buf;
-unsigned long initrd_start = 0, initrd_end = 0;
 char *zimage_start;

+extern unsigned long start;
+
+extern void flush_instruction_cache(void);
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void embed_config(bd_t **bp);
 extern unsigned long serial_init(int chan, bd_t *bp);
@@ -75,8 +70,7 @@
 {
 	int timer, zimage_size = ZIMAGE_SIZE;
 	char *cp, ch;
-	extern unsigned long start;
-	extern void flush_instruction_cache(void);
+	unsigned long initrd_size;

 	/* First, capture the embedded board information.  Then
 	 * initialize the serial console port.
@@ -102,16 +96,12 @@
 #else
 	cmd_line = (char *)(0x200000);
 #endif
+
 	hold_residual = (bd_t *)(cmd_line + sizeof(cmd_buf));
 	/* copy board data */
 	if (bp)
 		memcpy(hold_residual,bp,sizeof(bd_t));

-	/* Set end of memory available to us.  It is always the highest
-	 * memory address provided by the board information.
-	 */
-	end_avail = (char *)(bp->bi_memsize);
-
 	puts("loaded at:     "); puthex(load_addr);
 	puts(" "); puthex((unsigned long)(load_addr + (4*num_words))); puts("\n");
 	if ( (unsigned long)load_addr != (unsigned long)&start )
@@ -135,86 +125,52 @@
 		puts("\n");
 	}

-	/* we have to subtract 0x10000 here to correct for objdump including the
-	   size of the elf header which we strip -- Cort */
-	zimage_start = (char *)(load_addr - 0x10000 + ZIMAGE_OFFSET);
+	/*
+	 * We link ourself to 0x00800000.  When we run, we relocate
+	 * ourselves there.  So we just need __image_begin for the
+	 * start. -- Tom
+	 */
+	zimage_start = (char *)(unsigned long)(&__image_begin);
+	zimage_size = (unsigned long)(&__image_end) -
+			(unsigned long)(&__image_begin);

-	if ( INITRD_OFFSET )
-		initrd_start = load_addr - 0x10000 + INITRD_OFFSET;
-	else
-		initrd_start = 0;
-	initrd_end = INITRD_SIZE + initrd_start;
+	initrd_size = (unsigned long)(&__ramdisk_end) -
+		(unsigned long)(&__ramdisk_begin);

 	/*
-	 * setup avail_ram - this is the first part of ram usable
-	 * by the uncompress code. -- Cort
+	 * The zImage and initrd will be between start and _end, so they've
+	 * already been moved once.  We're good to go now. -- Tom
 	 */
-	avail_ram = (char *)PAGE_ALIGN((unsigned long)zimage_start+zimage_size);
-	if ( ((load_addr+(num_words*4)) > (unsigned long) avail_ram)
-		&& (load_addr <= 0x01000000) )
-		avail_ram = (char *)(load_addr+(num_words*4));
-	if ( (((unsigned long)&start+(num_words*4)) > (unsigned long) avail_ram)
-		&& (load_addr <= 0x01000000) )
-		avail_ram = (char *)((unsigned long)&start+(num_words*4));
-
-	/* relocate zimage */
 	puts("zimage at:     "); puthex((unsigned long)zimage_start);
-	puts(" "); puthex((unsigned long)(zimage_size+zimage_start)); puts("\n");
-	/*
-	 * There is no reason (yet) to relocate zImage for embedded boards.
-	 * To support boot from flash rom on 8xx embedded boards, I
-	 * assume if zimage start is over 16M we are booting from flash.
-	 * In this case, avilable ram will start just above the space we
-	 * have allocated for the command buffer and board information.
-	 */
-	if ((unsigned long)zimage_start > 0x01000000)
-		avail_ram = (char *)PAGE_ALIGN((unsigned long)hold_residual + sizeof(bd_t));
-
-	/* relocate initrd */
-	if ( initrd_start )
-	{
-		puts("initrd at:     "); puthex(initrd_start);
-		puts(" "); puthex(initrd_end); puts("\n");
+	puts(" "); puthex((unsigned long)(zimage_size+zimage_start));
+	puts("\n");

-		/* We only have to relocate initrd if we find it is in Flash
-		 * rom.  This is because the kernel thinks it can toss the
-		 * pages into the free memory pool after it is done.  Use
-		 * the same 16M test.
-		 */
-		if ((unsigned long)initrd_start > 0x01000000) {
-			memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-INITRD_SIZE),
-				(void *)initrd_start,
-				INITRD_SIZE );
-			initrd_start = PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-INITRD_SIZE);
-			initrd_end = initrd_start + INITRD_SIZE;
-			end_avail = (char *)initrd_start;
-			puts("relocated to:  "); puthex(initrd_start);
-			puts(" "); puthex(initrd_end); puts("\n");
-		}
-		else {
-			avail_ram = (char *)PAGE_ALIGN((unsigned long)initrd_end);
-		}
+	if ( initrd_size ) {
+		puts("initrd at:     ");
+		puthex((unsigned long)(&__ramdisk_begin));
+		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
 	}

-
-	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
-	puthex((unsigned long)end_avail); puts("\n");
 	puts("\nLinux/PPC load: ");
 	timer = 0;
 	cp = cmd_line;
-	/* This is where we try and pick the right command line for booting.
+
+	/*
+	 * This is where we try and pick the right command line for booting.
 	 * If we were given one at compile time, use it.  It Is Right.
 	 * If we weren't, see if we have a ramdisk.  If so, thats root.
-	 * When in doubt, give them the netroot (root=/dev/nfs rw) -- Tom */
+	 * When in doubt, give them the netroot (root=/dev/nfs rw) -- Tom
+	 */
 #ifdef CONFIG_CMDLINE_BOOL
 	memcpy (cmd_line, compiled_string, sizeof(compiled_string));
 #else
-	if (initrd_start)
+	if (initrd_size)
 		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
 	else
 		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
 #endif
-	while ( *cp ) putc(*cp++);
+	while ( *cp )
+		putc(*cp++);
 	while (timer++ < 5*1000) {
 		if (tstc()) {
 			while ((ch = getc()) != '\n' && ch != '\r') {
@@ -244,6 +200,35 @@
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	flush_instruction_cache();
 	puts("done.\n");
+	{
+		struct bi_record *rec;
+
+		rec = (struct bi_record *)_ALIGN((unsigned long)(zimage_size) +
+				(1 << 20) - 1, (1 << 20));
+
+		rec->tag = BI_FIRST;
+		rec->size = sizeof(struct bi_record);
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
+		rec->tag = BI_CMD_LINE;
+		memcpy( (char *)rec->data, cmd_line, strlen(cmd_line)+1);
+		rec->size = sizeof(struct bi_record) + strlen(cmd_line) + 1;
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
+		if ( initrd_size ) {
+			rec->tag = BI_INITRD;
+			rec->data[0] = (unsigned long)(&__ramdisk_begin);
+			rec->data[1] = initrd_size;
+			rec->size = sizeof(struct bi_record) + 2 *
+				sizeof(unsigned long);
+			rec = (struct bi_record *)((unsigned long)rec +
+					rec->size);
+		}
+
+		rec->tag = BI_LAST;
+		rec->size = sizeof(struct bi_record);
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+	}
 	puts("Now booting the kernel\n");
 	return (unsigned long)hold_residual;
 }

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
