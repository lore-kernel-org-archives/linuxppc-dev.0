Return-Path: <jim@jklewis.com>
Received: from que01.suddenlink.net (queue01-pub.suddenlink.net
	[208.180.40.86]) by ozlabs.org (Postfix) with ESMTP id 4D53967B9B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 18:18:55 +1100 (EST)
Subject: Re: [PATCH] drivers/net: spidernet driver on Celleb
From: Jim Lewis <jim@jklewis.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165982077.11914.123.camel@localhost.localdomain>
References: <200612120525.kBC5PpWC009418@toshiba.co.jp>
	<20061213011435.GN4329@austin.ibm.com>
	<1165982077.11914.123.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 00:30:35 -0600
Message-Id: <1165991435.21877.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 I got a note from Jens earlier today that mentioned some changes he has
made to the PHY code. He plans to get those in soon, so this might be
solved already.

Jim Lewis


On Wed, 2006-12-13 at 14:54 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-12 at 19:14 -0600, Linas Vepstas wrote:
> > On Tue, Dec 12, 2006 at 02:25:50PM +0900, Ishizaki Kou wrote:
> > > 
> > > Following are the changes.
> > > -This patch enables auto-negotiation.
> > > -Loading firmware is done when spidernet_open() is called.
> > > -And this patch adds other several small changes for Celleb. 
> > > -This patch is not tested on CellBlade.
> > 
> > I just tested this, and it does not work. Jim Lewis is gone
> > until the new year. However, as he was leaving, he grumbled something
> > about how autonegotiation simply won't work on the spider. 
> > (I didn't think to ask about the details). Perhaps he'll 
> > look at his email soon?
> 
> Duh ? Autoneg is completely local to the PHY. It will not work on the
> Cell blade because it's using a fiber link though, thus we probably need
> to disable this code when running on a fiber link.
>  
> > I've been trying to figure out how to modify the patch to make it 
> > work anyway, but so far, no success. 
> > 
> > Basically, in genmii_poll_link(), 
> >   status = phy_read(phy, MII_BMSR);
> >     status & BMSR_LSTATUS will always be zero.
> > 
> > So I tried ignoring this value, and calling setup_forced()
> > However, this still doesn't get the thing working.
> > I am somewhat at a loss to see why right now, since
> > I don't see what may be causing this.
> 
> I can have a look, most of the code was borrowed from sungem and I wrote
> the MII code for it :-)
> 
> Ben.
> 
