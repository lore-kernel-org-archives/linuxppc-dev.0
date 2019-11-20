Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F2C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 15:52:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7306420672
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 15:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47J6f11D6NzDqtR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 02:52:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=julietk@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47J6bV6z3mzDqn4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 02:50:27 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKFl8xr017780; Wed, 20 Nov 2019 10:50:23 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf5ag51q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 10:50:23 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAKFnjW7005670;
 Wed, 20 Nov 2019 15:50:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma05wdc.us.ibm.com with ESMTP id 2wa8r6p0rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 15:50:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKFoL4x61407530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 15:50:21 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2080EC605F;
 Wed, 20 Nov 2019 15:50:21 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F2CC6059;
 Wed, 20 Nov 2019 15:50:20 +0000 (GMT)
Received: from ltcalpine2-lp21.aus.stglabs.ibm.com (unknown [9.40.195.230])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 15:50:20 +0000 (GMT)
From: Juliet Kim <julietk@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net/ibmvnic 0/2] Support both XIVE and XICS modes in ibmvnic
Date: Wed, 20 Nov 2019 10:50:02 -0500
Message-Id: <1574265004-8388-1-git-send-email-julietk@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_04:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 mlxlogscore=584 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200140
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
Cc: julietk@linux.vnet.ibm.com, tlfalcon@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series aims to support both XICS and XIVE with avoiding
a regression in behavior when a system runs in XICS mode.

Patch 1 reverts commit 11d49ce9f7946dfed4dcf5dbde865c78058b50ab
(“net/ibmvnic: Fix EOI when running in XIVE mode.”)

Patch 2 Ignore H_FUNCTION return from H_EOI to tolerate XIVE mode

Juliet Kim (2):
  Revert "net/ibmvnic: Fix EOI when running in XIVE mode"
  net/ibmvnic: Ignore H_FUNCTION return from H_EOI to tolerate XIVE mode

 drivers/net/ethernet/ibm/ibmvnic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
1.8.3.1

