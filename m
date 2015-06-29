Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76F021A0D2A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 20:43:37 +1000 (AEST)
Message-ID: <1435574617.11963.0.camel@neuling.org>
Subject: Re: [PATCH 1/1] cxl/vphb.c: Use phb pointer after NULL check
From: Michael Neuling <mikey@neuling.org>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, pankaj.m@samsung.com
Date: Mon, 29 Jun 2015 20:43:37 +1000
In-Reply-To: <1435574111-45617-1-git-send-email-maninder1.s@samsung.com>
References: <1435574111-45617-1-git-send-email-maninder1.s@samsung.com>
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

On Mon, 2015-06-29 at 16:05 +0530, Maninder Singh wrote:
> static Anlaysis detected below error:-
> (error) Possible null pointer dereference: phb
>=20
> So, Use phb after NULL check.
>=20
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Thanks, looks good.

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/vphb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index b1d1983a..2eba002 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -112,9 +112,10 @@ static int cxl_pcie_config_info(struct pci_bus *bus,=
 unsigned int devfn,
>  	unsigned long addr;
> =20
>  	phb =3D pci_bus_to_host(bus);
> -	afu =3D (struct cxl_afu *)phb->private_data;
>  	if (phb =3D=3D NULL)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> +	afu =3D (struct cxl_afu *)phb->private_data;
> +
>  	if (cxl_pcie_cfg_record(bus->number, devfn) > afu->crs_num)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	if (offset >=3D (unsigned long)phb->cfg_data)
