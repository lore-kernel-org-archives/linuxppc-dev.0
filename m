Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B58C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 06:27:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876E82082C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 06:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QYcT4lhhzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 17:27:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QYZZ5SlrzDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 17:26:11 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2M6J5uL079763
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 02:26:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rct68rkb5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 02:26:08 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Fri, 22 Mar 2019 06:25:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Mar 2019 06:25:55 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2M6Q3G320775098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2019 06:26:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C20AAE053;
 Fri, 22 Mar 2019 06:26:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FEB0AE04D;
 Fri, 22 Mar 2019 06:26:02 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2019 06:26:02 +0000 (GMT)
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
Date: Fri, 22 Mar 2019 01:25:29 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
References: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032206-0020-0000-0000-000003263E74
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032206-0021-0000-0000-0000217867D0
Message-Id: <20190322062530.7586-2-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-22_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220048
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
Cc: daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 Abhishek Goel <huntbag@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, the cpuidle governors (menu /ladder) determine what idle state
an idling CPU should enter into based on heuristics that depend on the
idle history on that CPU. Given that no predictive heuristic is perfect,
there are cases where the governor predicts a shallow idle state, hoping
that the CPU will be busy soon. However, if no new workload is scheduled
on that CPU in the near future, the CPU will end up in the shallow state.

In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

To address this, such lite states need to be autopromoted. The cpuidle-
core can queue timer to correspond with the residency value of the next
available state. Thus leading to auto-promotion to a deeper idle state as
soon as possible.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2406e2655..c4d1c1b38 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -584,11 +584,8 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 
 static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
-	int i;
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
 	dev->last_residency = 0;
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
-               dev->states_usage[i].disable = true;
 }
 
 /**
-- 
2.17.1

