Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 12:59:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C205206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 12:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C205206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YTml3y5kzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:59:03 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YTkj4Z6kzDqM5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 23:57:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x32Cs6ge135941
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Apr 2019 08:57:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rm835rc52-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 08:57:13 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 2 Apr 2019 13:57:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Apr 2019 13:57:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x32Cv8MR61931594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2019 12:57:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849F452050;
 Tue,  2 Apr 2019 12:57:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.72.143])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 416D452051;
 Tue,  2 Apr 2019 12:57:07 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ben Hutchings <ben@decadent.org.uk>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
In-Reply-To: <87a7hjp4oi.fsf@concordia.ellerman.id.au>
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
 <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
 <87ftrbq0qe.fsf@igel.home>
 <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
 <87a7hjp4oi.fsf@concordia.ellerman.id.au>
Date: Tue, 02 Apr 2019 18:27:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19040212-4275-0000-0000-000003236085
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040212-4276-0000-0000-000038326395
Message-Id: <87zhp8pntq.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-02_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020087
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Ben Hutchings <ben@decadent.org.uk> writes:
>> On Mon, 2019-03-25 at 01:03 +0100, Andreas Schwab wrote:
>>> On M=C3=A4r 24 2019, Ben Hutchings <ben@decadent.org.uk> wrote:
>>>=20
>>> > Presumably you have CONFIG_PPC_BOOK3S_64 enabled and
>>> > CONFIG_SPARSEMEM
>>> > disabled?  Was this configuration actually usable?
>>>=20
>>> Why not?
>>
>> I assume that CONFIG_SPARSEMEM is the default for a good reason.
>> What I don't know is how strong that reason is (I am not a Power expert
>> at all).  Looking a bit further, it seems to be related to CONFIG_NUMA
>> in that you can enable CONFIG_FLATMEM if and only if that's disabled.=20
>> So I suppose the configuration you used works for non-NUMA systems.
>
> Aneesh pointed out this fix would break FLATMEM after I'd merged it, but
> it didn't break any of our defconfigs so I wondered if anyone would
> notice.
>
> I checked today and a G5 will boot with FLATMEM, which I assume is what
> Andreas is using.
>
> I guess we should fix this build break for now.
>
> Even some G5's have discontiguous memory, so FLATMEM is not clearly a
> good choice even for all G5's, and actually a fresh g5_defconfig uses
> SPARSEMEM.
>
> So I'm inclined to just switch to always using SPARSEMEM on 64-bit
> Book3S, because that's what's well tested and we hardly need more code
> paths to test. Unless anyone has a strong objection, I haven't actually
> benchmarked FLATMEM vs SPARSEMEM on a G5.
>

How about

From 207fb0036065d8db44853e63bb858c4fd9952106 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 1 Apr 2019 17:51:17 +0530
Subject: [PATCH] powerpc/mm: Fix build error=20

The current value of MAX_PHYSMEM_BITS cannot work with 32 bit configs.
We used to have MAX_PHYSMEM_BITS not defined without SPARSEMEM and 32
bit configs never expected a value to be set for MAX_PHYSMEM_BITS.

Dependent code such as zsmalloc derived the right values based on other
fields. Instead of finding a value that works with different configs,
use new values only for book3s_64. For 64 bit booke, use the definition
of MAX_PHYSMEM_BITS as per commit a7df61a0e2b6 ("[PATCH] ppc64: Increase sp=
arsemem defaults")
That change was done in 2005 and hopefully will work with book3e 64.

Fixes: 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2P=
B")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 15 +++++++++++++++
 arch/powerpc/include/asm/mmu.h           | 15 ---------------
 arch/powerpc/include/asm/nohash/64/mmu.h |  2 ++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/includ=
e/asm/book3s/64/mmu.h
index 1ceee000c18d..a809bdd77322 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -35,6 +35,21 @@ typedef pte_t *pgtable_t;
=20
 #endif /* __ASSEMBLY__ */
=20
+/*
+ * If we store section details in page->flags we can't increase the MAX_PH=
YSMEM_BITS
+ * if we increase SECTIONS_WIDTH we will not store node details in page->f=
lags and
+ * page_to_nid does a page->section->node lookup
+ * Hence only increase for VMEMMAP. Further depending on SPARSEMEM_EXTREME=
 reduce
+ * memory requirements with large number of sections.
+ * 51 bits is the max physical real address on POWER9
+ */
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME)=
 &&  \
+	defined(CONFIG_PPC_64K_PAGES)
+#define MAX_PHYSMEM_BITS 51
+#else
+#define MAX_PHYSMEM_BITS 46
+#endif
+
 /* 64-bit classic hash table MMU */
 #include <asm/book3s/64/mmu-hash.h>
=20
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 598cdcdd1355..78d53c4396ac 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -341,21 +341,6 @@ static inline bool strict_kernel_rwx_enabled(void)
  */
 #define MMU_PAGE_COUNT	16
=20
-/*
- * If we store section details in page->flags we can't increase the MAX_PH=
YSMEM_BITS
- * if we increase SECTIONS_WIDTH we will not store node details in page->f=
lags and
- * page_to_nid does a page->section->node lookup
- * Hence only increase for VMEMMAP. Further depending on SPARSEMEM_EXTREME=
 reduce
- * memory requirements with large number of sections.
- * 51 bits is the max physical real address on POWER9
- */
-#if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME)=
 &&	\
-	defined (CONFIG_PPC_64K_PAGES)
-#define MAX_PHYSMEM_BITS        51
-#elif defined(CONFIG_SPARSEMEM)
-#define MAX_PHYSMEM_BITS        46
-#endif
-
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/includ=
e/asm/nohash/64/mmu.h
index e6585480dfc4..81cf30c370e5 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
 #define _ASM_POWERPC_NOHASH_64_MMU_H_
=20
+#define MAX_PHYSMEM_BITS        44
+
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
=20
--=20
2.20.1

