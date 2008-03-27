Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 84D6ADE082
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:04 +1100 (EST)
Message-ID: <47EAEC76.7000006@am.sony.com>
Date: Wed, 26 Mar 2008 17:38:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 3/6] PS3: Bootwrapper improvements
References: <20080327001821.827672589@am.sony.com>
In-Reply-To: <20080327001821.827672589@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Improve the debuging support of the PS3 bootwraper code:

 o Increase the size of the PS3 bootwrapper overlay from 256 to 512 bytes to
   allow for more debugging code in the overlay.
 o Use the dot symbol to set the size of __system_reset_overlay.  The
   asembler will then emit an error if the overlay code is too big.
 o Remove some unused instructions.
 o Update the text describing the PS3 bootwrapper overlay.
 o Add a check for null pointer writes.
 o Change hcall return value from s64.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/ps3-head.S |   25 ++++++++++++++++---------
 arch/powerpc/boot/ps3.c      |   21 +++++++++++++--------
 arch/powerpc/boot/wrapper    |   21 +++++++++++----------
 3 files changed, 40 insertions(+), 27 deletions(-)

--- a/arch/powerpc/boot/ps3-head.S
+++ b/arch/powerpc/boot/ps3-head.S
@@ -27,8 +27,9 @@
 /*
  * __system_reset_overlay - The PS3 first stage entry.
  *
- * The bootwraper build script copies the 0x100 bytes at symbol
- * __system_reset_overlay to offset 0x100 of the rom image.
+ * The bootwraper build script copies the 512 bytes at symbol
+ * __system_reset_overlay to offset 0x100 of the rom image.  This symbol
+ * must occupy 512 or less bytes.
  *
  * The PS3 has a single processor with two threads.
  */
@@ -47,8 +48,6 @@ __system_reset_overlay:
 
 	mfspr	r3, 0x88
 	cntlzw.	r3, r3
-	li	r4, 0
-	li	r5, 0
 	beq	1f
 
 	/* Secondary goes to __secondary_hold in kernel. */
@@ -57,8 +56,14 @@ __system_reset_overlay:
 	mtctr	r4
 	bctr
 
-	/* Primary delays then goes to _zimage_start in wrapper. */
 1:
+	/* Save the value at addr zero for a null pointer write check later. */
+
+	li	r4, 0
+	lwz	r3, 0(r4)
+
+	/* Primary delays then goes to _zimage_start in wrapper. */
+
 	or	31, 31, 31 /* db16cyc */
 	or	31, 31, 31 /* db16cyc */
 
@@ -67,16 +72,18 @@ __system_reset_overlay:
 	mtctr	r4
 	bctr
 
+	. = __system_reset_overlay + 512
+
 /*
  * __system_reset_kernel - Place holder for the kernel reset vector.
  *
- * The bootwrapper build script copies 0x100 bytes from offset 0x100
+ * The bootwrapper build script copies 512 bytes from offset 0x100
  * of the rom image to the symbol __system_reset_kernel.  At runtime
- * the bootwrapper program copies the 0x100 bytes at __system_reset_kernel
- * to ram address 0x100.  This symbol must occupy 0x100 bytes.
+ * the bootwrapper program copies the 512 bytes at __system_reset_kernel
+ * to ram address 0x100.  This symbol must occupy 512 bytes.
  */
 
 	.globl __system_reset_kernel
 __system_reset_kernel:
 
-	. = __system_reset_kernel + 0x100
+	. = __system_reset_kernel + 512
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -27,10 +27,10 @@
 #include "page.h"
 #include "ops.h"
 
-extern s64 lv1_panic(u64 in_1);
-extern s64 lv1_get_logical_partition_id(u64 *out_1);
-extern s64 lv1_get_logical_ppe_id(u64 *out_1);
-extern s64 lv1_get_repository_node_value(u64 in_1, u64 in_2, u64 in_3,
+extern int lv1_panic(u64 in_1);
+extern int lv1_get_logical_partition_id(u64 *out_1);
+extern int lv1_get_logical_ppe_id(u64 *out_1);
+extern int lv1_get_repository_node_value(u64 in_1, u64 in_2, u64 in_3,
 	u64 in_4, u64 in_5, u64 *out_1, u64 *out_2);
 
 #ifdef DEBUG
@@ -46,6 +46,7 @@ BSS_STACK(4096);
  * edit the command line passed to vmlinux (by setting /chosen/bootargs).
  * The buffer is put in it's own section so that tools may locate it easier.
  */
+
 static char cmdline[COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
@@ -75,7 +76,7 @@ static void ps3_exit(void)
 
 static int ps3_repository_read_rm_size(u64 *rm_size)
 {
-	s64 result;
+	int result;
 	u64 lpar_id;
 	u64 ppe_id;
 	u64 v2;
@@ -114,11 +115,11 @@ void ps3_copy_vectors(void)
 {
 	extern char __system_reset_kernel[];
 
-	memcpy((void *)0x100, __system_reset_kernel, 0x100);
-	flush_cache((void *)0x100, 0x100);
+	memcpy((void *)0x100, __system_reset_kernel, 512);
+	flush_cache((void *)0x100, 512);
 }
 
-void platform_init(void)
+void platform_init(unsigned long null_check)
 {
 	const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
 	void *chosen;
@@ -151,6 +152,10 @@ void platform_init(void)
 
 	printf(" flat tree at 0x%lx\n\r", ft_addr);
 
+	if (*(unsigned long *)0 != null_check)
+		printf("null check failed: %lx != %lx\n\r", *(unsigned long *)0,
+			(unsigned long)null_check);
+
 	((kernel_entry_t)0)(ft_addr, 0, NULL);
 
 	ps3_exit();
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -298,15 +298,16 @@ treeboot*)
     exit 0
     ;;
 ps3)
-    # The ps3's loader supports loading gzipped binary images from flash
-    # rom to addr zero. The loader enters the image at addr 0x100.  A
-    # bootwrapper overlay is use to arrange for the kernel to be loaded
-    # to addr zero and to have a suitable bootwrapper entry at 0x100.
-    # To construct the rom image, 0x100 bytes from offset 0x100 in the
-    # kernel is copied to the bootwrapper symbol __system_reset_kernel.
-    # The 0x100 bytes at the bootwrapper symbol __system_reset_overlay is
-    # then copied to offset 0x100.  At runtime the bootwrapper program
-    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
+    # The ps3's loader supports loading a gzipped binary image from flash
+    # rom to ram addr zero. The loader then enters the system reset
+    # vector at addr 0x100.  A bootwrapper overlay is used to arrange for
+    # a binary image of the kernel to be at addr zero, and yet have a
+    # suitable bootwrapper entry at 0x100.  To construct the final rom
+    # image 512 bytes from offset 0x100 is copied to the bootwrapper
+    # place holder at symbol __system_reset_kernel.  The 512 bytes of the
+    # bootwrapper entry code at symbol __system_reset_overlay is then
+    # copied to offset 0x100.  At runtime the bootwrapper program copies
+    # the data at __system_reset_kernel back to addr 0x100.
 
     system_reset_overlay=0x`${CROSS}nm "$ofile" \
         | grep ' __system_reset_overlay$'       \
@@ -317,7 +318,7 @@ ps3)
         | cut -d' ' -f1`
     system_reset_kernel=`printf "%d" $system_reset_kernel`
     overlay_dest="256"
-    overlay_size="256"
+    overlay_size="512"
 
     ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
 

-- 
