Return-Path: <silvio.fricke@googlemail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.237])
	by ozlabs.org (Postfix) with ESMTP id 0CA20DDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 22:42:01 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so575296hud
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:41:59 -0700 (PDT)
Date: Tue, 11 Sep 2007 14:41:54 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
Message-ID: <20070911124154.GI11807@sfrouter>
References: <20070906133050.GE11807@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
In-Reply-To: <20070906133050.GE11807@sfrouter>
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


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Dear Linux-enthusiasts,

I'm still at the same problem.

I have now implemented a irq_chip for the hardwired IRQ2. Now I have:


--=3D=3D>
volatile static struct mpc52xx_intr __iomem *intr;
unsigned long flags;
static DEFINE_SPINLOCK(my_irq_controller_lock);

/*
 * HELPER-Function
 */
static inline void io_be_setbit(u32 __iomem *addr, int bitno)
{
    out_be32(addr, in_be32(addr) | (1 << bitno));
}

static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
{
    out_be32(addr, in_be32(addr) & ~(1 << bitno));
}

/*
 * IRQ-Zeugs
 */
static void my_irq_ack(unsigned int irq)
{
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
    spin_lock_irqsave(&my_irq_controller_lock, flags);
    if(intr)
        io_be_setbit(&intr->ctrl, 25);
    spin_unlock_irqrestore(&my_irq_controller_lock, flags);
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
}

/* irq - disabled */
static void my_irq_mask(unsigned int irq)
{
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
    spin_lock_irqsave(&my_irq_controller_lock, flags);
    if(intr)
        io_be_clrbit(&intr->ctrl, 9);=20
    spin_unlock_irqrestore(&my_irq_controller_lock, flags);
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
}

/* irq - enable */
static void my_irq_unmask(unsigned int irq)
{
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
    spin_lock_irqsave(&my_irq_controller_lock, flags);
    if(intr)
        io_be_setbit(&intr->ctrl, 9);
    spin_unlock_irqrestore(&my_irq_controller_lock, flags);
    printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
}

static struct irq_chip my_irq_chip =3D {=20
    .typename   =3D "MY_IRQ_TEST",
    .ack        =3D my_irq_ack,
    .mask       =3D my_irq_mask,
    .unmask     =3D my_irq_unmask,
};

static int __init mod_init( void )
{
    // ...

    intr =3D mpc52xx_find_and_map("mpc52xx-pic");
    if(!intr) {
        panic(__FILE__ ": mpc52xx-pic - MAP failed");
    }

    set_irq_chip(MPC52xx_IRQ2, &my_irq_chip);
    a =3D request_irq(2, intmod_isr, IRQF_DISABLED , "intmod", INTMOD_IRQ_B=
OARD);
    printk("a: 0x%08x\n", a);

    // ...
}

<=3D=3D--

Now my code hangs on the my_irq_unmask(...)-function on "io_be_setbit". Why?
Can anyone help me, or point me to the right newsgroup/forum?

So long!

Silvio


--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG5o0S8WEBxatmn40RAiQXAKDJPbsunhqNyBT8QMPpeWMnbD1dgQCggTiI
KumN9+FDiOuUGOKapGmeOaE=
=c+Ar
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
