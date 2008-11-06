Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8DF51DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 12:55:23 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id mA61sZYZ018447
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 12:54:35 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA61n47a179128
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 12:49:04 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA61n4Fx015267
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 12:49:04 +1100
Date: Thu, 6 Nov 2008 12:48:56 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
Message-ID: <20081106014856.GI28465@yookeroo.seuss>
References: <fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
	<20081101113018.GA13646@zod.rchland.ibm.com>
	<1225576502.8004.222.camel@pasglop>
	<20081102134153.GA1029@zod.rchland.ibm.com>
	<1225661596.8004.226.camel@pasglop>
	<20081102193307.32d17e62@zod.rchland.ibm.com>
	<1225673034.8004.239.camel@pasglop>
	<1225742121.24019.9.camel@localhost.localdomain>
	<20081103150055.70bd7360@zod.rchland.ibm.com>
	<1225906408.26835.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1225906408.26835.77.camel@localhost.localdomain>
Cc: Wolfgang Denk <wd@denx.de>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	pvr@emcraft.com, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2008 at 11:33:28AM -0600, Hollis Blanchard wrote:
> On Mon, 2008-11-03 at 15:00 -0500, Josh Boyer wrote:
> > On Mon, 03 Nov 2008 13:55:21 -0600
> > Hollis Blanchard <hollisb@us.ibm.com> wrote:
> > 
> > > On Mon, 2008-11-03 at 11:43 +1100, Benjamin Herrenschmidt wrote:
> > > > > Cropping the size of the memory node.  That was simplest to do from the
> > > > > cuboot wrapper at the time.  If marking it reserved via a reserve map
> > > > > is more elegant and correct, we could do that.
> > > > > 
> > > > > But I will still like to know what about the other way is hairy please.
> > > > 
> > > > I don't like it :-) Bad feeling ... don't like having a memory
> > > > node entry that isn't aligned to some large power of two typically.
> > > 
> > > More specifically, mm/bootmem.c seems to be making the implicit
> > > assumption that memory size is an even multiple of PAGE_SIZE. With 4K
> > > pages, 0xffff000 bytes of RAM fits; with 64K pages it does not.
> > 
> > Hmm..  I dunno what to think about that.  Again, how does mem= play
> > into this?  (I will look myself in a bit, but if someone knows offhand
> > that would be nice..)
> > 
> > > Using the device tree reserve map stuff does indeed seem to solve the
> > > problem. However, I really don't understand the layering in
> > > arch/powerpc/boot at all, so I'll just put this patch out here and
> > > people can play with wrappers and prototypes all they want:
> > 
> > This actually looks pretty nice.  I'll wait for David to Ack the fdt
> > parts.
> 
> David?

Sorry, I've been on leave for a few days.

I assume you mean the new call through to fdt_add_mem_rsv().

Hrm.. currently all the things in fdt_wrapper are hooks called through
dt_ops.  Adding such a trivial wrapper seems a little silly.  There
have been other people wanting to use other libfdt features directly,
knowing that they have a flat tree on their system.  I think it would
be more sensible, I think, to just expose the global fdt pointer, so
that people can use the libfdt functions directly, without having to
go through the wrapper code.

Unless of course there is occasion to use this "add reserve" callback
on real OF systems, in which case it should be a new dt_ops hook.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
