Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712AC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:04:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9952173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9952173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjBR5qLMzDqMw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:04:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj4W5hZczDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:59:39 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCjGDE089603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:37 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx2rfn1f2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:36 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 13:59:29 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 13:59:28 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HCxRMa26280074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 12:59:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E81ABE058;
 Wed, 17 Apr 2019 12:59:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0B6CBE04F;
 Wed, 17 Apr 2019 12:59:24 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 12:59:24 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 0/8] Update hash MMU kernel mapping to be in sync with radix
Date: Wed, 17 Apr 2019 18:29:12 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041712-8235-0000-0000-00000E81584A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190369; UDB=6.00623770; IPR=6.00971167; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 12:59:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041712-8236-0000-0000-0000452E59B6
Message-Id: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170089
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
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series map all the kernel regions (vmalloc, IO and vmemmap) using
0xc top nibble address. This brings hash translation kernel mapping in sync with radix.
Each of these regions can now map 512TB. We use one context to map these
regions and hence the 512TB limit. We also update radix to use the same limit even though
we don't have context related restrictions there.

With this we have for 4K

 kernel vmalloc start   = 0xc008000000000000
 kernel IO start        = 0xc008100000000000
 kernel vmemmap start   = 0xc008200000000000

64K hash, 64K radix and 4k radix:

  kernel vmalloc start   = 0xc008000000000000
  kernel IO start        = 0xc00a000000000000
  kernel vmemmap start   = 0xc00c000000000000


Changes from v3:
* Make 4k page size hash translation vmalloc start address to be
  same as hash 64k and radix.

Aneesh Kumar K.V (8):
  powerpc/mm/hash64: Add a variable to track the end of IO mapping
  powerpc/mm/hash64: Map all the kernel regions in the same 0xc range
  powerpc/mm: Validate address values against different region limits
  powerpc/mm: Drop the unnecessary region check
  powerpc/mm/hash: Simplify the region id calculation.
  powerpc/mm: Print kernel map details to dmesg
  powerpc/mm/hash: Rename KERNEL_REGION_ID to LINEAR_MAP_REGION_ID
  powerpc/mm/hash/4K: Update the vmalloc start for hash 4K config

 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 21 ++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 12 +++
 arch/powerpc/include/asm/book3s/64/hash.h     | 95 ++++++++++++-------
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 42 ++++----
 arch/powerpc/include/asm/book3s/64/mmu.h      |  9 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  9 +-
 arch/powerpc/include/asm/book3s/64/radix.h    | 40 ++++----
 arch/powerpc/include/asm/page.h               | 11 ---
 arch/powerpc/kernel/setup-common.c            |  3 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c          |  2 +-
 arch/powerpc/mm/copro_fault.c                 | 18 ++--
 arch/powerpc/mm/hash_utils_64.c               | 45 ++++++---
 arch/powerpc/mm/pgtable-hash64.c              | 13 ++-
 arch/powerpc/mm/pgtable-radix.c               | 24 ++++-
 arch/powerpc/mm/pgtable_64.c                  |  9 +-
 arch/powerpc/mm/ptdump/hashpagetable.c        |  2 +-
 arch/powerpc/mm/ptdump/ptdump.c               |  3 +-
 arch/powerpc/mm/slb.c                         | 26 +++--
 arch/powerpc/platforms/cell/spu_base.c        |  4 +-
 drivers/misc/cxl/fault.c                      |  2 +-
 drivers/misc/ocxl/link.c                      |  2 +-
 21 files changed, 254 insertions(+), 138 deletions(-)

-- 
2.20.1

