Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06381140079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 18:36:18 +1100 (EST)
From: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
Date: Fri, 28 Mar 2014 07:36:11 +0000
Message-ID: <0ca1e7910cd247c4aebe4cbd48a633cb@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1395901116-16034-1-git-send-email-B45475@freescale.com>
 <53341101.9000404@cogentembedded.com>
In-Reply-To: <53341101.9000404@cogentembedded.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mugunthanvnm@ti.com" <mugunthanvnm@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "helmut.schaa@googlemail.com" <helmut.schaa@googlemail.com>,
 "zonque@gmail.com" <zonque@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Xiaobo Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, March 27, 2014 7:53 PM, Sergei Shtylyov wrote:
> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]
> Sent: Thursday, March 27, 2014 7:53 PM
> To: Zhao Qiang-B45475; linuxppc-dev@lists.ozlabs.org;
> netdev@vger.kernel.org; Wood Scott-B07421
> Cc: linux-kernel@vger.kernel.org; davem@davemloft.net;
> mugunthanvnm@ti.com; zonque@gmail.com; helmut.schaa@googlemail.com; Xie
> Xiaobo-R63061
> Subject: Re: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
>=20
> Hello.
>=20
> On 27-03-2014 10:18, Zhao Qiang wrote:
>=20
> > The at8031 can work on polling mode and interrupt mode.
> > Add ack_interrupt and config intr funcs to enable interrupt mode for
> > it.
>=20
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> >   drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
>=20
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c index
> > bc71947..d034ef5 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> [...]
> > @@ -191,6 +194,31 @@ static int at803x_config_init(struct phy_device
> *phydev)
> >   	return 0;
> >   }
> >
> > +static int at803x_ack_interrupt(struct phy_device *phydev) {
> > +	int err;
> > +
> > +	err =3D phy_read(phydev, AT803X_INSR);
>=20
>     Could make this an initializer...

Thank you very much. However I have no idea about "make this an initializer=
".

>=20
> > +
> > +	return (err < 0) ? err : 0;
> > +}
> > +
> > +static int at803x_config_intr(struct phy_device *phydev) {
> > +	int err;
> > +	int value;
> > +
> > +	value =3D phy_read(phydev, AT803X_INER);
> > +
> > +	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED)
> > +		err =3D phy_write(phydev, AT803X_INER,
> > +				(value | AT803X_INER_INIT));
>=20
>     Inner parens not needed.
>=20
> > +	else
> > +		err =3D phy_write(phydev, AT803X_INER, value);
>=20
>     Why are you not clearing the bits here? Why write back what has been
> read at all?
>=20
> WBR, Sergei
>=20
>=20
