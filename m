Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3F4267EC8
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2006 23:10:18 +1100 (EST)
Date: Mon, 6 Feb 2006 13:10:13 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] make powerbook_sleep_grackle static
Message-ID: <20060206121013.GA27981@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerbook_sleep_grackle is only called inside via-pmu,
from pmu_ioctl()

Signed-off-by: Olaf Hering <olh@suse.de>
---
 drivers/macintosh/via-pmu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.15/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.15.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.15/drivers/macintosh/via-pmu.c
@@ -2200,8 +2200,7 @@ pmac_wakeup_devices(void)
 #define	GRACKLE_NAP	(1<<4)
 #define	GRACKLE_SLEEP	(1<<3)
 
-int
-powerbook_sleep_grackle(void)
+static int powerbook_sleep_grackle(void)
 {
 	unsigned long save_l2cr;
 	unsigned short pmcr1;
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
