Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70474C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 08:47:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B450C20820
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 08:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B450C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tLtZ2Zq0zDqHp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 19:47:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tLrH070FzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 19:45:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43tLrG3rCyz9s4Z;
 Mon,  4 Feb 2019 19:45:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 10/21] memblock: refactor internal allocation functions
In-Reply-To: <20190203113915.GC8620@rapoport-lnx>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-11-git-send-email-rppt@linux.ibm.com>
 <87ftt5nrcn.fsf@concordia.ellerman.id.au>
 <20190203113915.GC8620@rapoport-lnx>
Date: Mon, 04 Feb 2019 19:45:17 +1100
Message-ID: <878sywndr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mike Rapoport <rppt@linux.ibm.com> writes:
> On Sun, Feb 03, 2019 at 08:39:20PM +1100, Michael Ellerman wrote:
>> Mike Rapoport <rppt@linux.ibm.com> writes:
>> > Currently, memblock has several internal functions with overlapping
>> > functionality. They all call memblock_find_in_range_node() to find free
>> > memory and then reserve the allocated range and mark it with kmemleak.
>> > However, there is difference in the allocation constraints and in fallback
>> > strategies.
...
>> 
>> This is causing problems on some of my machines.
...
>> 
>> On some of my other systems it does that, and then panics because it
>> can't allocate anything at all:
>> 
>> [    0.000000] numa:   NODE_DATA [mem 0x7ffcaee80-0x7ffcb3fff]
>> [    0.000000] numa:   NODE_DATA [mem 0x7ffc99d00-0x7ffc9ee7f]
>> [    0.000000] numa:     NODE_DATA(1) on node 0
>> [    0.000000] Kernel panic - not syncing: Cannot allocate 20864 bytes for node 16 data
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4-gccN-next-20190201-gdc4c899 #1
>> [    0.000000] Call Trace:
>> [    0.000000] [c0000000011cfca0] [c000000000c11044] dump_stack+0xe8/0x164 (unreliable)
>> [    0.000000] [c0000000011cfcf0] [c0000000000fdd6c] panic+0x17c/0x3e0
>> [    0.000000] [c0000000011cfd90] [c000000000f61bc8] initmem_init+0x128/0x260
>> [    0.000000] [c0000000011cfe60] [c000000000f57940] setup_arch+0x398/0x418
>> [    0.000000] [c0000000011cfee0] [c000000000f50a94] start_kernel+0xa0/0x684
>> [    0.000000] [c0000000011cff90] [c00000000000af70] start_here_common+0x1c/0x52c
>> [    0.000000] Rebooting in 180 seconds..
>> 
>> 
>> So there's something going wrong there, I haven't had time to dig into
>> it though (Sunday night here).
>
> Yeah, I've misplaced 'nid' and 'MEMBLOCK_ALLOC_ACCESSIBLE' in
> memblock_phys_alloc_try_nid() :(
>
> Can you please check if the below patch fixes the issue on your systems?

Yes it does, thanks.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


> From 5875b7440e985ce551e6da3cb28aa8e9af697e10 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Sun, 3 Feb 2019 13:35:42 +0200
> Subject: [PATCH] memblock: fix parameter order in
>  memblock_phys_alloc_try_nid()
>
> The refactoring of internal memblock allocation functions used wrong order
> of parameters in memblock_alloc_range_nid() call from
> memblock_phys_alloc_try_nid().
> Fix it.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/memblock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e047933..0151a5b 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1402,8 +1402,8 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  
>  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
>  {
> -	return memblock_alloc_range_nid(size, align, 0, nid,
> -					MEMBLOCK_ALLOC_ACCESSIBLE);
> +	return memblock_alloc_range_nid(size, align, 0,
> +					MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  }
>  
>  /**
> -- 
> 2.7.4
>
>
> -- 
> Sincerely yours,
> Mike.
