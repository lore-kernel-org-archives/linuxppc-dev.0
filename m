Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456EC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:09:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBEC206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBEC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k1Lf3Xh0zDqFt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:09:30 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1JT5898zDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:07:36 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G9wtvb009114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwcb520kf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:34 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 16 Apr 2019 11:07:33 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:07:31 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GA7T3I23265280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:07:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58D4AC05B;
 Tue, 16 Apr 2019 10:07:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47FA9AC064;
 Tue, 16 Apr 2019 10:07:28 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.209])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:07:28 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v3 0/8] Update hash MMU kernel mapping to be in sync with radix
Date: Tue, 16 Apr 2019 15:37:14 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0060-0000-0000-0000032D9F49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010937; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189843; UDB=6.00623449; IPR=6.00970634; 
 MB=3.00026465; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 10:07:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0061-0000-0000-000048F89187
Message-Id: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=711 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160069
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

For 4K page size, Michael Ellerman requested to keep the VMALLOC_START the same as
what we have with hash 64K. I did try to implement that but found that code
gets complicated with no real benefit. To assist in debugging I am adding patch
"powerpc/mm: Print kernel map details to dmesg"  which should show different
mapping region for the booted kernel.

Also to note here is we now have the same map for both hash and radix on 4K page size.
This limits 4K radix to 16TB linear mapping range. This was done to make sure we
have a similar mapping between hash and radix. If we think this is unnecessarily limiting
radix translation mode, I can drop this. 

Aneesh Kumar K.V (8):
  powerpc/mm/hash64: Add a variable to track the end of IO mapping
  powerpc/mm/hash64: Map all the kernel regions in the same 0xc range
  powerpc/mm: Validate address values against different region limits
  powerpc/mm: Drop the unnecessary region check
  powerpc/mm/hash: Simplify the region id calculation.
  powerpc/mm: Print kernel map details to dmesg
  powerpc/mm: Consolidate radix and hash address map details
  powerpc/mm/hash: Rename KERNEL_REGION_ID to LINEAR_MAP_REGION_ID

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 --
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  6 --
 arch/powerpc/include/asm/book3s/64/hash.h     | 89 +++++++++++--------
 arch/powerpc/include/asm/book3s/64/map.h      | 80 +++++++++++++++++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 33 ++++---
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 34 +------
 arch/powerpc/include/asm/book3s/64/radix.h    | 33 ++-----
 arch/powerpc/include/asm/page.h               | 11 ---
 arch/powerpc/kernel/setup-common.c            |  3 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c          |  2 +-
 arch/powerpc/mm/copro_fault.c                 | 18 ++--
 arch/powerpc/mm/hash_utils_64.c               | 48 ++++++----
 arch/powerpc/mm/pgtable-hash64.c              | 13 ++-
 arch/powerpc/mm/pgtable-radix.c               | 23 +++--
 arch/powerpc/mm/pgtable_64.c                  | 15 ++--
 arch/powerpc/mm/ptdump/hashpagetable.c        |  4 -
 arch/powerpc/mm/ptdump/ptdump.c               |  4 -
 arch/powerpc/mm/slb.c                         | 26 +++---
 arch/powerpc/platforms/cell/spu_base.c        |  4 +-
 drivers/misc/cxl/fault.c                      |  2 +-
 drivers/misc/ocxl/link.c                      |  2 +-
 21 files changed, 255 insertions(+), 201 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/map.h

-- 
2.20.1

