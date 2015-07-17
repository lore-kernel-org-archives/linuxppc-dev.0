Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286411A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:19:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 18:19:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 44EBD2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:18:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H8Im5j23003304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:18:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H8INwP022608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:18:24 +1000
Date: Fri, 17 Jul 2015 13:47:59 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, vipin@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RESEND,v3] powerpc/pseries: Limit EPOW reset event warnings
Message-ID: <20150717081540.GA25802@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1436934126-9273-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20150716040552.BBCEC1402C2@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150716040552.BBCEC1402C2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2015-07-16 14:05:52]:

[..]
> 
> Why are we even getting these reset events when nothing has happened?

Thanks for the review. It was seen only on one machine, couldn't
get hold of the machine any more. I am guessing here, that it might be
the firmware.

> 
> > Also, merged adjacent pr_err/pr_emerg into single one to reduce
> > the number of lines printed per warning.
[..]
> >  
> > +/* Flag to limit EPOW RESET warning. */
> > +static bool epow_state;
> 
> This name is terrible, it doesn't give me any hint to what it means.
> 
> But really it should be a counter, not a boolean.
> 
> We could have multiple EPOW events come in and then later get the reset events
> for them, couldn't we?
> 
> 
> So what about:
> 
> static unsigned epow_event_depth;
> 
--->8----

>From 0d27916fd09a9f0912a217432a41e2b579dc2952 Mon Sep 17 00:00:00 2001
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 17 Jul 2015 13:19:31 +0530
Subject: [PATCH v4] powerpc/pseries: Limit EPOW reset event warnings

Kernel prints respective warnings about various EPOW events for
user information/action after parsing EPOW interrupts. At times
EPOW reset event warning, such as below could flood kernel log,
over a period of time.

May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared

This patch avoids these multiple EPOW reset warnings by using epow_depth
counter. Which is incremented every time EPOW event is reported and
decremented on EPOW_RESET event. With this approach number EPOW RESET
warning matches the number of EPOW events.

Also, merged adjacent pr_info/pr_err/pr_emerg into single one to reduce
the number of lines printed per warning across the file and converted
non-critical errors to pr_info from pr_error, including grammar
correction in the warnings printed.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
V4: Changes:
   - Changed the approach to depth counter to match the EPOW events and
     EPOW reset.
   - Converted pr_err() ot pr_info() for non-critical errors.
   - Merged adjacent warnings into single line across the file.
   - Fixed grammar in the warnings to make is short.

v3 Changes:
   - Limit warning printed by EPOW RESET event, by guarding it with bool flag.
     Instead of rate limiting all the EPOW events.

v2 Changes:
   - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
     warnings, based on Michael's comments.

 arch/powerpc/platforms/pseries/ras.c | 53 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 02e4a17..995cab8 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -40,6 +40,8 @@ static int ras_check_exception_token;
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
 
+static unsigned epow_event_depth;
+
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
@@ -82,32 +84,30 @@ static void handle_system_shutdown(char event_modifier)
 {
 	switch (event_modifier) {
 	case EPOW_SHUTDOWN_NORMAL:
-		pr_emerg("Firmware initiated power off");
+		pr_emerg("Firmware initiated power off\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_ON_UPS:
-		pr_emerg("Loss of power reported by firmware, system is "
-			"running on UPS/battery");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Loss of power reported, system is running on"
+			 " UPS/battery. Check RTAS error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
-		pr_emerg("Loss of system critical functions reported by "
-			"firmware");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Loss of system critical functions reported. Check"
+			 " RTAS error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH:
-		pr_emerg("Ambient temperature too high reported by firmware");
-		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Ambient temperature too high reported. Check RTAS"
+			 " error log for details\n");
 		orderly_poweroff(true);
 		break;
 
 	default:
-		pr_err("Unknown power/cooling shutdown event (modifier %d)",
+		pr_info("Unknown power/cooling shutdown event (modifier %d)\n",
 			event_modifier);
 	}
 }
@@ -145,40 +145,46 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	switch (action_code) {
 	case EPOW_RESET:
-		pr_err("Non critical power or cooling issue cleared");
+		if (epow_event_depth) {
+			pr_err("Non critical power/cooling issue cleared\n");
+			epow_event_depth--;
+		}
 		break;
 
 	case EPOW_WARN_COOLING:
-		pr_err("Non critical cooling issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_info("Non-critical cooling issue reported, check RTAS error"
+			" log for details\n");
+		epow_event_depth++;
 		break;
 
 	case EPOW_WARN_POWER:
-		pr_err("Non critical power issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_info("Non-critical power issue reported, check RTAS error"
+			" log for details\n");
+		epow_event_depth++;
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
 		handle_system_shutdown(epow_log->event_modifier);
+		epow_event_depth++;
 		break;
 
 	case EPOW_SYSTEM_HALT:
-		pr_emerg("Firmware initiated power off");
+		pr_emerg("Firmware initiated power off\n");
 		orderly_poweroff(true);
 		break;
 
 	case EPOW_MAIN_ENCLOSURE:
 	case EPOW_POWER_OFF:
-		pr_emerg("Critical power/cooling issue reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("Critical power/cooling issue reported, Check RTAS"
+			 " error log for details. Immediate power off\n");
 		emergency_sync();
 		kernel_power_off();
 		break;
 
 	default:
-		pr_err("Unknown power/cooling event (action code %d)",
+		pr_info("Unknown power/cooling event (action code %d)\n",
 			action_code);
+		epow_event_depth++;
 	}
 }
 
@@ -248,13 +254,12 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, fatal);
 
 	if (fatal) {
-		pr_emerg("Fatal hardware error reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("Fatal hardware error reported, Check RTAS error"
+			 " log for details. Immediate power off\n");
 		emergency_sync();
 		kernel_power_off();
 	} else {
-		pr_err("Recoverable hardware error reported by firmware");
+		pr_err("Recoverable hardware error reported by firmware\n");
 	}
 
 	spin_unlock(&ras_log_buf_lock);
-- 
2.1.2
