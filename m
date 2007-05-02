Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFAB4DDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:24:40 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Johannes Berg <johannes@sipsolutions.net>
To: michael@ellerman.id.au
In-Reply-To: <1178082143.5296.9.camel@concordia.ozlabs.ibm.com>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1178082143.5296.9.camel@concordia.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5GX61+25rL9ddDHt+DQu"
Date: Wed, 02 May 2007 10:25:17 +0200
Message-Id: <1178094317.13233.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5GX61+25rL9ddDHt+DQu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 15:02 +1000, Michael Ellerman wrote:

> This seems to break prep_defconfig:
>=20
> timer.c:(.text+0x28c): undefined reference to `rtc_tm_to_time'
> timer.c:(.text+0x38c): undefined reference to `rtc_tm_to_time'
> make[1]: *** [.tmp_vmlinux1] Error 1

Odd. I put this into Kconfig:
config PPC_PM_NEEDS_RTC_LIB
        bool
        select RTC_LIB
        default y if PM

and that should cause the rtc lib that contains the rtc_tm_to_time
function to be compiled in if you have PM enabled (and otherwise timer.c
isn't compiled). Or maybe defconfig doesn't invoke oldconfig?

johannes

--=-5GX61+25rL9ddDHt+DQu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOErt/ETPhpq3jKURApr2AKCDoNII/OmI/ICQLI+gLFp3pdi/TQCdHZzK
f9IlGAjmO2Ao50HuhqqjVB0=
=4+uG
-----END PGP SIGNATURE-----

--=-5GX61+25rL9ddDHt+DQu--
