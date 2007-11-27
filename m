Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D86FDDD0D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 22:34:42 +1100 (EST)
Date: Tue, 27 Nov 2007 14:39:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 2/3] [POWERPC] fsl_soc: add support for gianfar for
	fixed-link property
Message-ID: <20071127113935.GA26867@localhost.localdomain>
References: <20071126142906.19642.45540.stgit@localhost.localdomain>
	<20071126142915.19642.5842.stgit@localhost.localdomain>
	<1196089448.12625.62.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1196089448.12625.62.camel@gentoo-jocke.transmode.se>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 04:04:08PM +0100, Joakim Tjernlund wrote:
> On Mon, 2007-11-26 at 17:29 +0300, Vitaly Bordug wrote:
> > fixed-link says: register new "Fixed/emulated PHY", i.e. PHY that
> > not connected to the real MDIO bus.
> > 
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > 
> > ---
> > 
> >  Documentation/powerpc/booting-without-of.txt |    3 +
> >  arch/powerpc/sysdev/fsl_soc.c                |   56 ++++++++++++++++++--------
> >  2 files changed, 42 insertions(+), 17 deletions(-)
> > 
> > 
> > diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> > index e9a3cb1..cf25070 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1254,6 +1254,9 @@ platforms are moved over to use the flattened-device-tree model.
> >        services interrupts for this device.
> >      - phy-handle : The phandle for the PHY connected to this ethernet
> >        controller.
> > +    - fixed-link : <a b c> where a is emulated phy id - choose any,
> > +      but unique to the all specified fixed-links, b is duplex - 0 half,
> > +      1 full, c is link speed - d#10/d#100/d#1000.
> 
> Good work!
> May I suggest adding a "d" to <a b c> where d is flow control - 0 no, 1 yes

Well, I see no reference of the "flow" neither in the include/linux/mii.h
nor in the drivers/net/phy/*. :-/ Thus today there is no such register
bit we can emulate?..

> flow control or not just popped up here today so I got a use for it.

..and I looked into few drivers (gianfar, ucc), and they seem to use
hard-coded flow control values, thus they don't speak to the PHYs
about that.

Can you give any reference to the driver that needs that parameter?
Does it use PHY subsystem to obtain flow-control on/off information?

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
