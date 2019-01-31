Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C31C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 07:42:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F9F20870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 07:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F9F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qsdS3sp5zDqZW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 18:42:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qsbL50b9zDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 18:40:30 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V7dXjT028061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 02:40:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbtren844-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 02:40:27 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Thu, 31 Jan 2019 07:40:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 07:40:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V7eLhv7799146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 07:40:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56A1311C04A;
 Thu, 31 Jan 2019 07:40:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98BE011C05B;
 Thu, 31 Jan 2019 07:40:20 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 31 Jan 2019 07:40:20 +0000 (GMT)
Date: Thu, 31 Jan 2019 09:40:18 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the akpm
 tree
References: <20190131163854.307e17ab@canb.auug.org.au>
 <20190131170629.2cc20600@canb.auug.org.au>
 <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013107-0020-0000-0000-0000030F2DC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013107-0021-0000-0000-000021602F43
Message-Id: <20190131074018.GD28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310061
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrey Konovalov <andreyknvl@google.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(added Andrey Konovalov)

On Thu, Jan 31, 2019 at 07:15:26AM +0100, Christophe Leroy wrote:
> 
> Le 31/01/2019 à 07:06, Stephen Rothwell a écrit :
> >Hi all,
> >
> >On Thu, 31 Jan 2019 16:38:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >>[I am guessing that is is something in Andrew's tree that has caused
> >>this.]
> >>
> >>My qemu boot of the powerpc pseries_le_defconfig config failed like this:
> >>
> >>htab_hash_mask    = 0x1ffff
> >>-----------------------------------------------------
> >>numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
> >>Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 2147483648 bytes align=0x10000 nid=0 from=fffffffffffffff
> >>CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
> >>Call Trace:
> >>[c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliable)
> >>[c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
> >>[c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
> >>[c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
> >>[c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
> >>[c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
> >>[c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
> >>[c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c
> >
> >A quick bisect leads to this:
> >
> >1c3c9328cde027eb875ba4692f0a5d66b0afe862 is the first bad commit
> >commit 1c3c9328cde027eb875ba4692f0a5d66b0afe862
> >Author: Mike Rapoport <rppt@linux.ibm.com>
> >Date:   Thu Jan 31 10:51:32 2019 +1100
> >
> >     treewide: add checks for the return value of memblock_alloc*()
> >     Add check for the return value of memblock_alloc*() functions and call
> >     panic() in case of error.  The panic message repeats the one used by
> >     panicing memblock allocators with adjustment of parameters to include only
> >     relevant ones.
> >
> >Which is just adding the panic we hit.  So, presumably, the bug is in a
> >preceding patch :-(
> >
> >I have left the kernel not booting for today.
> >
> 
> No I think the error is really in that patch, see my other mail.
> 
> See https://elixir.bootlin.com/linux/v5.0-rc4/source/mm/memblock.c#L1455,
> memblock_alloc_try_nid_raw() is not supposed to panic, so the last hunk of
> this patch should be reverted.
> 
> Found in total three problematic hunks in that patch:
> 
> @@ -48,6 +53,11 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
>  	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
>  						__pa(MAX_DMA_ADDRESS),
>  						MEMBLOCK_ALLOC_KASAN, node);
> +	if (!p)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
> +		      __func__, PAGE_SIZE, PAGE_SIZE, node,
> +		      __pa(MAX_DMA_ADDRESS));
> +
>  	return __pa(p);
>  }
 
I've looked more closely to the code that uses this function and it does
not seem to handle allocation error.
I can replace the panic with WARN(), but I think that panic() here is
appropriate.

Andrey, can you comment?


> @@ -211,6 +211,9 @@ static int __init iob_init(struct device_node *dn)
>  	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
>  					MEMBLOCK_LOW_LIMIT, 0x80000000,
>  					NUMA_NO_NODE);
> +	if (!iob_l2_base)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx max_addr=%x\n",
> +		      __func__, 1UL << 21, 1UL << 21, 0x80000000);
> 
>  	pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
 
This one is actually fixes my own mistake from one of the previous patches
that converted memblock_alloc_base() to memblock_alloc_try_nid_raw() without
adding the panic() (commit 47e382eb08cfa0199c4ea9f9cc73f1b48a3a4b1d
"powerpc: prefer memblock APIs returning virtual address")
 
> @@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long
> size, int nid)
>  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>  						__pa(MAX_DMA_ADDRESS),
>  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	if (!sparsemap_buf)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
> +		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
> +
>  	sparsemap_buf_end = sparsemap_buf + size;
>  }
 
This hunk was not needed as sparse can deal with this allocation failure.

Andrew, can you please add the below patch to as a fixup to "treewide: add
checks for the return value of memblock_alloc*()"?
 
From 854f54b9d4fe52f477765b905a4b2c421d30f46e Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 31 Jan 2019 09:18:50 +0200
Subject: [PATCH] mm/sparse: don't panic if the allocation in
 sparse_buffer_init fails

Addition of panic if memblock_alloc_try_nid_raw() call in
sparse_buffer_init() fails was over enthusiastic as the system is perfectly
capable to deal with that allocation failure.
Remove the panic().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/sparse.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 1471f06..c11aba0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -434,10 +434,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
 						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-	if (!sparsemap_buf)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
-		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
-
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
-- 
2.7.4

