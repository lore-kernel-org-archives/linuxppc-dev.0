Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD24BC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 11:54:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BF32087A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 11:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BF32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42w2wn3bTwzF3cw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 22:54:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=gromero@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42w2tY5RnKzF3Nh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 22:52:53 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAEBhiLJ049420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 06:52:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nrhe6nbv0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 06:52:51 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Wed, 14 Nov 2018 11:52:49 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Nov 2018 11:52:48 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAEBqlcq35717246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Nov 2018 11:52:47 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4EA9AC059;
 Wed, 14 Nov 2018 11:52:47 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFE0AAC05B;
 Wed, 14 Nov 2018 11:52:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.225.70])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 14 Nov 2018 11:52:44 +0000 (GMT)
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: Adjust wild_bctr to build with old gcc
Date: Wed, 14 Nov 2018 06:50:51 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18111411-0060-0000-0000-000002D2B83F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010047; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117293; UDB=6.00579502; IPR=6.00897402; 
 MB=3.00024155; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-14 11:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111411-0061-0000-0000-0000473191F2
Message-Id: <1542196251-46904-1-git-send-email-gromero@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140108
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the selftest wild_bctr can fail to build when an old gcc is used,
notably on gcc using a binutils version <= 2.27, because the assembler does
not support the integer suffix UL.

That patch adjusts the wild_bctr test so the type promotion to UL for the
shifts on compilation still happens but the UL suffix is absent on the
stringification, so the inline asm code generated has no UL suffixes.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/mm/wild_bctr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
index 90469a9..7e56aa4 100644
--- a/tools/testing/selftests/powerpc/mm/wild_bctr.c
+++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
@@ -47,8 +47,8 @@ static int ok(void)
 	return 0;
 }
 
-#define REG_POISON	0x5a5aUL
-#define POISONED_REG(n)	((REG_POISON << 48) | ((n) << 32) | (REG_POISON << 16) | (n))
+#define REG_POISON	0x5a5a
+#define POISONED_REG(n)	(((REG_POISON+0UL) << 48) | ((n) << 32) | ((REG_POISON+0UL) << 16) | (n))
 
 static inline void poison_regs(void)
 {
-- 
2.7.4

