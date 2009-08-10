Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA85EB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 18:01:07 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 5B5DDDDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 18:01:06 +1000 (EST)
Date: Mon, 10 Aug 2009 10:00:49 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [PATCH 03/14] powerpc: use printk_once
Message-ID: <20090810080049.GA3132@pengutronix.de>
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
	<1249847649-11631-4-git-send-email-marcin.slusarz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <1249847649-11631-4-git-send-email-marcin.slusarz@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, Aug 09, 2009 at 09:53:58PM +0200, Marcin Slusarz wrote:
> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/kernel/iommu.c      |    6 +-----
>  arch/powerpc/kernel/irq.c        |    5 ++---
>  arch/powerpc/sysdev/ppc4xx_pci.c |    9 ++-------
>  3 files changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index fd51578..c7fa258 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -502,7 +502,6 @@ static void iommu_table_clear(struct iommu_table *tbl)
>  struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>  {
>  	unsigned long sz;
> -	static int welcomed =3D 0;
>  	struct page *page;
> =20
>  	/* Set aside 1/4 of the table for large allocations. */
> @@ -523,11 +522,8 @@ struct iommu_table *iommu_init_table(struct iommu_ta=
ble *tbl, int nid)
> =20
>  	iommu_table_clear(tbl);
> =20
> -	if (!welcomed) {
> -		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
> +	printk_once(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
>  		       novmerge ? "disabled" : "enabled");
> -		welcomed =3D 1;
> -	}
> =20
>  	return tbl;
>  }
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index f7f376e..05ebd21 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -231,7 +231,6 @@ skip:
>  void fixup_irqs(cpumask_t map)
>  {
>  	unsigned int irq;
> -	static int warned;
> =20
>  	for_each_irq(irq) {
>  		cpumask_t mask;
> @@ -246,8 +245,8 @@ void fixup_irqs(cpumask_t map)
>  		}
>  		if (irq_desc[irq].chip->set_affinity)
>  			irq_desc[irq].chip->set_affinity(irq, &mask);
> -		else if (irq_desc[irq].action && !(warned++))
> -			printk("Cannot set affinity for irq %i\n", irq);
> +		else if (irq_desc[irq].action)
> +			printk_once("Cannot set affinity for irq %i\n", irq);

Maybe we should add a loglevel to this printk (and the other one in fix_irq=
s)
while we are here?

Other than that:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp/07EACgkQD27XaX1/VRv0WwCfUhSxu3pv3YoG2OWL5O4vahPc
NksAoL0PRBVRNKHAvWqoYKMChO+5RSN6
=svFT
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
