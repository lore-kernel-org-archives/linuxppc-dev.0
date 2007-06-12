Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy02.edpnet.net (lmailproxy02.edpnet.net [212.71.1.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 139C8DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:00:04 +1000 (EST)
Date: Tue, 12 Jun 2007 18:06:28 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Message-ID: <20070612160628.GB2481@chiana.homelinux.org>
References: <4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
	<d3c57096eec4553de180adab085d0145@kernel.crashing.org>
	<20070611162135.GS2591@chiana.homelinux.org>
	<894636D6-AC2E-4D28-8698-EB43C7354BB5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <894636D6-AC2E-4D28-8698-EB43C7354BB5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I'm confused what you are comparing here, 3 seconds on arch=3Dppc vs =20
> over a minute on arch=3Dpowerpc?

Loading of a TI DSP over HPI. HPI is implemented in UPMB (programmed by
U-Boot); all that the kernel has to do is write to the in U-Boot
programmed location (0xe2400000) to trigger the UPMB HPI protocol.

> I'd expect the driver to be exactly the same (or close to it) for =20
> arch=3Dppc vs arch=3Dpowerpc.

Same here: there are a number of performance issues wrt to an older 8245
based implementation (network seems slower too) and this was not one I
expected while switching to powerpc.

> There shouldn't be, but if you are seeing this we really should =20
> figure out what's going on.
>=20
> What kernel is this on?  What processor are you using?

$ cat /proc/cpuinfo
processor       : 0
cpu             : e300c1
clock           : 396.000000MHz
revision        : 1.1 (pvr 8083 0011)
bogomips        : 131.28
timebase        : 66000000
platform        : BARCO834x SVC2

$ uname -a
Linux barco 2.6.21.1-barco1 #1 PREEMPT Tue Jun 12 09:48:12 CEST 2007 ppc un=
known

The board is based on the FreeScale SYS/EMDS reference design.

Most of the HPI operations are stuff like this:

static inline int8_t _hpi_set_hhwil(uint8_t b)
{
        volatile immap_t* im;

        if(!(im =3D ioremap((immrbar),sizeof(struct immap)))){
                return -EINVAL;
        }
        (b)?(im->gpio[0].dat |=3D HHWIL):(im->gpio[0].dat &=3D ~HHWIL);
        iounmap(im);

        return 0;
}

static inline uint32_t __hpi_read_hpid(void)
{
        uint32_t returnval;

        /* Program HPID */
        _hpi_set_hcntl1(1);
        _hpi_set_hcntl0(1);

        /* first halfword */
        _hpi_set_hhwil(0);
        /* dummy read */
        returnval =3D (((uint32_t)(*hpi_dsp))<<16);

        /* delay */
        udelay(1);

        /* second halfword */
        _hpi_set_hhwil(1);
        /* dummy read */
        returnval |=3D *hpi_dsp;

        /* delay */
        udelay(1);

        return returnval;
}

The ioremap was certainly a bottleneck; and moving it to initialisation
with a global pointer got us from 60 secs back to around 1 sec, but the
a similar effect was obtained on the ppc arch with this change (this was
just making a bad situation to be hidden).

Even after this change; the load of a streaming application was
something of 40% on ppc and 60% on powerpc.

--=20
  greetz, marc
I'm having sex with 3 hynerian donkeys. What does it look like i'm
doing?
	Chiana - Crackers Don't Matter
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbsSDUQpj09NWLeERAjDbAJ47Wg39NiCQVDaZe5rGx2D6fc25VwCfXlc0
Hy0frOddDDz185mJPthil0g=
=O5L4
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
