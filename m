Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D236FDDEC4
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:17 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 11/20] bootwrapper: Move linker symbols into ops.h.
Message-ID: <20070820173958.GJ30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Most of these were previously used by numerous C files and
redeclared in each one.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-83xx.c    |    1 -
 arch/powerpc/boot/cuboot-85xx.c    |    1 -
 arch/powerpc/boot/cuboot.c         |    3 ---
 arch/powerpc/boot/ebony.c          |    3 ---
 arch/powerpc/boot/holly.c          |    5 -----
 arch/powerpc/boot/main.c           |   10 ----------
 arch/powerpc/boot/of.c             |    2 --
 arch/powerpc/boot/ops.h            |   10 ++++++++++
 arch/powerpc/boot/prpmc2800.c      |    4 ----
 arch/powerpc/boot/ps3.c            |    4 ----
 arch/powerpc/boot/treeboot-ebony.c |    2 --
 11 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
index 296025d..a050550 100644
--- a/arch/powerpc/boot/cuboot-83xx.c
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -18,7 +18,6 @@
 #include "ppcboot.h"
 
 static bd_t bd;
-extern char _dtb_start[], _dtb_end[];
 
 static void platform_fixups(void)
 {
diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
index 10f0f69..345dcbe 100644
--- a/arch/powerpc/boot/cuboot-85xx.c
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -18,7 +18,6 @@
 #include "ppcboot.h"
 
 static bd_t bd;
-extern char _dtb_start[], _dtb_end[];
 
 static void platform_fixups(void)
 {
diff --git a/arch/powerpc/boot/cuboot.c b/arch/powerpc/boot/cuboot.c
index 6579546..7768b23 100644
--- a/arch/powerpc/boot/cuboot.c
+++ b/arch/powerpc/boot/cuboot.c
@@ -17,9 +17,6 @@
 
 #include "ppcboot.h"
 
-extern char _end[];
-extern char _dtb_start[], _dtb_end[];
-
 void cuboot_init(unsigned long r4, unsigned long r5,
 		 unsigned long r6, unsigned long r7,
 		 unsigned long end_of_ram)
diff --git a/arch/powerpc/boot/ebony.c b/arch/powerpc/boot/ebony.c
index 75daeda..2cf9cc2 100644
--- a/arch/powerpc/boot/ebony.c
+++ b/arch/powerpc/boot/ebony.c
@@ -27,9 +27,6 @@
 #include "dcr.h"
 #include "44x.h"
 
-extern char _dtb_start[];
-extern char _dtb_end[];
-
 static u8 *ebony_mac0, *ebony_mac1;
 
 /* Calculate 440GP clocks */
diff --git a/arch/powerpc/boot/holly.c b/arch/powerpc/boot/holly.c
index 7d6539f..199e783 100644
--- a/arch/powerpc/boot/holly.c
+++ b/arch/powerpc/boot/holly.c
@@ -21,11 +21,6 @@
 #include "ops.h"
 #include "io.h"
 
-extern char _start[];
-extern char _end[];
-extern char _dtb_start[];
-extern char _dtb_end[];
-
 BSS_STACK(4096);
 
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 416dc38..1b496b3 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -19,16 +19,6 @@
 #include "flatdevtree.h"
 #include "reg.h"
 
-extern char _start[];
-extern char __bss_start[];
-extern char _end[];
-extern char _vmlinux_start[];
-extern char _vmlinux_end[];
-extern char _initrd_start[];
-extern char _initrd_end[];
-extern char _dtb_start[];
-extern char _dtb_end[];
-
 static struct gunzip_state gzstate;
 
 struct addr_range {
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 385e08b..61d9899 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -17,8 +17,6 @@
 
 #include "of.h"
 
-extern char _end[];
-
 /* Value picked to match that used by yaboot */
 #define PROG_START	0x01400000	/* only used on 64-bit systems */
 #define RAM_END		(512<<20)	/* Fixme: use OF */
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 2bc2f02..e4b6139 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -196,4 +196,14 @@ static inline void exit(void)
 extern unsigned long timebase_period_ns;
 void udelay(long delay);
 
+extern char _start[];
+extern char __bss_start[];
+extern char _end[];
+extern char _vmlinux_start[];
+extern char _vmlinux_end[];
+extern char _initrd_start[];
+extern char _initrd_end[];
+extern char _dtb_start[];
+extern char _dtb_end[];
+
 #endif /* _PPC_BOOT_OPS_H_ */
diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index 5c6cd36..9614e1d 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -21,10 +21,6 @@
 #include "gunzip_util.h"
 #include "mv64x60.h"
 
-extern char _end[];
-extern char _vmlinux_start[], _vmlinux_end[];
-extern char _dtb_start[], _dtb_end[];
-
 #define KB	1024U
 #define MB	(KB*KB)
 #define GB	(KB*MB)
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 893d593..d666115 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -120,10 +120,6 @@ void ps3_copy_vectors(void)
 
 void platform_init(void)
 {
-	extern char _end[];
-	extern char _dtb_start[];
-	extern char _initrd_start[];
-	extern char _initrd_end[];
 	const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
 	void *chosen;
 	unsigned long ft_addr;
diff --git a/arch/powerpc/boot/treeboot-ebony.c b/arch/powerpc/boot/treeboot-ebony.c
index 8436a9c..21cc483 100644
--- a/arch/powerpc/boot/treeboot-ebony.c
+++ b/arch/powerpc/boot/treeboot-ebony.c
@@ -16,8 +16,6 @@
 #include "stdio.h"
 #include "44x.h"
 
-extern char _end[];
-
 BSS_STACK(4096);
 
 #define OPENBIOS_MAC_BASE	0xfffffe0c
-- 
1.5.0.3
