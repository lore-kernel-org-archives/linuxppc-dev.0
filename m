Return-Path: <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc	device tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Horms <horms@verge.net.au>
In-Reply-To: <20060921025122.GA8573@verge.net.au>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1RspvDSG/mDCToszD8fn"
Date: Thu, 21 Sep 2006 13:40:33 +1000
Message-Id: <1158810033.7062.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1RspvDSG/mDCToszD8fn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 11:51 +0900, Horms wrote:
> On Thu, Sep 21, 2006 at 11:59:04AM +1000, Michael Ellerman wrote:
> > On Thu, 2006-09-21 at 11:10 +1000, Michael Neuling wrote:
> > > This code no longer needed with Jimi's auto reserve of device tree bl=
ob
> > > kernel patch now in 2.6.18.   =20
> > >=20
> > > This patch will break Linux if you're kexecing to a kernel which does=
n't
> > > have this patch (ie. earlier than 2.6.17).  Required kernel patch is
> > > this one:  =20
> > > http://git.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommit;h=3D4d1f3f25d9c303d1ce63b42cc94c54ac0ab2e950
> > >=20
> >=20
> > Although it'd be nice to get rid of that code, I'm not sure we want to
> > go breaking this. This will mean RHEL5 and SLES10 users can't use
> > upstream kexec-tools :/
>=20
> Surely if they are using a RHEL5 or SLES10 kernel then its
> reasonably to expect they are also using a RHEL5 or SLES10 supplied
> kexec-tool.

Or Ubuntu Dapper .. Debian Stable .. FC whatever. In general they'll be
using the distro tools sure, but I'd rather not force them to. I
generally expect to be able to run mainline kernels without upgrading my
entire distro - it should cut both ways IMHO.

> I guess it all comes down to backwards compatibility.
> And IMHO thats a hard thing to maintain with something
> as green as kexec.
>=20
> I'm in favour of the patch, though I'm prepared to be convinced otherwise=
.

Sure it's hard, but we can at least try. If we put this patch in we'll
be breaking backward compatibility simply in order to beautify the
kexec-tools code a little.

> If the code needs to stay, perhaps this patch could be modified
> so that the code in question is only executed if the kernel
> is pre 2.6.18. Or is that just overly complex?

There's no need, it simply means the blob is reserved twice, which is
pretty harmless.

I think the best option is just to add a note somewhere in the kexec
sources that we can remove that code sometime in the future.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1RspvDSG/mDCToszD8fn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFEgmxdSjSd0sB4dIRAh6iAJ9Yju4vFu4ko4OOIhO2DbLklu+aXACfbRz/
2u7QKlN9PNHHR53dYkUMcSI=
=GS37
-----END PGP SIGNATURE-----

--=-1RspvDSG/mDCToszD8fn--
