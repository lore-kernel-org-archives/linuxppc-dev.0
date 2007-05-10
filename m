Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D34E0DDECC
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:57:09 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4ANwcDm1278068
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:58:38 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4B00aND129608
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 10:00:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ANv4eb006018
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:57:05 +1000
Date: Fri, 11 May 2007 09:54:53 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Message-ID: <20070510235453.GD27188@localhost.localdomain>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
	<0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
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

On Wed, May 09, 2007 at 05:28:18PM +0200, Segher Boessenkool wrote:
> >>>>> Other dts'es are similar. Could be nice
> >>>>> to have a comment next to it if that's the case.
> >>>>
> >>>> Yeah.  There's also this ?? syntax now I believe.
> >>>
> >>> Not quite yet.
> >>
> >> Yes, the idea was raised, but discussion kind of petered out and
> >> nobody (read: me) got around to implementing it.
> >
> > What exactly did this ?? syntax imply?  I must have missed that thread.
> 
> A property in a DTS file can use that to say
> the property should have a value, but it will
> be filled in by the bootwrapper instead (memory
> address/size, or network MAC address, for
> instance).  Presumably the kernel parser would
> complain when it sees the this-is-still-undefined
> marker.
> 
> The original proposal specified the length of
> the property value IIRC, but that isn't necessary
> anymore.

Well.. sort of.  The first cut at the idea is that ? would be
equivalent to zeroes in terms of dtc output, but would act as internal
documentation that that property is supposed to be filled in by the
bootloader.

Refinements to try to enforce that would be nice: easiest is to
replace it with a configurable poison value.  When using asm output,
or with a map file, it might be possible to generate out-of-band
information which we can use to check that the right things are filled
in.

It's not a simply a matter of making the kernel parser recognize the
uninitialized info, because there's no way to encode that in the dtb
itself.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
