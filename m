Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4B32DDDD8
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 23:48:20 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76DmFif027720
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 09:48:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76DmFcL252680
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 07:48:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76DmFEn032305
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 07:48:15 -0600
Date: Mon, 6 Aug 2007 08:48:13 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070806084813.5432ba91@weaponx.rchland.ibm.com>
In-Reply-To: <20070727013331.GB1561@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 27 Jul 2007 11:33:31 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jul 26, 2007 at 10:21:33AM -0500, Jon Loeliger wrote:
> > So, like, the other day David Gibson mumbled:
> > 
> > > > > Only thing I'm not really happy with in the current release is the
> > > > > versioning stuff.  For starters, it always reports my builds as
> > > > > -dirty, even when they're not.
> > > > 
> > > > I think it won't do that once there is a tag available.
> > > 
> > > Your 1.0.0-rc1 tag is there, still showing as dirty.

git vs quilt issue, as you have already discovered.  I've always seen
that with kernel builds.

> > > > I would like to keep the current version mechanism as it
> > > > is really quite similar to what is in the Kernel now.
> > > 
> > > First, I don't think it really is - except in superficial aspect of
> > > how the version number is partitioned
> > 
> > I lifted the code from the Kernel's Makefile directly, and tweaked
> > it slightly for lack of Kconfig aspects.
> 
> Ah, yes, ok, I see.  Frankly I really don't think a lot of that stuff
> makes much sense outside the context of Kbuild.  The whole complex
> filechk macro, for example - for which there's only one used parameter
> in dtc's case.

Except didn't you say you were going to work with Stephen to get DTC
into the kernel source itself?  Keeping things similar to Kbuild might
help in that effort.

> > I don't want to tie the code and build mechanism to git too much.
> > Specifically, we need to be able to support stand-alone tarball
> > based builds.  For example, I've spoken to the Debian package
> > maintainer on this issue, and he likes this approach as well as
> > he says it will make packaging it much easier.
> 
> Have a look at the patch I posted.  I haven't sufficiently tested it
> yet, but it should be able to generated version info for a tarball too
> (provided the .git-manifest file is included, and I'm intending that
> will be build by a make dist target).  It will give both the
> git-derived based version, and a file content derived hash so we can
> robustly tell different builds apart, all with less code than the
> current system.

That may be.  But I don't see the current approach being too much of a
problem either.  Especially given that it's already there and it
works.  Oh, and you sent out your patch saying it wasn't ready for
merge and with no sign off.  Small but important issues to fix I'd
think.

This seems to be the last issue holding up a dtc 1.0 release.  Perhaps
we could go with what exists and see if there really are problems.  It
can always be fixed later.

josh
