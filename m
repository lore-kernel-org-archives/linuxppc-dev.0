Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D970679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Mar 2006 22:31:50 +1100 (EST)
Date: Sun, 12 Mar 2006 12:31:44 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] correct AC Power info in /proc/pmu/info
Message-ID: <20060312113144.GA26321@suse.de>
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


Report AC Power present in /proc/pmu/info if there is no battery.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 drivers/macintosh/via-pmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc6-olh/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.16-rc6-olh.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.16-rc6-olh/drivers/macintosh/via-pmu.c
@@ -825,7 +825,7 @@ proc_get_info(char *page, char **start, 
 	p += sprintf(p, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
 	p += sprintf(p, "PMU firmware version   : %02x\n", pmu_version);
 	p += sprintf(p, "AC Power               : %d\n",
-		((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0));
+		((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0) || pmu_battery_count == 0);
 	p += sprintf(p, "Battery count          : %d\n", pmu_battery_count);
 
 	return p - page;
