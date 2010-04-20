Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/5] fsl_msi: enable msi allocation in all banks
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1271766048-19272-2-git-send-email-leoli@freescale.com>
References: <1271766048-19272-1-git-send-email-leoli@freescale.com>
	<1271766048-19272-2-git-send-email-leoli@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-+He7nLQsEN6jAstd/MAS"
Date: Tue, 20 Apr 2010 22:23:22 +1000
Message-ID: <1271766202.4324.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <b26998@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-+He7nLQsEN6jAstd/MAS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-20 at 20:20 +0800, Li Yang wrote:
> Put all fsl_msi banks in a linked list. The list of banks then can be
> traversed when allocating new msi interrupts.  Also fix failing path
> of fsl_setup_msi_irqs().
>=20
> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_msi.c |   16 +++++++++++++---
>  arch/powerpc/sysdev/fsl_msi.h |    2 ++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> index 93a638a..712f934 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -24,6 +24,8 @@
>  #include <asm/mpic.h>
>  #include "fsl_msi.h"
> =20
> +LIST_HEAD(msi_head);
> +
>  struct fsl_msi_feature {
>  	u32 fsl_pic_ip;
>  	u32 msiir_offset;
> @@ -137,16 +139,19 @@ static void fsl_compose_msi_msg(struct pci_dev *pde=
v, int hwirq,
> =20
>  static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  {
> -	int rc, hwirq =3D NO_IRQ;
> +	int rc, hwirq =3D -ENOMEM;
>  	unsigned int virq;
>  	struct msi_desc *entry;
>  	struct msi_msg msg;
>  	struct fsl_msi *msi_data;
> =20
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
> -		msi_data =3D get_irq_chip_data(entry->irq);
> +		list_for_each_entry(msi_data, &msi_head, list) {
> +			hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> +			if (hwirq >=3D 0)
> +				break;
> +		}
> =20
> -		hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>  		if (hwirq < 0) {
>  			rc =3D hwirq;
>  			pr_debug("%s: fail allocating msi interrupt\n",
> @@ -160,6 +165,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, i=
nt nvec, int type)
>  			pr_debug("%s: fail mapping hwirq 0x%x\n",
>  					__func__, hwirq);
>  			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
> +			irq_dispose_mapping(virq);

No, you're in the body of this if because virq =3D=3D NO_IRQ, so you don't
need to dispose of the mapping - there is no mapping. Unless the
out-of-context code has changed from what I'm looking at.


> @@ -172,6 +178,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, i=
nt nvec, int type)
>  	return 0;
> =20
>  out_free:
> +	/* free MSI interrupt already allocated */
> +	fsl_teardown_msi_irqs(pdev);

You don't need to do this. The generic code (drivers/pci/msi.c) always
calls teardown if setup fails.

cheers


--=-+He7nLQsEN6jAstd/MAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvNnLYACgkQdSjSd0sB4dJrfQCeI8Q7X6KBoCi7eGTwdOjCyzTJ
aMwAoMQE6JiBxwNJo/khNwH/tpRGNF6U
=7Hd4
-----END PGP SIGNATURE-----

--=-+He7nLQsEN6jAstd/MAS--
