Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1178094317.13233.42.camel@johannes.berg>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1178082143.5296.9.camel@concordia.ozlabs.ibm.com>
	<1178094317.13233.42.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Ut6Y+RdHXseKGUIzhbV7"
Date: Wed, 02 May 2007 21:06:35 +1000
Message-Id: <1178103995.14649.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Ut6Y+RdHXseKGUIzhbV7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 10:25 +0200, Johannes Berg wrote:
> On Wed, 2007-05-02 at 15:02 +1000, Michael Ellerman wrote:
>=20
> > This seems to break prep_defconfig:
> >=20
> > timer.c:(.text+0x28c): undefined reference to `rtc_tm_to_time'
> > timer.c:(.text+0x38c): undefined reference to `rtc_tm_to_time'
> > make[1]: *** [.tmp_vmlinux1] Error 1
>=20
> Odd. I put this into Kconfig:
> config PPC_PM_NEEDS_RTC_LIB
>         bool
>         select RTC_LIB
>         default y if PM
>=20
> and that should cause the rtc lib that contains the rtc_tm_to_time
> function to be compiled in if you have PM enabled (and otherwise timer.c
> isn't compiled). Or maybe defconfig doesn't invoke oldconfig?

Ah sorry, I didn't mention prep_defconfig is arch/__ppc__.=20

See arch/ppc/Makefile:

core-y                          +=3D arch/ppc/kernel/ arch/powerpc/kernel/ =
\
                                   arch/ppc/platforms/ \
                                   arch/ppc/mm/ arch/ppc/lib/ \
                                   arch/ppc/syslib/ arch/powerpc/sysdev/ \
                                   arch/powerpc/lib/


So I guess we need to add the Kconfig fragment on arch/ppc also?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Ut6Y+RdHXseKGUIzhbV7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBGOHC7dSjSd0sB4dIRAt/QAKCXXHhCOSqvVtwDvjlyk+xEblYP5QCYqyqH
7t3rMbe3rFl3A2kG+2Rlig==
=eqoB
-----END PGP SIGNATURE-----

--=-Ut6Y+RdHXseKGUIzhbV7--
