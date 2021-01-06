Return-Path: <SRS0=DrE0=GJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C53C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 20:27:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E329122B40
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 20:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DB1Bq5rW0zDqkG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Jan 2021 07:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=rMKQezn0; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DB10X3qs3zDqXQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2021 07:18:51 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 106K390U082028; Wed, 6 Jan 2021 15:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+bvxh+mxZJEZbYcUebGI7iyqFcTLkb1XswviEko5Cyo=;
 b=rMKQezn0XOCZigPNRmcLWcYIWpKsSTfV/GxbRWN2hQLWKXtuH9slHR+08ivS9yglqbCg
 ZjbXGwRItMjXrkW0tt1ZOF8G5gATiBYDr5RJt/HYPEzD6ogK4S4Yzv8T5kmL+xtz/mIX
 PThVSo732LO1pAs4KWVS8M3fGs28/QKiUD30lIGKZzkJw5VjMONIEgFdLuymN4h6CRWA
 Uqmjh2a9/23aXNDOTn2CjFvPr8g7j/cX3bKJ0oiwaxQt22ws1gU8KzxSY1cu2M3OdtKo
 u49dTeCZLIFYSBYy3YiMk1VGYr1dQIOeACptytcvxChGKk7stcBXJSStpNtM05BKu4am Cw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 35why5429q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Jan 2021 15:18:47 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 106KHbo8029844;
 Wed, 6 Jan 2021 20:18:46 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01dal.us.ibm.com with ESMTP id 35tgf9qbx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Jan 2021 20:18:46 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 106KIjWr26673644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Jan 2021 20:18:45 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F18D7C605A;
 Wed,  6 Jan 2021 20:18:44 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3953C6055;
 Wed,  6 Jan 2021 20:18:44 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  6 Jan 2021 20:18:44 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com
Subject: [PATCH v2 0/5] ibmvfc: MQ preparatory locking work
Date: Wed,  6 Jan 2021 14:18:30 -0600
Message-Id: <20210106201835.1053593-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-06_11:2021-01-06,
 2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=853 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060109
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, brking@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ibmvfc driver in its current form relies heavily on the host_lock. This
patchset introduces a genric queue with its own queue lock and sent/free event
list locks. This generic queue allows the driver to decouple the primary queue
and future subordinate queues from the host lock reducing lock contention while
also relaxing locking for submissions and completions to simply the list lock of
the queue in question.

changes in v2:
* Patch 4: Made ibmvfc_locked_done() static fixing a no-prototype warning

Tyrel Datwyler (5):
  ibmvfc: define generic queue structure for CRQs
  ibmvfc: make command event pool queue specific
  ibmvfc: define per-queue state/list locks
  ibmvfc: complete commands outside the host/queue lock
  ibmvfc: relax locking around ibmvfc_queuecommand

 drivers/scsi/ibmvscsi/ibmvfc.c | 379 ++++++++++++++++++++++-----------
 drivers/scsi/ibmvscsi/ibmvfc.h |  54 +++--
 2 files changed, 286 insertions(+), 147 deletions(-)

-- 
2.27.0

