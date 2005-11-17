Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDA776877F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 07:35:10 +1100 (EST)
Date: Thu, 17 Nov 2005 13:17:30 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051117151730.GA10180@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: INTERACTIVE_CONSOLE for misc-embedded.c and watchdog issue
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

The following patch against misc-embedded.c adds an INTERACTIVE_CONSOLE
#define to guard reading from console (causes unecessary delay in some
situations).

Its an adaptation of misc.c's define, a difference being that platform
headers define "NO_INTERACTIVE_CONSOLE" if required.

What do you think?

Another issue is the watchdog - if it is active all 8xx systems
should fail to boot because load_kernel() (and the gzip functions)
don't calm the dog.

Our internal kernels always have sprinkled "service_wdt()" calls
around "load_kernel()".

Adding hooks for the wdt to be service there (and possibly other places)
is terrible, but is there any other solution so early?

Setting up a HW timer with early setup code might be possible, 
but sounds quite complicated.

Of course, with U-Boot all of this is a non-issue, but for simple
bootloaders (which I suppose are quite common) it is a nasty problem.


diff --git a/arch/ppc/boot/simple/misc-embedded.c b/arch/ppc/boot/simple/misc-embedded.c
index 3865f3f..85e3e24 100644
--- a/arch/ppc/boot/simple/misc-embedded.c
+++ b/arch/ppc/boot/simple/misc-embedded.c
@@ -23,6 +23,10 @@
 
 #include "nonstdio.h"
 
+#ifndef NO_INTERACTIVE_CONSOLE
+#define INTERACTIVE_CONSOLE
+#endif
+
 /* The linker tells us where the image is. */
 extern char __image_begin, __image_end;
 extern char __ramdisk_begin, __ramdisk_end;
@@ -82,8 +86,11 @@ embed_config(bd_t **bdp)
 unsigned long
 load_kernel(unsigned long load_addr, int num_words, unsigned long cksum, bd_t *bp)
 {
+#ifdef INTERACTIVE_CONSOLE
 	char *cp, ch;
-	int timer = 0, zimage_size;
+	int timer = 0;
+#endif
+	int zimage_size;
 	unsigned long initrd_size;
 
 	/* First, capture the embedded board information.  Then
@@ -187,6 +194,8 @@ load_kernel(unsigned long load_addr, int
 #endif
 	while ( *cp )
 		putc(*cp++);
+
+#ifdef INTERACTIVE_CONSOLE
 	while (timer++ < 5*1000) {
 		if (tstc()) {
 			while ((ch = getc()) != '\n' && ch != '\r') {
@@ -211,6 +220,7 @@ load_kernel(unsigned long load_addr, int
 		udelay(1000);  /* 1 msec */
 	}
 	*cp = 0;
+#endif
 	puts("\nUncompressing Linux...");
 
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
