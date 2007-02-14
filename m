Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11DE5DDF45
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:43:31 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1ENwwhL288688
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:59:00 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1ENkqnR138656
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:46:53 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1ENhMu1001013
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:43:23 +1100
Date: Thu, 15 Feb 2007 10:05:05 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214230505.GA16279@localhost.localdomain>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
	<20070214010235.GB19430@crusty.rchland.ibm.com>
	<20070214010044.GG11491@localhost.localdomain>
	<20070214020012.GB8541@bubble.grove.modra.org>
	<20070214020251.GI11491@localhost.localdomain>
	<20070214023846.GC8541@bubble.grove.modra.org>
	<1171467708.4003.92.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171467708.4003.92.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 09:41:48AM -0600, Josh Boyer wrote:
> On Wed, 2007-02-14 at 13:08 +1030, Alan Modra wrote:
> > > > 
> > > > I would guess that this isn't a matter of how old the assembler is,
> > > > but how the assembler was built.  If built on a 32-bit host with no
> > > > 64-bit targets supported, then most internal assembler variables
> > > > are 32-bit and 64-bit constants are not handled very well.
> > > > 
> > > > You probably should avoid 64-bit expressions on a 32-bit target.
> > > 
> > > Well, yes, but how.
> > 
> > No idea, but I haven't even looked at the code in question.  I'm just
> > pointing out the toolchain limitation.  It sounds like what you've
> > done requires that people build their binutils with
> > --enable-64-bit-bfd or choose support for an extra 64-bit target,
> > eg. --enable-targets=powerpc64-linux
> 
> Yes, that seems to be the case.  I built a powerpc64 cross toolchain
> this morning and recompiled the kernel.  It worked just fine.
> 
> But I also think we want to avoid requiring that in peoples toolchains.
> I'll see if we can't accomplish what we're trying to do some other way
> without being too ugly.

Ugh.  Yeah, we're going to have to do something.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
