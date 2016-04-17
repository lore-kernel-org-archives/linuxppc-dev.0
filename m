Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnZ2P2HqczDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 11:49:16 +1000 (AEST)
Message-ID: <1460857751.32510.175.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Valentin Longchamp <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 16 Apr 2016 20:49:11 -0500
In-Reply-To: <5705FAD3.40106@keymile.com>
References: <1459949825-10533-1-git-send-email-valentin.longchamp@keymile.com>
 <1459979380.32510.75.camel@buserror.net> <5705FAD3.40106@keymile.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: define the fman node for the kmcoge4 DTS
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-07 at 08:14 +0200, Valentin Longchamp wrote:
> On 06/04/16 23:49, Scott Wood wrote:
> > On Wed, 2016-04-06 at 15:37 +0200, Valentin Longchamp wrote:
> > > Now that the FMAN mac driver has been merged the fman node is relevant.
> > > 
> > > The kmcoge4 board implements 3 ethernet interfaces, 1 with a RGMII phy
> > > and 2 with fixed 1 Giga SGMII links.
> > > 
> > > Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> > > ---
> > >  arch/powerpc/boot/dts/fsl/kmcoge4.dts | 39
> > > +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> > > b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> > > index 6858ec9..1cec66d 100644
> > > --- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> > > +++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> > > @@ -106,6 +106,45 @@
> > >  		sata@221000 {
> > >  			status = "disabled";
> > >  		};
> > > +
> > > +		fman0: fman@400000 {
> > > +			enet0: ethernet@e0000 {
> > > +				phy-connection-type = "sgmii";
> > > +				local-mac-address = [00 11 22 33 44
> > > 55];
> > > +				fixed-link {
> > > +					speed = <1000>;
> > > +					full-duplex;
> > > +				};
> > > +			};
> > > +			mdio0: mdio@e1120 {
> > > +				front_phy: ethernet-phy@11 {
> > > +					reg = <0x11>;
> > > +				};
> > > +			};
> > > +
> > > +			enet1: ethernet@e2000 {
> > > +				phy-connection-type = "sgmii";
> > > +				local-mac-address = [00 11 22 33 44
> > > 56];
> > > +				fixed-link {
> > > +					speed = <1000>;
> > > +					full-duplex;
> > > +				};
> > > +			};
> > 
> > No hardcoded MAC addresses.
> > 
> 
> For these 2 interfaces where I have the local-mac-address field, the MAC
> addresses are set later by an application that reads the real address in
> some
> EEPROM. However, in order to let the fman mac_probe to run successfully in
> the
> first place I have set non-zero MAC addresses since the local-mac-address
> fields
> are not set by u-boot.

Why can't it be set from U-Boot?

If you absolutely must hardcode a mac address, use one with the locally
-administered bit set (0x02 in the first byte).

> I have found several local-mac-address fields in other DTS files that are
> all
> zeros, and thus are rejected by of_get_mac_address. Are they leftovers from
> the
> past or should they be used here as well ? If not, I will simply drop these
> 2
> fields.

That's a relic from ancient U-Boots that could only overwrite existing
properties rather than insert them from scratch.

-Scott
