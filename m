Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:53:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB8A2183F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB8A2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448dwJ3qY2zDqPB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 01:53:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448dqd3mjNzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 01:49:17 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1REn0kg116227
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 09:49:15 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwtpx6ced-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 09:49:13 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 27 Feb 2019 14:47:58 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 14:47:55 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1RElsVb25428054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Feb 2019 14:47:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 104E2C6057;
 Wed, 27 Feb 2019 14:47:54 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6FC9C6055;
 Wed, 27 Feb 2019 14:47:50 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.49.135])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 14:47:50 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Subject: [PATCH v8 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of CMA
 region
Date: Wed, 27 Feb 2019 20:17:32 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022714-0016-0000-0000-00000989BC81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010674; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167143; UDB=6.00609716; IPR=6.00947752; 
 MB=3.00025765; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 14:47:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022714-0017-0000-0000-00004249F18A
Message-Id: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270100
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

ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
be able to start guest if we fail to allocate hash page table. We have observed
hash table allocation failure because we failed to migrate pages out of CMA region
because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
won't be able to migrate those pages. The pages are also pinned for the lifetime of the
guest.

Currently we support migration of non-compound pages. With THP and with the addition of
 hugetlb migration we can end up allocating compound pages from CMA region. This
patch series add support for migrating compound pages. 

Changes from V7:
* update commit descrption for patch 3
* Address review feedback.
* Move PF_MEMALLOC_NOCMA to a different value.

Changes from V6:
* use get_user_pages_longterm instead of get_user_pages_cma_migrate()

Changes from V5:
* Add PF_MEMALLOC_NOCMA
* remote __GFP_THISNODE when allocating target page for migration

Changes from V4:
* use __GFP_NOWARN when allocating pages to avoid page allocation failure warnings.

Changes from V3:
* Move the hugetlb check before transhuge check
* Use compound head page when isolating hugetlb page



*** BLURB HERE ***

Aneesh Kumar K.V (4):
  mm/cma: Add PF flag to force non cma alloc
  mm: Update get_user_pages_longterm to migrate pages allocated from CMA
    region
  powerpc/mm/iommu: Allow migration of cma allocated pages during
    mm_iommu_do_alloc
  powerpc/mm/iommu: Allow large IOMMU page size only for hugetlb backing

 arch/powerpc/mm/mmu_context_iommu.c | 145 ++++++--------------
 include/linux/hugetlb.h             |   2 +
 include/linux/mm.h                  |   3 +-
 include/linux/sched.h               |   1 +
 include/linux/sched/mm.h            |  48 +++++--
 mm/gup.c                            | 200 ++++++++++++++++++++++++----
 mm/hugetlb.c                        |   4 +-
 7 files changed, 266 insertions(+), 137 deletions(-)

-- 
2.20.1

