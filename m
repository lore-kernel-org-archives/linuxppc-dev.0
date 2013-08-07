Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFE5F2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 07:27:11 +1000 (EST)
Message-ID: <1375910819.18333.58.camel@snotra.buserror.net>
Subject: Re: [PATCH] net/fsl_pq_mdio: fix handling of TBIPA register
From: Scott Wood <scottwood@freescale.com>
To: Lutz Jaenicke <ljaenicke@innominate.com>
Date: Wed, 7 Aug 2013 16:26:59 -0500
In-Reply-To: <20130807142247.GA9012@lutz.bln.innominate.local>
References: <1375379355-18594-1-git-send-email-ljaenicke@innominate.com>
 <1375830655.5600.24.camel@snotra.buserror.net>
 <1375833300.5600.51.camel@snotra.buserror.net>
 <20130807142247.GA9012@lutz.bln.innominate.local>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-07 at 16:22 +0200, Lutz Jaenicke wrote:
> On Tue, Aug 06, 2013 at 06:55:00PM -0500, Scott Wood wrote:
> > On Tue, 2013-08-06 at 18:10 -0500, Scott Wood wrote:
> > > On Thu, 2013-08-01 at 19:49 +0200, Lutz Jaenicke wrote:
> > > > The TBIPA register is part of gianfar's full register set. When starting
> > > > from the MII registers, the start address of struct gfar needs to
> > > > be determined via container_of().
> > > > Experienced with mpc8313 and "fsl,gianfar-mdio" device tree entries.
> > > > 
> > > > Signed-off-by: Lutz Jaenicke <ljaenicke@innominate.com>
> > > > ---
> > > >  drivers/net/ethernet/freescale/fsl_pq_mdio.c |    3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > > index c93a056..9485fdb 100644
> > > > --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > > +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > > @@ -193,7 +193,8 @@ static int fsl_pq_mdio_reset(struct mii_bus *bus)
> > > >   */
> > > >  static uint32_t __iomem *get_gfar_tbipa(void __iomem *p)
> > > >  {
> > > > -	struct gfar __iomem *enet_regs = p;
> > > > +	struct gfar __iomem *enet_regs = 
> > > > +		container_of(p, struct gfar, gfar_mii_regs);
> > > >  
> > > >  	return &enet_regs->tbipa;
> > > >  }
> > > 
> > > Please send this to the netdev list/maintainer.
> > 
> > Though, do we have any guarantee that p is contained by a "struct gfar"?
> > It looks like the code of_iomap()s the reg of the mdio node, which is
> > just the MDIO registers.  Don't access outside that area.
> 
> If I did not understand the setup totally wrong, The proposed patch just
> restores the behavior before application of
>   commit afae5ad78b342f401c28b0bb1adb3cd494cb125a
>   Author: Timur Tabi <timur@freescale.com>
>   Date:   Wed Aug 29 08:08:01 2012 +0000
> 
>     net/fsl_pq_mdio: streamline probing of MDIO nodes

It's not exactly new ugliness, but it's still ugly. :-)

Though I think you need to go back before commit
1d2397d742b7a2b39b2f09dd9da3b9d1463f55e9 ("fsl_pq_mdio: Add Suport for
etsec2.0 devices.") for the offset to be "properly" adjusted.

> > Of course, this register probably *should* be described in the MDIO node
> > (see http://patchwork.ozlabs.org/patch/250766/), but since it isn't,
> > we'll need to either find the associated full gianfar device and ask it
> > to set tbipa, or look up the physical address of tbipa and do a separate
> > ioremap.  I know that in practice we'll have at least 4K-granular
> > mappings and thus tbipa will be there, but it's best to avoid such
> > hacks.
> 
> This patch does make some sense, it however only covers the pure
> fsl,gianfar-tbi case (just a TBI PHY) but not the fsl,gianfar-mdio
> with a full MDIO (@24520). 

I'm not seeing any difference between the address for fsl,gianfar-tbi
and fsl,gianfar-mdio.

> On my MPC8313 based custom board I have
> a PHY at address 0 and I can only access this PHY if the TBI PHY's address
> is first rewritten to another id (from the "0" which is the reset
> default).

Yes, I understand the need to write TBIPA -- I was just hoping it could
be done in a less hacky way.

> As to ask the gianfar device: It is fine to setup the mdio_bus first and
> only load the gianfar module later, so at least the gianfar driver itself
> cannot do it.

You could look up the main gianfar node from the mdio driver.  Or at
least modify the ioremap so that it covers the whole struct gfar,
instead of using of_iomap().  It'd still be a little hacky but only in
that we're recognizing a bad device tree and interpreting it how it
should have been written, rather than accessing outside the bounds of an
ioremap request.

-Scott
