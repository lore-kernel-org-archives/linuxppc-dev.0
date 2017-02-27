Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX49H02TpzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 01:39:30 +1100 (AEDT)
Message-ID: <1488204416.2819.9.camel@decadent.org.uk>
Subject: Re: [PATCH] kbuild: avoid unrecognized option error for external DTC
From: Ben Hutchings <ben@decadent.org.uk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Arnd Bergmann
 <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
 linux-c6x-dev@linux-c6x.org,  Michal Simek <monstr@monstr.eu>, Nicolas
 Pitre <nicolas.pitre@linaro.org>, Marcin Nowakowski
 <marcin.nowakowski@imgtec.com>, devicetree@vger.kernel.org, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Michal Marek
 <mmarek@suse.com>, Scott Wood <oss@buserror.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  linuxppc-dev@lists.ozlabs.org, Paul Mackerras
 <paulus@samba.org>,  openrisc@lists.librecores.org, Mark Salter
 <msalter@redhat.com>, Stafford Horne <shorne@gmail.com>, Aurelien Jacquiot
 <a-jacquiot@ti.com>, Jonas Bonn <jonas@southpole.se>, Michael Ellerman
 <mpe@ellerman.id.au>,  linux-kernel@vger.kernel.org, Oliver O'Halloran
 <oohall@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Emese Revfy
 <re.emese@gmail.com>
Date: Mon, 27 Feb 2017 14:06:56 +0000
In-Reply-To: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-34dSXzycV0LBKz+SA5yC"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-34dSXzycV0LBKz+SA5yC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-02-27 at 14:40 +0900, Masahiro Yamada wrote:
> Since commit 6b22b3d1614a ("kbuild: Allow using host dtc instead of
> kernel's copy"), it is possible to use an external dtc.=C2=A0=C2=A0In thi=
s
> case, we do not know which options are supported on it.
>=20
> Commit bc553986a2f7 ("dtc: turn off dtc unit address warnings by
> default") gives -Wno-unit_address_vs_reg, but this options is only
> recognized by v1.4.2 or later.
>=20
> If an older version is specified, the build fails:

But the option to use an external dtc was intended to allow testing of
newer versions.  If there's no reason to use this option to run an
older version, why bother trying to support that?

[...]
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -171,6 +171,20 @@ ld-version =3D $(shell $(LD) --version | $(srctree)/=
scripts/ld-version.sh)
> =C2=A0# Usage:=C2=A0=C2=A0$(call ld-ifversion, -ge, 22252, y)
> =C2=A0ld-ifversion =3D $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) |=
| echo $(4))
> =C2=A0
> +# dtc-option
> +# Usage:=C2=A0=C2=A0DTC_FLAGS +=3D $(call dtc-option,-Wno-unit_address_v=
s_reg)
> +#
> +# When we use the external dtc, check if the desired options are support=
ed.
> +# When we use the kernel's copy (scripts/dtc/dtc), just use the fixed op=
tion.
> +# Until Kbuild descends into the scripts/dtc/ directory, scripts/dtc/dtc=
 may
> +# not exist, i.e. $(call try-run,...) may not work.
> +ifeq ("$(origin DTC)", "command line")
[...]

It could also be specified as an environment variable (assignment with
"?=3D" doesn't override them, but "=3D" does).

Ben.

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.


--=-34dSXzycV0LBKz+SA5yC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAli0MoAACgkQ57/I7JWG
EQnf9xAAsrFofDAMb/8Y7FdR1SB9TyigTo5kslryzW1w9ge3wdkEst3DCrXIuAJg
rYlVL4Rlu+kvW8tQExD345wZKNbVZ1vkaviJfr7mqHP+EHRlyJR3qVlpZMsnSuZm
ZwhaB+J3Nl6jMo7G9nj4+YGa8smPWANwj3svFuuZv+VHSXipsIzYDKjWsjE9F2xs
cX3T2ESaUV7yGKGiMiGyQN7LOMyPawNuKYGxq3g9B8rfS/twEd3CD/uA+99rftsZ
ycwwSIzlulBUKbie9bv/5tZ/Jkt9x8/iF3iun87AJYUSaiwv9S+iUbhQJDx2cpm4
LAC4DXBsQllfEjKQCFaZZ8NnkRM5VYGinNvVy69gv/Q/iXQWaqVFqcrnFw+pW5u9
EUzdz2H4ebhXJM0pi+pUowJKH6e8ySrLAbkY1CqcCJno5IvpUR2YhLJp3Gq/CElZ
D8rlWNaY7NTPddckwLNh1AYZpVF31AIkFDFxSG9A5xTudyPmP1j8gA/MS1DLiH7b
xe5i7qdYeR5noHgc5CqM7SPCqUHSv2rbaCDbdC8oAfSxVK2mGPMcurOcz6rhrf07
Mot8XYtGglXs+VnQFxSX0I+brqw5TDEHPAaa89VuwoFbxaABpGWkRwOpED1mTCSM
sWEe1LEReCMYKF/oQygec5jhf2QhWKMKgXZjo7CVDV+ljYzHm1o=
=UfrQ
-----END PGP SIGNATURE-----

--=-34dSXzycV0LBKz+SA5yC--
