Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18082.43262.487474.356610@cargo.ozlabs.ibm.com>
Date: Sun, 22 Jul 2007 10:46:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Don't compile the PMU power driver on 64-bit PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As reported by Stephen Rothwell, an allmodconfig build on 64-bit
PowerPC reports these errors:

ERROR: "pmu_batteries" [drivers/power/pmu_battery.ko] undefined!
ERROR: "pmu_battery_count" [drivers/power/pmu_battery.ko] undefined!
ERROR: "pmu_power_flags" [drivers/power/pmu_battery.ko] undefined!

This fixes the problem by not building pmu_battery.ko on ppc64.  There
are no battery-powered ppc64 machines with an Apple PMU, and we can be
reasonably confident there never will be.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 3f6e176..58c806e 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -38,7 +38,7 @@ config BATTERY_DS2760
 
 config BATTERY_PMU
 	tristate "Apple PMU battery"
-	depends on ADB_PMU
+	depends on PPC32 && ADB_PMU
 	help
 	  Say Y here to expose battery information on Apple machines
 	  through the generic battery class.
