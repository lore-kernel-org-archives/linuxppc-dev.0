Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 607BDDDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:03:16 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1EE4ewR8368264
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:04:40 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1E26NfT133818
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:06:29 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1E22qxo016114
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:02:52 +1100
Date: Wed, 14 Feb 2007 13:02:51 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214020251.GI11491@localhost.localdomain>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
	<20070214010235.GB19430@crusty.rchland.ibm.com>
	<20070214010044.GG11491@localhost.localdomain>
	<20070214020012.GB8541@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070214020012.GB8541@bubble.grove.modra.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 12:30:12PM +1030, Alan Modra wrote:
> On Wed, Feb 14, 2007 at 12:00:44PM +1100, David Gibson wrote:
> > On Tue, Feb 13, 2007 at 07:02:36PM -0600, Josh Boyer wrote:
> > > On Wed, Feb 14, 2007 at 11:16:22AM +1100, David Gibson wrote:
> > > > I'm using a 64-bit constant there, but for me at least the assembler
> > > > is able to handle manipulating it in constant expressions.
> > > 
> > > [jwboyer@zod ~]$ powerpc-440-linux-gnu-as --version
> > > GNU assembler 2.15
> > > 
> > > This is a crosstool built toolchain with binutils 2.15 and gcc 3.4.1.
> > > Which versions are you using?
> > 
> > Hmm.. I appear to have binutils-2.17.  That could be it.
> > 
> > It would be nice to support the older binutils too, but I'm not sure
> > how to get around this without considerable inconvenience.
> 
> I would guess that this isn't a matter of how old the assembler is,
> but how the assembler was built.  If built on a 32-bit host with no
> 64-bit targets supported, then most internal assembler variables
> are 32-bit and 64-bit constants are not handled very well.
> 
> You probably should avoid 64-bit expressions on a 32-bit target.

Well, yes, but how.  This 32-bit target has 36-bit physical
addresses.  All those expressions do is pull the high and low 32-bit
words from literals.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
