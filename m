Return-Path: <amodra@bigpond.net.au>
Received: from omta01sl.mx.bigpond.com (omta01sl.mx.bigpond.com
	[144.140.92.153]) by ozlabs.org (Postfix) with ESMTP id F2608DDE31
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:38:47 +1100 (EST)
Date: Wed, 14 Feb 2007 13:08:46 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214023846.GC8541@bubble.grove.modra.org>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
	<20070214010235.GB19430@crusty.rchland.ibm.com>
	<20070214010044.GG11491@localhost.localdomain>
	<20070214020012.GB8541@bubble.grove.modra.org>
	<20070214020251.GI11491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070214020251.GI11491@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 01:02:51PM +1100, David Gibson wrote:
> On Wed, Feb 14, 2007 at 12:30:12PM +1030, Alan Modra wrote:
> > On Wed, Feb 14, 2007 at 12:00:44PM +1100, David Gibson wrote:
> > > On Tue, Feb 13, 2007 at 07:02:36PM -0600, Josh Boyer wrote:
> > > > On Wed, Feb 14, 2007 at 11:16:22AM +1100, David Gibson wrote:
> > > > > I'm using a 64-bit constant there, but for me at least the assembler
> > > > > is able to handle manipulating it in constant expressions.
> > > > 
> > > > [jwboyer@zod ~]$ powerpc-440-linux-gnu-as --version
> > > > GNU assembler 2.15
> > > > 
> > > > This is a crosstool built toolchain with binutils 2.15 and gcc 3.4.1.
> > > > Which versions are you using?
> > > 
> > > Hmm.. I appear to have binutils-2.17.  That could be it.
> > > 
> > > It would be nice to support the older binutils too, but I'm not sure
> > > how to get around this without considerable inconvenience.
> > 
> > I would guess that this isn't a matter of how old the assembler is,
> > but how the assembler was built.  If built on a 32-bit host with no
> > 64-bit targets supported, then most internal assembler variables
> > are 32-bit and 64-bit constants are not handled very well.
> > 
> > You probably should avoid 64-bit expressions on a 32-bit target.
> 
> Well, yes, but how.

No idea, but I haven't even looked at the code in question.  I'm just
pointing out the toolchain limitation.  It sounds like what you've
done requires that people build their binutils with
--enable-64-bit-bfd or choose support for an extra 64-bit target,
eg. --enable-targets=powerpc64-linux

>  This 32-bit target has 36-bit physical
> addresses.  All those expressions do is pull the high and low 32-bit
> words from literals.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
