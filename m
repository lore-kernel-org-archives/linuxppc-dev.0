Return-Path: <dgibson@ozlabs.org>
Date: Fri, 14 Sep 2007 15:54:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: rtc-ds1742.c should use resource_size_t for base address
Message-ID: <20070914055427.GM481@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the rtc driver, rtc-ds1742.c uses an unsigned long to store
the base mmio address of the NVRAM/RTC.  This breaks on systems like
PowerPC 440, which is a 32-bit core with 36-bit physical addresses: IO
on the system, including the RTC, is typically above the 4GB point,
and cannot fit into an unsigned long.

This patch fixes the problem by replacing the unsigned long with a
resource_size_t.  Tested on Ebony (PPC440) (with additional patches to
instantiate the ds1742 platform device appropriately).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/rtc/rtc-ds1742.c
===================================================================
--- working-2.6.orig/drivers/rtc/rtc-ds1742.c	2007-09-14 15:43:31.000000000 +1000
+++ working-2.6/drivers/rtc/rtc-ds1742.c	2007-09-14 15:44:09.000000000 +1000
@@ -55,7 +55,7 @@ struct rtc_plat_data {
 	void __iomem *ioaddr_rtc;
 	size_t size_nvram;
 	size_t size;
-	unsigned long baseaddr;
+	resource_size_t baseaddr;
 	unsigned long last_jiffies;
 };
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
