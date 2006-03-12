Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D65F679E2
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Mar 2006 10:07:06 +1100 (EST)
Subject: [Fwd: [PATCH] correct AC Power info in /proc/pmu/info]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 10:06:27 +1100
Message-Id: <1142204787.4433.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 

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
