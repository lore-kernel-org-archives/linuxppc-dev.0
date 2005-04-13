Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 230BF67B45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 10:43:23 +1000 (EST)
Date: Wed, 13 Apr 2005 16:57:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050413195713.GF11131@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [RFC] attempt to remove misc-embedded.c 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Tom,

This is an attempt to move remove misc-embedded.c by moving its quirks to
misc.c. 

It needs further fixing and cleaning, for sure. 

Are there any major disagreements about the change? 
Might need to define a bd_t structure for all ppc's? 

PS: it crashes right after

loaded at:     00002120 00C8744C
relocated to:  00400020 0108534C
board data at: 01083130 0108334C
relocated to:  0040522C 00405448
zimage at:     00405D49 0050E525
initrd at:     0050F000 01082C6E
avail ram:     01086000 08000000
                                                                                           
Linux/PPC load: root=/dev/ram rw
Uncompressing Linux...
done.
Now booting the kernel

BDI>i
    Target state      : debug mode
    Debug entry cause : machine check interrupt
    Current PC        : 0x00001280
    Data  address     : 0x24702000
    DSISR value       : 0x0000014a
BDI>

but shouldnt be a major thing (I haven't figured what it is).


--- /mnt/test1/tslinux_mv21-CVS/linux-2.6/arch/ppc/boot/simple/misc.c	2005-03-17 15:56:59.000000000 -0300
+++ misc.c	2005-04-13 17:57:36.000000000 -0300
@@ -25,7 +25,10 @@
 #include <asm/bootinfo.h>
 #ifdef CONFIG_44x
 #include <asm/ibm4xx.h>
+#elif CONFIG_8xx
+#include <asm/mpc8xx.h>
 #endif
+
 #include <asm/reg.h>
 
 #include "nonstdio.h"
@@ -54,6 +57,16 @@
 	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
 	&& !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
+
+
+
+#ifdef CONFIG_EMBEDDEDBOOT
+/* We need to make sure that this is before the images to ensure
+ * that it's in a mapped location. - Tom */
+bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t *hold_residual = &hold_resid_buf;
+char ramroot_string[] = "root=/dev/ram rw";
+char netroot_string[] = "root=/dev/nfs rw ip=on";
 #endif
 
 char *avail_ram;
@@ -88,8 +101,16 @@
 	return 0;
 }
 
+/* Weak function for boards which don't need to build the
+ * board info struct because they are using PPCBoot/U-Boot.
+ */
+void __attribute__ ((weak))
+embed_config(bd_t **bdp)
+{
+}
+
 struct bi_record *
-decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
+decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum, bd_t *bp)
 {
 #ifdef INTERACTIVE_CONSOLE
 	int timer = 0;
@@ -99,8 +120,9 @@
 	struct bi_record *rec;
 	unsigned long initrd_loc = 0, TotalMemory = 0;
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_MPSC_CONSOLE)
-	com_port = serial_init(0, NULL);
+	embed_config(&bp);
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	com_port = serial_init(0, bp);
 #endif
 
 #if defined(CONFIG_44x) && defined(PPC44x_EMAC0_MR0)
@@ -112,6 +134,18 @@
 	*(volatile unsigned long *)PPC44x_EMAC0_MR0 = 0x20000000;
 	__asm__ __volatile__("eieio");
 #endif
+#ifdef CONFIG_MBX
+        /* Because of the way the MBX loads the ELF image, we can't
+         * tell where we started.  We read a magic variable from the NVRAM
+         * that gives us the intermediate buffer load address.
+         */
+        load_addr = *(uint *)0xfa000020;
+        load_addr += 0x10000;           /* Skip ELF header */
+#endif
+#ifdef CONFIG_EMBEDDEDBOOT
+	if (bp)
+		memcpy(hold_residual,bp,sizeof(bd_t));
+#endif
 
 	/*
 	 * Call get_mem_size(), which is memory controller dependent,
@@ -119,8 +153,15 @@
 	 */
 	TotalMemory = get_mem_size();
 
+#ifdef CONFIG_EMBEDDEDBOOT
+        /* Set end of memory available to us.  It is always the highest
+         * memory address provided by the board information.
+         */
+	end_avail = (char *)(bp->bi_memsize);
+#else
 	/* assume the chunk below 8M is free */
 	end_avail = (char *)0x00800000;
+#endif
 
 	/*
 	 * Reveal where we were loaded at and where we
@@ -136,6 +177,16 @@
 		puthex((unsigned long)((unsigned long)&start + (4*num_words)));
 		puts("\n");
 	}
+	if (bp) {
+                puts("board data at: "); puthex((unsigned long)bp);
+                puts(" ");
+                puthex((unsigned long)((unsigned long)bp + sizeof(bd_t)));
+                puts("\nrelocated to:  ");
+                puthex((unsigned long)hold_residual);
+                puts(" ");
+                puthex((unsigned long)((unsigned long)hold_residual + sizeof(bd_t)));
+                puts("\n");
+	}
 
 	/*
 	 * We link ourself to 0x00800000.  When we run, we relocate
@@ -163,9 +214,10 @@
 		puthex((unsigned long)(&__ramdisk_begin));
 		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
 	}
-
+#ifndef CONFIG_EMBEDDEDBOOT
 	avail_ram = (char *)0x00400000;
 	end_avail = (char *)0x00800000;
+#endif
 	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
 	puthex((unsigned long)end_avail); puts("\n");
 
@@ -181,11 +233,17 @@
 	if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
 		memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
 #endif
+#ifdef CONFIG_EMBEDDEDBOOT
+	if ( initrd_size )
+		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
+	else
+		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
+#endif
 
 	/* Display standard Linux/PPC boot prompt for kernel args */
 	puts("\nLinux/PPC load: ");
 	cp = cmd_line;
-	memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
+//	memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
 	while ( *cp ) putc(*cp++);
 
 #ifdef INTERACTIVE_CONSOLE
@@ -224,6 +282,7 @@
 	puts("Uncompressing Linux...");
 	gunzip(0x0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");
+	flush_instruction_cache();
 
 	/* get the bi_rec address */
 	rec = bootinfo_addr(zimage_size);
@@ -280,5 +339,5 @@
 		void *ign1, void *ign2)
 {
 		board_isa_init();
-		return decompress_kernel(load_addr, num_words, cksum);
+		return decompress_kernel(load_addr, num_words, cksum, ign1);
 }
