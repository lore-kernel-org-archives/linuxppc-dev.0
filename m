Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F0EAB7170
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 12:51:11 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAH1kdkf023473
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2010 18:46:39 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oAH1p48L252812
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2010 18:51:04 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAH1p46I011606
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2010 18:51:04 -0700
Subject: Re: Can't boot benh/powerpc.git kernel
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <17075.1289877977@neuling.org>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>	<1289520464.4752.12.camel@localhost>
	<17075.1289877977@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Nov 2010 17:51:03 -0800
Message-ID: <1289958663.3028.175.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-16 at 14:26 +1100, Michael Neuling wrote:
> In message <1289520464.4752.12.camel@localhost> you wrote:
> > On Thu, 2010-11-11 at 09:06 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2010-11-10 at 11:54 -0800, Jim Keniston wrote:
> > > > I got Ben's linux/kernel/git/benh/powerpc.git source and built it
> > > > (.config file attached*).  It hangs on boot.  When I boot it with
> > > > loglevel=8, its last words are:
> > > 
> > > First, please try with Linus upstream. The "master" branch in my git
> > > tree is quite stale, and my next and merge branch are too at the moment
> > > as I'm still travelling. All our current stuff was merged during the
> > > last merge window so there's nothing "new" for you to pickup in my tree
> > > at the moment :-)
> > > 
> > > If the problem still occurs, I'll have a look next week.
> > > 
> > > Cheers,
> > > Ben.
> > 
> > I built from Linus's git tree, and that kernel doesn't boot, either.
> > (It doesn't hang, but rather panics during boot.  I can provide a
> > console log if you like.)
> 
> Yes please.  
> 
> Linus' tree with pseries_defconfig boots fine for me on my POWER5 box.
> 
> > v2.6.36 and v2.6.37-rc1 boot fine for me.  I'll post my nvram-related
> > patches against v2.6.37-rc1.
> 
> So it's broken between 37-rc1 and whereever you grabbed Linus tree.
> That's a fairly small window.  Can you bisect it?

I was apparently comparing apples to oranges.  Given the fatal
configuration options (DEBUG_SLAB and/or DEBUG_PAGEALLOC) 2.6.37-rc1
fails the same as a more recent snapshot of Linus's tree.  I updated my
view today, and it still fails to boot with DEBUG_SLAB and/or
DEBUG_PAGEALLOC, and boots OK without them.

It also fails to boot with SLUB and SLUB_DEBUG enabled, even with
SLUB_DEBUG_ON disabled.

Ben has access to my system, and will look at it in a few days.

Jim

> 
> Mikey
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
