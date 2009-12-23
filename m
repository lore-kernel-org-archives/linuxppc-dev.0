Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Make cpu hotplug driver lock part of ppc_md
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4B322DD6.60801@austin.ibm.com>
References: <4B30DB8B.3030305@austin.ibm.com>
	<1261520982.17348.8.camel@concordia>  <4B322DD6.60801@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-n436c/xKWhFSNrOVFsBf"
Date: Thu, 24 Dec 2009 09:29:11 +1100
Message-ID: <1261607351.3401.11.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-n436c/xKWhFSNrOVFsBf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-12-23 at 08:48 -0600, Nathan Fontenot wrote:
> Michael Ellerman wrote:
> > On Tue, 2009-12-22 at 08:45 -0600, Nathan Fontenot wrote:
> >> The recently introduced cpu_hotplug_driver_lock used to serialize
> >> cpu hotplug operations, namely for the pseries platform, causes a buil=
d
> >> issue for other platforms.  The base cpu hotplug code attempts
> >> to take this lock, but it may not be needed for all platforms.  This p=
atch
> >> moves the lock/unlock routines to be part of the ppc_md structure
> >> so that platforms needing the lock can take it.  This also makes the
> >> previous cpu_hotplug_driver_lock, defined in pseries code, pseries spe=
cific.
> >>
> >> The past failure without this patch was seen when building pmac and ma=
y
> >> be present in other platform builds.  The error is included below for =
reference.
> >>
> >> drivers/built-in.o: In function `.store_online':
> >> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_l=
ock'
> >> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_u=
nlock'
> >> make: *** [.tmp_vmlinux1] Error 1
> >=20
> > Why does the pmac code /not/ need a lock? And would it be harmless if i=
t
> > was locked too?
>=20
> The intention of the cpu_hotplug_driver_locks to add additional serializa=
tion
> during cpu hotplug operations.  For pseries this is used during DLPAR of =
cpu
> operations so that cpu hotplug actions cannot be initiated whiloe a DLPAR
> operation is in flight.  For example, during DLPAR add we take the lock w=
hile
> acquiring the cpu from firmware and updating the device tree with the new
> cpu information, after which we hotplug add the cpu to the system. =20

Right.

> There is nothing harmless about taking the lock on all platforms, I was j=
ust
> trying to avoid taking the lock if the additional serialization is not ne=
eded.

"nothing harmless" :)

But I think I know what you mean.

> >=20
> > If so, you could just make the mutex available to all powerpc code, and
> > rename it, and then we wouldn't need all this jiggery pokery just to
> > take & release a lock.
>=20
> I can make the lock available to all powerpc code and not go through the
> ppc_md struct, it makes no difference to me personally.  Of course this w=
ould
> make all that fun pokery jiggery go away :)

I think that would be a nicer result. Sure it adds an extra lock/unlock
on other platforms, but I think that's thoroughly insignificant compared
to a cpu hotplug.

Of course Ben might disagree with me ;)

cheers


--=-n436c/xKWhFSNrOVFsBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksymbMACgkQdSjSd0sB4dI+4gCfXjLmDTQnw0PTqs8nKWGznJN3
+PEAn1EHhhZA9imRm0mRfNLTKRVJOFff
=eiUd
-----END PGP SIGNATURE-----

--=-n436c/xKWhFSNrOVFsBf--
