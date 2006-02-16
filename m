Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C2532679EB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 07:27:40 +1100 (EST)
Date: Thu, 16 Feb 2006 14:14:43 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.16rc2] EST8260 has bogus bd_info
Message-ID: <20060216191442.GE28338@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I managed to rescue an old EST8260 board from a life as a doorstop, and
after sticking u-boot on it, I was getting nothing but a silent death.
I eventually discovered it wouldn't boot because est8260.h had its own 
personal copy of an ancient bd_info struct that doesn't match any U-boot
from this century.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>


--- linux-2.6.16rc2-orig/arch/ppc/platforms/est8260.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/platforms/est8260.h	2006-02-16 12:04:02.000000000 -0500
@@ -6,30 +6,15 @@
 #ifndef __EST8260_PLATFORM
 #define __EST8260_PLATFORM
 
+#include <linux/config.h>
+#include <asm/ppcboot.h>
+
 #define CPM_MAP_ADDR		((uint)0xf0000000)
 
 #define BOOTROM_RESTART_ADDR	((uint)0xff000104)
 
 /* For our show_cpuinfo hooks. */
-#define CPUINFO_VENDOR		"EST Corporation"
-#define CPUINFO_MACHINE		"SBC8260 PowerPC"
-
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
-	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */
-	unsigned int	bi_brgfreq;	/* BRG Freq, in MHz */
-	unsigned int	bi_vco;		/* VCO Out from PLL */
-	unsigned int	bi_baudrate;	/* Default console baud rate */
-	unsigned int	bi_immr;	/* IMMR when called from boot rom */
-	unsigned char	bi_enetaddr[6];
-} bd_t;
-
-extern bd_t m8xx_board_info;
+#define CPUINFO_VENDOR		"Wind River"
+#define CPUINFO_MACHINE		"EST SBC8260 PowerPC"
 
 #endif 	/* __EST8260_PLATFORM */
