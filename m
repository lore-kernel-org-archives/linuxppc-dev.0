Return-Path: <silvio.fricke@googlemail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.238])
	by ozlabs.org (Postfix) with ESMTP id 2D094DDE36
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 04:28:16 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so638197hud
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 11:28:15 -0700 (PDT)
Date: Tue, 11 Sep 2007 20:28:11 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
Message-ID: <20070911182811.GA3582@sfrouter>
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> >[...]
> >     intr =3D mpc52xx_find_and_map("mpc52xx-pic");
> >     if(!intr) {
> >         panic(__FILE__ ": mpc52xx-pic - MAP failed");
> >     }
> >
> >     set_irq_chip(MPC52xx_IRQ2, &my_irq_chip);
>=20
> You probably don't want to do this (unless you are cascading IRQs to
> custom external hardware).  All you should need is the call to
> request_irq() to register your irq handler, and code in your ISR
> handler to clear the interrupt condition.
>=20
> You do *NOT* want to program the interrupt controller directly.  The
> mpc5200 interrupt controller already has a driver.  Don't go twiddling
> the registers manually.

OK!

I have tried it before and i get a "-ENOSYS" returned.

My code was/is now:
--=3D=3D>
request_irq(MPC52xx_IRQ2, intmod_isr, IRQF_DISABLED , "intmod",
            INTMOD_IRQ_BOARD);
<=3D=3D--

I have looked up "kernel/irq/manage.c". "-ENOSYS" is returned on function
"setup_irq" because the used irq(MPC52xx_IRQ2) is the same as no_irq_chip.

THE MPC52xx_IRQ2 is a excerpt from "include/ppc/mpc52xx.h" (per copy
paste), but mpc52xx is (now) a powerpc-arch. What is the desired value for
IRQ-2 on a mpc5200b?

best regards,
Silvio Fricke


--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG5t478WEBxatmn40RAqKZAKDQw1uf/baN8LFYWnjf2em4RNUdAwCfQnXq
nzRmNfQgPpju4p9HpIN60b8=
=Pe2U
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
