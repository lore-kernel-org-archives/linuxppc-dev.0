Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
Subject: Re: Can't boot benh/powerpc.git kernel
In-reply-to: <1289958663.3028.175.camel@localhost>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost> <17075.1289877977@neuling.org>
	<1289958663.3028.175.camel@localhost>
Date: Wed, 17 Nov 2010 13:03:55 +1100
Message-ID: <27638.1289959435@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <1289958663.3028.175.camel@localhost> you wrote:
> On Tue, 2010-11-16 at 14:26 +1100, Michael Neuling wrote:
> > In message <1289520464.4752.12.camel@localhost> you wrote:
> > > On Thu, 2010-11-11 at 09:06 +1100, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2010-11-10 at 11:54 -0800, Jim Keniston wrote:
> > > > > I got Ben's linux/kernel/git/benh/powerpc.git source and built it
> > > > > (.config file attached*).  It hangs on boot.  When I boot it with
> > > > > loglevel=8, its last words are:
> > > > 
> > > > First, please try with Linus upstream. The "master" branch in my git
> > > > tree is quite stale, and my next and merge branch are too at the moment
> > > > as I'm still travelling. All our current stuff was merged during the
> > > > last merge window so there's nothing "new" for you to pickup in my tree
> > > > at the moment :-)
> > > > 
> > > > If the problem still occurs, I'll have a look next week.
> > > > 
> > > > Cheers,
> > > > Ben.
> > > 
> > > I built from Linus's git tree, and that kernel doesn't boot, either.
> > > (It doesn't hang, but rather panics during boot.  I can provide a
> > > console log if you like.)
> > 
> > Yes please.  
> > 
> > Linus' tree with pseries_defconfig boots fine for me on my POWER5 box.
> > 
> > > v2.6.36 and v2.6.37-rc1 boot fine for me.  I'll post my nvram-related
> > > patches against v2.6.37-rc1.
> > 
> > So it's broken between 37-rc1 and whereever you grabbed Linus tree.
> > That's a fairly small window.  Can you bisect it?
> 
> I was apparently comparing apples to oranges.  Given the fatal
> configuration options (DEBUG_SLAB and/or DEBUG_PAGEALLOC) 2.6.37-rc1
> fails the same as a more recent snapshot of Linus's tree.  I updated my
> view today, and it still fails to boot with DEBUG_SLAB and/or
> DEBUG_PAGEALLOC, and boots OK without them.

I can't reproduce any of these.

I modified pseries_defconfig to enable DEBUG_SLAB and it still works for
me on my POWER5 here

% grep SLAB .config
CONFIG_SLAB=y
CONFIG_SLABINFO=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_SLAB_LEAK is not set

I also can't reproduce with DEBUG_PAGEALLOC enabeled either.

> It also fails to boot with SLUB and SLUB_DEBUG enabled, even with
> SLUB_DEBUG_ON disabled.

pseries_defconfig uses this configuration and boots for me.

% grep SLUB .config
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set

> Ben has access to my system, and will look at it in a few days.

Can you please try pseries_defconfig?

Mikey
