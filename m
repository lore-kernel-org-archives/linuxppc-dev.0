Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTvFp50tkzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 02:51:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4JGi5Bw077993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 12:51:06 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ahr3jj3bd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 12:51:06 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sat, 20 May 2017 02:51:03 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4JGoqkc2032126
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 02:51:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4JGoQvj021945
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 02:50:27 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] drivers/rtc/interface.c: Validate alarm-time before handling
 rollover
Date: Fri, 19 May 2017 22:18:55 +0530
Message-Id: <20170519164855.11747-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In function __rtc_read_alarm() its possible for an alarm time-stamp to
be invalid even after replacing missing components with current
time-stamp. The condition 'alarm->time.tm_year < 70' will trigger this
case and will cause the call to 'rtc_tm_to_time64(&alarm->time)'
return a negative value for variable t_alm.

While handling alarm rollover this negative t_alm (assumed to seconds
offset from '1970-01-01 00:00:00') is converted back to rtc_time via
rtc_time64_to_tm() which results in this error log with seemingly
garbage values:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

This error was generated when the rtc driver (rtc-opal in this case)
returned an alarm time-stamp of '00-00-00 00:00:00' to indicate that
the alarm is disabled. Though I have submitted a separate fix for the
rtc-opal driver, this issue may potentially impact other
existing/future rtc drivers.

To fix this issue the patch validates the alarm time-stamp just after
filling up the missing datetime components and if rtc_valid_tm() still
reports it to be invalid then bails out of the function without
handling the rollover.

Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/rtc/interface.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index fc0fa75..8cec9a0 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -227,6 +227,13 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 			missing = year;
 	}
 
+	/* Can't proceed if alarm is still invalid after replacing
+	 * missing fields.
+	 */
+	err = rtc_valid_tm(&alarm->time);
+	if (err)
+		goto done;
+
 	/* with luck, no rollover is needed */
 	t_now = rtc_tm_to_time64(&now);
 	t_alm = rtc_tm_to_time64(&alarm->time);
@@ -278,9 +285,9 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		dev_warn(&rtc->dev, "alarm rollover not handled\n");
 	}
 
-done:
 	err = rtc_valid_tm(&alarm->time);
 
+done:
 	if (err) {
 		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
 			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
-- 
2.9.3
