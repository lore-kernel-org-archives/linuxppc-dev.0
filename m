Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/6] ehea: header files
From: Michael Ellerman <michael@ellerman.id.au>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <44E07267.7070007@de.ibm.com>
References: <44D99F56.7010201@de.ibm.com>
	<1155190921.9801.43.camel@localhost.localdomain>
	<44E07267.7070007@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mGWz1ApQ+VDu554yWbLm"
Date: Tue, 15 Aug 2006 10:08:19 +1000
Message-Id: <1155600499.9047.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mGWz1ApQ+VDu554yWbLm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-08-14 at 14:53 +0200, Jan-Bernd Themann wrote:
> Michael Ellerman wrote:
> >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.=
000000000 -0800
> >> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
> >> +
> >> +#define EHEA_PAGESHIFT  12
> >> +#define EHEA_PAGESIZE   4096UL
> >> +#define EHEA_CACHE_LINE 128
> >=20
> > This looks like a very bad idea, what happens if you're running on a
> > machine with 64K pages?
> >=20
>=20
> The EHEA_PAGESIZE define is needed for queue management to hardware side.

You mean the eHEA has its own concept of page size? Separate from the
page size used by the MMU?

> >> +/*
> >> + *  h_galpa:
> >> + *  for pSeries this is a 64bit memory address where
> >> + *  I/O memory is mapped into CPU address space
> >> + */
> >> +
> >> +struct h_galpa {
> >> +	u64 fw_handle;
> >> +};
> >=20
> > What is a h_galpa? And why does it need a struct if it's just a u64?
> >=20
>=20
> The eHEA chip is not PCI attached but directly connected to a proprietary
> bus. Currently, we can access it by a simple 64 bit address, but this is =
not
> true in all cases. Having a struct here allows us to encapsulate the chip
> register access and to respond to changes to system hardware.
>=20
> We'll change the name to h_epa meaning "ehea physical address"

Hmm, I'm not convinced. Having the struct doesn't really encapsulate
much, because most of the places where you use the h_galpa struct just
pull out the fw_handle anyway. So if you change the layout of the struct
you're going to have to change most of the code anyway. And in the
meantime it makes the code a lot less readable, most people understand
what "u64 addr" is about, whereas "struct h_galpa" is much less
meaningful. </2c>

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-mGWz1ApQ+VDu554yWbLm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4RBzdSjSd0sB4dIRAh2OAJ94ZbR53XYsEFcsxdnQnDiiiQHn2wCgpDm0
bn0qC6IRF+LwDf/j5Ml119k=
=aD/f
-----END PGP SIGNATURE-----

--=-mGWz1ApQ+VDu554yWbLm--
