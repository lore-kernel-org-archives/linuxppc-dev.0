Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lMmf030111@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:51 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 36/43] ppc64: AC Power handling broken for desktops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Currently, AC Power is 0 on a desktop G4.  No batteries present should mean
AC Power == 1.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/macintosh/apm_emu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN drivers/macintosh/apm_emu.c~ppc64-ac-power-handling-broken-for-desktops drivers/macintosh/apm_emu.c
--- devel/drivers/macintosh/apm_emu.c~ppc64-ac-power-handling-broken-for-desktops	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/drivers/macintosh/apm_emu.c	2005-10-28 17:44:04.000000000 -0700
@@ -430,8 +430,8 @@ static int apm_emu_get_info(char *buf, c
 	      -1: Unknown
 	   8) min = minutes; sec = seconds */
 
-	unsigned short  ac_line_status = 0xff;
-	unsigned short  battery_status = 0xff;
+	unsigned short  ac_line_status;
+	unsigned short  battery_status = 0;
 	unsigned short  battery_flag   = 0xff;
 	int		percentage     = -1;
 	int             time_units     = -1;
@@ -446,6 +446,7 @@ static int apm_emu_get_info(char *buf, c
 	ac_line_status = ((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0);
 	for (i=0; i<pmu_battery_count; i++) {
 		if (pmu_batteries[i].flags & PMU_BATT_PRESENT) {
+			battery_status++;
 			if (percentage < 0)
 				percentage = 0;
 			if (charge < 0)
@@ -461,6 +462,9 @@ static int apm_emu_get_info(char *buf, c
 				charging++;
 		}
 	}
+	if (0 == battery_status)
+		ac_line_status = 1;
+	battery_status = 0xff;
 	if (real_count) {
 		if (amperage < 0) {
 			if (btype == PMU_BATT_TYPE_SMART)
_
