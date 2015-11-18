Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D889F1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 19:43:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 18 Nov 2015 14:13:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3C408E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:13:31 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI8gsAP35061868
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:12:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI8gqoG016755
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:12:52 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH v5] powerpc/pseries: Limit EPOW reset event warnings
Date: Wed, 18 Nov 2015 14:12:37 +0530
Message-Id: <1447836157-19599-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel prints respective warnings about various EPOW events for
user information/action after parsing EPOW interrupts. At times
below EPOW reset event warning is seen to be flooding kernel log
over a period of time.

May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared

These EPOW reset events are spurious in nature and are triggered by
firmware witout an actual EPOW event being reset. This patch avoids these
multiple EPOW reset warnings by using a counter variable. This variable
is incremented every time an EPOW event is reported. Upon receiving a EPOW
reset event the same variable is checked to filer out spurious events and
decremented accordingly.

This patch also improves log messages to better describe EPOW event being
reported. Merged adjacent log messages into single one to reduce number of
lines printed per event.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
v5 changes:
   - Used num_epow_events counter variable to count number of epow_events
   - Improved log messages to better describe epow event.
   - Merged adjacent warnings into single lines.

v4 changes:
   - Changed the approach to depth counter to match the EPOW events and
     EPOW reset.
   - Converted pr_err() ot pr_info() for non-critical errors.
   - Merged adjacent warnings into single line across the file.
   - Fixed grammar in the warnings to make is short.

v3 changes:
   - Limit warning printed by EPOW RESET event, by guarding it with bool flag.
     Instead of rate limiting all the EPOW events.

v2 changes:
   - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
     warnings, based on Michael's comments.

 arch/powerpc/platforms/pseries/ras.c | 54 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 3b6647e..bbe2856 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -40,6 +40,8 @@ static int ras_check_exception_token;
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
 
+static int num_epow_events;
+
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
@@ -82,32 +84,30 @@ static void handle_system_shutdown(char event_modifier)
 {
 	switch (event_modifier) {
 	case EPOW_SHUTDOWN_NORMAL:
-		pr_emerg("Firmware initiated power off");
+		pr_emerg("Power off requested\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_ON_UPS:
-		pr_emerg("Loss of power reported by firmware, system is "
-			"running on UPS/battery");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Loss of system power detected. System is running on"
+			 " UPS/battery. Check RTAS error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
-		pr_emerg("Loss of system critical functions reported by "
-			"firmware");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Loss of system critical functions detected. Check"
+			 " RTAS error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH:
-		pr_emerg("Ambient temperature too high reported by firmware");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("High ambient temperature detected. Check RTAS"
+			 " error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	default:
-		pr_err("Unknown power/cooling shutdown event (modifier %d)",
+		pr_err("Unknown power/cooling shutdown event (modifier = %d)\n",
 			event_modifier);
 	}
 }
@@ -145,40 +145,47 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	switch (action_code) {
 	case EPOW_RESET:
-		pr_err("Non critical power or cooling issue cleared");
+		if (num_epow_events) {
+			pr_info("Non critical power/cooling issue cleared\n");
+			num_epow_events--;
+		}
 		break;
 
 	case EPOW_WARN_COOLING:
-		pr_err("Non critical cooling issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_info("Non-critical cooling issue detected. Check RTAS error"
+			" log for details\n");
+		num_epow_events++;
 		break;
 
 	case EPOW_WARN_POWER:
-		pr_err("Non critical power issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_info("Non-critical power issue detected. Check RTAS error"
+			" log for details\n");
+		num_epow_events++;
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
 		handle_system_shutdown(epow_log->event_modifier);
+		num_epow_events++;
 		break;
 
 	case EPOW_SYSTEM_HALT:
-		pr_emerg("Firmware initiated power off");
+		pr_emerg("Critical power/cooling issue detected. Check RTAS"
+			 " error log for details. Powering off.\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_MAIN_ENCLOSURE:
 	case EPOW_POWER_OFF:
-		pr_emerg("Critical power/cooling issue reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("System about to lose power. Check RTAS error log "
+			 " for details. Powering off immediately.\n");
 		emergency_sync();
 		kernel_power_off();
 		break;
 
 	default:
-		pr_err("Unknown power/cooling event (action code %d)",
+		pr_err("Unknown power/cooling event (action code  = %d)\n",
 			action_code);
+		num_epow_events++;
 	}
 }
 
@@ -249,13 +256,12 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, fatal);
 
 	if (fatal) {
-		pr_emerg("Fatal hardware error reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("Fatal hardware error detected. Check RTAS error"
+			 " log for details. Powering off immediately\n");
 		emergency_sync();
 		kernel_power_off();
 	} else {
-		pr_err("Recoverable hardware error reported by firmware");
+		pr_err("Recoverable hardware error detected\n");
 	}
 
 	spin_unlock(&ras_log_buf_lock);
-- 
1.9.3
