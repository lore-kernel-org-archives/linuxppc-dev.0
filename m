Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 1778ADDDB6
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 22:33:23 +1000 (EST)
Date: Thu, 28 May 2009 14:33:11 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
Message-ID: <20090528123311.GA3112@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <4A1E6877.2060106@aimvalley.nl>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> this is an example of how a simple 8313 Periodic Interval Timer (PIT) ker=
nel driver
> registers for the PIT IRQ (Interrupt ID 65)
>
> #define PIT_IRQ 65
>
>     virq =3D irq_create_mapping(NULL, PIT_IRQ);
>     set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
>
>     if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (void *)=
0)) {
>         printk(KERN_ERR "request_irq() returned error for irq=3D%d virq=
=3D%d\n", PIT_IRQ, virq);
>     }

It is some time ago, but when I did something similar I needed the
following patch in order to use NULL for irq_create_mapping(). Have a
try, and if it is still needed (as it looks from a glimpse), then maybe
we should get it merged?

=3D=3D=3D

=46rom: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] powerpc/cpm2: make cpm2_pic the default host

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/sysdev/cpm2_pic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..7a7d4e5 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -272,4 +272,5 @@ void cpm2_pic_init(struct device_node *node)
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
 	}
+	irq_set_default_host(cpm2_pic_host);
 }

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoehIYACgkQD27XaX1/VRsAygCePysW72eSPbW0rdM5DZ6lJS+7
lEwAoItsU+K2CO9Eqfrwj64TgwEskB85
=+3mh
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
