Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 925E6DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Mar 2007 18:03:03 +1100 (EST)
Date: Wed, 7 Mar 2007 08:02:58 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: u-boot-users@lists.sourceforge.net
Subject: [RFC PATCH] icecube/lite5200b: fix OF_TBCLK (timebase-frequency)
	calculation
Message-ID: <20070307070258.GA4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tracked jiffies (on Linux) incrementing twice as fast on
lite5200b to this ("timebase-frequency" property).

G2 core reference manual says decrementer and time base
are decreasing/increasing once every 4 bus clock cycles.

Was there a reason this was busfreq/8?


	Domen
---
 include/configs/IceCube.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: u-boot.git/include/configs/IceCube.h
===================================================================
--- u-boot.git.orig/include/configs/IceCube.h
+++ u-boot.git/include/configs/IceCube.h
@@ -182,7 +182,7 @@
 
 #define OF_CPU			"PowerPC,5200@0"
 #define OF_SOC			"soc5200@f0000000"
-#define OF_TBCLK		(bd->bi_busfreq / 8)
+#define OF_TBCLK		(bd->bi_busfreq / 4)
 #define OF_STDOUT_PATH		"/soc5200@f0000000/serial@2000"
 
 /*
