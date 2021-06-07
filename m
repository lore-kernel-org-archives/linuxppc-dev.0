Return-Path: <SRS0=rLAe=LB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC8FC4743C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A679260FEF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A679260FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fz2Zy5SC2z3btg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 15:52:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ryzh7vcW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Ryzh7vcW; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fz2ZP27dCz2yWT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jun 2021 15:52:12 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1575Wlhl167514; Mon, 7 Jun 2021 01:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=NTRxnxOMV28QHwb1WjNDdwG5+Cg11PGZspxJGMmhJQk=;
 b=Ryzh7vcWPCLR9h8pLCmQKaz+PFxYYe/vvtz6/BjE9Ivglf1O7D9EreNk+BlnQUyX2XD7
 /n3gIdTIjUj3hC65IBRjIgO+0Bgmjz9MxoJrRC9ZfCL34LQkaghSK1ys6QBdfdlgAP9v
 miEU5qi8kaedRAls/T+4yjMTW1h2LkYT+bLiqdFL8hbFoCb5Z+Rt5TkZiBw7O56W1Rn9
 tjUE/gz5MhVJl7TCsakil+obVKK21cKA7a5MNOdKW7iPKdpwweehKg3lk+fRWmp71jMF
 bXtT/ahBGMCYdIxKOrlEoKO3e/Y8JTiARpLjVMbCoMHh1ZMFbGvMdUiuQ0qdKRAMsHFx fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 391d4tgqek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Jun 2021 01:51:56 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1575Zkcg177287;
 Mon, 7 Jun 2021 01:51:56 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 391d4tgqeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Jun 2021 01:51:56 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1575hTlf018292;
 Mon, 7 Jun 2021 05:51:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 3900wa7rx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Jun 2021 05:51:55 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1575psgs28246388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Jun 2021 05:51:54 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB30128059;
 Mon,  7 Jun 2021 05:51:54 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A9DC28058;
 Mon,  7 Jun 2021 05:51:51 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.32.129])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  7 Jun 2021 05:51:50 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Subject: [PATCH v7 00/11] Speedup mremap on ppc64
Date: Mon,  7 Jun 2021 11:21:20 +0530
Message-Id: <20210607055131.156184-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5rlwncQujx5OTIARyQ2PKVgI0DdwSU2S
X-Proofpoint-GUID: bWV4Mpv2iLyiCOi71MQ3FXRW8_-GmcEy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-07_03:2021-06-04,
 2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070042
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, npiggin@gmail.com,
 kaleshsingh@google.com, joel@joelfernandes.org,
 "Kirill A . Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This patchset enables MOVE_PMD/MOVE_PUD support on power. This requires
the platform to support updating higher-level page tables without
updating page table entries. This also needs to invalidate the Page Walk
Cache on architecture supporting the same.

Changes from v6:
* Update ppc64 flush_tlb_range to invalidate page walk cache.
* Add patches to fix race between mremap and page out
* Add patch to fix build error with page table levels 2

Changes from v5:
* Drop patch mm/mremap: Move TLB flush outside page table lock
* Add fixes for race between optimized mremap and page out

Changes from v4:
* Change function name and arguments based on review feedback.

Changes from v3:
* Fix build error reported by kernel test robot
* Address review feedback.

Changes from v2:
* switch from using mmu_gather to flush_pte_tlb_pwc_range() 

Changes from v1:
* Rebase to recent upstream
* Fix build issues with tlb_gather_mmu changes


Aneesh Kumar K.V (11):
  mm/mremap: Fix race between MOVE_PMD mremap and pageout
  mm/mremap: Fix race between MOVE_PUD mremap and pageout
  selftest/mremap_test: Update the test to handle pagesize other than 4K
  selftest/mremap_test: Avoid crash with static build
  mm/mremap: Convert huge PUD move to separate helper
  mm/mremap: Don't enable optimized PUD move if page table levels is 2
  mm/mremap: Use pmd/pud_poplulate to update page table entries
  powerpc/mm/book3s64: Fix possible build error
  mm/mremap: Allow arch runtime override
  powerpc/book3s64/mm: Update flush_tlb_range to flush page walk cache
  powerpc/mm: Enable HAVE_MOVE_PMD support

 .../include/asm/book3s/64/tlbflush-radix.h    |   2 +
 arch/powerpc/include/asm/tlb.h                |   6 +
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |   8 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  70 +++++++----
 arch/powerpc/platforms/Kconfig.cputype        |   2 +
 include/linux/rmap.h                          |  13 +-
 mm/mremap.c                                   | 104 +++++++++++++--
 mm/page_vma_mapped.c                          |  43 ++++---
 tools/testing/selftests/vm/mremap_test.c      | 118 ++++++++++--------
 9 files changed, 251 insertions(+), 115 deletions(-)

-- 
2.31.1

