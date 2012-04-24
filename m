Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
 by ozlabs.org (Postfix) with SMTP id B202BB6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 03:10:04 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 24 Apr 2012 19:10:00 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1335276900.3383.23.camel@thor.local>
Message-ID: <20120424171000.304180@gmx.net>
MIME-Version: 1.0
References: <20120420111527.190290@gmx.net>	
 <1334927896.5989.463.camel@thor.local> <20120420161407.190300@gmx.net>	
 <1335174966.5989.529.camel@thor.local> <20120423164504.235670@gmx.net>
 <1335276900.3383.23.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
To: =?iso-8859-1?Q?=22Michel_D=E4nzer=22?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 24 Apr 2012 16:15:00 +0200
> Von: "Michel Dänzer" <michel@daenzer.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@lists.ozlabs.org
> Betreff: Re: PowerPC radeon KMS - is it possible?

> On Mon, 2012-04-23 at 18:45 +0200, Gerhard Pircher wrote:
> > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > On Fre, 2012-04-20 at 18:14 +0200, Gerhard Pircher wrote: 
> > > > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > > > [...] 
> > > > > > Could it be that the memory is finally mapped uncacheable by
> > > > > > radeon_bo_kmap()/ttm_bo_kmap()/..some other TTM
> > > > > > functions../vmap()?
> > > > > 
> > > > > Yeah, AFAICT, basically ttm_io_prot() defines the mapping
> > > > > attributes, and vmap() is used to enforce them for kernel
> > > > > mappings.
> > > > Okay, that sounds like the approach used by arch/powerpc/mm/dma-
> > > > noncoherent.c in my ("green") ears. What about the PCIGART mode?
> > > > Is the driver free to use cached memory in this mode?
> > > 
> > > Yes, it assumes PCI(e) GART to be CPU cache coherent.
> > Okay. I guess it should be possible to modify it so that it makes use
> > of uncacheable memory - just for testing!?
> 
> Sure. Just set man->available_caching and man->default_caching as in the
> AGP case in radeon_init_mem_type(). 
Thanks for the info! I'll play around with it.

> > PCIGART was working "somehow" on my platform up to the ~2.6.39 kernel,
> > i.e. I could login to GNOME and open a program until the machine
> > locked-up. :-)
> 
> But it's worse with newer kernels?
Yes, it's worse. But that's surely the fault of the buggy northbridge.
I believe the bridge doesn't like some of the code that the driver uses
to avoid ordering issues. But I still have to find out where the lockups
exactly happen.

> > BTW: I see that the uninorth driver defines needs_scratch_page. What
> > is this actually good for?
> 
> It causes the code in drivers/char/agp/backend.c to allocate a scratch
> page (bridge->scratch_page) which the driver can use for unused GART
> entries.
Okay, so it would make sense to set this for my platform's AGP bridge,
which doesn't seem to support a "GATT entry valid" bit.

Gerhard
-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de
