Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 20D6A67A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 08:45:04 +1100 (EST)
Date: Fri, 18 Mar 2005 13:44:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-Id: <20050318134429.7dae3962.akpm@osdl.org>
In-Reply-To: <423B2310.4020005@mvista.com>
References: <423B2310.4020005@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.12] ppc32: Fix mv64x60 internal SRAM size
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
>  ppc32: Fix wrong size for mv64[34]60's internal SRAM.

This got a reject against other ppc32 patches which I had (they've all just
been flushed to Linus).

The reject was in arch/ppc/Kconfig.  Please check that I fixed it up
correctly.


From: "Mark A. Greer" <mgreer@mvista.com>

ppc32: Fix wrong size for mv64[34]60's internal SRAM.

- Fix incorrect SRAM size
- Minor Kconfig cleanups for mv64x60 platforms

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/Kconfig               |   10 ++--------
 25-akpm/arch/ppc/platforms/chestnut.h  |    4 ++--
 25-akpm/arch/ppc/platforms/katana.h    |    2 +-
 25-akpm/include/asm-ppc/mv64x60_defs.h |    2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff -puN arch/ppc/Kconfig~ppc32-fix-mv64x60-internal-sram-size arch/ppc/Kconfig
--- 25/arch/ppc/Kconfig~ppc32-fix-mv64x60-internal-sram-size	2005-03-18 13:41:27.000000000 -0800
+++ 25-akpm/arch/ppc/Kconfig	2005-03-18 13:42:57.000000000 -0800
@@ -577,7 +577,6 @@ config SANDPOINT
 
 config RADSTONE_PPC7D
 	bool "Radstone Technology PPC7D board"
-	select MV64360
 
 config ADIR
 	bool "SBS-Adirondack"
@@ -753,16 +752,11 @@ config GT64260
 	depends on EV64260 || CPCI690
 	default y
 
-config MV64360
+config MV64360		# Really MV64360 & MV64460
 	bool
-	depends on KATANA || RADSTONE_PPC7D || HDPU
+	depends on CHESTNUT || KATANA || RADSTONE_PPC7D || HDPU
 	default y
 
-config MV64360
-	bool
-	depends on CHESTNUT
-  	default y
-
 config MV64X60
 	bool
 	depends on (GT64260 || MV64360)
diff -puN arch/ppc/platforms/chestnut.h~ppc32-fix-mv64x60-internal-sram-size arch/ppc/platforms/chestnut.h
--- 25/arch/ppc/platforms/chestnut.h~ppc32-fix-mv64x60-internal-sram-size	2005-03-18 13:41:27.000000000 -0800
+++ 25-akpm/arch/ppc/platforms/chestnut.h	2005-03-18 13:41:27.000000000 -0800
@@ -28,8 +28,8 @@
  *    0xffd00000-0xffd00004      - CPLD
  *    0xffc00000-0xffc0000f      - UART
  *    0xffb00000-0xffb07fff      - FRAM
- *    0xffa00000-0xffafffff      - *** HOLE ***
- *    0xff800000-0xff9fffff      - MV64460 Integrated SRAM
+ *    0xff840000-0xffafffff      - *** HOLE ***
+ *    0xff800000-0xff83ffff      - MV64460 Integrated SRAM
  *    0xfe000000-0xff8fffff      - *** HOLE ***
  *    0xfc000000-0xfdffffff      - 32bit Flash
  *    0xf1010000-0xfbffffff      - *** HOLE ***
diff -puN arch/ppc/platforms/katana.h~ppc32-fix-mv64x60-internal-sram-size arch/ppc/platforms/katana.h
--- 25/arch/ppc/platforms/katana.h~ppc32-fix-mv64x60-internal-sram-size	2005-03-18 13:41:27.000000000 -0800
+++ 25-akpm/arch/ppc/platforms/katana.h	2005-03-18 13:41:27.000000000 -0800
@@ -24,7 +24,7 @@
  * on a boundary that is a multiple of the window size):
  *
  *    0xff800000-0xffffffff      - Boot window
- *    0xf8400000-0xf85fffff      - Internal SRAM
+ *    0xf8400000-0xf843ffff      - Internal SRAM
  *    0xf8200000-0xf83fffff      - CPLD
  *    0xf8100000-0xf810ffff      - MV64360 Registers (CONFIG_MV64X60_NEW_BASE)
  *    0xf8000000-0xf80fffff      - Socketed FLASH
diff -puN include/asm-ppc/mv64x60_defs.h~ppc32-fix-mv64x60-internal-sram-size include/asm-ppc/mv64x60_defs.h
--- 25/include/asm-ppc/mv64x60_defs.h~ppc32-fix-mv64x60-internal-sram-size	2005-03-18 13:41:27.000000000 -0800
+++ 25-akpm/include/asm-ppc/mv64x60_defs.h	2005-03-18 13:41:27.000000000 -0800
@@ -347,7 +347,7 @@
 #define	MV64360_SRAM_ERR_DATA_HI		0x03a0
 #define	MV64360_SRAM_ERR_PARITY			0x03a8
 
-#define	MV64360_SRAM_SIZE			0x00200000 /* 2 MB of SRAM */
+#define	MV64360_SRAM_SIZE			0x00040000 /* 2Mb/256KB SRAM */
 
 /*
  *****************************************************************************
_
