Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 226751A01AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 17:15:13 +1000 (EST)
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A5B7140120
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2014 17:15:11 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1XBeui-0001YT-4Y
 for linuxppc-dev@ozlabs.org; Mon, 28 Jul 2014 09:00:04 +0200
Received: from gate-tx3.freescale.com ([192.88.168.1])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2014 09:00:04 +0200
Received: from Emilian.Medve by gate-tx3.freescale.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2014 09:00:04 +0200
To: linuxppc-dev@ozlabs.org
From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
Date: Mon, 28 Jul 2014 06:51:11 +0000 (UTC)
Message-ID: <loom.20140728T081519-636@post.gmane.org>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


Scott Wood <scottwood <at> freescale.com> writes:
> On Wed, 2014-07-16 at 15:17 -0500, Shruti Kanetkar wrote:
> > +			mdio <at> fd000 {
> > +				/* For 10g interfaces */
> > +				phy_xaui_slot1: xaui-phy <at> slot1 {
> > +					status = "disabled";
> > +					compatible = "ethernet-phy-ieee802.3-c45";
> > +					reg = <0x7>; /* default switch setting on slot1 of AMC2PEX */
> > +				};
> 
> Why xaui-phy and not ethernet-phy?
> 
> As for the device_type discussion from v1, there is a generic binding
> that says device_type "should" be ethernet-phy.

I have no strong feelings about this and we can use ethernet-phy, but:

1. The binding is old/stale (?) as it still uses device_type and the kernel
doesn't seem to use anymore the device_type for PHY(s)

2. The binding asks "ethernet-phy" for the device_type property, not for the
name. As such TBI PHY(s) use (upstream) the tbi-phy@ node name

> BTW, that binding
> (net/phy.txt) could use some cleaning up -- it still has references to
> things like linux,phandle.
> 
> > diff --git a/arch/powerpc/boot/dts/b4qds.dtsi
b/arch/powerpc/boot/dts/b4qds.dtsi
> > index 8b47edc..6188583 100644
> > --- a/arch/powerpc/boot/dts/b4qds.dtsi
> > +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> >  <at>  <at>  -39,6 +39,13  <at>  <at> 
> >  	#size-cells = <2>;
> >  	interrupt-parent = <&mpic>;
> >  
> > +	aliases {
> > +		phy_sgmii_10 = &phy_sgmii_10;
> > +		phy_sgmii_11 = &phy_sgmii_11;
> > +		phy_sgmii_1c = &phy_sgmii_1c;
> > +		phy_sgmii_1d = &phy_sgmii_1d;
> > +	};
> 
> Is the encoding of these alias strings considered ABI (for either the
> OS's use or U-Boot's)?

U-Boot uses these aliases

> If so, please document it.

Will do

> If not, how do you
> see this being used?  What does the hex number mean from the user's
> perspective?
> 
> > +			mdio0: mdio <at> fc000 {
> > +			};
> 
> Why is the empty node needed?

For the label


Cheers,
