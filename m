Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67C0767A45
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:34:21 +1000 (EST)
Date: Mon, 27 Jun 2005 11:56:03 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050627145603.GB9810@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050627142803.GA9810@logos.cnet>
	<014331894c585b85c6bb419d72110125@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <014331894c585b85c6bb419d72110125@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: tlbie debugging aid (try #2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dan,

On Mon, Jun 27, 2005 at 04:18:14PM -0400, Dan Malek wrote:
> 
> On Jun 27, 2005, at 10:28 AM, Marcelo Tosatti wrote:
> 
> >it yields
> >
> >_tlbie on pinned range: c0000000-c1800000
> >Badness in _tlbie at arch/ppc/mm/pgtable.c:527
> >Call trace:
> > [c0005530] dump_stack+0x18/0x28
> > [c0003628] check_bug_trap+0x84/0xac
> > [c00037b0] ProgramCheckException+0x160/0x1a0
> > [c0002d50] ret_from_except_full+0x0/0x4c
> > [c000a91c] _tlbie+0x94/0xa0
> > [c902f018] alloc_init_module+0x18/0x40 [alloc]
> > [c002c4ac] sys_init_module+0x224/0x324
> > [c00026f0] ret_from_syscall+0x0/0x44

Note: this was just a test module doing tlbie(0xc0000100)... 
Hum, it should also print out the address in question...

> How much real memory on your board?

128M

> We need to ensure VMALLOC_START is beyond
> the pinned entries. 

Right now VMALLOC_START is before the IMMR pinned space.

> We should make all of the code
> much smarter to pin on the real space that is on
> the board.  

Oh! What are the side effects of such pinning as the 
code is today?

The only issue I see with pinning virtual address translations
farther the the physical addresses (real space) is that we lose
some virtual space, but nothing more than that.

Is it only that?

> For testing now, just make VMALLOC_OFFSET
> 32M, which will push the start to the 32M boundary
> after the kernel.

For what purpose? Sorry I don't get you, please be more
verbose.
