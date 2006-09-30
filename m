Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 091D667B52
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 01:25:45 +1000 (EST)
Date: Sat, 30 Sep 2006 17:25:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] AC power not detected if no battery present
Message-ID: <20060930152530.GA9465@aepfle.de>
References: <20060924064008.GA7925@aepfle.de>
	<1159081888.5924.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1159081888.5924.20.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
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
@@ -168,7 +168,7 @@ static int option_server_mode;
 
 int pmu_battery_count;
 int pmu_cur_battery;
-unsigned int pmu_power_flags;
+unsigned int pmu_power_flags = PMU_PWR_AC_PRESENT;
 struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
