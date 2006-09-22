Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9714267B5D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 18:00:50 +1000 (EST)
Date: Fri, 22 Sep 2006 12:00:36 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] POWERPC: Added devicetree for mpc8272ads board
Message-ID: <20060922120036.54829e3f@localhost.localdomain>
In-Reply-To: <DBDA0C60-A5F4-4F8A-BF98-FE232EAAA010@kernel.crashing.org>
References: <20060922064610.0943f1fc@localhost.localdomain>
	<20060922024827.27185.39986.stgit@localhost.localdomain>
	<DBDA0C60-A5F4-4F8A-BF98-FE232EAAA010@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_2tmMrmy+OyPAqVDs3XUeYhk;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_2tmMrmy+OyPAqVDs3XUeYhk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Kumar,

Thanks a lot for extracting some time and glance at this approach...
My comments below.

On Thu, 21 Sep 2006 23:55:36 -0500
Kumar Gala wrote:

>=20
> On Sep 21, 2006, at 9:48 PM, Vitaly Bordug wrote:
>=20
> >
> > This adds current dts file used with MPC8272ADS,
> > introducing new mdio bitbang defines, as well as
> > fully-CPM2-SoC board design.
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
> >
> >  arch/powerpc/boot/dts/mpc8272ads.dts |  236
> > +++++++++++++++++++++++ +++++++++++
> >  1 files changed, 236 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/=20
> > boot/dts/mpc8272ads.dts
> > new file mode 100644
> > index 0000000..6d72b7d
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> > @@ -0,0 +1,236 @@
> > +/*
> > + * MPC8272 ADS Device Tree Source
> > + *
> > + * Copyright 2005 Freescale Semiconductor Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or =20
> > modify it
> > + * under  the terms of  the GNU General  Public License as =20
> > published by the
> > + * Free Software Foundation;  either version 2 of the  License,
> > or (at your
> > + * option) any later version.
> > + */
> > +
> > +
> > +/*
> > +/memreserve/   00000000 4000000;
> > +*/
>=20
> Is this needed?
>=20
not necessarily-will clean up.
> > +
> > +/ {
> > +       model =3D "MPC8272ADS";
> > +       compatible =3D "MPC8260ADS";
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <1>;
> > +       linux,phandle =3D <100>;
> > +
> > +       cpus {
> > +               #cpus =3D <1>;
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +               linux,phandle =3D <200>;
> > +
> > +               PowerPC,8272@0 {
> > +                       device_type =3D "cpu";
> > +                       reg =3D <0>;
> > +                       d-cache-line-size =3D <20>;       // 32 bytes
> > +                       i-cache-line-size =3D <20>;       // 32 bytes
> > +                       d-cache-size =3D <4000>;          // L1, 16K
> > +                       i-cache-size =3D <4000>;          // L1, 16K
> > +                       timebase-frequency =3D <17d7840>;
> > +                       bus-frequency =3D <5f5e100>;
> > +                       clock-frequency =3D <17D78400>;
>=20
> Are the freq's really fixed? if not having these values as 0, maybe =20
> be better.
>=20

On some path u-boot messed the frequencies, that's why here resides fixed a=
pproach. Eventually will be put back to <0> once it will definitely work.
> > +                       32-bit;
> > +                       linux,phandle =3D <201>;
> > +                       linux,boot-cpu;
> > +               };
> > +       };
> > +
> > +       interrupt-controller@f8200000 {
> > +               linux,phandle =3D <f8200000>;
> > +               #address-cells =3D <0>;
> > +               #interrupt-cells =3D <2>;
> > +               interrupt-controller;
> > +               reg =3D <f8200000 f8200004>;
> > +               built-in;
> > +               device_type =3D "pci-pic";
> > +       };
> > +       memory {
> > +               device_type =3D "memory";
> > +               linux,phandle =3D <300>;
> > +               reg =3D <00000000 4000000 f4500000 00000020>;
> > +       };
> > +
> > +       chosen {
> > +               name =3D "chosen";
> > +               bootargs =3D "root=3D/dev/nfs rw ip=3Don";
>=20
> Seems bad form to put bootargs in the .dts directly like this.
>=20
> > +               linux,stdout-path =3D "/dev/ttyCPM0";
>=20
> I thought this was the 'of' path, not a dev path.
>

I was about to remove the upper stuff, and at the last moment missed that. =
Will clean up.

> > +               linux,platform =3D <0>;
> > +               interrupt-controller =3D <10c00>;
> > +               linux,phandle =3D <400>;
> > +       };
> > +
> > +       soc8272@f0000000 {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               #interrupt-cells =3D <2>;
> > +               device_type =3D "soc";
> > +               ranges =3D < 0 0 2 00000000 f0000000 00053000>;
> > +               reg =3D <f0000000 0>;
> > +
> > +               mdio@0 {
> > +                       device_type =3D "mdio";
> > +                       compatible =3D "fs_enet";
> > +                       reg =3D <0 0>;
> > +                       linux,phandle =3D <24520>;
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
> > +                       ethernet-phy@0 {
> > +                               linux,phandle =3D <2452000>;
> > +                               interrupt-parent =3D <10c00>;
> > +                               interrupts =3D <19 1>;
> > +                               reg =3D <0>;
> > +                               bitbang =3D [ 12 12 13 02 02 01 ];
> > +                               device_type =3D "ethernet-phy";
> > +                       };
> > +                       ethernet-phy@1 {
> > +                               linux,phandle =3D <2452001>;
> > +                               interrupt-parent =3D <10c00>;
> > +                               interrupts =3D <19 1>;
> > +                               bitbang =3D [ 12 12 13 02 02 01 ];
> > +                               reg =3D <3>;
> > +                               device_type =3D "ethernet-phy";
> > +                       };
> > +               };
> > +
> > +               ethernet@24000 {
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
> > +                       device_type =3D "network";
> > +                       device-id =3D <2>;
> > +                       compatible =3D "fs_enet";
> > +                       model =3D "FCC";
> > +                       reg =3D <11300 20 8400 100 11380 30>;
> > +                       mac-address =3D [ 00 11 2F 99 43 54 ];
> > +                       interrupts =3D <20 2>;
> > +                       interrupt-parent =3D <10c00>;
> > +                       phy-handle =3D <2452000>;
> > +                       rx-clock =3D <13>;
> > +                       tx-clock =3D <12>;
> > +               };
> > +
> > +               ethernet@25000 {
> > +                       device_type =3D "network";
> > +                       device-id =3D <3>;
> > +                       compatible =3D "fs_enet";
> > +                       model =3D "FCC";
> > +                       reg =3D <11320 20 8500 100 113b0 30>;
> > +                       mac-address =3D [ 00 11 2F 99 44 54 ];
> > +                       interrupts =3D <21 2>;
> > +                       interrupt-parent =3D <10c00>;
> > +                       phy-handle =3D <2452001>;
> > +                       rx-clock =3D <17>;
> > +                       tx-clock =3D <18>;
> > +               };
> > +
> > +               cpm@f0000000 {
> > +                       linux,phandle =3D <f0000000>;
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <1>;
> > +                       #interrupt-cells =3D <2>;
> > +                       device_type =3D "cpm";
> > +                       model =3D "CPM2";
> > +                       ranges =3D <00000000 00000000 3ffff>;
> > +                       reg =3D <10d80 3280>;
> > +                       command-proc =3D <119c0>;
> > +                       brg-frequency =3D <17D7840>;
> > +                       cpm_clk =3D <BEBC200>;
> > +
> > +                       scc@11a00 {
> > +                               device_type =3D "serial";
> > +                               compatible =3D "cpm_uart";
> > +                               model =3D "SCC";
> > +                               device-id =3D <2>;
> > +                               reg =3D <11a00 20 8000 100>;
> > +                               current-speed =3D <1c200>;
> > +                               interrupts =3D <28 2>;
> > +                               interrupt-parent =3D <10c00>;
> > +                               clock-setup =3D <0 00ffffff>;
> > +                               rx-clock =3D <1>;
> > +                               tx-clock =3D <1>;
> > +                       };
> > +
> > +                       scc@11a60 {
> > +                               device_type =3D "serial";
> > +                               compatible =3D "cpm_uart";
> > +                               model =3D "SCC";
> > +                               device-id =3D <5>;
> > +                               reg =3D <11a60 20 8300 100>;
> > +                               current-speed =3D <1c200>;
> > +                               interrupts =3D <2b 2>;
> > +                               interrupt-parent =3D <10c00>;
> > +                               clock-setup =3D <1b ffffff00>;
> > +                               rx-clock =3D <4>;
> > +                               tx-clock =3D <4>;
> > +                       };
> > +
> > +               };
> > +               interrupt-controller@10c00 {
> > +                       linux,phandle =3D <10c00>;
> > +                       #address-cells =3D <0>;
> > +                       #interrupt-cells =3D <2>;
> > +                       interrupt-controller;
> > +                       reg =3D <10c00 80>;
> > +                       built-in;
> > +                       device_type =3D "cpm-pic";
> > +               };
>=20
> Do we need to distinguish cpm2-pic from cpm-pic (8xx)?
>=20

IIRC, no, but I'll double-check.

> > +               pci@0500 {
> > +                       linux,phandle =3D <0500>;
> > +                       #interrupt-cells =3D <1>;
> > +                       #size-cells =3D <2>;
> > +                       #address-cells =3D <3>;
> > +                       compatible =3D "8272";
> > +                       device_type =3D "pci";
> > +                       reg =3D <10430 4dc>;
> > +                       clock-frequency =3D <3f940aa>;
> > +                       interrupt-map-mask =3D <f800 0 0 7>;
> > +                       interrupt-map =3D <
> > +
> > +                                       /* IDSEL 0x16 */
> > +                                        b000 0 0 1 f8200000 40 0
> > +                                        b000 0 0 2 f8200000 41 0
> > +                                        b000 0 0 3 f8200000 42 0
> > +                                        b000 0 0 4 f8200000 43 0
> > +
> > +                                       /* IDSEL 0x17 */
> > +                                        b800 0 0 1 f8200000 43 0
> > +                                        b800 0 0 2 f8200000 40 0
> > +                                        b800 0 0 3 f8200000 41 0
> > +                                        b800 0 0 4 f8200000 42 0
> > +
> > +                                       /* IDSEL 0x18 */
> > +                                        c000 0 0 1 f8200000 42 0
> > +                                        c000 0 0 2 f8200000 43 0
> > +                                        c000 0 0 3 f8200000 40 0
> > +                                        c000 0 0 4 f8200000 41 0>;
> > +                       interrupt-parent =3D <10c00>;
> > +                       interrupts =3D <14 3>;
> > +                       bus-range =3D <0 0>;
> > +                       ranges =3D <02000000 0 80000000 80000000 0 =20
> > 40000000
> > +                                 01000000 0 00000000 f6000000 0 =20
> > 02000000>;
> > +               };
> > +
> > +/* May need to remove if on a part without crypto engine */
> > +               crypto@30000 {
> > +                       device_type =3D "crypto";
> > +                       model =3D "SEC2";
> > +                       compatible =3D "talitos";
> > +                       reg =3D <30000 10000>;
> > +                       interrupts =3D <b 0>;
> > +                       interrupt-parent =3D <10c00>;
> > +                       num-channels =3D <4>;
> > +                       channel-fifo-len =3D <18>;
> > +                       exec-units-mask =3D <0000007e>;
> > +/* desc mask is for rev1.x, we need runtime fixup for >=3D2.x */
> > +                       descriptor-types-mask =3D <01010ebf>;
> > +               };
> > +
> > +       };
> > +};
>=20
>=20
Sincerely, Vitaly

--Sig_2tmMrmy+OyPAqVDs3XUeYhk
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFE5gkuOg9JvQhSEsRAg7lAJ4ymPgQetHHooBIUNBOqwOZSAXqIACgoJcj
uYbl7PrPVlDDmT7ZA5BEmTE=
=8dFw
-----END PGP SIGNATURE-----

--Sig_2tmMrmy+OyPAqVDs3XUeYhk--
