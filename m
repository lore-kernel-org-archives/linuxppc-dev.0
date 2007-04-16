Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [2/4] pasemi_mac: irq mapping changes
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070416061818.GD19783@lixom.net>
References: <20070416061654.GB19783@lixom.net>
	<20070416061818.GD19783@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+25/y3tYHy3RjYi/K/3H"
Date: Mon, 16 Apr 2007 16:32:14 +1000
Message-Id: <1176705134.4728.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+25/y3tYHy3RjYi/K/3H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-16 at 01:18 -0500, Olof Johansson wrote:
> Fixes for ethernet IRQ mapping, to move it to the driver instead of in
> the platform setup code.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> Index: powerpc/arch/powerpc/platforms/pasemi/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.orig/arch/powerpc/platforms/pasemi/pci.c
> +++ powerpc/arch/powerpc/platforms/pasemi/pci.c
> @@ -163,19 +163,6 @@ static void __init pas_fixup_phb_resourc
>  }
> =20
>=20
> -void __devinit pas_pci_irq_fixup(struct pci_dev *dev)
> -{
> -	/* DMA is special, 84 interrupts (128 -> 211), all but 128
> -	 * need to be mapped by hand here.
> -	 */
> -	if (dev->vendor =3D=3D 0x1959 && dev->device =3D=3D 0xa007) {
> -		int i;
> -		for (i =3D 129; i < 212; i++)
> -			irq_create_mapping(NULL, i);
> -	}
> -}
> -
> -
>  void __init pas_pci_init(void)
>  {
>  	struct device_node *np, *root;
> Index: powerpc/arch/powerpc/platforms/pasemi/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.orig/arch/powerpc/platforms/pasemi/setup.c
> +++ powerpc/arch/powerpc/platforms/pasemi/setup.c
> @@ -240,5 +240,4 @@ define_machine(pas) {
>  	.check_legacy_ioport    =3D pas_check_legacy_ioport,
>  	.progress		=3D pas_progress,
>  	.machine_check_exception =3D pas_machine_check_handler,
> -	.pci_irq_fixup		=3D pas_pci_irq_fixup,
>  };
> Index: powerpc/drivers/net/pasemi_mac.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.orig/drivers/net/pasemi_mac.c
> +++ powerpc/drivers/net/pasemi_mac.c
> @@ -537,6 +537,9 @@ static irqreturn_t pasemi_mac_tx_intr(in
>  static int pasemi_mac_open(struct net_device *dev)
>  {
>  	struct pasemi_mac *mac =3D netdev_priv(dev);
> +	struct device_node *dma_dn =3D pci_device_to_OF_node(mac->dma_pdev);
> +	const unsigned int *prop;
> +	int base_irq;
>  	unsigned int flags;
>  	int ret;
> =20
> @@ -600,8 +603,24 @@ static int pasemi_mac_open(struct net_de
>  	netif_start_queue(dev);
>  	netif_poll_enable(dev);
> =20
> -	ret =3D request_irq(mac->dma_pdev->irq + mac->dma_txch,
> -			  &pasemi_mac_tx_intr, IRQF_DISABLED,
> +	/* Interrupts are a bit different for our DMA controller: While
> +	 * it's got one a regular PCI device header, the interrupt there
> +	 * is really the base of the range it's using. Each tx and rx
> +	 * channel has it's own interrupt source.
> +	 *
> +	 * The only way to get to the actual hardware interrupt is by
> +	 * getting it from the device tree, since the kernel has done
> +	 * virtual remapping of the sources by the time we can get them
> +	 * from the PCI device.
> +	 */
> +
> +	prop =3D of_get_property(dma_dn, "interrupts", NULL);
> +	base_irq =3D *prop;

The recently added virq_to_hw() makes it nice 'n easy to reverse map the
hw irq from the pci_dev:

	  base_irq =3D virq_to_hw(pdev->irq);


You should also probably check that irq_create_mapping() succeeds, just
to be pedantic.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+25/y3tYHy3RjYi/K/3H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGIxhudSjSd0sB4dIRAp1BAKCsdSN4pxEzhg7IH9ygXRAURtDWHwCeJy3c
3URpVEs6JLSlwGoJ/P5XDXI=
=kZJ6
-----END PGP SIGNATURE-----

--=-+25/y3tYHy3RjYi/K/3H--
