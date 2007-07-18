Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E9F7DE014
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1XHvT018531
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:18 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1XHPM001225
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:17 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18aWW007856
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:36 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 31FDBAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:16 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1XGbM015301
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:16 -0500
Date: Tue, 17 Jul 2007 20:33:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/61] Declare udelay() in ops.h,
	and remove declarations in various users.
Message-ID: <20070718013316.GN15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/mpsc.c        |    1 -
 arch/powerpc/boot/mv64x60_i2c.c |    2 --
 arch/powerpc/boot/ops.h         |    2 ++
 arch/powerpc/boot/prpmc2800.c   |    2 --
 arch/powerpc/boot/serial.c      |    2 --
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index f1c0e96..802ea53 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -17,7 +17,6 @@
 #include "io.h"
 #include "ops.h"
 
-extern void udelay(long delay);
 
 #define MPSC_CHR_1		0x000c
 
diff --git a/arch/powerpc/boot/mv64x60_i2c.c b/arch/powerpc/boot/mv64x60_i2c.c
index 435fe85..d085377 100644
--- a/arch/powerpc/boot/mv64x60_i2c.c
+++ b/arch/powerpc/boot/mv64x60_i2c.c
@@ -21,8 +21,6 @@
 #include "ops.h"
 #include "mv64x60.h"
 
-extern void udelay(long);
-
 /* Register defines */
 #define MV64x60_I2C_REG_SLAVE_ADDR			0x00
 #define MV64x60_I2C_REG_DATA				0x04
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 9a88a80..c48e8ed 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -192,4 +192,6 @@ static inline void exit(void)
 	static char _bss_stack[size]; \
 	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
 
+void udelay(long delay);
+
 #endif /* _PPC_BOOT_OPS_H_ */
diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index f428bac..5c6cd36 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -25,8 +25,6 @@ extern char _end[];
 extern char _vmlinux_start[], _vmlinux_end[];
 extern char _dtb_start[], _dtb_end[];
 
-extern void udelay(long delay);
-
 #define KB	1024U
 #define MB	(KB*KB)
 #define GB	(KB*MB)
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 1c27110..441151f 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -19,8 +19,6 @@
 #include "io.h"
 #include "ops.h"
 
-extern void udelay(long delay);
-
 static int serial_open(void)
 {
 	struct serial_console_data *scdp = console_ops.data;
-- 
1.5.0.3
