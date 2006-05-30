Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F077A67A79
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 19:12:45 +1000 (EST)
Subject: pmf_register_irq_client gives sleep with locks held warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mBwZKgt7makVm2aK0Rxp"
Date: Tue, 30 May 2006 22:19:00 +0200
Message-Id: <1149020341.5128.7.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mBwZKgt7makVm2aK0Rxp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

When testing headphone detection stuff I got this:

[  634.218762] BUG: sleeping function called from invalid context at mm/sla=
b.c:2794
[  634.218774] in_atomic():0, irqs_disabled():1
[  634.218777] Call Trace:
[  634.218779] [D67ADC00] [C00085F8] show_stack+0x50/0x190 (unreliable)
[  634.218794] [D67ADC30] [C0024030] __might_sleep+0xcc/0xe8
[  634.218804] [D67ADC40] [C0076C04] __kmalloc+0xf4/0xf8
[  634.218815] [D67ADC60] [C00B37D4] proc_create+0x9c/0xe8
[  634.218827] [D67ADC90] [C00B3930] proc_mkdir_mode+0x2c/0x88
[  634.218833] [D67ADCB0] [C005227C] register_handler_proc+0xe4/0xfc
[  634.218844] [D67ADD50] [C0051D70] setup_irq+0x118/0x16c
[  634.218850] [D67ADD70] [C0051E68] request_irq+0xa4/0xb8
[  634.218855] [D67ADDA0] [C0020BA0] macio_do_gpio_irq_enable+0x40/0x50
[  634.218860] [D67ADDB0] [C00208BC] pmf_register_irq_client+0x88/0x9c
[..., not important]

The problem obviously is that request_irq via setup_irq and ... may
sleep via kmalloc, while pmf_register_irq_client spin_lock_irqsave()s
around the call.

The solution is probably to use spin_lock() instead of
spin_lock_irqsave() here.

Comments?

johannes

--=-mBwZKgt7makVm2aK0Rxp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHyosqVg1VMiehFYAQKpfw//cNoYNwLVgC6PFnHS8v0Z2RjfHBBrJ8pL
JXzsT1ddiAIuPaIwiuoFOl5K57zFSFDldqsH3MwuIC/NZ3k0aMjT8r46mTn8GdVi
2VhiBIbDwlfHK9UL8NoQHHlwvD6R6WUxWUh0VuZUUa8S63g+feNwKcziVMK7/uq9
7rTEcPZgXP2SHnERQkM8kPVK5DLgNtHVlxK7rkLJLq8Uk0U9DP/ifJQ9ZSzca+ow
MXzaWC8LI9+MPVFfl0hkeqBxi+UXLL0sNLVnNER2y3v/5xRevtYCPiCSmtV9pDzx
KsmzcwXZtmkM2UqEZjNN3pXEf5bNTFZvroCAAIG+G7Iab3X8hvekwQDTrsTYEZ68
UYZ1YFHNYTorRON34Y3/kwAs4BYZZHVJd+oaiBUWvl/iSaPCk/HZ1+sDxDSzaBjA
WSJ43jcV3rRHY4LIqvpnSRza8z0yRPV5nlWLmDiMqzyH5zQh2Pz3vIiEpoOCaFNT
sTqrIRtKYun17AkUTLGlE65j1bec/80p97hWp40prKWcYSSrb5nrfZ1KEKcw5wFF
DmhZCA0J4iWngB97J3mLnmxEnfuAfe93jxqziF19W14VcfhgW+lxuToa9Vgevr+S
AJ1AlOWLz7RKNKKS0BHhQk167pXcRfDAOVrgnWR69mqn1MU4R48PTyz5VbAkevP9
Fhop49GG7as=
=oI4e
-----END PGP SIGNATURE-----

--=-mBwZKgt7makVm2aK0Rxp--
