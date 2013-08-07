Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (home.innominate.com [77.245.32.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F05F2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 00:22:52 +1000 (EST)
Date: Wed, 7 Aug 2013 16:22:48 +0200
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] net/fsl_pq_mdio: fix handling of TBIPA register
Message-ID: <20130807142247.GA9012@lutz.bln.innominate.local>
References: <1375379355-18594-1-git-send-email-ljaenicke@innominate.com>
 <1375830655.5600.24.camel@snotra.buserror.net>
 <1375833300.5600.51.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1375833300.5600.51.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 06:55:00PM -0500, Scott Wood wrote:
> On Tue, 2013-08-06 at 18:10 -0500, Scott Wood wrote:
> > On Thu, 2013-08-01 at 19:49 +0200, Lutz Jaenicke wrote:
> > > The TBIPA register is part of gianfar's full register set. When starting
> > > from the MII registers, the start address of struct gfar needs to
> > > be determined via container_of().
> > > Experienced with mpc8313 and "fsl,gianfar-mdio" device tree entries.
> > > 
> > > Signed-off-by: Lutz Jaenicke <ljaenicke@innominate.com>
> > > ---
> > >  drivers/net/ethernet/freescale/fsl_pq_mdio.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > index c93a056..9485fdb 100644
> > > --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> > > @@ -193,7 +193,8 @@ static int fsl_pq_mdio_reset(struct mii_bus *bus)
> > >   */
> > >  static uint32_t __iomem *get_gfar_tbipa(void __iomem *p)
> > >  {
> > > -	struct gfar __iomem *enet_regs = p;
> > > +	struct gfar __iomem *enet_regs = 
> > > +		container_of(p, struct gfar, gfar_mii_regs);
> > >  
> > >  	return &enet_regs->tbipa;
> > >  }
> > 
> > Please send this to the netdev list/maintainer.
> 
> Though, do we have any guarantee that p is contained by a "struct gfar"?
> It looks like the code of_iomap()s the reg of the mdio node, which is
> just the MDIO registers.  Don't access outside that area.

If I did not understand the setup totally wrong, The proposed patch just
restores the behavior before application of
  commit afae5ad78b342f401c28b0bb1adb3cd494cb125a
  Author: Timur Tabi <timur@freescale.com>
  Date:   Wed Aug 29 08:08:01 2012 +0000

    net/fsl_pq_mdio: streamline probing of MDIO nodes

I guess that is meant with
  /*
   * This is mildly evil, but so is our hardware for doing this.
   * Also, we have to cast back to struct gfar because of
   * definition weirdness done in gianfar.h.
   */

> Of course, this register probably *should* be described in the MDIO node
> (see http://patchwork.ozlabs.org/patch/250766/), but since it isn't,
> we'll need to either find the associated full gianfar device and ask it
> to set tbipa, or look up the physical address of tbipa and do a separate
> ioremap.  I know that in practice we'll have at least 4K-granular
> mappings and thus tbipa will be there, but it's best to avoid such
> hacks.

This patch does make some sense, it however only covers the pure
fsl,gianfar-tbi case (just a TBI PHY) but not the fsl,gianfar-mdio
with a full MDIO (@24520). On my MPC8313 based custom board I have
a PHY at address 0 and I can only access this PHY if the TBI PHY's address
is first rewritten to another id (from the "0" which is the reset
default).
The device trees shipped with Linux indicate that the boards listed
typically do not have PHYs at address 0 so that the effect won't be
noted. (And: writing the TBI-PHY's mdio_bus-address into another
register (with offset 0x520!?) instead of the real TBIPA register
does not seem to create any ill effects.

As to ask the gianfar device: It is fine to setup the mdio_bus first and
only load the gianfar module later, so at least the gianfar driver itself
cannot do it.

Best regards,
	Lutz
-- 
Dr.-Ing. Lutz Jänicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.921028-200
fax: +49.30.921028-020
Rudower Chaussee 13
D-12489 Berlin, Germany
www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Dirk Seewald
Chairman of the Supervisory Board: Christoph Leifer
