Return-Path: <SRS0=AZ+D=FL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7CC4361B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Dec 2020 22:07:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1264B2395A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Dec 2020 22:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1264B2395A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqcr70DKxzDqXZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 09:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=IsW8erTT; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqcV15X5HzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2020 08:52:09 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0B7LXKIX101261
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2020 16:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e3lOu4+YNdroElBDJTGBjTqwvBcyP86gHmB+P53cv4c=;
 b=IsW8erTTkx9+Wbr+ZrEsWMg0e6vKv4RdgoMyEd7HTIM3kNzY3bJv0cMWR+oXveRVwVBY
 OsO0u8mmV+30mi7pSfcdpMLez970pmjCzxaY/k8hjnzJTefiD4PhtRZYhdw/nqBxjl/T
 hoW7RoLf8J2LVkFD31Olt7gnuNq7Gm+i81i4bmf+uVFx6P+IkX2nV5sLHrUOwNzgSwLo
 1DMOizRtODHdNPRuPW6WqEat0rkfxhQrqVuR03SXHx6X+wdHVAoq0hulCMVs4L/cQE4g
 ZvcFgwQxRLxVIUTYCUaJKSgFpU3jGVSH3xijbmFi4umjz9WlA18Qnqf8tOXN5KfEEYEo 7w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 359s0me1n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2020 16:52:07 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7LliV4000950
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2020 21:52:06 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04wdc.us.ibm.com with ESMTP id 3581u92xyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2020 21:52:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0B7Lq6Vq63242504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Dec 2020 21:52:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 518C1AC059;
 Mon,  7 Dec 2020 21:52:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ECF7AC05B;
 Mon,  7 Dec 2020 21:52:06 +0000 (GMT)
Received: from localhost (unknown [9.160.57.67])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  7 Dec 2020 21:52:06 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/28] powerpc/pseries/mobility: don't error on absence of
 ibm, update-nodes
Date: Mon,  7 Dec 2020 15:51:39 -0600
Message-Id: <20201207215200.1785968-8-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201207215200.1785968-1-nathanl@linux.ibm.com>
References: <20201207215200.1785968-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-07_16:2020-12-04,
 2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070140
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
Cc: tyreld@linux.ibm.com, ajd@linux.ibm.com, mmc@linux.vnet.ibm.com,
 cforno12@linux.vnet.ibm.com, drt@linux.vnet.ibm.com, brking@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Treat the absence of the ibm,update-nodes function as benign instead
of reporting an error. If the platform does not provide that facility,
it's not a problem for Linux.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 6ff642e84c6a..e66359b00297 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -261,7 +261,7 @@ int pseries_devicetree_update(s32 scope)
 
 	update_nodes_token = rtas_token("ibm,update-nodes");
 	if (update_nodes_token == RTAS_UNKNOWN_SERVICE)
-		return -EINVAL;
+		return 0;
 
 	rtas_buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
 	if (!rtas_buf)
-- 
2.28.0

