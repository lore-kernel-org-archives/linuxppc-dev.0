Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8814FC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:22:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C61C2086A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UAFPMCmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C61C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rCqz0cf4zF3Ly
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:22:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UAFPMCmj";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rCkS6T2rzF3HP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="UAFPMCmj"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rCkS2T9Hz9sBZ; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541657856;
 bh=P8PmFaONYEzMfnbB5ryTBaezbstR7bBcJLG3wcueBnY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UAFPMCmjLQqrUOTY1xjzv6w2PZB/4vmaeyMaa2CvxQiE1t19mVsCOxthjZkkrEPJU
 KZ56ezH8mxHOZmhQvyyRzZg4Fkthc1HOro5zOA8VX4vU2Y4YAYnicmKnHLjSaUxXMc
 WHbWssFRa9uCmIiVnDEyIzkf1E07SopGnY6yU2po=
Date: Thu, 8 Nov 2018 16:05:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 4/5] powerpc/powernv/npu: Factor out OPAL calls
 from context manipulation
Message-ID: <20181108050540.GM5575@umbus.fritz.box>
References: <20181015093301.1007-1-aik@ozlabs.ru>
 <20181015093301.1007-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C01fF7hLGvN0zd9s"
Content-Disposition: inline
In-Reply-To: <20181015093301.1007-5-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:33:00PM +1100, Alexey Kardashevskiy wrote:
> At the moment the NPU context init/destroy code calls OPAL. The init
> handler in OPAL configures the NPU to pass ATS requests to nested MMU,
> the destroy handler does nothing besides sanity checks.
>=20
> Since the init handler programs the NPU with a wildcard for LPID/PID,
> this can be done at the point where a GPU is mapped to an LPAR; it also
> makes calling opal_npu_destroy_context() unnecessary in this context
> (this will change with VFIO later though).

I think this wants a bit more explanation.  It certainly makes me
nervous removing the destroy_context calls with nothing replacing
them.

> Also, the pnv_npu2_init() helper does not really need to call OPAL as
> well as it inialized an NPU structure and does not interact with GPU or
> NPU at that moment.
>=20
> This moves OPAL calls to a separate helper. With this change, the API
> for GPUs does not do any OPAL calls and therefore can be used by both
> pseries and powernv platforms. The new pnv_npu2_map_lpar_phb() helper
> should be called on powernv only as it does OPAL calls and it takes
> an MSR mask which NPU adds to ATS requests so nested MMU knows what
> translations are permitted; the VFIO/KVM will not set MSR_HV.
>=20
> This removes the check for FW_FEATURE_OPAL as pnv_npu2_init_context/
> pnv_npu2_release_context/pnv_npu2_init do not call OPAL anymore.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/pci.h            |   1 +
>  arch/powerpc/platforms/powernv/pci.h      |   2 +-
>  arch/powerpc/platforms/powernv/npu-dma.c  | 100 +++++++++++++++---------=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c |   7 ++-
>  4 files changed, 57 insertions(+), 53 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pc=
i.h
> index 1a96075..f196df6 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -130,5 +130,6 @@ extern void pcibios_scan_phb(struct pci_controller *h=
ose);
>  extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
>  extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int in=
dex);
>  extern void pnv_npu2_devices_init(void);
> +extern int pnv_npu2_init(struct pci_controller *hose);
> =20
>  #endif /* __ASM_POWERPC_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 3b7617d..ca2ce4b 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -224,7 +224,7 @@ extern long pnv_npu_set_window(struct pnv_ioda_pe *np=
e, int num,
>  extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
>  extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
>  extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
> -extern int pnv_npu2_init(struct pnv_phb *phb);
> +extern void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long ms=
r);
> =20
>  /* pci-ioda-tce.c */
>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index cb2b4f9..677f30a 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -762,7 +762,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	u32 nvlink_index;
>  	struct device_node *nvlink_dn;
>  	struct mm_struct *mm =3D current->mm;
> -	struct pnv_phb *nphb;
>  	struct npu *npu;
>  	struct npu_context *npu_context;
> =20
> @@ -772,9 +771,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	 */
>  	struct pci_dev *npdev =3D pnv_pci_get_npu_dev(gpdev, 0);
> =20
> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
> -		return ERR_PTR(-ENODEV);
> -
>  	if (!npdev)
>  		/* No nvlink associated with this GPU device */
>  		return ERR_PTR(-ENODEV);
> @@ -792,22 +788,9 @@ struct npu_context *pnv_npu2_init_context(struct pci=
_dev *gpdev,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
>  	npu =3D npdev_to_npu(npdev);
> =20
>  	/*
> -	 * Setup the NPU context table for a particular GPU. These need to be
> -	 * per-GPU as we need the tables to filter ATSDs when there are no
> -	 * active contexts on a particular GPU. It is safe for these to be
> -	 * called concurrently with destroy as the OPAL call takes appropriate
> -	 * locks and refcounts on init/destroy.
> -	 */
> -	rc =3D opal_npu_init_context(nphb->opal_id, mm->context.id,
> flags,

AFAICT this was the only use of 'flags' in this function, so it should
be removed from the signature, no?

> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> -	if (rc < 0)
> -		return ERR_PTR(-ENOSPC);
> -
> -	/*
>  	 * We store the npu pci device so we can more easily get at the
>  	 * associated npus.
>  	 */
> @@ -817,9 +800,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  		if (npu_context->release_cb !=3D cb ||
>  			npu_context->priv !=3D priv) {
>  			spin_unlock(&npu2_devices.context_lock);
> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> -						PCI_DEVID(gpdev->bus->number,
> -							gpdev->devfn));
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
> @@ -845,9 +825,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
> =20
>  		if (rc) {
>  			kfree(npu_context);
> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> -					PCI_DEVID(gpdev->bus->number,
> -						gpdev->devfn));
>  			return ERR_PTR(rc);
>  		}
> =20
> @@ -900,7 +877,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu=
_context,
>  			struct pci_dev *gpdev)
>  {
>  	int removed;
> -	struct pnv_phb *nphb;
>  	struct npu *npu;
>  	struct pci_dev *npdev =3D pnv_pci_get_npu_dev(gpdev, 0);
>  	struct device_node *nvlink_dn;
> @@ -909,18 +885,12 @@ void pnv_npu2_destroy_context(struct npu_context *n=
pu_context,
>  	if (WARN_ON(!npdev))
>  		return;
> =20
> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
> -		return;
> -
> -	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
>  	npu =3D npdev_to_npu(npdev);
>  	nvlink_dn =3D of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))
>  		return;
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
> -	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
>  	spin_lock(&npu2_devices.context_lock);
>  	removed =3D kref_put(&npu_context->kref, pnv_npu2_release_context);
>  	spin_unlock(&npu2_devices.context_lock);
> @@ -952,9 +922,6 @@ int pnv_npu2_handle_fault(struct npu_context *context=
, uintptr_t *ea,
>  	/* mmap_sem should be held so the struct_mm must be present */
>  	struct mm_struct *mm =3D context->mm;
> =20
> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
> -		return -ENODEV;
> -
>  	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
> =20
>  	for (i =3D 0; i < count; i++) {
> @@ -983,15 +950,11 @@ int pnv_npu2_handle_fault(struct npu_context *conte=
xt, uintptr_t *ea,
>  }
>  EXPORT_SYMBOL(pnv_npu2_handle_fault);
> =20
> -int pnv_npu2_init(struct pnv_phb *phb)
> +int pnv_npu2_init(struct pci_controller *hose)
>  {
>  	unsigned int i;
>  	u64 mmio_atsd;
> -	struct device_node *dn;
> -	struct pci_dev *gpdev;
>  	static int npu_index;
> -	uint64_t rc =3D 0;
> -	struct pci_controller *hose =3D phb->hose;
>  	struct npu *npu;
>  	int ret;
> =20
> @@ -1006,18 +969,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	}
> =20
>  	npu->nmmu_flush =3D of_property_read_bool(hose->dn, "ibm,nmmu-flush");
> -	for_each_child_of_node(phb->hose->dn, dn) {
> -		gpdev =3D pnv_pci_get_gpu_dev(get_pci_dev(dn));
> -		if (gpdev) {
> -			rc =3D opal_npu_map_lpar(phb->opal_id,
> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
> -				0, 0);
> -			if (rc)
> -				dev_err(&gpdev->dev,
> -					"Error %lld mapping device to LPAR\n",
> -					rc);
> -		}
> -	}
> =20
>  	for (i =3D 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>  							i, &mmio_atsd); i++)
> @@ -1047,3 +998,52 @@ int pnv_npu2_init(struct pnv_phb *phb)
> =20
>  	return ret;
>  }
> +
> +void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr)
> +{
> +	struct pci_dev *gpdev;
> +	struct device_node *dn;
> +	int ret;
> +	struct pci_controller *hose =3D nphb->hose;
> +
> +	for_each_child_of_node(hose->dn, dn) {
> +		gpdev =3D pnv_pci_get_gpu_dev(get_pci_dev(dn));
> +		if (!gpdev)
> +			continue;
> +
> +		dev_dbg(&gpdev->dev, "Map LPAR opalid=3D%llu\n", nphb->opal_id);
> +		ret =3D opal_npu_map_lpar(nphb->opal_id,
> +				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
> +				0, 0);
> +		if (!ret)
> +			continue;
> +		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
> +	}
> +
> +	/*
> +	 * It seems that touching NPU2_XTS_BDF_MAP in the way
> +	 * the opal_npu_map_lpar() does somehow affects the result of
> +	 * what opal_npu_init_context() does so let's put the latter in
> +	 * a separate loop.
> +	 */
> +	for_each_child_of_node(hose->dn, dn) {
> +		gpdev =3D pnv_pci_get_gpu_dev(get_pci_dev(dn));
> +		if (!gpdev)
> +			continue;
> +
> +		/*
> +		 * Setup the NPU context table for a particular GPU. These need
> +		 * to be per-GPU as we need the tables to filter ATSDs when
> +		 * there are no active contexts on a particular GPU. It is safe
> +		 * for these to be called concurrently with destroy as the OPAL
> +		 * call takes appropriate locks and refcounts on init/destroy.
> +		 */
> +		dev_dbg(&gpdev->dev, "init context opalid=3D%llu\n",
> +				nphb->opal_id);
> +		ret =3D opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
> +				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> +		if (!ret)
> +			continue;
> +		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
> +	}
> +}
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 0cc81c0..56a1398 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1287,8 +1287,11 @@ static void pnv_pci_ioda_setup_PEs(void)
>  			/* PE#0 is needed for error reporting */
>  			pnv_ioda_reserve_pe(phb, 0);
>  			pnv_ioda_setup_npu_PEs(hose->bus);
> -			if (phb->model =3D=3D PNV_PHB_MODEL_NPU2)
> -				pnv_npu2_init(phb);
> +			if (phb->model =3D=3D PNV_PHB_MODEL_NPU2) {
> +				pnv_npu2_init(hose);
> +				pnv_npu2_map_lpar_phb(phb,
> +						MSR_DR | MSR_PR | MSR_HV);

This is the only caller of pnv_np2_map_lpar_phb(), do we need the
second parameter?  I take it those "flags" to the function are
actually an MSR value; that wasn't clear from the previous code.

> +			}
>  		}
>  		if (phb->type =3D=3D PNV_PHB_NPU_OCAPI) {
>  			bus =3D hose->bus;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C01fF7hLGvN0zd9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvjxB4ACgkQbDjKyiDZ
s5L6qRAA4aNaev1X7gu4f3qvu6U8qy3cfDR45JoVeU2BtkYRwG68WxeiRi/vqTJI
kPGms59sX8ywqp/KfLGMaS7dWb+nGpST18III9hOMIyff/hi9IBcVI2R/kEFxqZY
QQKIs/9v04mG/gsG9sdxOiKpkaNIGZVq20adDqrdNm09rHzwv+1Lbnl+hwX8PMn8
Y4TZ4FzxP38SN5eGXVEb/TzcTvNMMWZUFA8PEQGHvJ4cUTfkIv8LI384Mz8tIT2/
3UL3MdQ3PI2/gtKt97NblN58Dg+6HoONDTA6dP9wEDt0EZOW5tc2AQpwKbY/Svxl
cMVSYKY4qaDJDCkkoWT5uctsY4tlbyFHfw+7lykD/3p0ayoev1VZIL7EOMZ6T+3t
GVqFgWNazHxzJ5frHpckefKXQhXVSrUtYDik7BuFQYjJAWvLyEgq7JmwIY6PpZIu
MFe79AzJorMpOc6bej8SmXd1FlJvUrPTUrKBH4fz4gZ9/VTXsIk7S7HPkDHFYEFZ
VTxYxD4Q7LLoJpFN7gK6bVTDjK5hvv9YvWpYHamy57a9CggQyn4jReN9vcCuqSFj
SQLBGNWr2d1tiufvELQ01oeQaoYEVC/Tqe5kSy/BK3smsyFX/7nVPbCtRmWFVtdA
pGKw4LC96L1FwKGyi4rL8sSczDyPiCjb9Acvjd3aALs8Q5WufHY=
=IPgc
-----END PGP SIGNATURE-----

--C01fF7hLGvN0zd9s--
