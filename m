Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNHsm3jpPzF10K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 22:00:12 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0JAx7tE022126
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 06:00:07 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkdbwn4m6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 06:00:06 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 11:00:04 -0000
Subject: Re: [PATCH v7 2/2] cxl: read PHB indications from the device tree
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@au1.ibm.com, clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com
References: <20180115133937.13063-1-felix@linux.vnet.ibm.com>
 <20180115133937.13063-2-felix@linux.vnet.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 12:00:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180115133937.13063-2-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f84a2c11-12ab-e7f8-4fdb-0053a59c62ae@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/01/2018 14:39, Philippe Bergheaud wrote:
> Configure the P9 XSL_DSNCTL register with PHB indications found
> in the device tree, or else use legacy hard-coded values.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: New patch. Use the new device tree property "ibm,phb-indications".
> 
> v3: No change.
> 
> v4: No functional change.
>     Drop cosmetic fix in comment.
> 
> v5: get_phb_indications():
>       - make static variables local to function.
>       - return static variable values by arguments.
> 
> v6: get_phb_indications():
>       - acquire a mutex before setting the phb indications.
> 
> v7: get_phb_indications():
>     cxl_get_xsl9_dsnctl():
>       - return -ENODEV instead of -1.
> 
> This patch depends on the following skiboot patch:
>   https://patchwork.ozlabs.org/patch/858324/
> ---
>  drivers/misc/cxl/cxl.h    |  2 +-
>  drivers/misc/cxl/cxllib.c |  2 +-
>  drivers/misc/cxl/pci.c    | 50 ++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index e46a4062904a..5a6e9a921c2b 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -1062,7 +1062,7 @@ int cxl_psl_purge(struct cxl_afu *afu);
>  int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
>  			  u32 *phb_index, u64 *capp_unit_id);
>  int cxl_slot_is_switched(struct pci_dev *dev);
> -int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg);
> +int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg);
>  u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
> 
>  void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
> index dc9bc1807fdf..61f80d586279 100644
> --- a/drivers/misc/cxl/cxllib.c
> +++ b/drivers/misc/cxl/cxllib.c
> @@ -99,7 +99,7 @@ int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
>  	if (rc)
>  		return rc;
> 
> -	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &cfg->dsnctl);
> +	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &cfg->dsnctl);
>  	if (rc)
>  		return rc;
>  	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 19969ee86d6f..89840181fc03 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -409,21 +409,61 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
>  	return 0;
>  }
> 
> -int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
> +static DEFINE_MUTEX(indications_mutex);
> +
> +static int get_phb_indications(struct pci_dev *dev, u64* capiind, u64 *asnind,
> +			       u64 *nbwind)
> +{
> +	static u64 nbw, asn, capi = 0;
> +	struct device_node *np;
> +	const __be32 *prop;
> +
> +	if (!capi) {
> +		mutex_lock(&indications_mutex);
> +		if (!capi) {
> +			if (!(np = pnv_pci_get_phb_node(dev))) {
> +				mutex_unlock(&indications_mutex);
> +				return -ENODEV;
> +			}
> +
> +			prop = of_get_property(np, "ibm,phb-indications", NULL);
> +			if (!prop) {
> +				nbw = 0x0300UL; /* legacy values */
> +				asn = 0x0400UL;
> +				capi = 0x0200UL;
> +			} else {
> +				nbw = (u64)be32_to_cpu(prop[2]);
> +				asn = (u64)be32_to_cpu(prop[1]);
> +				capi = (u64)be32_to_cpu(prop[0]);
> +			}
> +			of_node_put(np);
> +		}
> +		mutex_unlock(&indications_mutex);
> +	}

In the case capi !=0, I think you will need a smp_rmb() here because there
is a dependancy between the check on capi and the reading of the asn and
nbw values, and there is nothing to prevent the CPU from fetching those
values before fetching and checking capi.

> +	*capiind = capi;
> +	*asnind = asn;
> +	*nbwind = nbw;
> +	return 0;
> +}
> +
> +int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
>  {
>  	u64 xsl_dsnctl;
> +	u64 capiind, asnind, nbwind;
> 
>  	/*
>  	 * CAPI Identifier bits [0:7]
>  	 * bit 61:60 MSI bits --> 0
>  	 * bit 59 TVT selector --> 0
>  	 */
> +	if (get_phb_indications(dev, &capiind, &asnind, &nbwind))
> +		return -ENODEV;
> 
>  	/*
>  	 * Tell XSL where to route data to.
>  	 * The field chipid should match the PHB CAPI_CMPM register
>  	 */
> -	xsl_dsnctl = ((u64)0x2 << (63-7)); /* Bit 57 */
> +	xsl_dsnctl = (capiind << (63-15)); /* Bit 57 */
>  	xsl_dsnctl |= (capp_unit_id << (63-15));
> 
>  	/* nMMU_ID Defaults to: b’000001001’*/
> @@ -437,14 +477,14 @@ int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
>  		 * nbwind=0x03, bits [57:58], must include capi indicator.
>  		 * Not supported on P9 DD1.
>  		 */
> -		xsl_dsnctl |= ((u64)0x03 << (63-47));
> +		xsl_dsnctl |= (nbwind << (63-55));
> 
>  		/*
>  		 * Upper 16b address bits of ASB_Notify messages sent to the
>  		 * system. Need to match the PHB’s ASN Compare/Mask Register.
>  		 * Not supported on P9 DD1.
>  		 */
> -		xsl_dsnctl |= ((u64)0x04 << (63-55));
> +		xsl_dsnctl |= asnind;
>  	}
> 
>  	*reg = xsl_dsnctl;
> @@ -464,7 +504,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
>  	if (rc)
>  		return rc;
> 
> -	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &xsl_dsnctl);
> +	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &xsl_dsnctl);
>  	if (rc)
>  		return rc;
> 
