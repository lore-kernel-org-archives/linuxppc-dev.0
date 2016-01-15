Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0058.outbound.protection.outlook.com [157.56.112.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81D9E1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 15:01:28 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "shh.xie@gmail.com" <shh.xie@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: RE: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Date: Fri, 15 Jan 2016 04:01:19 +0000
Message-ID: <VI1PR04MB166491DEBB439EB72742201DE8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
 <20160114164418.GD19773@lunn.ch>
In-Reply-To: <20160114164418.GD19773@lunn.ch>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Friday, January 15, 2016 12:44 AM
> To: shh.xie@gmail.com
> Cc: devicetree@vger.kernel.org; netdev@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; f.fainelli@gmail.com; davem@davemloft.net; Shaohui =
Xie
> Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-=
KR
>=20
> On Thu, Jan 14, 2016 at 04:23:59PM +0800, shh.xie@gmail.com wrote:
> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> >
> > This commit adds necessary definitions for the PHY layer to recognize
> > backplane Ethernet 1000BASE-KX and 10GBASE-KR as valid PHY interfaces,
> > "1000base-kx" for 1000BASE-KX, "10gbase-kr" for 10GBASE-KR.
> >
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > ---
> > changes in v2:
> > new patch.
> >
> >  Documentation/devicetree/bindings/net/ethernet.txt | 4 ++--
> >  include/linux/phy.h                                | 6 ++++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/ethernet.txt
> > b/Documentation/devicetree/bindings/net/ethernet.txt
> > index 5d88f37..1166a5c 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet.txt
> > +++ b/Documentation/devicetree/bindings/net/ethernet.txt
> > @@ -11,8 +11,8 @@ The following properties are common to the Ethernet
> controllers:
> >    the maximum frame size (there's contradiction in ePAPR).
> >  - phy-mode: string, operation mode of the PHY interface; supported val=
ues are
> >    "mii", "gmii", "sgmii", "qsgmii", "tbi", "rev-mii", "rmii",
> > "rgmii", "rgmii-id",
> > -  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii"; this is now a
> > de-facto
> > -  standard property;
> > +  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii", "1000base-kx",
> > + "10gbase-kr";  this is now a de-facto standard property;
>=20
> I know very little about this, so i'm just asking a question. None of the=
 other
> interface modes contain a bit rate. So is the bit rate needed for your tw=
o new
> modes?
>=20
> With a bit of googling, K means copper backplane, X means 4B/5B and R mea=
ns
> 64B/66B. Could there be a 10Gbps KX? a 1GBps KR? Do we actually need the =
speed
> here, or is kx and kr sufficient?
Hello Andrew,

1000BASE-KX and 10GBASE-KR are terms in IEEE802.3, so as XGMII and GMII.=20
There are interfaces could be different bit rates but same types,=20
e.g. 100BASE-LX10 and 1000BASE-LX10, or 40GBASE-KR4 and 100GBASE-KR4,=20
having bit rate is clear to represent hardware.

Thank you!

 Shaohui
