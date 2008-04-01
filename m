Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Michael Ellerman <michael@ellerman.id.au>
To: jyoung5@us.ibm.com
In-Reply-To: <1206987598.9165.10.camel@thinkpadL>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<1206987598.9165.10.camel@thinkpadL>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jLEGGen4Zyl7hVPthDej"
Date: Tue, 01 Apr 2008 12:04:22 +1100
Message-Id: <1207011862.7490.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jLEGGen4Zyl7hVPthDej
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-03-31 at 13:19 -0500, Jerone Young wrote:
> On Mon, 2008-03-31 at 13:05 -0500, Josh Boyer wrote:
> > On Mon, 31 Mar 2008 12:07:17 -0500
> > Josh Boyer <jwboyer@gmail.com> wrote:
> >=20
> > > On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> > > > # HG changeset patch
> > > > # User Jerone Young <jyoung5@us.ibm.com>
> > > > # Date 1206969060 18000
> > > > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f
> > > > # Parent  1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc
> > > > Add idle power save for ppc 4xx
> > > >=20
> > > > This patch sets the wait state MSR when power_save is called in cpu=
_idle loop for ppc4xx. This is mainly to help out virtualization solutions =
such as KVM. This way the virtualization soultions are able to tell if the =
guest kernel is idle.
> > > >=20
> > > > I have tested this on hardware & KVM virtual guest.
> > >=20
> > > I'm not overly thrilled with adding this to all of 4xx.  It doesn't
> > > actually save much power at all (1% on a project that actually measur=
ed
> > > it with an amp meter recently) and there's really no other benefit to
> > > doing it outside of the virtual guest case.
> > >=20
> > > I'm assuming you pass a dtb to the virtual guest when you start it up=
.
> > > Could you define a property in the CPU node there that can be parsed =
to
> > > use the power_save function instead of always making it the default?
> >=20
> > Actually, you probably don't want this as a property in the device
> > tree.  It doesn't describe hardware.  A Kconfig option might be
> > warranted though.
>=20
> I'll go with the Kconfig option.=20

Go with a device-tree check. The pseries kernel supports both bare-metal
and hypervisor in the same kernel image, and it works out which it's
running on by looking at the device-tree. This seems equivalent to me?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jLEGGen4Zyl7hVPthDej
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH8YoWdSjSd0sB4dIRAsgZAJ0QyQ8ncxrb04jJMLutOrffcwhqnwCgwq7A
yBoPtKUy6hRl9fSu3uGyrHo=
=9omu
-----END PGP SIGNATURE-----

--=-jLEGGen4Zyl7hVPthDej--
