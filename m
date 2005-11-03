Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 9E4E968596
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 05:32:57 +1100 (EST)
Date: Thu, 3 Nov 2005 11:32:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>
Message-ID: <20051103183256.GJ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ppc (not ppc64) boot loader (zimage wrapper) has a hard coded limit of
4 MB on the size of an uncompressed kernel it can boot. The boot loader has
been changed to dynamically determine the largest possible kernel and
support it. Relocating the boot loader to a higher address (currently
located at 8 MB) will provide additional room.

Signed-off-by: Mark Bellon <mbellon@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
--- a/arch/ppc/boot/simple/misc.c
+++ b/arch/ppc/boot/simple/misc.c
@@ -7,10 +7,10 @@
  * your serial console.  If a machine meets these requirements, it can quite
  * likely use this code during boot.
  *
- * Author: Matt Porter <mporter@mvista.com>
+ * Author: Tom Rini <trini@mvista.com>
  * Derived from arch/ppc/boot/prep/misc.c
  *
- * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
+ * 2001-2005 (c) MontaVista, Software, Inc.  This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -56,6 +56,11 @@
 #define INTERACTIVE_CONSOLE	1
 #endif
 
+#define	ONE_MB		(1 << 20)
+#define	MAX_BI_RECS	(8 * 1024)
+#define	MAX_AVAIL_MEM	(4 * ONE_MB)
+#define	RAM_RESERVE	(4 * ONE_MB)
+
 char *avail_ram;
 char *end_avail;
 char *zimage_start;
@@ -97,7 +102,8 @@ decompress_kernel(unsigned long load_add
 #endif
 	char *cp;
 	struct bi_record *rec;
-	unsigned long initrd_loc = 0, TotalMemory = 0;
+	unsigned long initrd_loc, TotalMemory;
+	unsigned long max_kernel, top_free;
 
 #if defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	com_port = serial_init(0, NULL);
@@ -119,9 +125,6 @@ decompress_kernel(unsigned long load_add
 	 */
 	TotalMemory = get_mem_size();
 
-	/* assume the chunk below 8M is free */
-	end_avail = (char *)0x00800000;
-
 	/*
 	 * Reveal where we were loaded at and where we
 	 * were relocated to.
@@ -153,7 +156,6 @@ decompress_kernel(unsigned long load_add
 	 * The zImage and initrd will be between start and _end, so they've
 	 * already been moved once.  We're good to go now. -- Tom
 	 */
-	avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
 	puts("zimage at:     "); puthex((unsigned long)zimage_start);
 	puts(" "); puthex((unsigned long)(zimage_size+zimage_start));
 	puts("\n");
@@ -164,11 +166,51 @@ decompress_kernel(unsigned long load_add
 		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
 	}
 
-	avail_ram = (char *)0x00400000;
-	end_avail = (char *)0x00800000;
+	/*
+	 * If there is sufficent memory move the available RAM area after
+	 * the zImage (but stay away from the top of RAM). Otherwise fudge
+	 * it to fit in below the zImage as it did in the past.
+	 */
+
+	top_free = _ALIGN((unsigned long)(_end) + ONE_MB - 1, ONE_MB);
+
+	if ((TotalMemory != 0) &&
+		((top_free + MAX_AVAIL_MEM + RAM_RESERVE) < TotalMemory)) {
+		avail_ram = (char *) top_free;
+
+		/*
+		 * We're linked in the middle of RAM and the kernel starts
+		 * at zero. This means that the kernel must fit between
+		 * zero and our starting address. Figure out the highest
+		 * address below this that will allow a complete
+		 * uncompressed kernel and bi_recs to fit - the maximum
+		 * kernel size.
+		 */
+
+		max_kernel = (unsigned long) &start;
+
+		while (1) {
+			avail_ram = (char *) bootinfo_addr(max_kernel);
+
+			if ((avail_ram + MAX_BI_RECS) < ((char *) &start))
+				break;
+
+			max_kernel -= MAX_BI_RECS;
+		}
+	}
+	else {
+		max_kernel = ((unsigned long) &start) - MAX_AVAIL_MEM;
+		avail_ram = max_kernel;
+	}
+
+	end_avail = avail_ram + MAX_AVAIL_MEM;
+
 	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
 	puthex((unsigned long)end_avail); puts("\n");
 
+	/* Document the limitation */
+	puts("max kernel:    "); puthex(max_kernel); puts("\n");
+
 	if (keyb_present)
 		CRT_tstc();  /* Forces keyboard to be initialized */
 #ifdef CONFIG_GEMINI
@@ -222,32 +264,12 @@ decompress_kernel(unsigned long load_add
 	puts("\n");
 
 	puts("Uncompressing Linux...");
-	gunzip(NULL, 0x400000, zimage_start, &zimage_size);
+	gunzip(NULL, max_kernel, zimage_start, &zimage_size);
 	puts("done.\n");
 
 	/* get the bi_rec address */
 	rec = bootinfo_addr(zimage_size);
 
-	/* We need to make sure that the initrd and bi_recs do not
-	 * overlap. */
-	if ( initrd_size ) {
-		unsigned long rec_loc = (unsigned long) rec;
-		initrd_loc = (unsigned long)(&__ramdisk_begin);
-		/* If the bi_recs are in the middle of the current
-		 * initrd, move the initrd to the next MB
-		 * boundary. */
-		if ((rec_loc > initrd_loc) &&
-				((initrd_loc + initrd_size) > rec_loc)) {
-			initrd_loc = _ALIGN((unsigned long)(zimage_size)
-					+ (2 << 20) - 1, (2 << 20));
-		 	memmove((void *)initrd_loc, &__ramdisk_begin,
-				 initrd_size);
-	         	puts("initrd moved:  "); puthex(initrd_loc);
-		 	puts(" "); puthex(initrd_loc + initrd_size);
-		 	puts("\n");
-		}
-	}
-
 	bootinfo_init(rec);
 	if ( TotalMemory )
 		bootinfo_append(BI_MEMSIZE, sizeof(int), (void*)&TotalMemory);
@@ -258,7 +280,7 @@ decompress_kernel(unsigned long load_add
 	if (initrd_size) {
 		unsigned long initrd[2];
 
-		initrd[0] = initrd_loc;
+		initrd[0] = (unsigned long)(&__ramdisk_begin);
 		initrd[1] = initrd_size;
 
 		bootinfo_append(BI_INITRD, sizeof(initrd), &initrd);

-- 
Tom Rini
http://gate.crashing.org/~trini/
