Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 490721A0763
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 12:42:25 +1000 (AEST)
Message-ID: <1437360145.6255.37.camel@neuling.org>
Subject: Re: [PATCH] cxl: Remove use of macro DEFINE_PCI_DEVICE_TABLE
From: Michael Neuling <mikey@neuling.org>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2015 12:42:25 +1000
In-Reply-To: <20150719172352.GA14386@vaishali-Ideapad-Z570>
References: <20150719172352.GA14386@vaishali-Ideapad-Z570>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-07-19 at 22:53 +0530, Vaishali Thakkar wrote:
> Macro DEFINE_PCI_DEVICE_TABLE is deprecated. So, here use
> struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE with
> the goal of getting rid of this macro completely.
>=20
> The Coccinelle semantic patch that performs this transformation
> is as follows:
>=20
> @@
> identifier a;
> declarer name DEFINE_PCI_DEVICE_TABLE;
> initializer i;
> @@
> - DEFINE_PCI_DEVICE_TABLE(a)
> + const struct pci_device_id a[]
> =3D i;
>=20
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Looks good, thanks!

Acked-by: Michael Neuling <mikey@neuling.org>


> ---
>  drivers/misc/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 32ad097..3ed0621 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -133,7 +133,7 @@ u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 =
off)
>  	return (val >> ((off & 0x3) * 8)) & 0xff;
>  }
> =20
> -static DEFINE_PCI_DEVICE_TABLE(cxl_pci_tbl) =3D {
> +static const struct pci_device_id cxl_pci_tbl[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
