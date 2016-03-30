Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZSxx4PdbzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 11:21:57 +1100 (AEDT)
In-Reply-To: <1458145736-20326-2-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com
Subject: Re: [v2,2/2] cxl: Configure the PSL for two CAPI ports on POWER8NVL
Message-Id: <3qZSxx3cszz9sBg@ozlabs.org>
Date: Wed, 30 Mar 2016 11:21:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-16-03 at 16:28:56 UTC, Philippe Bergheaud wrote:
> The POWER8NVL chip has two CAPI ports.  Configure the PSL to route
> data to the port corresponding to the CAPP unit.
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 0c6c17a1..924ba63 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -340,12 +341,35 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
>  #undef show_reg
>  }
>  
> +#define CAPP_UNIT0_ID 0xBA
> +#define CAPP_UNIT1_ID 0XBE
> +
> +static u64 capp_unit_id(struct device_node *np)

It's always nice if function names contain a verb, eg. get_capp_unit_id().

> +{
> +	const __be32 *prop;
> +	u64 phb_index;
> +
> +	/* For chips other than POWER8NVL, we only have CAPP 0,
> +	 * irrespective of which PHB is used */

Can you use the standard block commenting style please, eg:

/*
 * For chips ..
 */

> +	if (!pvr_version_is(PVR_POWER8NVL))
> +		return CAPP_UNIT0_ID ;
                                    ^
				    don't need a space here

> +	/* For POWER8NVL, assume CAPP 0 is attached to PHB0 and
> +	 * CAPP 1 is attached to PHB1 */
> +	prop = of_get_property(np, "ibm,phb-index", NULL);

Please use of_property_read_u32().

> +	if (!prop)
> +		return 0;
> +	phb_index = be32_to_cpup(prop);

Some blank lines here would help readability.

> +	return phb_index ? CAPP_UNIT1_ID : CAPP_UNIT0_ID;

This logic doesn't quite match your comment above. This says that any non-zero
PHB index is CAPP1, whereas the comment says CAPP1 == PHB1.

> +}
> +
>  static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
>  {
>  	struct device_node *np;
>  	const __be32 *prop;
>  	u64 psl_dsnctl;
>  	u64 chipid;
> +	u64 cappunitid;

capp_unit_id ?

>  	if (!(np = pnv_pci_get_phb_node(dev)))
>  		return -ENODEV;
> @@ -355,10 +379,15 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>  	if (!np)
>  		return -ENODEV;
>  	chipid = be32_to_cpup(prop);
> +	cappunitid = capp_unit_id(np);
>  	of_node_put(np);
> +	if (!cappunitid)
> +		return -ENODEV;

You probably want a pr_xxx() there don't you?

>  	/* Tell PSL where to route data to */
> -	psl_dsnctl = 0x02E8900002000000ULL | (chipid << (63-5));
> +	psl_dsnctl = 0x0000900002000000ULL | (chipid << (63-5));
> +	psl_dsnctl |= (cappunitid << (63-13));
> +
>  	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
>  	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
>  	/* snoop write mask */


cheers
