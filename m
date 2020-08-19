Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31325C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 05:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248B20772
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 05:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOny/mV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D248B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWcDF65VrzDqwT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 15:44:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=ljp@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=pOny/mV8; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWc1f40h3zDqq7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 15:35:18 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J5WZIx078428; Wed, 19 Aug 2020 01:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H8hBoiZlNF67Lah+17S5EUflHemRCDXK7B7kUiUqJSc=;
 b=pOny/mV8OsoZB7iMX9Gf2548IY8LSa1dPWvZPhGl+YfUNFI57lGcexa0qPtOrhZtQthU
 kn7JPFBU7Ye7BARUoH4fD5W/tcdzIN8pWJ5N+mt1gTMULbwhLUZj6XNII1wytfKf3/SK
 aoll70LkrCndII7qGWdA2Wwt/9UlaUljQHNVJ7HQLR+BLAfyY/zCs6O68q7+XjTDTW5d
 lHU1FG/hrm1bf7ACAkfaBNrvyabtqqRRIEp/WtwGi9FkvTw0ry39dnih72LQi2OavMCi
 nkeuDiAIY7isDPFjjdEzCjA4mWZiWuSJxrKrxasHddLgm6sQszYfcOBHV5fInsSuAJaj +w== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304nv25ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 01:35:15 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07J5Yk4T029063;
 Wed, 19 Aug 2020 05:35:15 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01wdc.us.ibm.com with ESMTP id 3304tkhew9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 05:35:15 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07J5ZFq448431428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 05:35:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC12FAC05B;
 Wed, 19 Aug 2020 05:35:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C91AAC059;
 Wed, 19 Aug 2020 05:35:14 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.104.33])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2020 05:35:14 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 4/5] ibmvnic: remove never executed if statement
Date: Wed, 19 Aug 2020 00:35:11 -0500
Message-Id: <20200819053512.3619-5-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200819053512.3619-1-ljp@linux.ibm.com>
References: <20200819053512.3619-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_02:2020-08-18,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190042
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
Cc: Lijun Pan <ljp@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the beginning of the function, from_passive_init is set false by
"adapter->from_passive_init = false;",
hence the if statement will never run.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e366fd42a8c4..280358dce8ba 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5000,12 +5000,6 @@ static int ibmvnic_reset_init(struct ibmvnic_adapter *adapter)
 		return adapter->init_done_rc;
 	}
 
-	if (adapter->from_passive_init) {
-		adapter->state = VNIC_OPEN;
-		adapter->from_passive_init = false;
-		return -1;
-	}
-
 	if (test_bit(0, &adapter->resetting) && !adapter->wait_for_reset &&
 	    adapter->reset_reason != VNIC_RESET_MOBILITY) {
 		if (adapter->req_rx_queues != old_num_rx_queues ||
@@ -5059,12 +5053,6 @@ static int ibmvnic_init(struct ibmvnic_adapter *adapter)
 		return adapter->init_done_rc;
 	}
 
-	if (adapter->from_passive_init) {
-		adapter->state = VNIC_OPEN;
-		adapter->from_passive_init = false;
-		return -1;
-	}
-
 	rc = init_sub_crqs(adapter);
 	if (rc) {
 		dev_err(dev, "Initialization of sub crqs failed\n");
-- 
2.23.0

