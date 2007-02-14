Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D79EBDDECC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 03:06:10 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1EG66WP005272
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:06:06 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1EG66se451532
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 09:06:06 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1EG65fk022426
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 09:06:05 -0700
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <1171381565.4003.48.camel@zod.rchland.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<1171381565.4003.48.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 10:06:23 -0600
Message-Id: <1171469183.4003.96.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 09:46 -0600, Josh Boyer wrote:
> On Tue, 2007-02-13 at 17:09 +1100, David Gibson wrote:
> > Here is a preliminary set of patches implementing support for the
> > 440GP based Ebony evaluation board in arch/powerpc.  A number of the
> > earlier patches are in Paul's queue already, so may appear in
> > powerpc.git at any point.  Most of the later ones need at least some
> > cleanup or reworking before they'll be ready for merging.
> > 
> > With these patches I can boot to a shell prompt on initrd on my Ebony
> > board.  There are still a bunch of problems: clock timings are way out
> > (runs about 4* fast), things freeze up when I attempt to use an
> > nfsroot, many devices aren't supported.  A lot of things are hardcoded
> > in the device tree, so you may well have to tweak it if your Ebony is
> > different from mine.
> 
> I've noticed a couple issues so far on my board, which should just be a
> stock Ebony.
> 
> 1) Things are off when just using the zImage.ebony image.  For reasons
> I've yet to narrow down, the bootwrapper thinks something passed an
> initrd to it via the a2 parameter in prep_kernel even though there is no
> initrd.  I get output like:

I still have this issue, just haven't had a chance to figure out why
yet.  Likely because the openbios code is leaving garbage somewhere.

> 2) I get no boot output after the "Finalizing device tree..." step.  I
> don't have a BDI or RW at the moment, but I'll try and figure out where
> it's at and what it's doing.

After turning on the early debug stuff (once I got it to compile) I get
output of the kernel boot.  Without that enabled however, I get no
kernel boot messages.

josh
