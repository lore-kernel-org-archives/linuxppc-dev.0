Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9823DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:21:40 +1000 (EST)
Date: Mon, 11 May 2009 06:21:35 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-ID: <20090511122135.GC8112@parisc-linux.org>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A081437.7000409@in.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 05:34:07PM +0530, Sachin Sant wrote:
> Matthew Wilcox wrote:
>> On Mon, May 11, 2009 at 05:16:10PM +0530, Sachin Sant wrote:
>>   
>>> Today's Next tree failed to boot on a Power6 box with following BUG :
>>
>> This doesn't actually appear to be a SCSI bug ... it looks like SCSI tried
>> to allocate memory and things went wrong in the memory allocator:
>>
>> [c0000000c7d038b0] [c0000000005d67d8] ._spin_lock+0x10/0x24
>> [c0000000c7d03920] [c00000000013fbdc] .__slab_alloc_page+0x344/0x3cc
>> [c0000000c7d039e0] [c000000000141168] .kmem_cache_alloc+0x13c/0x21c
>> [c0000000c7d03aa0] [c000000000141b04] .kmem_cache_create+0x294/0x2a8
>> [c0000000c7d03b90] [d000000000ea14cc] .scsi_init_queue+0x38/0x170 [scsi_mod]
>>
>> Which memory allocator did you have selected (SLAB, SLUB, SLOB, SLQB)?
>>   
> Default one. SLQB
>
> CONFIG_SLQB_ALLOCATOR=y
> CONFIG_SLQB=y
>
> Page size is 64K with Config DEBUG_PAGEALLOC set.
>
> CONFIG_PPC_HAS_HASH_64K=y
> CONFIG_PPC_64K_PAGES=y
> CONFIG_DEBUG_PAGEALLOC=y

Hm.  We've seen some similar problems at Intel while doing database
performance tests with SLQB.  Any ideas, Nick?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
