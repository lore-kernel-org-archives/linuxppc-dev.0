Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 6DFC0DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 22:30:12 +1000 (EST)
Date: Mon, 6 Apr 2009 14:30:01 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Print information about mapping hw irqs to
	virtual irqs
Message-ID: <20090406123001.GA3044@pengutronix.de>
References: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2009 at 12:05:02PM +1000, Michael Ellerman wrote:
> The irq remapping layer seems to cause some confusion when people
> see a different irq number in /proc/interrupts vs the one they
> request in their driver or DTS.
>=20
> So have the irq remapping layer print out a message when we map an
> irq. The message is only printed the first time the irq is mapped,
> and it's KERN_DEBUG so most people won't see it.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

I like the patch in general...

> ---
>  arch/powerpc/kernel/irq.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 5576147..8c1a496 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -672,11 +672,13 @@ unsigned int irq_create_mapping(struct irq_host *ho=
st,
>  			return NO_IRQ;
>  		}
>  	}
> -	pr_debug("irq: -> obtained virq %d\n", virq);
> =20
>  	if (irq_setup_virq(host, virq, hwirq))
>  		return NO_IRQ;
> =20
> +	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n",
> +		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
> +

Are you replacing the pr_debug because you want to drop the
DEBUG-dependency?

>  	return virq;
>  }
>  EXPORT_SYMBOL_GPL(irq_create_mapping);
> --=20
> 1.6.1.2
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknZ9ckACgkQD27XaX1/VRvjrwCbBcnR9VYsq0MoEq+dztVb14ke
lfAAn1mRCXgS3XBHrg9Wb0Zde2WJ4sUF
=KrLE
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
