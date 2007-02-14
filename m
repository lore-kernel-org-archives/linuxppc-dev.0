Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5848DDF40
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:43:28 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1FBioAk2375764
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:44:50 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1ENkq7o165952
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:46:52 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1ENhMAV001016
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:43:23 +1100
Date: Thu, 15 Feb 2007 10:12:04 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
Message-ID: <20070214231204.GB16279@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<1171381565.4003.48.camel@zod.rchland.ibm.com>
	<1171469183.4003.96.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171469183.4003.96.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 10:06:23AM -0600, Josh Boyer wrote:
> On Tue, 2007-02-13 at 09:46 -0600, Josh Boyer wrote:
> > On Tue, 2007-02-13 at 17:09 +1100, David Gibson wrote:
> > > Here is a preliminary set of patches implementing support for the
> > > 440GP based Ebony evaluation board in arch/powerpc.  A number of the
> > > earlier patches are in Paul's queue already, so may appear in
> > > powerpc.git at any point.  Most of the later ones need at least some
> > > cleanup or reworking before they'll be ready for merging.
> > > 
> > > With these patches I can boot to a shell prompt on initrd on my Ebony
> > > board.  There are still a bunch of problems: clock timings are way out
> > > (runs about 4* fast), things freeze up when I attempt to use an
> > > nfsroot, many devices aren't supported.  A lot of things are hardcoded
> > > in the device tree, so you may well have to tweak it if your Ebony is
> > > different from mine.
> > 
> > I've noticed a couple issues so far on my board, which should just be a
> > stock Ebony.
> > 
> > 1) Things are off when just using the zImage.ebony image.  For reasons
> > I've yet to narrow down, the bootwrapper thinks something passed an
> > initrd to it via the a2 parameter in prep_kernel even though there is no
> > initrd.  I get output like:
> 
> I still have this issue, just haven't had a chance to figure out why
> yet.  Likely because the openbios code is leaving garbage somewhere.

More likely simply because openbios just puts different things in the
registers on entry, and we're assuming it uses the same method OF
does.  Need to fix the entry path, and get rid of the hardcoded a1 and
a2 junk.

> > 2) I get no boot output after the "Finalizing device tree..." step.  I
> > don't have a BDI or RW at the moment, but I'll try and figure out where
> > it's at and what it's doing.
> 
> After turning on the early debug stuff (once I got it to compile) I get
> output of the kernel boot.  Without that enabled however, I get no
> kernel boot messages.

Yeah, looks like my stuff for setting up the serial console properly
was bogus, but I didn't notice because I had the udbg console running.

I'm planning to get rid of my hacks to the legacy serial detection,
and instead use Arnd's general OF serial port detection stuff.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
