Return-Path: <silvio.fricke@googlemail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.236])
	by ozlabs.org (Postfix) with ESMTP id A526DDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 19:03:15 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so376494hud
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 02:03:13 -0700 (PDT)
Date: Mon, 10 Sep 2007 11:03:05 +0200
To: linuxppc-embedded@ozlabs.org
Subject: Interrupt-problem mpc5200
Message-ID: <20070910090305.GG11807@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all.

What are the steps to configure an MPC500B-Board to react on an IRQ (2)?

I have written a test-driver with this code-snippets, but the prozessor
hangs when loading the driver.

my __init-function looks like:

static int __init mod_init( void )=20
{
    volatile static struct mpc52xx_intr __iomem *intr;
    u32 intr_ctrl;

    // ...

    printk( "intmod.ko: interrupt init ");
    if (request_irq(MPC52xx_IRQ2, intmod_isr, IRQF_SHARED , "intmod",
                INTMOD_IRQ_BOARD) =3D=3D -EBUSY)
        printk("KO\n");
    else
        printk("OK\n");

    intr =3D ioremap(MPC52xx_MBAR+MPC52xx_INTR_OFFSET, MPC52xx_INTR_SIZE);

    // read - modify - write
    intr_ctrl =3D in_be32(&intr->ctrl);
    intr_ctrl &=3D 0xfff3ffff;
    intr_ctrl |=3D 0x00080200;
    out_be32(&intr->ctrl, intr_ctrl);       // ERROR!

    if(intr) iounmap(intr);

    // ...
}

On the Line, marked with "ERROR!" the prozessor hangs and the kernel drops
out.

TIA: Silvio


Mit freundlichen Gruessen
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG5QhJ8WEBxatmn40RAnGKAKDDtcPFaDbIROqOOdimcaRpfKUvLwCeJkR6
tuhGrnt83hz+fvWSyMO19ao=
=9nZv
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
