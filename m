Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1BE61DDF35
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 07:38:40 +1100 (EST)
Date: Sat, 10 Feb 2007 21:40:00 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] correct AC Power: in /proc/pmu/info on ibook1
Message-ID: <20070210204000.GA25638@aepfle.de>
References: <20070210203512.GA25586@aepfle.de>
	<20070210203614.GA25602@aepfle.de>
	<20070210203733.GA25611@aepfle.de>
	<20070210203837.GA25625@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070210203837.GA25625@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


/proc/pmu/info contains AC Power: 0 when booting without battery.
Force AC Power, it will be updated whenever the battery state changes.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/via-pmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6/drivers/macintosh/via-pmu.c
@@ -169,7 +169,7 @@ static int option_server_mode;
 
 int pmu_battery_count;
 int pmu_cur_battery;
-unsigned int pmu_power_flags;
+unsigned int pmu_power_flags = PMU_PWR_AC_PRESENT;
 struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
