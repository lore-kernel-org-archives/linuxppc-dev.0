Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76660DDD07
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:25:01 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4E0itQM202008
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:44:55 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4E0SVCL172724
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:28:31 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4E0Ox9u005158
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:24:59 +1000
Date: Mon, 14 May 2007 10:24:57 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Message-ID: <20070514002457.GD6517@localhost.localdomain>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
	<0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
	<20070510235453.GD27188@localhost.localdomain>
	<b5cd56b7081eaba062cf056545777989@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b5cd56b7081eaba062cf056545777989@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Loeliger Jon-LOELIGER <jdl@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 12, 2007 at 02:02:42PM +0200, Segher Boessenkool wrote:
> >>> What exactly did this ?? syntax imply?  I must have missed that 
> >>> thread.
> >>
> >> A property in a DTS file can use that to say
> >> the property should have a value, but it will
> >> be filled in by the bootwrapper instead (memory
> >> address/size, or network MAC address, for
> >> instance).  Presumably the kernel parser would
> >> complain when it sees the this-is-still-undefined
> >> marker.
> >>
> >> The original proposal specified the length of
> >> the property value IIRC, but that isn't necessary
> >> anymore.
> >
> > Well.. sort of.  The first cut at the idea is that ? would be
> > equivalent to zeroes in terms of dtc output, but would act as internal
> > documentation that that property is supposed to be filled in by the
> > bootloader.
> 
> Yes.
> 
> > Refinements to try to enforce that would be nice:
> 
> Exactly my point.
> 
> > easiest is to
> > replace it with a configurable poison value.  When using asm output,
> > or with a map file, it might be possible to generate out-of-band
> > information which we can use to check that the right things are filled
> > in.
> >
> > It's not a simply a matter of making the kernel parser recognize the
> > uninitialized info, because there's no way to encode that in the dtb
> > itself.
> 
> There can be, with a new DTB version -- perhaps simply
> define proplen == -1 to mean "undefined" or similar.

That doesn't quite do it, because I'd prefer ? to cover cases where
the property's length is known, just not its value.  In particular
that could be useful for device trees where *only* non-moving edits
are required by the bootloader, letting us use the asm output mode as
intended.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
