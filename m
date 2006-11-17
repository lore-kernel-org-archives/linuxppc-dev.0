Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20061117033638.0E24B67BCE@ozlabs.org>
References: <20061117033638.0E24B67BCE@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Mc78ILGUX++JPyCjfICF"
Date: Fri, 17 Nov 2006 14:59:47 +1100
Message-Id: <1163735987.16815.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: srinivasa@in.ibm.com, ntl@pobox.com, Anton Blanchard <anton@samba.org>,
	paulus@samba.org, ego@in.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Mc78ILGUX++JPyCjfICF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-17 at 14:36 +1100, Michael Ellerman wrote:
> The pseries cpu hotplug code is currently spread between ./kernel/rtas.c,
> ./platforms/pseries/smp.c and ./platforms/pseries/setup.c. Some of it is
> not #ifdef CONFIG_HOTPLUG_CPU, but it should be.
>=20
> So move all the cpu hotplug code into platforms/pseries/hotplug-cpu.c
> While we're moving, rename studly caps functions to normal caps, they're
> all static so no harm done. Fixup some long lines also, and make things
> static that can be, now we're all in the same file.
>=20
> Currently we unconditionally hookup pSeries_mach_cpu_die to ppc_md.cpu_di=
e,
> even if we don't have CONFIG_HOTPLUG_CPU enabled. This is wrong, as it
> signals the sysfs code to create the online attribute for cpu nodes,
> allowing the user to attempt an offline when it's not actually supported.
>=20
> There is also a problem on systems that don't have the correct RTAS token=
s
> available to do RTAS-based cpu hotplug, we still indicate via sysfs that
> we support cpu hotplug - and then attempt to do so with missing RTAS toke=
ns.
>=20
> Both problems are solved by conditionally registering the cpu hotplug
> callbacks, only when CONFIG_HOTPLUG_CPU is enabled, and only after we've
> found the requisite RTAS tokens.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>=20
> OK, what do people think of this? I think it solves the problems we've
> seen lately. This supersedes Linas patch to wrap the pSeries bits in
> CONFIG_HOTPLUG_CPU.
>=20
> I haven't tested this - if someone can that'd be great - otherwise I'll
> have a go on Monday.

I should add .. The callbacks now get setup in an arch_initcall() - this
is not as early, by a long shot, as it used to be - however AFAICT it
should make no difference as there's no way to trigger a cpu hotplug
until later on anyway.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Mc78ILGUX++JPyCjfICF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXTOzdSjSd0sB4dIRAorxAJ4474sKUIZ/kpfdfjQT+9PeqPprhwCeM8oq
OolWd158HjW8i2iXvLeJSLw=
=RkB4
-----END PGP SIGNATURE-----

--=-Mc78ILGUX++JPyCjfICF--
