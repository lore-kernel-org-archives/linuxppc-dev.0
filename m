Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 747DEDE271
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:27:14 +1000 (EST)
Date: Wed, 17 Oct 2007 01:27:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
Message-Id: <20071017012706.adbd3188.sfr@canb.auug.org.au>
In-Reply-To: <200710162320.00630.fenkes@de.ibm.com>
References: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD39C@de.ibm.com>
	<200710162320.00630.fenkes@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Oct_2007_01_27_06_+1000_0XWMKq/49uR6BW_i"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Mackerras <pmac@au1.ibm.com>, netdev@vger.kernel.org,
	Jan-Bernd Themann <THEMANN@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <meder@de.ibm.com>, Paul,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Oct_2007_01_27_06_+1000_0XWMKq/49uR6BW_i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Oct 2007 23:20:00 +0200 Joachim Fenkes <fenkes@de.ibm.com> wrote:
>

One small change - I intend to remove the name and owner fields from
struct of_platform_driver, so you should not bother initialising the name
field and just initialise the name field of the embedded struct
device_driver instead.  This, of course, means that you don't need

	drv->driver.name =3D drv->name;

in ibmebus_register_driver.

Sorry for not picking this up earlier.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Oct_2007_01_27_06_+1000_0XWMKq/49uR6BW_i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFNhQTgG2atn1QN8RAg8JAJwNZcBRPjzYHy6ZFr4zTdD6xzbG+wCfbyFu
FwuA+pG1SWXaVdvQZKza554=
=sWnd
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Oct_2007_01_27_06_+1000_0XWMKq/49uR6BW_i--
