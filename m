Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 08:52:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940CF20840
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 08:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940CF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fgvg10CGzDqVH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fgsk2Tl0zDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 19:51:05 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0G8mdDT106794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:51:03 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q20fytp09-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:51:03 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 16 Jan 2019 08:51:03 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 08:50:59 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0G8owTP19005586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jan 2019 08:50:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0322A12405E;
 Wed, 16 Jan 2019 08:50:58 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5EDB124054;
 Wed, 16 Jan 2019 08:50:55 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.92])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jan 2019 08:50:55 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org, x86@kernel.org
Subject: [PATCH V5 0/5] NestMMU pte upgrade workaround for mprotect
Date: Wed, 16 Jan 2019 14:20:30 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011608-0064-0000-0000-000003977B7F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010416; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147213; UDB=6.00597570; IPR=6.00927509; 
 MB=3.00025150; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 08:51:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011608-0065-0000-0000-00003C0E10E2
Message-Id: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=358 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160075
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can upgrade pte access (R -> RW transition) via mprotect. We need
to make sure we follow the recommended pte update sequence as outlined in
commit bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
for such updates. This patch series do that.

Changes from V4:
* Drop EXPORT_SYMBOL 

Changes from V3:
* Build fix for x86

Changes from V2:
* Update commit message for patch 4
* use radix tlb flush routines directly.

Changes from V1:
* Restrict ths only for R->RW upgrade. We don't need to do this for Autonuma
* Restrict this only for radix translation mode.


Aneesh Kumar K.V (5):
  mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
  mm: update ptep_modify_prot_commit to take old pte value as arg
  arch/powerpc/mm: Nest MMU workaround for mprotect RW upgrade.
  mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
  arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
    upgrade

 arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
 arch/powerpc/mm/hugetlbpage-hash64.c         | 25 ++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage-radix.c          | 17 +++++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 25 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c              | 18 ++++++++++++++
 arch/s390/include/asm/pgtable.h              |  5 ++--
 arch/s390/mm/pgtable.c                       |  8 ++++---
 arch/x86/include/asm/paravirt.h              | 13 +++++-----
 arch/x86/include/asm/paravirt_types.h        |  5 ++--
 arch/x86/xen/mmu.h                           |  4 ++--
 arch/x86/xen/mmu_pv.c                        |  8 +++----
 fs/proc/task_mmu.c                           |  8 ++++---
 include/asm-generic/pgtable.h                | 18 +++++++-------
 include/linux/hugetlb.h                      | 20 ++++++++++++++++
 mm/hugetlb.c                                 |  8 ++++---
 mm/memory.c                                  |  8 +++----
 mm/mprotect.c                                |  6 ++---
 19 files changed, 189 insertions(+), 41 deletions(-)

-- 
2.20.1

