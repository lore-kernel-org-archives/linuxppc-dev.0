Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id ADA7BB6F44
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 01:45:43 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH 1/2] Remove REDWOOD_[456] config options and conditional
	code
Message-ID: <redwood56-reply-2-miltonm@bga.com>
In-Reply-To: <20100716142055.GA11736@zod.rchland.ibm.com>
References: <4f07b3092cafbbba37d61d367cc7484e24d18d2a.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<ae6929d3206f6a282f2b0bf2621a05af45d892ff.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<ca1bb25d203618c3548748f5efb6f125a96c89e0.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<redwood56-reply-1-miltonm@bga.com>
	<cover.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<20100716142055.GA11736@zod.rchland.ibm.com>
Date: Fri, 16 Jul 2010 10:45:27 -0500
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linuxppc-dev@ozlabs.org,
	Alexander Kurz <linux@kbdbabel.org>, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>, David Brown <davidb@quicinc.com>,
	Ladislav Michl <ladis@linux-mips.org>,
	Solomon Peachy <solomon@linux-wlan.com>,
	vamos-dev@i4.informatik.uni-erlangen.de,
	Mike Frysinger <vapier@gentoo.org>, Florian Fainelli <florian@openwrt.org>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jiri Kosina <jkosina@suse.cz>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
	linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 16 Jul 2010 at about 08:20:55 -0600 Josh Boyer wrote:
> On Fri, Jul 16, 2010 at 02:29:02PM +0200, Christian Dietrich wrote: 
> > The config options for REDWOOD_[456] were commented out in the powerpc
> > Kconfig. The ifdefs referencing this options therefore are dead and all
> > references to this can be removed (Also dependencies in other KConfig
> > files).

> This seems fine with me.
> 
> The only question is which tree it coms through. I'm happy to take it
> in via mine if the netdev and MTD people are fine with that. Otherwise,
> my ack is below.


> On Fri, 16 Jul 2010 around 14:29:08 +0200 Christian Dietrich wrote:
> > diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> > index f22bc9f..6629d09 100644
> > --- a/drivers/mtd/maps/Kconfig
> > +++ b/drivers/mtd/maps/Kconfig
> > @@ -321,7 +321,7 @@ config MTD_CFI_FLAGADM
> > 
> >  config MTD_REDWOOD
> >  	tristate "CFI Flash devices mapped on IBM Redwood"
> > -	depends on MTD_CFI && ( REDWOOD_4 || REDWOOD_5 || REDWOOD_6 )
> > +	depends on MTD_CFI
> >  	help
> >  	  This enables access routines for the flash chips on the IBM
> >  	  Redwood board. If you have one of these boards and would like to
> > diff --git a/drivers/mtd/maps/redwood.c b/drivers/mtd/maps/redwood.c
> > index 933c0b6..d2c9db0 100644
> > --- a/drivers/mtd/maps/redwood.c
> > +++ b/drivers/mtd/maps/redwood.c
> > @@ -22,8 +22,6 @@

The patches are unnecssarly coupled by removing the REDWOOD_* symbols
in the MTD area before removing the files and Kconfig completely in
the second patch.  This could easily be eliminated by pushing the
two fragments into the second patch.

milton
