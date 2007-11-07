Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA115DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 02:04:36 +1100 (EST)
Subject: Re: [PATCH 4/3] Make swsusp_32.S usable for suspend-to-RAM.
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070905220846.GA11400@ld0162-tx32.am.freescale.net>
References: <20070905220846.GA11400@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uCxdasW+FQzbYWf5zI6C"
Date: Wed, 07 Nov 2007 13:25:45 +0100
Message-Id: <1194438345.4470.4.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uCxdasW+FQzbYWf5zI6C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +config PPC32_SUSPEND

> +config PPC32_SWSUSP

> -obj32-$(CONFIG_HIBERNATION) +=3D swsusp_32.o
> +obj32-$(CONFIG_PPC32_SUSPEND)	+=3D swsusp_32.o

I think that's overkill, couldn't it just use CONFIG_PM_SLEEP here? I'm
not sure that was available at the time you posted this patchset though,
so that may well be the reason you didn't use it.

For reference, kernel/power/Kconfig has:

config PM_SLEEP
        bool  =20
        depends on SUSPEND || HIBERNATION
        default y


johannes

--=-uCxdasW+FQzbYWf5zI6C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzGuyKVg1VMiehFYAQLYyBAAkIJ85V/JkmeMm+Al5aTsc7kpIl+JX4ss
XUQMco2Edma0g8lSzviWUfSBJ+GbYonTgcaBND8hx31vd7P5VaGgzlyvVd7EB4EM
ar3rb+AaEdkZagMg5EQV1vKwq4Lqa2/odaesNByB8dThERSFKZtE20B0D5kvC3Hb
19fjCg9J4DzvEtT21BKKBsJ2dxieNA+ZdJtiSw/uLgOXP6SWgJaL5a9LQIVry9hG
YQsTZ74hR0KjqHV6uJfIYL8J1bM8Q00pxuZDBOBslZoIeT52FnLRpVcUT5FGaUBy
j3WMQ7QYQ7cmEoInq3YBJmCjuVlhL3/xqhNIGoFjkfrev9SJXeca9VKrMpyFkyg2
SalmlM/veatfsBminf9O+eyPZ1S/MDbf8jhGujBUQgSD0+7u5iTx8dTP4HLl3fpd
e6p7V0DHfTUVoYHN6MQ0rRJX6RT9bfJlFX2mk6CrJl8h2MT6O/afA4mK8EgY7gTx
dfnzD5yCR/tOHHzJBsvuzHZ90b5ZKxZB8xskxu4KkkG20JVqOJW8g0+is/lelabW
OuNut33lJolq4HUav2wKXAG9n1CMjcjrE+4n8M9amzBxOzen3oaApejy08uPtS1v
JVAN/0hXGB2ISFTJw1BwE6nKlNROQ8gmNYcK9GySnd8dehB17eZuOJ0NPAMmvG2E
LRz/vWoywew=
=RWIY
-----END PGP SIGNATURE-----

--=-uCxdasW+FQzbYWf5zI6C--
