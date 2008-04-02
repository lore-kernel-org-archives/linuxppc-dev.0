Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id C83A1DDFA2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 00:16:57 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1532901nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 06:16:51 -0700 (PDT)
Date: Wed, 2 Apr 2008 15:06:45 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: psc and spi
Message-ID: <20080402130645.GE14213@sfrouter>
References: <20080115135306.GE14333@sfrouter>
	<fa686aa40801150651s213a745dwa4d595de5a9d191b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
In-Reply-To: <fa686aa40801150651s213a745dwa4d595de5a9d191b@mail.gmail.com>
From: "S. Fricke" <silvio.fricke@googlemail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> On 1/15/08, S. Fricke <silvio.fricke@googlemail.com> wrote:
> > Hello friends,
> >
> > I have on the psc3 the spi-interface of a fpga connected.
> >
> >    psc3-0 - MOSI
> >    psc3-1 - MISO
> >    psc3-2 - CLK
> >    psc3-3 - SlaveSelect
> >    psc3-4 - CS-FPGA
> >    psc3-5 - CS Another device
> >    psc3-6 - SPI-SEL0
> >    psc3-7 - SPI-SEL1
> >    psc3-8/9 - Not connected
> >
> > Can I use the mpc52xx_psc_spi-driver? And if yes, how I have to use this
> > driver?  Or must I write a own spi-master/slave thing? Can anyone point=
 me
> > to a good start-position?
>=20
> Yes, you should be able to use the mpc52xx_psc_spi driver.  You'' need
> to add the activate_cs and deactivate_cs hooks in your platform code
> to activate your SPI CS lines.  You'll also need to set port_config to
> have the PSC3 pins in "CODEC3" mode.

OK, I defined a "fsl_spi_platform_data" for my "activate_cs" and=20
"deactivate_cs". This structure I have insert in a "spi_board_info" with
all other mandatory Informations.
When I load "mpc52xx_psc_spi", then I get a "mpc52xx-psc-spi f0002400.spi:
probe called without platform data, no (de)activate_cs function will be
called"

What is wrong in my setup or did I have forget something?

    static void activate_cs(u8 cs, u8 polarity) {/* ... */ }
    static void deactivate_cs(u8 cs, u8 polarity) {/* ...*/}

    static struct fsl_spi_platform_data my_spi_p_data =3D {=20
        .bus_num =3D 0x2400,
        .max_chipselect =3D 3,
        .activate_cs =3D activate_cs,
        .deactivate_cs =3D deactivate_cs,
    }; =20
    static struct spi_board_info my_spi_boardinfo =3D {=20
        .bus_num =3D 0x2400,
        .chip_select =3D 0,
        .max_speed_hz =3D 1000,
        .modalias =3D "my-spi-device",
        .platform_data =3D &my_spi_p_data,
    }; =20

    static int __init ipek01_spi_init(void) {
        int ret;
        return fsl_spi_init(&my_spi_boardinfo, 1, activate_cs, deactivate_c=
s);
    }  =20
    device_initcall(ipek01_spi_init);

best regards,
Silvio Fricke

--=20
-- S. Fricke ------------------------------------ silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)         TEL:                 (+49)8330-911278
   Linux-Entwicklung             JABBER: silvio@conversation.port1024.net
----------------------------------------------------------------------------


--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfzhOUACgkQ8WEBxatmn4021gCgisrHMgnmTghCAY2cYZ2ih00b
wLIAnjHUhx2GbAi+Go1YnJq+9p85C0As
=htb2
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
