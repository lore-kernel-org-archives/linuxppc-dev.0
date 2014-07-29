Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C28931A01CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 05:58:28 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1234B140184
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2014 05:58:26 +1000 (EST)
Message-ID: <1406663895.29414.240.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 29 Jul 2014 14:58:15 -0500
In-Reply-To: <loom.20140728T081519-636@post.gmane.org>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
 <loom.20140728T081519-636@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-28 at 06:51 +0000, Emil Medve wrote:
> Hello Scott,
> 
> 
> Scott Wood <scottwood <at> freescale.com> writes:
> > On Wed, 2014-07-16 at 15:17 -0500, Shruti Kanetkar wrote:
> > > +			mdio <at> fd000 {
> > > +				/* For 10g interfaces */
> > > +				phy_xaui_slot1: xaui-phy <at> slot1 {
> > > +					status = "disabled";
> > > +					compatible = "ethernet-phy-ieee802.3-c45";
> > > +					reg = <0x7>; /* default switch setting on slot1 of AMC2PEX */
> > > +				};
> > 
> > Why xaui-phy and not ethernet-phy?
> > 
> > As for the device_type discussion from v1, there is a generic binding
> > that says device_type "should" be ethernet-phy.
> 
> I have no strong feelings about this and we can use ethernet-phy, but:
> 
> 1. The binding is old/stale (?) as it still uses device_type and the kernel
> doesn't seem to use anymore the device_type for PHY(s)

Yes.

> 2. The binding asks "ethernet-phy" for the device_type property, not for the
> name. As such TBI PHY(s) use (upstream) the tbi-phy@ node name

It shows ethernet-phy as the name in the example.  ePAPR urges generic
node names (this was also a recommendation for IEEE1275), and has
ethernet-phy on the preferred list.  Is a xaui-phy not an ethernet phy?

> > > +			mdio0: mdio <at> fc000 {
> > > +			};
> > 
> > Why is the empty node needed?
> 
> For the label

For mdio-parent-bus, or is there some other dts layer that makes this
node non-empty?

-Scott
