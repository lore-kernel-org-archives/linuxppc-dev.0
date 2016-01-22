Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0082.outbound.protection.outlook.com [157.56.112.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21CC21A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 19:50:02 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>, "shh.xie@gmail.com" <shh.xie@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Shaohui Xie
 <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Date: Fri, 22 Jan 2016 08:15:53 +0000
Message-ID: <VI1PR04MB1664BAFB4EE494CB14830BCCE8C40@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
 <20160114164418.GD19773@lunn.ch>
 <VI1PR04MB166491DEBB439EB72742201DE8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <56997951.90304@gmail.com> <5699B211.5070602@gmail.com>
 <VI1PR04MB16645A2F24DB515D86136BE2E8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <569C9CD2.10301@gmail.com>
 <VI1PR04MB1664AB0E483F01F1641059FFE8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <20160118151500.GD923@lunn.ch>
 <VI1PR04MB1664DFBC53F08C5CE7EBF22AE8C10@VI1PR04MB1664.eurprd04.prod.outlook.com>,
 <20160121211250.GK9991@lunn.ch>
In-Reply-To: <20160121211250.GK9991@lunn.ch>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_______________________________________
From: Andrew Lunn <andrew@lunn.ch>
Sent: Friday, January 22, 2016 5:12 AM
To: Shaohui Xie
Cc: Sebastian Hesselbarth; Florian Fainelli; shh.xie@gmail.com; devicetree@=
vger.kernel.org; netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; dav=
em@davemloft.net; Shaohui Xie
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR

On Tue, Jan 19, 2016 at 05:00:35AM +0000, Shaohui Xie wrote:
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Monday, January 18, 2016 11:15 PM
> > To: Shaohui Xie
> > Cc: Sebastian Hesselbarth; Florian Fainelli; shh.xie@gmail.com;
> > devicetree@vger.kernel.org; netdev@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; davem@davemloft.net; Shaohui Xie
> > Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBAS=
E-KR
> >
> > > [S.H] the fsl backplane, e.g. 10GBASE-KR, needs software to handle
> > > link training, It's to train link partner, and trained by link partne=
r
> > parallel.
> > >
> > > But if media type is not copper, e.g. optical module, we won't need t=
his.
> >
> > So what we actually need to know is copper vs fibre?

> Copper is not enough to indicate backplane, since backplane is
> always copper, but copper is not always backplane.

>O.K, lets try again....

[S.H]Seems I did not get your point, Sorry for the inconvenient.

>If it is copper backplane you need to perform training.

>Looking at the driver probe function, it is either 1000BASE-KX, no
>training needed, or else it is 10GBASE-RK and training is needed.

>Looking at fsl_backplane_config_aneg() you expect phydev->speed to be
>set, and from the speed you then kick of either KR autoneg or KX
>autoneg. Could you also start the training at this point? Use the
>speed to indicate if training is needed?

 [S.H]The training cannot be started at this point, yet, because it's based=
 on=20
autoneg result, only when both sides autoneg-ed to 10G-KR, then to start
the training.

Besides the driver, generally speaking, "copper + speed" is not enough to i=
ndicate=20
it's backplane, for ex. "copper + 1000" does not mean it has to be 1000BASE=
-KX,=20
it could be SGMII, hence cannot use KX autoneg.

If putting backplane property to phy.txt is not good, I can put it to fsl s=
pecific
binding, like the second patch 2/3 did.

Thank you!
Shaohui=
