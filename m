Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFgwG6B5GzDqvm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:39:26 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08GdJMU067632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 11:39:24 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fcbswt10q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 11:39:23 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 16:38:52 -0000
Subject: Re: [PATCH v5 2/2] cxl: read PHB indications from the device tree
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20171222123624.1880-1-felix@linux.vnet.ibm.com>
 <20171222123624.1880-2-felix@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 17:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171222123624.1880-2-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7dd36bac-87f8-7afe-0d83-51813d9bbaab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/12/2017 à 13:36, Philippe Bergheaud a écrit :
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
>      Drop cosmetic fix in comment.
> 
> v5: get_phb_indications():
>        - make static variables local to function.
>        - return static variable values by arguments.
> 
> This patch depends on the following skiboot prerequisite:
> 
> https://patchwork.ozlabs.org/patch/849162/
> ---
>   drivers/misc/cxl/cxl.h    |  2 +-
>   drivers/misc/cxl/cxllib.c |  2 +-
>   drivers/misc/cxl/pci.c    | 42 +++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index e46a4062904a..5a6e9a921c2b 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -1062,7 +1062,7 @@ int cxl_psl_purge(struct cxl_afu *afu);
>   int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
>   			  u32 *phb_index, u64 *capp_unit_id);
>   int cxl_slot_is_switched(struct pci_dev *dev);
> -int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg);
> +int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg);
>   u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
> 
>   void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
> index dc9bc1807fdf..61f80d586279 100644
> --- a/drivers/misc/cxl/cxllib.c
> +++ b/drivers/misc/cxl/cxllib.c
> @@ -99,7 +99,7 @@ int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
>   	if (rc)
>   		return rc;
> 
> -	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &cfg->dsnctl);
> +	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &cfg->dsnctl);
>   	if (rc)
>   		return rc;
>   	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 19969ee86d6f..1d38fff2139f 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -409,21 +409,53 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
>   	return 0;
>   }
> 
> -int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
> +static int get_phb_indications(struct pci_dev *dev, u64* capiind, u64 *asnind,
> +			       u64 *nbwind)
> +{
> +	static u64 nbw, asn, capi = 0;
> +	struct device_node *np;
> +	const __be32 *prop;
> +
> +	if (!capi) {
> +		if (!(np = pnv_pci_get_phb_node(dev)))
> +			return -1;
> +
> +		prop = of_get_property(np, "ibm,phb-indications", NULL);
> +		if (!prop) {
> +			nbw = 0x0300UL; /* legacy values */
> +			asn = 0x0400UL;
> +			capi = 0x0200UL;
> +		} else {
> +			nbw = (u64)be32_to_cpu(prop[2]);
> +			asn = (u64)be32_to_cpu(prop[1]);
> +			capi = (u64)be32_to_cpu(prop[0]);
> +		}
> +		of_node_put(np);
> +	}

Though unlikely, we could get some concurrence here (because of cxllib). 
Each occurrence would find the same values for the 3 variables and we 
could be ok if the underlying code only load/store 64 bits, but a mutex 
would make it safer.

   Fred


> +	*capiind = capi;
> +	*asnind = asn;
> +	*nbwind = nbw;
> +	return 0;
> +}
> +
> +int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
>   {
>   	u64 xsl_dsnctl;
> +	u64 capiind, asnind, nbwind;
> 
>   	/*
>   	 * CAPI Identifier bits [0:7]
>   	 * bit 61:60 MSI bits --> 0
>   	 * bit 59 TVT selector --> 0
>   	 */
> +	if (get_phb_indications(dev, &capiind, &asnind, &nbwind))
> +		return -1;
> 
>   	/*
>   	 * Tell XSL where to route data to.
>   	 * The field chipid should match the PHB CAPI_CMPM register
>   	 */
> -	xsl_dsnctl = ((u64)0x2 << (63-7)); /* Bit 57 */
> +	xsl_dsnctl = (capiind << (63-15)); /* Bit 57 */
>   	xsl_dsnctl |= (capp_unit_id << (63-15));
> 
>   	/* nMMU_ID Defaults to: b’000001001’*/
> @@ -437,14 +469,14 @@ int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
>   		 * nbwind=0x03, bits [57:58], must include capi indicator.
>   		 * Not supported on P9 DD1.
>   		 */
> -		xsl_dsnctl |= ((u64)0x03 << (63-47));
> +		xsl_dsnctl |= (nbwind << (63-55));
> 
>   		/*
>   		 * Upper 16b address bits of ASB_Notify messages sent to the
>   		 * system. Need to match the PHB’s ASN Compare/Mask Register.
>   		 * Not supported on P9 DD1.
>   		 */
> -		xsl_dsnctl |= ((u64)0x04 << (63-55));
> +		xsl_dsnctl |= asnind;
>   	}
> 
>   	*reg = xsl_dsnctl;
> @@ -464,7 +496,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
>   	if (rc)
>   		return rc;
> 
> -	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &xsl_dsnctl);
> +	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &xsl_dsnctl);
>   	if (rc)
>   		return rc;
> 
