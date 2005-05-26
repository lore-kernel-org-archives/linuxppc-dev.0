Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id C0728679E8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2005 03:31:59 +1000 (EST)
Date: Thu, 26 May 2005 09:31:19 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050526093119.A3872@cox.net>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80f48eb53b0f876138cde07a997791b6@embeddededge.com>;
	from dan@embeddededge.com on Thu, May 26, 2005 at 02:00:11AM -0400
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 26, 2005 at 02:00:11AM -0400, Dan Malek wrote:
> 
> On May 25, 2005, at 5:44 PM, Benjamin Herrenschmidt wrote:
> 
> > This is a VERY BAD habit. Just set KERNELBASE to 0x80000000 if you do
> > that, an use io_block_mapping() dynamically the way I explained to 
> > alloc
> > from the top of the address space.
> 
> Well, back when kernelbase was assumed in too many places
> to be 0xc0000000, it was the only option.
> 
> > Well, The PCI IO space base just need to be in a global that is
> > referenced by _IO_BASE, it works fine, no need to hard code a mapping.
> 
> Sure you do.  No one ioremap()s PCI IO space.  It has to be hard wired
> somewhere.

As BenH and Eugene already pointed out, this is simply not true. Most
maintained ports have completely stomped out use of io_block_map()
where it's not necessary. Which is everywhere on 4xx and 8xx. The
only place it serves any purpose at all is on green book and motbooke
processors.
 
<big snip>

> You are missing the point.  The reason for io_block_mapping() isn't
> to allocate virtual space for someone, it's to _wire_ a space using an
> efficient mapping method so someone else can call ioremap() and
> get that wired access.  Based upon various configuration options,
> the board set up functions call io_block_mapping() to set up these
> spaces.  Then, ioremap() just finds them in the BAT or CAM array
> and says, "oh, it's a wired entry, I'll just compute the virtual address
> and return that."  Unless someone tells ioremap() there are BATs or
> CAMs, it won't use them.

Why don't we try a different approach to the problem? The problem is
that io_block_mapping() is causing a ton of problems with people
abusing it. Just check the archives for all the ways people break
their ports by passing it arbitrary values.  The other issue is
that although it's dangerous, the call still serves a purposes on
those processors with BATs and CAMs. So, let's kill io_block_mapping().
i.e. the version that allows virt->phys translations to be set up
without use of BATs and CAMs. Let's add a new mmu_block_mapping()
call that will ONLY map using a BAT or CAM and is only available
on platforms with those facilities. If a free BAT or CAM is not available
or alignment/size is invalid, the call fails. I would hope that would
make everybody happy.

We still end up with a call that will help people shoot themselves
in the foot, but at least we limit it to a specific task.

-Matt
