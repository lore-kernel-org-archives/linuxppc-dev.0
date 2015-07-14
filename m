Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFD801A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:53:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 17:52:58 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A59BE3578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:52:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6E7qlBj63963324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:52:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6E7qMPi007536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:52:22 +1000
Date: Tue, 14 Jul 2015 13:21:55 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/pseries: Ratelimit EPOW event warnings
Message-ID: <20150714075153.GA32237@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1433222291-26461-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <558B027C.1060304@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <558B027C.1060304@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vipin K Parashar <vipin@linux.vnet.ibm.com> [2015-06-25 00:48:20]:

> 
> On 06/02/2015 10:48 AM, Kamalesh Babulal wrote:
> >We print the respective warning after parsing EPOW interrupts,
> >prompting user to take action depending upon the severity of the
> >event.
> >
> >Some times same EPOW event warning, such as below could flood kernel
> >log, over a period of time. So Limit the warnings by using ratelimit
> >variant of pr_err. Also, merge adjacent pr_err/pr_emerg into single
> >one to reduce the number of lines printed per warning.
> >
> >May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> >May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> >May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> >May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> >May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> >May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
> >May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared
> 
> These messages are minutes apart and thus rate limiting won't help.
> One solution could be to use a flag based approach. Set a flag once a
> EPOW condition is detected and check that flag upon receiving EPOW_RESET.
> EPOW condition clear message should be logged only if a EPOW was previously
> detected i.e. flag found set.

Thanks for reviewing it. Sorry for late response.

bool flag epow_state, which is initialized to false and when any event gets
reported, the flag set to true once the event gets acknowledged by a reset.
As, seen in the example of flooded messages occurring only with reset event.
The reset action is guarded with bool flag (set only if there was event
reported previously) and ignore multiple resets, without real EPOW event.

I have only compile tested the patch. If this approach sounds good.
I will resend formal patch.


diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 02e4a17..4819b1d 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -40,6 +40,8 @@ static int ras_check_exception_token;
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
 
+static bool epow_state = false;
+
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
@@ -145,21 +147,27 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	switch (action_code) {
 	case EPOW_RESET:
-		pr_err("Non critical power or cooling issue cleared");
+		if (epow_state) {
+			pr_err("Non critical power or cooling issue cleared");
+			epow_state = false;
+		}
 		break;
 
 	case EPOW_WARN_COOLING:
-		pr_err("Non critical cooling issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_err("Non critical cooling issue reported by firmware, "
+		       "Check RTAS error log for details");
+		epow_state = true;
 		break;
 
 	case EPOW_WARN_POWER:
-		pr_err("Non critical power issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_err("Non critical power issue reported by firmware, "
+		       "Check RTAS error log for details");
+		epow_state = true;
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
 		handle_system_shutdown(epow_log->event_modifier);
+		epow_state = true;
 		break;
 
 	case EPOW_SYSTEM_HALT:
@@ -169,9 +177,8 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	case EPOW_MAIN_ENCLOSURE:
 	case EPOW_POWER_OFF:
-		pr_emerg("Critical power/cooling issue reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("Critical power/cooling issue reported by firmware, "
+			 "Check RTAS error log for details. Immediate power off.");
 		emergency_sync();
 		kernel_power_off();
 		break;
@@ -179,6 +186,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 	default:
 		pr_err("Unknown power/cooling event (action code %d)",
 			action_code);
+		epow_state = true;
 	}
 }
 
