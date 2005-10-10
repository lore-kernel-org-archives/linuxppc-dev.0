Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA288683D5
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 03:09:02 +1000 (EST)
Date: Mon, 10 Oct 2005 19:08:57 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>
Message-ID: <20051010170857.GB9928@suse.de>
References: <20050824115452.GA29148@suse.de> <1124922771.5159.134.camel@gaston>
	<20050825045108.GA19792@suse.de> <1124946481.7906.8.camel@gaston>
	<20050825051528.GB19792@suse.de> <1124948071.7907.10.camel@gaston>
	<20050826113827.GA25134@suse.de> <1127090662.4502.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1127090662.4502.12.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] AC Power handling broken for desktops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Currently, AC Power is 0 on a desktop G4.
No batteries present should mean AC Power == 1.

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/macintosh/apm_emu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc7-ac-power/drivers/macintosh/apm_emu.c
===================================================================
--- linux-2.6.13-rc7-ac-power.orig/drivers/macintosh/apm_emu.c
+++ linux-2.6.13-rc7-ac-power/drivers/macintosh/apm_emu.c
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
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
