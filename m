Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5840BC282E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 06:36:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988352075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 06:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988352075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ncKc0sCVzDqS6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 16:36:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ncHg2dVnzDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 16:34:22 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3M6XnVY067145
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s12t41dq4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 22 Apr 2019 07:34:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Apr 2019 07:34:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3M6YDTP55247052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Apr 2019 06:34:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74BCB5204E;
 Mon, 22 Apr 2019 06:34:13 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1829D52059;
 Mon, 22 Apr 2019 06:34:11 +0000 (GMT)
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Mon, 22 Apr 2019 01:32:30 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19042206-4275-0000-0000-0000032A459E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042206-4276-0000-0000-0000383986BE
Message-Id: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220049
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 Abhishek Goel <huntbag@linux.vnet.ibm.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, the cpuidle governors determine what idle state a idling CPU
should enter into based on heuristics that depend on the idle history on
that CPU. Given that no predictive heuristic is perfect, there are cases
where the governor predicts a shallow idle state, hoping that the CPU will
be busy soon. However, if no new workload is scheduled on that CPU in the
near future, the CPU will end up in the shallow state.

Motivation
----------
In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

So we do not want to get stucked in such states for longer duration. To
address this, the cpuidle-core can queue timer to correspond with the
residency value of the next available state. This timer will forcefully
wakeup the cpu. Few such iterations will essentially train the governor to
select a deeper state for that cpu, as the timer here corresponds to the
next available cpuidle state residency. Cpu will be kicked out of the lite
state and end up in a non-lite state.

Experiment
----------
I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained in a upstream kernel -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally,
observation was

=========================================================
sample          min            max           99percentile
20              4ms            12ms          4ms
=========================================================

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a
          timer)

============================================================
sample          min             max             99percentile
============================================================
20              144us           192us           144us
============================================================

In this patch, we queue a timer just before entering into a stop0_lite
state. The timer fires at (residency of next available state + exit latency
of next available state * 2). Let's say if next state(stop0) is available
which has residency of 20us, it should get out in as low as (20+2*2)*8
[Based on the forumla (residency + 2xlatency)*history length] microseconds
= 192us. Ideally we would expect 8 iterations, it was observed to get out
in 6-7 iterations. Even if let's say stop2 is next available state(stop0
and stop1 both are unavailable), it would take (100+2*10)*8 = 960us to get
into stop2.

So, We are able to get out of stop0_lite generally in 150us(with this
patch) as compared to 4ms(with tick retained). As stated earlier, we do not
want to get stuck into stop0_lite as it inhibits SMT folding for other
sibling threads, depriving them of core resources. Current patch is using
forced-wakeup only for stop0_lite, as it gives performance benefit(primary
reason) along with lowering down power consumption. We may extend this
model for other states in future.

Abhishek Goel (1):
  cpuidle-powernv : forced wakeup for stop lite states

 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/cpuidle-powernv.c   | 71 ++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.17.1

