Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B56601A1BEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 14:13:10 +1000 (AEST)
Message-ID: <1438920790.16275.2.camel@neuling.org>
Subject: Re: [PATCH 3/4] cxl: sparse: Flag iomem pointers properly
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 07 Aug 2015 14:13:10 +1000
In-Reply-To: <1438917500-12100-3-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
 <1438917500-12100-3-git-send-email-dja@axtens.net>
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

On Fri, 2015-08-07 at 13:18 +1000, Daniel Axtens wrote:
> Sparse identifies the following address space issues:
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17: warning: incorrec=
t type in assignment (different address spaces)
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    expected void =
volatile [noderef] <asn:2>*<noident>
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    got void *<noi=
dent>
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23: warning: incorrec=
t type in assignment (different address spaces)
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    expected void =
[noderef] <asn:2>*cfg_data
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    got void *<noi=
dent>
>=20
> Fix those by flagging __iomem in the relevant casts.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/vphb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 2eba002b580b..a7b55772a91c 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -122,7 +122,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, =
unsigned int devfn,
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	addr =3D cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
> =20
> -	*ioaddr =3D (void *)(addr & ~0x3ULL);
> +	*ioaddr =3D (void __iomem *)(addr & ~0x3ULL);
>  	*shift =3D ((addr & 0x3) * 8);
>  	switch (len) {
>  	case 1:
> @@ -217,7 +217,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>  	/* Setup the PHB using arch provided callback */
>  	phb->ops =3D &cxl_pcie_pci_ops;
>  	phb->cfg_addr =3D afu->afu_desc_mmio + afu->crs_offset;
> -	phb->cfg_data =3D (void *)(u64)afu->crs_len;
> +	phb->cfg_data =3D (void __iomem *)(u64)afu->crs_len;
>  	phb->private_data =3D afu;
>  	phb->controller_ops =3D cxl_pci_controller_ops;
> =20
