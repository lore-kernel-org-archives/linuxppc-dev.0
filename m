Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 6B22D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Dec 2004 19:07:51 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 2 Dec 2004 09:07:44 +0100
References: <200412011707.14693.g.jaeger@sysgo.com>
	<0429B8F6-43E7-11D9-A6C5-000393DBC2E8@freescale.com>
In-Reply-To: <0429B8F6-43E7-11D9-A6C5-000393DBC2E8@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412020907.44778.g.jaeger@sysgo.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] Fix gianfar netdriver oops when using bootp...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Wednesday 01 December 2004 23:19, Kumar Gala wrote:
> There is some belief that the following patch should fix the issue:
>=20
> http://linux.bkbits.net:8080/linux-2.5/cset@1.2249.2.2? nav=3Dindex.html|=
ChangeSet@-3d
>=20
> I would be interested to know if this helps w/o your patch.

I'd like to cross-check this, but are you sure, you're referencing the corr=
ect
changeset? Currently I only got:
Error 500
Unable to find revision 1.2249.2.2

Gerhard

>=20
> - kumar
>=20
> On Dec 1, 2004, at 10:07 AM, Gerhard Jaeger wrote:
>=20
> > Hi,
> >
> > this patch fixes an issue, that occurs on my MPC8541CDS, when trying to
> >  use bootp to get the IP parameters. It seems, that the patch only =20
> > cures
> >  the symptom but obviously not the cause ;)
> >
> > Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
> >
> > --- linux-2.6.10-rc2-mm4/drivers/net/gianfar.c.orig=A0=A0=A0=A0 2004-11=
=2D15 =20
> > 02:26:34.000000000 +0100
> >  +++ linux-2.6.10-rc2-mm4/drivers/net/gianfar.c=A0 2004-12-01 =20
> > 17:00:19.000000000 +0100
> >  @@ -1477,6 +1477,9 @@ static void gfar_phy_change(void *data)
> >  =A0=A0=A0=A0=A0=A0=A0 struct gfar_private *priv =3D netdev_priv(dev);
> > =A0=A0=A0=A0=A0=A0=A0 int result =3D 0;
> >  =A0
> >  +=A0=A0=A0=A0=A0=A0 if( !priv->mii_info->phyinfo )
> >  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return;
> >  +
> >  =A0=A0=A0=A0=A0=A0=A0 /* Delay to give the PHY a chance to change the
> >  =A0=A0=A0=A0=A0=A0=A0=A0 * register state */
> >  =A0=A0=A0=A0=A0=A0=A0 msleep(1);
>=20
>=20
