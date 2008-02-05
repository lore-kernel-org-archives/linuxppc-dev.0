Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58EFEDDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 02:39:35 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m15FdVZ6030339
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 10:39:31 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m15FdVvE311200
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 10:39:31 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m15FdVSR005121
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 10:39:31 -0500
Date: Tue, 5 Feb 2008 09:38:20 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080205093820.5918a216@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40802050724o692ef9e7yf51945225f56da5b@mail.gmail.com>
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
	<20080205070833.3a5b7c11@zod.rchland.ibm.com>
	<20080205143926.GA9709@powerlinux.fr>
	<20080205091548.724c4e20@zod.rchland.ibm.com>
	<fa686aa40802050724o692ef9e7yf51945225f56da5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Bernhard
	Reiter <bernhard@intevation.de>, debian-powerpc@lists.debian.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 5 Feb 2008 08:24:38 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 2/5/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > > I mean, if you have not included 4xx support in the kernel, as is the
> > > case here, it does not make sense to add the 4xx bootwrapper code, no ?
> >
> > It does, in a manner.  There are both generic and platform specific
> > pieces to the bootwrapper.  Having everything always built helps keep
> > the generic bits from breaking, which is important as they're often
> > tightly coupled.  That's at least the reason I can think of.
> >
> > The powerpc maintainers have been over this quite a bit and I don't see
> > it changing anytime soon.
> 
> That would mean we're dropping support for compilers which can't build
> 405/440 specific wrapper bits (or other core specific quirks that need
> to go in the wrapper)  That doesn't sound appropriate to me.

No it doesn't.  At least not yet.  I said I'd try to come up with a
patch soon-ish.  We haven't failed!(yet)  Also, this isn't a
core-specific quirk. It's an architected instruction of Book III-E in
the PowerPC ISA.  I can't help it if other chips don't implement this
wonderful control mechanism ;)

Taking a step back though, there will always be odd cases like this as
we move forward.  Toolchain XXX will eventually not support instruction
YYYY which will eventually be used, etc.  I'll try to make this
specific case work because it's scope is quite limited.  But this
problem as a whole will still remain.

josh
