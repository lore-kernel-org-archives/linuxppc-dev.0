Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1073AC2F3A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 12:40:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8E72085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 12:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8E72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jrjt2FBSzDqL8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 23:40:18 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jrcg1S7XzDqYq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 23:35:46 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0LCUDaq116359
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 07:35:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q5d902etu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 07:35:44 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 21 Jan 2019 12:35:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 12:35:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0LCZbfZ1966472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 12:35:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B560811C058;
 Mon, 21 Jan 2019 12:35:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62F7F11C050;
 Mon, 21 Jan 2019 12:35:36 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.74.157])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 21 Jan 2019 12:35:36 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Matt Corallo <kernel@bluematt.me>
Subject: Re: [Bug 202149] New: NULL Pointer Dereference in __split_huge_pmd on
 PPC64LE
In-Reply-To: <A61367CF-277E-4E74-8A9D-C94C5E53817B@bluematt.me>
References: <bug-202149-27@https.bugzilla.kernel.org/>
 <20190104170459.c8c7fa57ba9bc8a69dee5666@linux-foundation.org>
 <87ef9nk4cj.fsf@linux.ibm.com>
 <ed4bea40-cf9e-89a1-f99a-3dbd6249847f@bluematt.me>
 <8736q2jbhr.fsf@linux.ibm.com>
 <A61367CF-277E-4E74-8A9D-C94C5E53817B@bluematt.me>
Date: Mon, 21 Jan 2019 18:05:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012112-0012-0000-0000-000002EAD832
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012112-0013-0000-0000-00002121FEF7
Message-Id: <87bm4achnu.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210099
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Can you test this patch?

From e511e79af9a314854848ea8fda9dfa6d7e07c5e4 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 21 Jan 2019 16:43:17 +0530
Subject: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap

With support for split pmd lock, we use pmd page pmd_huge_pte pointer to store
the deposited page table. In those config when we move page tables we need to
make sure we move the depoisted page table to the right pmd page. Otherwise this
can result in crash when we withdraw of deposited page table because we can find
the pmd_huge_pte NULL.

c0000000004a1230 __split_huge_pmd+0x1070/0x1940
c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
c00000000042fe04 __vma_adjust+0x2b4/0x9b0
c0000000004316e8 __split_vma+0x1b8/0x280
c00000000043192c __do_munmap+0x13c/0x550
c000000000439390 sys_mremap+0x220/0x7e0
c00000000000b488 system_call+0x5c/0x70

Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 92eaea164700..86e62384256d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1262,8 +1262,6 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 					 struct spinlock *old_pmd_ptl,
 					 struct vm_area_struct *vma)
 {
-	if (radix_enabled())
-		return false;
 	/*
 	 * Archs like ppc64 use pgtable to store per pmd
 	 * specific information. So when we switch the pmd,
-- 
2.20.1

