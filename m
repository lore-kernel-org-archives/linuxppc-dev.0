Return-Path: <silvio.fricke@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id 80029DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 17:16:49 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so139879mue
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:16:48 -0700 (PDT)
Date: Wed, 19 Sep 2007 09:16:43 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
Message-ID: <20070919071643.GE5682@sfrouter>
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
	<20070912183038.GA5682@sfrouter>
	<fa686aa40709121229h6bb2902etffcd197e2e5af722@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
In-Reply-To: <fa686aa40709121229h6bb2902etffcd197e2e5af722@mail.gmail.com>
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


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > Can u give me an example with a single IRQ of a configuration-node for a
> > dts?
>=20
> myreallycooldevice@0 {
>         interrupts =3D <1 2 3>;
>         interrupt-parent =3D <&mpc5200_pic>;
> };

Ahh - oh weh - so simple! Thank you!

> The interrupts property matches the size of the #interrupt-cells
> property in the interrupt controller node.  For the 5200-intc, each
> interrupt is described by 3 cells; l1, l2 and sense which is a
> reflection of the interrupt controller architecture.  For IRQ0, l1=3D0,
> l2=3D0; IRQ1, l1=3D1, l2=3D1; IRQ2, l1=3D1 and l2=3D2; IRQ3, l1=3D1, l2=
=3D3 Sense is
> described in mpc52xx-device-tree-bindings.txt

OK, my dts is now:

    / {
        /* ... */
        soc5200@f0000000 {
            /* ... */
            intpin@0 {
                interrupt-parent =3D <500>;
                interrupts =3D <1 2 2>;
            };
            /* ... */
        };
        /* ... */
    };

And the corresponding code is:

struct intmod_priv {
    /** Interrupt-Number */
    int own_irq;

    /** The of-device-node */
    struct device_node *intmod_dev_node;
};

static int __init mod_init( void )
{
    // ...
    priv.intmod_dev_node =3D NULL;
    priv.intmod_dev_node =3D of_find_node_by_name(NULL, "intpin");

    priv.own_irq =3D irq_of_parse_and_map(priv.intmod_dev_node, 0);
    request_irq(priv.own_irq, intmod_isr, IRQF_DISABLED , "intmod", INTMOD_=
IRQ_BOARD);
    // ...


Thank you and bye, my next question is following :-)

Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8Mzb8WEBxatmn40RApMyAKCw8WbTUAJz2vpV2B0xApANmNzUfACfZd16
+5xsTF1qKP9faB1VOgtkgEw=
=J1WD
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
