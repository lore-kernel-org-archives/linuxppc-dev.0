Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA2C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:50:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E0A20896
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E0A20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MkLD2k0fzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 02:50:44 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MkJ50RgNzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 02:48:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2HFiVJO013220
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:48:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r9e87he87-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:48:48 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 17 Mar 2019 15:48:47 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Mar 2019 15:48:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2HFmh7W22675588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Mar 2019 15:48:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 629E5B205F;
 Sun, 17 Mar 2019 15:48:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC87FB2066;
 Sun, 17 Mar 2019 15:48:40 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.84.106])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 17 Mar 2019 15:48:40 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2 0/5] Update hash MMU kernel mapping to be in sync with
 radix.
Date: Sun, 17 Mar 2019 21:18:22 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031715-0040-0000-0000-000004D35957
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010774; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01175713; UDB=6.00606765; IPR=6.00956389; 
 MB=3.00026018; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-17 15:48:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031715-0041-0000-0000-000008DE7239
Message-Id: <20190317154827.9188-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-17_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=653 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903170123
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

Aneesh Kumar K.V (5):
  powerpc/mm/hash64: Add a variable to track the end of IO mapping
  powerpc/mm/hash64: Map all the kernel regions in the same 0xc range
  powerpc/mm: Validate address values against different region limits
  powerpc/mm: Drop the unnecessary region check
  powerpc/mm/hash: Simplify the region id calculation.

 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 15 +++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 12 +++
 arch/powerpc/include/asm/book3s/64/hash.h     | 97 ++++++++++++-------
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 31 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  9 +-
 arch/powerpc/include/asm/book3s/64/radix.h    | 40 ++++----
 arch/powerpc/include/asm/page.h               | 11 ---
 arch/powerpc/kvm/book3s_hv_rm_xics.c          |  2 +-
 arch/powerpc/mm/copro_fault.c                 | 14 ++-
 arch/powerpc/mm/hash_utils_64.c               | 45 ++++++---
 arch/powerpc/mm/pgtable-hash64.c              | 13 ++-
 arch/powerpc/mm/pgtable-radix.c               | 20 +++-
 arch/powerpc/mm/pgtable_64.c                  |  9 +-
 arch/powerpc/mm/ptdump/hashpagetable.c        |  2 +-
 arch/powerpc/mm/ptdump/ptdump.c               |  3 +-
 arch/powerpc/mm/slb.c                         | 22 +++--
 arch/powerpc/platforms/cell/spu_base.c        |  4 +-
 drivers/misc/cxl/fault.c                      |  2 +-
 drivers/misc/ocxl/link.c                      |  2 +-
 19 files changed, 227 insertions(+), 126 deletions(-)

-- 
2.20.1

