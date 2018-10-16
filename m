Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9471C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:08:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6228720869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6228720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZRFq2fLBzF3JL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:08:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZGZK1lR8zF10b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:37:09 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9GDYlPA045867
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:37:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n5fjbmwdx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:37:07 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Tue, 16 Oct 2018 14:37:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 14:37:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9GDaxqa53870692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 13:36:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5E9E11C064;
 Tue, 16 Oct 2018 16:36:28 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E40511C058;
 Tue, 16 Oct 2018 16:36:28 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.72])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Oct 2018 16:36:28 +0100 (BST)
Date: Tue, 16 Oct 2018 16:36:56 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Oct 15
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <20181016072439.42613abd@canb.auug.org.au>
 <20181015151319.3a443f0421c20bd7ed055cb9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015151319.3a443f0421c20bd7ed055cb9@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18101613-4275-0000-0000-000002CCD285
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101613-4276-0000-0000-000037D7DB10
Message-Id: <20181016133656.GA10925@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160116
X-Mailman-Approved-At: Wed, 17 Oct 2018 07:06:33 +1100
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 03:13:19PM -0700, Andrew Morton wrote:
> On Tue, 16 Oct 2018 07:24:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > On Tue, 16 Oct 2018 07:12:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > > 
> > > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > 
> > That is:
> > 
> > static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >                                         phys_addr_t align, phys_addr_t start,
> >                                         phys_addr_t end, int nid,
> >                                         enum memblock_flags flags)
> > {
> >        if (WARN_ON_ONCE(!align))
> >                 align = SMP_CACHE_BYTES;
> > 
> > Looks like patch
> > 
> >   "memblock: stop using implicit alignment to SMP_CACHE_BYTES"
> > 
> > missed some places ...
> 
> To be expected, I guess.  I'm pretty relaxed about this ;) Let's do
> another sweep in a week or so, after which we'll have a couple of
> months to mop up any leftovers.

After some more grepping and spatching I've found these:

From 8b014bae53a78ab747dbb76b9aff7df4cefcb604 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 16 Oct 2018 16:03:00 +0300
Subject: [PATCH] memblock: fix missed uses of implicit aligment

A couple of memblock*alloc uses were missed during conversion from implicit
alignment setting with 'align = 0' to explictly using SMP_CACHE_BYTES.
Fix them now.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c    | 2 +-
 drivers/firmware/efi/memmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f331a00..913bfca 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -198,7 +198,7 @@ void __init allocate_paca_ptrs(void)
 	paca_nr_cpu_ids = nr_cpu_ids;
 
 	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
-	paca_ptrs = __va(memblock_phys_alloc(paca_ptrs_size, 0));
+	paca_ptrs = __va(memblock_phys_alloc(paca_ptrs_size, SMP_CACHE_BYTES));
 	memset(paca_ptrs, 0x88, paca_ptrs_size);
 }
 
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index ef618bc..fa2904f 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -15,7 +15,7 @@
 
 static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
 {
-	return memblock_phys_alloc(size, 0);
+	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
 }
 
 static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-- 
2.7.4

 

-- 
Sincerely yours,
Mike.

