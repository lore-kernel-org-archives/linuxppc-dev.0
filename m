Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] fsl_msi: enable msi allocation in all banks
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1271403278-30091-2-git-send-email-leoli@freescale.com>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271403278-30091-2-git-send-email-leoli@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-s4mfNkMLhiqt9GBRQHvC"
Date: Mon, 19 Apr 2010 12:46:21 +1000
Message-ID: <1271645181.14835.46.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-s4mfNkMLhiqt9GBRQHvC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
> From: Zhao Chenhui <b26998@freescale.com>
>=20
> Put all fsl_msi banks in a linked list. The list of banks then can be
> traversed when allocating new msi interrupts.

So there are multiple banks, and you just use the first one that has an
empty slot in it's bitmap?

> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_msi.c |   29 ++++++++++++++++++++++-------
>  arch/powerpc/sysdev/fsl_msi.h |    2 ++
>  2 files changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> index 716862f..c46db75 100644
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
> @@ -143,15 +145,26 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev,=
 int nvec, int type)
>  	struct msi_msg msg;
>  	struct fsl_msi *msi_data;
> =20
> +	if (list_empty(&msi_head)) {
> +		pr_debug("%s: msi init error\n", __func__);
> +		rc =3D -EFAULT;
> +		goto out_free;
> +	}

If there's an error probing then fsl_setup_msi_irqs() should not be
installed as ppc_md.setup_msi_irqs(), and this code should never run.
ie. You shouldn't need this check.

> +
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
> -		msi_data =3D get_irq_chip_data(entry->irq);
> =20
> -		hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> -		if (hwirq < 0) {
> -			rc =3D hwirq;
> -			pr_debug("%s: fail allocating msi interrupt\n",
> -					__func__);
> -			goto out_free;
> +		list_for_each_entry(msi_data, &msi_head, list) {
> +
> +			hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> +			if (hwirq >=3D 0)
> +				break;
> +
> +			if (list_is_last(&msi_data->list, &msi_head)) {
> +				rc =3D hwirq;
> +				pr_debug("%s: fail allocating msi interrupt\n",
> +						__func__);
> +				goto out_free;
> +			}

You could make this cleaner by pulling the inner loop into a separate
function, and when you fall off the end of the list you return < 0. That
would avoid needing the list_is_last() check.

cheers

--=-s4mfNkMLhiqt9GBRQHvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvLw/wACgkQdSjSd0sB4dLjvACeMwRP0kkYbMHZgTXcC2eP8dcE
AAgAoI77ZVeyiOynDX5YKG9B8ls1yHM8
=3zXX
-----END PGP SIGNATURE-----

--=-s4mfNkMLhiqt9GBRQHvC--
