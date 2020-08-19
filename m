Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED1C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 22:54:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0397F20674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 22:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l1XnvpoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0397F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BX34Q3L3PzDr0X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:54:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=ljp@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=l1XnvpoL; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BX32T2vmMzDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2020 08:52:32 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JMZO0q141415; Wed, 19 Aug 2020 18:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hf7lEKz91x4x/xMqUfsAq8ICRpolLRo5guvOINRuTGM=;
 b=l1XnvpoL0vJhIuQNQSjFfHr/ZNLVOwcUJsEMHvPd7FoFaRvBHNcAb8p46FsKkr0OVRe2
 gHRmTBFDqe85ktM4mrHBzylE3jULxl14D96T5NxkZ5wXwg1eL571x2JVIVpeYtgh+hcR
 uv81XD1ewC2+fdafjt2nCpyGi4OXErLvHFQmmcAYudGe7w7xLqy1UPaXFukCMDfALTWG
 MWRyGsXEcUSZXvrjKmF1mRNWqd0iI/lZlgE/LPmXZJ3dLhJr80orBIzspWpp4oOczr37
 44Mq/kwixpD8eOzrt4t0UghxZABiOzH6fW4htlK9UGD6uqCjAbesbsiIiryvTt9rr+Os 2Q== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304r4xwp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 18:52:30 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JMnYKF016677;
 Wed, 19 Aug 2020 22:52:29 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 3304ccucs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 22:52:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07JMqRRc44040466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 22:52:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFD8DBE04F;
 Wed, 19 Aug 2020 22:52:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40AA5BE051;
 Wed, 19 Aug 2020 22:52:27 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.63.43])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2020 22:52:27 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] refactoring of ibmvnic code
Date: Wed, 19 Aug 2020 17:52:22 -0500
Message-Id: <20200819225226.10152-1-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_13:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=1 mlxlogscore=700 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190182
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

This patch series refactor reset_init and init functions,
and make some other cosmetic changes to make the code
easier to read and debug. v2 removes __func__ and v1's 1/5.

Lijun Pan (4):
  ibmvnic: compare adapter->init_done_rc with more readable
    ibmvnic_rc_codes
  ibmvnic: improve ibmvnic_init and ibmvnic_reset_init
  ibmvnic: remove never executed if statement
  ibmvnic: merge ibmvnic_reset_init and ibmvnic_init

 drivers/net/ethernet/ibm/ibmvnic.c | 84 ++++++++----------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

-- 
2.23.0

