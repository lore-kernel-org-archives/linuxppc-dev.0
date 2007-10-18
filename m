Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD144DDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 22:13:24 +1000 (EST)
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071018070139.339e2efb@weaponx.rchland.ibm.com>
References: <200710181108.19413.yur@emcraft.com>
	<1192704248.13993.36.camel@localhost.localdomain>
	<1192707914.12879.51.camel@pasglop>
	<20071018070139.339e2efb@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 22:12:12 +1000
Message-Id: <1192709532.12879.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-18 at 07:01 -0500, Josh Boyer wrote:
> On Thu, 18 Oct 2007 21:45:14 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > On Thu, 2007-10-18 at 05:44 -0500, Josh Boyer wrote:
> > > On Thu, 2007-10-18 at 11:08 +0400, Yuri Tikhonov wrote:
> > > >  Hello,
> > > > 
> > > >  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> > > > The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> > > > built using the modified version of binutils, where the MAXPAGESIZE 
> > > > definition is set to 0x40000 (as opposite to standard 0x10000).
> > > 
> > > Sorry, this is against arch/ppc which is bug fix only.  New features
> > > should be done against arch/powerpc.  Also, I'd rather see something
> > > along the lines of hugetlbfs support instead.
> > 
> > I slightly disagree on that one. It does make sense in embedded
> > applications to use larger page sizes like that to compensate for small
> > TLBs, and hugetlbfs has serious constraints that may well make it
> > impractical.
> 
> Out of curiosity, what constraints are those?

You have to open & map a specific file in specific areas, so you don't
just get existing code build & run with larger page size without change,
there are various sneaky limitations here or there too, such as
allocations more likely to fail etc... and in general, switching the
base page size provides overall more performance improvement than just
hacking an app to use hugetlbfs.

> > Based on that, I'd be tempted to let that in provided it doesn't
> > requires ugly hacks, which seems to be the case. It still needs to be
> > adapted to arch/powerpc however, and get closer scrutiny that I didn't
> > have time to do yet.
> > 
> > You are the maintainer, so you decide, but my opinion here is that
> > wanting that is fair enough.
> 
> I always reserve the right to change my mind.  If something makes sense
> and the code is decent enough then it might very well be acceptable.
> Requiring a modified binutils makes me a bit nervous though.

>From a kernel point of view, I totally don't care about the modified
binutils to build userspace as long as it's not required to build the
kernel and that option is not enabled by default (and explicitely
documented as having that requirement).

If it is necessary for building the kernel, then I'm a bit cooler about
the whole thing indeed, the max page size needs to be added at least as
a command line or linker script param so a different build of binutils
isn't needed.

My main base for judging is really how invasive/ugly the patch is. If
it's neat and fits in without much damage, and serves a purpose, then
there is no reason not to get it in.

Ben.
