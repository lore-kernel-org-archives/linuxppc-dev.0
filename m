Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5995DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:11 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 09/20] bootwrapper: Declare udelay() in ops.h.
Message-ID: <20070820173955.GH30562@ld0162-tx32.am.freescale.net>
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

Declarations in various users are removed.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/mpsc.c        |    1 -
 arch/powerpc/boot/mv64x60_i2c.c |    2 --
 arch/powerpc/boot/ops.h         |    1 +
 arch/powerpc/boot/prpmc2800.c   |    2 --
 arch/powerpc/boot/serial.c      |    2 --
 5 files changed, 1 insertions(+), 7 deletions(-)

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
index a10bf5a..e45b364 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -193,5 +193,6 @@ static inline void exit(void)
 	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
 
 extern unsigned long timebase_period_ns;
+void udelay(long delay);
 
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
index 3ce7f65..944f0ee 100644
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
