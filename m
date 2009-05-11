Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEE14DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:04:16 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4BC4873026333
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 17:34:08 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4BC47Kq307410
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 17:34:07 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4BC4737023231
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:04:07 +1000
Message-ID: <4A081437.7000409@in.ibm.com>
Date: Mon, 11 May 2009 17:34:07 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Next May 11 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
In-Reply-To: <20090511115233.GB8112@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-next@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew Wilcox wrote:
> On Mon, May 11, 2009 at 05:16:10PM +0530, Sachin Sant wrote:
>   
>> Today's Next tree failed to boot on a Power6 box with following BUG :
>>     
>
> This doesn't actually appear to be a SCSI bug ... it looks like SCSI tried
> to allocate memory and things went wrong in the memory allocator:
>
> [c0000000c7d038b0] [c0000000005d67d8] ._spin_lock+0x10/0x24
> [c0000000c7d03920] [c00000000013fbdc] .__slab_alloc_page+0x344/0x3cc
> [c0000000c7d039e0] [c000000000141168] .kmem_cache_alloc+0x13c/0x21c
> [c0000000c7d03aa0] [c000000000141b04] .kmem_cache_create+0x294/0x2a8
> [c0000000c7d03b90] [d000000000ea14cc] .scsi_init_queue+0x38/0x170 [scsi_mod]
>
> Which memory allocator did you have selected (SLAB, SLUB, SLOB, SLQB)?
>   
Default one. SLQB

CONFIG_SLQB_ALLOCATOR=y
CONFIG_SLQB=y

Page size is 64K with Config DEBUG_PAGEALLOC set.

CONFIG_PPC_HAS_HASH_64K=y
CONFIG_PPC_64K_PAGES=y
CONFIG_DEBUG_PAGEALLOC=y

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
