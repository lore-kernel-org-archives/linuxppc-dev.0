Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTkH02gVSzDqbF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:06:36 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4JA4kU1008833
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 06:06:30 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ahr3j10c4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 06:06:30 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 19 May 2017 20:06:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4JA6G4M63504470
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:06:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4JA5i6B028964
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:05:45 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 rtc-linux@googlegroups.com
Subject: [PATCH] rtc/tpo: Handle disabled TPO in opal_get_tpo_time()
Date: Fri, 19 May 2017 15:35:09 +0530
Message-Id: <20170519100509.7807-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
stored TPO yields value with all date components set to '0' inside
opal_get_tpo_time(). The function opal_to_tm() then converts it to an
offset from year 1900 yielding alarm-time == "1900-00-01
00:00:00". This causes problems with __rtc_read_alarm() that
expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
results in a -ve value for time64_t. Which ultimately results in this
error reported in kernel logs with a seemingly garbage value:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

We fix this by explicitly handling the case of all alarm date-time
components being '0' inside opal_get_tpo_time() and returning -ENOENT
in such a case. This signals generic rtc that no alarm is set and it
bails out from the alarm initialization flow without reporting the
above error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reported-by: Steve Best <sbest@redhat.com>
---
 drivers/rtc/rtc-opal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index ea20f62..2d84e2a 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -142,6 +142,16 @@ static int opal_get_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = ((u64)be32_to_cpu(__h_m) << 32);
+
+	/* check if no alarm is set */
+	if (y_m_d == 0 && h_m_s_ms == 0) {
+		pr_debug("No alarm is set\n");
+		rc = -ENOENT;
+		goto exit;
+	} else {
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+	}
+
 	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
 
 exit:
-- 
2.9.3
