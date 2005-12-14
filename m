Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C92C86886E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 01:05:34 +1100 (EST)
Received: from dhcp-78-147.uni-paderborn.de ([131.234.78.147]
	helo=[192.168.41.1])
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.54) id 1EmXG5-0005tP-0A
	for linuxppc-dev@ozlabs.org; Wed, 14 Dec 2005 14:05:30 +0000
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sy4SWpULocaFWt7A6Tik"
Date: Wed, 14 Dec 2005 15:05:18 +0100
Message-Id: <1134569118.3875.9.camel@localhost>
Mime-Version: 1.0
Subject: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sy4SWpULocaFWt7A6Tik
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So I run across this warning:=20
[ 2724.595549] Debug: sleeping function called from invalid context at arch=
/ppc/kernel/traps.c:528
[ 2724.595563] in_atomic():0, irqs_disabled():1
[ 2724.595568] Call trace:
[ 2724.595573]  [c001fe54] __might_sleep+0xd4/0xf0
[ 2724.595592]  [c0005ad8] program_check_exception+0xb8/0x520
[ 2724.595606]  [c0004f04] ret_from_except_full+0x0/0x4c

when I wrote a program calling illegal instructions. I then checked out
why this happened and the cause is the might_sleep() here:

#define __get_user_check(x, ptr, size)                                  \
({                                                                      \
        long __gu_err =3D -EFAULT;                                        \
        unsigned long  __gu_val =3D 0;                                    \
        const __typeof__(*(ptr)) __user *__gu_addr =3D (ptr);             \
        might_sleep();                                                  \
...

I then figured I could use __copy_from_user_inatomic to access the
instruction word to fix this (as far as I can tell only the warning is
annoying, because the instruction already failed at that point so it
must be in memory, right?)

But here's the actual question:
static inline unsigned long __copy_from_user(void *to,
                const void __user *from, unsigned long size)
{
        might_sleep();
        return __copy_from_user_inatomic(to, from, size);
}

Does that mean __copy_from_user_inatomic isn't actually valid to call in
atomic context? Or is this only so that kernel developers that use
powerpc see the bugs their code would have on other platforms? The magic
in get_user_asm thoroughly confuses me.

[Somehow I got sidetracked. I only wanted to look at implementing
backtrace support for oprofile...]

johannes

--=-sy4SWpULocaFWt7A6Tik
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ6Aml6Vg1VMiehFYAQKxiw//T+MLEXtKNn17akacLaIDJ6d4zlwBtI7x
MKrwv0sVoOHTp+yaIDenNdH/7HBTSsvShfQqyID+1PtNEqFlEcMMFGOhf468+Ocu
9pJvIfaGrp88qJOvbUIw+WhVkppNUeWshrlI+Frk2kqCJOuthSG9445+b5ag0MT/
ULJF4ACyCQj9ITS5z5YTMR2ibqnZIJCu+wsD6m3H+0E0+nR4EGW8G27Ek9GdQza6
ldISRkflJDEM3q5diRra3hx4jIS79XEB+9BFA8ivkiHXTg7etpt85Rqf6w40kB9Q
qJxzIuDINZ7DN25tf/rV5R0XYaY6gPvEOooUdncWnauuwdrpo8sxLvICjvrPpjRo
vtfYlc1wpn6TUMLSQGtkfbPaXBw6Rez/JdZKFyhS0SHueatA4D2jYcSNNx6bLyvD
PGkBO0lifJtysQGRSZL8LgvOapCkhEM5wuQ/KBLk7SVb0XpM7rrB4hsLA+A4sbWB
t++AvubcxvnhTXPXK3ORDKlSoI6iDGwYUd3Tv8CJwEfgDKhR9vksnQQj7l/vNP2p
6P4Y1sCn6XvFGlvg4ss3NOrAKrcDf1XBPISd75pcXfQqZuxOS0h+H8eizgEgmMVl
l7vYK0J50eb1f9cwOZAjON9IziT0VGFPxPQZmbYQgs8iZZTdCJli8PF3BdbviI5p
G5VC8Ky0HDo=
=Q3gj
-----END PGP SIGNATURE-----

--=-sy4SWpULocaFWt7A6Tik--
