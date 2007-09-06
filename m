Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 7BB00DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:31:01 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id h3so157425nfh
	for <linuxppc-dev@ozlabs.org>; Thu, 06 Sep 2007 06:31:00 -0700 (PDT)
Date: Thu, 6 Sep 2007 15:30:51 +0200
To: linuxppc-dev@ozlabs.org
Subject: [NEWBIE] Interrupt-problem mpc5200
Message-ID: <20070906133050.GE11807@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FEz7ebHBGB6b2e8X
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

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG4AEK8WEBxatmn40RAp0bAJ4/fGuAjoR2xFE0S0U9f/ibt8s5egCfUPvJ
OBnLpB7m9BejdIgFH5dfd3Y=
=EEle
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
