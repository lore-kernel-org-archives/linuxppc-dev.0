Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4045C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:56:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA65120644
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA65120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vxw43QFKzF2Dx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vxrv3sf4zF1QG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 14:53:19 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9B3oLwV057899
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 23:53:16 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1u3qystu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 23:53:16 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 10 Oct 2018 21:53:16 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 21:53:12 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9B3rBwl23134458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 20:53:11 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6738978064;
 Wed, 10 Oct 2018 21:53:11 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09BCD78067;
 Wed, 10 Oct 2018 21:53:08 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.85.73.187])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 21:53:08 -0600 (MDT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 0/5] NestMMU pte upgrade workaround for mprotect and autonuma
Date: Thu, 11 Oct 2018 09:22:42 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18101103-0016-0000-0000-0000093F5F92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009857; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100919; UDB=6.00569641; IPR=6.00880964; 
 MB=3.00023702; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 03:53:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101103-0017-0000-0000-000040A9328D
Message-Id: <20181011035247.30687-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=427 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110036
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can upgrade pte access (R -> RW transition) via mprotect or autonuma. We need
to make sure we follow the recommended pte update sequence as outlined in
commit: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
for such updates. This patch series do that.

Aneesh Kumar K.V (5):
  mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
  mm: update ptep_modify_prot_commit to take old pte value as arg
  arch/powerpc/mm: Nest MMU workaround for mprotect/autonuma RW upgrade.
  mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
  arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
    upgrade

 arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 arch/powerpc/mm/hugetlbpage.c                | 35 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 34 +++++++++++++++++++
 arch/s390/include/asm/pgtable.h              |  5 +--
 arch/s390/mm/pgtable.c                       |  8 +++--
 arch/x86/include/asm/paravirt.h              |  9 +++--
 fs/proc/task_mmu.c                           |  8 +++--
 include/asm-generic/pgtable.h                | 10 +++---
 include/linux/hugetlb.h                      | 18 ++++++++++
 mm/hugetlb.c                                 |  8 +++--
 mm/memory.c                                  |  8 ++---
 mm/mprotect.c                                |  6 ++--
 14 files changed, 150 insertions(+), 27 deletions(-)

-- 
2.17.1

