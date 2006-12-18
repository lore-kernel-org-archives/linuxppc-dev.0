Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A39D267B93
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 09:23:17 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
Date: Mon, 18 Dec 2006 23:23:10 +0100
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
In-Reply-To: <A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200612182323.11262.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 18 December 2006 22:52, Segher Boessenkool wrote:

> > +static int ipmi_of_probe(struct of_device *dev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const =
struct of_device_id *match)
>=20
> Shouldn't this (and everything else) be some kind of __init?

It should be __devinit.

> > +=A0=A0=A0=A0=A0regsize =3D get_property(np, "reg-size", NULL);
> > +=A0=A0=A0=A0=A0regspacing =3D get_property(np, "reg-spacing", NULL);
> > +=A0=A0=A0=A0=A0regshift =3D get_property(np, "reg-shift", NULL);
>=20
> You should check whether you get exactly 4 bytes back or not.
>
> > +=A0=A0=A0=A0=A0if (!regsize)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0info->io.regsize =3D DEFAULT_RE=
GSPACING;
> > +=A0=A0=A0=A0=A0else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0info->io.regsize =3D *regsize;
>=20
> info->io_regsize =3D regsize ? *regsize : DEFAULT_REGSIZE;
>=20
> [Please note that fixes a copy/paste bug, too].

These two changes are contradictory. It's either

    regsize =3D get_property(np, "reg-size", NULL);
    info->io_regsize =3D regsize ? *regsize : DEFAULT_REGSIZE;

or

    regsize =3D get_property(np, "reg-size", &proplen);
    info->io_regsize =3D (proplen =3D=3D 4) ? *regsize : DEFAULT_REGSIZE;

> > +static int ipmi_of_remove(struct of_device *dev)
> > +{
> > +=A0=A0=A0=A0=A0/* should call
> > +=A0=A0=A0=A0=A0 * cleanup_one_si(dev->dev.driver_data); */
>=20
> So fix that :-)

That should be a separate patch that fixes the same thing for
pci ipmi devices as well. It needs to move code around for this
(or introduce forward declarations), and the effect is no
different, so it's really just a cleanup.

> > +static struct of_device_id ipmi_match[] =3D
> > +{
> > +=A0=A0=A0=A0=A0{ .type =3D "ipmi", .compatible =3D "ipmi-kcs", =A0.dat=
a =3D (void*)=20
> > SI_KCS },
> > +=A0=A0=A0=A0=A0{ .type =3D "ipmi", .compatible =3D "ipmi-smic", .data =
=3D (void*)=20
> > SI_SMIC },
> > +=A0=A0=A0=A0=A0{ .type =3D "ipmi", .compatible =3D "ipmi-bt", =A0 .dat=
a =3D (void*)SI_BT },
>=20
> That cast-to-pointer is what gives you that warning when
> casting back. =A0Is there no better solution?

The one alternative might be something more complicated like:

static const enum si_type __devinitdata of_ipmi_dev_info[] =3D {
	[SI_KCS] SI_KCS,
	[SI_SMIC] SI_SMIC,
	[SI_BT] SI_BT,
};

static const struct of_device_id of_ipmi_match[] =3D {
	{ .type =3D "ipmi", .compatible =3D "ipmi-kcs",  .data =3D &of_ipmi_dev_in=
fo[SI_KCS] },
	{ .type =3D "ipmi", .compatible =3D "ipmi-kcs",  .data =3D &of_ipmi_dev_in=
fo[SI_SMIC] },
	{ .type =3D "ipmi", .compatible =3D "ipmi-kcs",  .data =3D &of_ipmi_dev_in=
fo[SI_BT] },
};

Not sure if that's worth it.

	Arnd <><
