Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 1C47C67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 05:51:26 +1100 (EST)
Message-ID: <423B2310.4020005@mvista.com>
Date: Fri, 18 Mar 2005 11:50:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------010706040806010809060007"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] ppc32: Fix mv64x60 internal SRAM size
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------010706040806010809060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: Fix wrong size for mv64[34]60's internal SRAM.

- Fix incorrect SRAM size
- Minor Kconfig cleanups for mv64x60 platforms

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------010706040806010809060007
Content-Type: text/plain;
 name="mv64x60_sram_size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64x60_sram_size.patch"

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-18 11:47:52 -07:00
+++ b/arch/ppc/Kconfig	2005-03-18 11:47:52 -07:00
@@ -570,7 +570,6 @@
 
 config RADSTONE_PPC7D
 	bool "Radstone Technology PPC7D board"
-	select MV64360
 
 config ADIR
 	bool "SBS-Adirondack"
@@ -746,19 +745,14 @@
 	depends on EV64260 || CPCI690
 	default y
 
-config MV64360
+config MV64360 # Really MV64360 & MV64460
 	bool
-	depends on KATANA || RADSTONE_PPC7D
+	depends on CHESTNUT || KATANA || RADSTONE_PPC7D
 	default y
 
-config MV64360
-	bool
-	depends on CHESTNUT
-  	default y
-
 config MV64X60
 	bool
-	depends on (GT64260 || MV64360)
+	depends on GT64260 || MV64360
 	default y
 
 menu "Set bridge options"
diff -Nru a/arch/ppc/platforms/chestnut.h b/arch/ppc/platforms/chestnut.h
--- a/arch/ppc/platforms/chestnut.h	2005-03-18 11:47:52 -07:00
+++ b/arch/ppc/platforms/chestnut.h	2005-03-18 11:47:52 -07:00
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
diff -Nru a/arch/ppc/platforms/katana.h b/arch/ppc/platforms/katana.h
--- a/arch/ppc/platforms/katana.h	2005-03-18 11:47:52 -07:00
+++ b/arch/ppc/platforms/katana.h	2005-03-18 11:47:52 -07:00
@@ -24,7 +24,7 @@
  * on a boundary that is a multiple of the window size):
  *
  *    0xff800000-0xffffffff      - Boot window
- *    0xf8400000-0xf85fffff      - Internal SRAM
+ *    0xf8400000-0xf843ffff      - Internal SRAM
  *    0xf8200000-0xf83fffff      - CPLD
  *    0xf8100000-0xf810ffff      - MV64360 Registers (CONFIG_MV64X60_NEW_BASE)
  *    0xf8000000-0xf80fffff      - Socketed FLASH
diff -Nru a/include/asm-ppc/mv64x60_defs.h b/include/asm-ppc/mv64x60_defs.h
--- a/include/asm-ppc/mv64x60_defs.h	2005-03-18 11:47:52 -07:00
+++ b/include/asm-ppc/mv64x60_defs.h	2005-03-18 11:47:52 -07:00
@@ -347,7 +347,7 @@
 #define	MV64360_SRAM_ERR_DATA_HI		0x03a0
 #define	MV64360_SRAM_ERR_PARITY			0x03a8
 
-#define	MV64360_SRAM_SIZE			0x00200000 /* 2 MB of SRAM */
+#define	MV64360_SRAM_SIZE			0x00040000 /* 2Mb/256KB SRAM */
 
 /*
  *****************************************************************************

--------------010706040806010809060007--
