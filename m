Return-Path: <Alexandre.Bounine@IDT.COM>
Received: from mxout1.mainstreet.net (mxout.mainstreet.net [207.5.0.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66738B7C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 01:31:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/7] RapidIO: Add IDT CPS/TSI switches
Date: Thu, 25 Feb 2010 06:18:49 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552A54E7A@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4B8585DE.50701@neli.hopto.org>
References: <20100224151447.GA13661@kaneng01.tundra.com>
	<4B8585DE.50701@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@IDT.COM>
To: "Micha Nelissen" <micha@neli.hopto.org>,
	"Alexandre Bounine" <alexb@tundra.com>
Cc: linux-kernel@vger.kernel.org, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org, alexandreb@tundra.com,
	thomas.moll.ext@nsn.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
> Alexandre Bounine wrote:
> > @@ -369,6 +380,10 @@ static struct rio_dev __devinit *rio_set
> >  			     rdev->rswitch->switchid);
> >  		rio_route_set_ops(rdev);
> >
> > +		if (do_enum && rdev->rswitch->clr_table)
> > +			rdev->rswitch->clr_table(port, destid, hopcount,
> > +						 RIO_GLOBAL_TABLE);
> > +
> >  		list_add_tail(&rswitch->node, &rio_switches);
> >
> >  	} else
>=20
> Why clear the tables here, why not in rio_enum_peer?

I prefer to keep it together with route table image initialization.=20

>=20
> > +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI572,
tsi57x_route_add_entry,
> tsi57x_route_get_entry, tsi57x_route_clr_table);
> > +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI574,
tsi57x_route_add_entry,
> tsi57x_route_get_entry, tsi57x_route_clr_table);
> > +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI577,
tsi57x_route_add_entry,
> tsi57x_route_get_entry, tsi57x_route_clr_table);
> > +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI578,
tsi57x_route_add_entry,
> tsi57x_route_get_entry, tsi57x_route_clr_table);
>=20
> Can the 568 and 578 driver be shared? Have a 5xx driver?

For route table operations this will work. But there are Error
Management functions added in follow-up patches, which are different for
Tsi568. I prefer to keep them in different files to avoid hiding the
differences. Plus, it makes easier for end-user to remove from the build
drivers for switches that are not used in their system. I do not want to
add new configuration options for switch selection at this moment but we
may consider it later.=20

Alex.
 =20
