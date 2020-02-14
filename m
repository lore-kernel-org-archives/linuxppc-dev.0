Return-Path: <SRS0=3O72=4C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999B5C352A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 00:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3B720848
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 00:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3B720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48JYvm4pr7zDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 11:21:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=desnesn@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48JYsj0x5pzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2020 11:19:30 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01E0IuG7033764; Thu, 13 Feb 2020 19:19:22 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxgbe9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2020 19:19:22 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01E0J0gG024099;
 Fri, 14 Feb 2020 00:19:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 2y5bc025vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Feb 2020 00:19:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01E0JKEA57868798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 00:19:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 785CA7805C;
 Fri, 14 Feb 2020 00:19:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 128707805E;
 Fri, 14 Feb 2020 00:19:18 +0000 (GMT)
Received: from ibm.ibmuc.com (unknown [9.85.147.147])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 00:19:18 +0000 (GMT)
From: "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix hardware PMU exception bug on PowerVM
 compatibility mode systems
Date: Thu, 13 Feb 2020 21:19:05 -0300
Message-Id: <20200214001905.20065-1-desnesn@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_10:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=1 clxscore=1011 mlxscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140000
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
Cc: desnesn@linux.ibm.com, gromero@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerVM systems running compatibility mode on a few Power8 revisions are
still vulnerable to the hardware defect that loses PMU exceptions arriving
prior to a context switch.

The software fix for this issue is enabled through the CPU_FTR_PMAO_BUG
cpu_feature bit, nevertheless this bit also needs to be set for PowerVM
compatibility mode systems.

Fixes: 68f2f0d431d9ea4 ("powerpc: Add a cpu feature CPU_FTR_PMAO_BUG")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
---
 arch/powerpc/kernel/cputable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e745abc5457a..5bfef6263dfb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2198,6 +2198,8 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 		if (old.oprofile_cpu_type != NULL) {
 			t->oprofile_cpu_type = old.oprofile_cpu_type;
 			t->oprofile_type = old.oprofile_type;
+			if (old.cpu_features & CPU_FTR_PMAO_BUG)
+				t->cpu_features |= CPU_FTR_PMAO_BUG;
 		}
 	}
 
-- 
2.21.1

