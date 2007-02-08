Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45C9FE30.8010108@freescale.com>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net>	<45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<45C91275.4020806@freescale.com> <45C97121.9080609@austin.ibm.com>
	<45C9FE30.8010108@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/5fVKq+0CC4kpKHEd0EO"
Date: Thu, 08 Feb 2007 11:31:46 +1100
Message-Id: <1170894706.4656.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/5fVKq+0CC4kpKHEd0EO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-07 at 10:28 -0600, Timur Tabi wrote:
> Mike Strosaker wrote:
>=20
> > The op panel on recent systems has 2 lines; the first can display 16=20
> > characters, the second, 80.  The first line is usually used to display=20
> > an 8 character hexadecimal progress/error message (called an SRC: Syste=
m=20
> > Reference Code), and the second line is used to display a location code=
=20
> > when appropriate (e.g. when the SRC indicates a device failure).  IBM=20
> > documents many of their OF and RTAS SRCs deep in the Hardware=20
> > Information Center:
>=20
> In that case, the big question is: does the kernel conform to this standa=
rd?=20
> Looking at the current usage of ppc_md.progress(), I can't help but think=
 that=20
> it being called the same way printk() is being called, i.e. at the whim o=
f the=20
> developer who wrote the code.
>=20
> So let's say that we need to keep ppc_md.progress().  I think we should h=
ave=20
> some way of restricting its usage to systems where it does something diff=
erent=20
> than printk().  On an Freescale 83xx reference board, for example, its ou=
tput=20
> goes to the same place as printk(), so it doesn't serve any purpose.
>=20
> Perhaps we should define ppc_md.progress() such that it never sends the o=
utput=20
> to the same place as printk().  If the only output device is the serial p=
ort,=20
> and printk() already outputs there, then ppc_md.progress() should do noth=
ing.=20
> This would eliminate any "accidental" use of ppc_md.progress(), when prin=
tk() is=20
> the better choice.

But then you'll end up with code that does:

 printk("Setup done");
 ppc_md.progress("Setup done");

Because on systems where the output _does_ go to two places, you'll want
the messages to appear in both.

I don't see what the problem is with progress messages going to the
printk buffer?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/5fVKq+0CC4kpKHEd0EO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFym9xdSjSd0sB4dIRAokLAKCDAwRQBDR4ws6+8dsyto5rOgD8TwCgjAg0
rFg4/zq/PcPOxRXeD2Jmw0Y=
=ow5K
-----END PGP SIGNATURE-----

--=-/5fVKq+0CC4kpKHEd0EO--
