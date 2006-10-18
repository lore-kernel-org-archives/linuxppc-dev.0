Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
From: Michael Ellerman <michael@ellerman.id.au>
To: Luke Browning <LukeBrowning@us.ibm.com>
In-Reply-To: <OF47E899DB.A06D1502-ON83257206.00106CF2-83257206.00122A1D@us.ibm.com>
References: <OF47E899DB.A06D1502-ON83257206.00106CF2-83257206.00122A1D@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yHKkw/F7Gi+uDC2mi9wf"
Date: Wed, 18 Oct 2006 17:14:56 +1000
Message-Id: <1161155697.7906.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yHKkw/F7Gi+uDC2mi9wf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-10-13 at 01:18 -0200, Luke Browning wrote:
>=20
> linuxppc-dev-bounces+lukebrowning=3Dus.ibm.com@ozlabs.org wrote on
> 10/12/2006 09:03:08 AM:
>=20
> > This patch adds support for stopping, and restarting, spus
> > from xmon. We use the spu master runcntl bit to stop execution,
> > this is apparently the "right" way to control spu execution and
> > spufs will be changed in the future to use this bit.
> >=20
> > Testing has shown that to restart execution we have to turn the
> > master runcntl bit on and also rewrite the spu runcntl bit, even
> > if it is already set to 1 (running).
> >=20
> > Stopping spus is triggered by the xmon command 'ss' - "spus stop"
> > perhaps. Restarting them is triggered via 'sr'. Restart doesn't
> > start execution on spus unless they were running prior to being
> > stopped by xmon.
> >=20
> > Walking the spu->full_list in xmon after a panic, would mean
> > corruption of any spu struct would make all the others
> > inaccessible. To avoid this, and also to make the next patch
> > easier, we cache pointers to all spus during boot.
>=20
> The spe affinity code drop created an array of spu pointers that=20
> is indexed by spu->number.  We have a couple of other fields in=20
> there that are needed for multiple spu scheduling operations.  =20
> Maybe, you can use this array.  The name of the arry is lspu[]=20
> for logical spus.=20

I'll have a look at it, but part of the rationale for xmon keeping its
own array is that there should be no code during normal kernel operation
that touches that array, and therefore less chance that a programming
error will corrupt the array.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-yHKkw/F7Gi+uDC2mi9wf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNdRwdSjSd0sB4dIRAo0MAKCBe1lyxRoE33YqrdXUvI2L95FYlQCfa5ws
p+Jab6iYgCfEdY+C/HBU+n4=
=+Iqd
-----END PGP SIGNATURE-----

--=-yHKkw/F7Gi+uDC2mi9wf--
