Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPtnq6QXszDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 12:15:11 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3qPtnq5K0hz9sDC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 12:15:11 +1100 (AEDT)
Message-ID: <1458090911.9668.15.camel@neuling.org>
Subject: Re: [PATCH] cxl: Configure the PSL for dual port CAPI on Naples
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Wed, 16 Mar 2016 12:15:11 +1100
In-Reply-To: <1458052008-29254-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1458052008-29254-1-git-send-email-felix@linux.vnet.ibm.com>
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

On Tue, 2016-03-15 at 15:26 +0100, Philippe Bergheaud wrote:
> Naples CPUs have two CAPI ports. =20

Naples is an internal name, don't use that.  Use POWER8NVL is the name
we use in the kernel.

alsi, it's a "chip" that has two CAPI ports, not the CPU.

> Configure the PSL to route data to
> the port corresponding to the PHB index.

Isn't this capp unit in reality, not phb index?

>=20
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/pci.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 0c6c17a1..3db0a0b 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -340,12 +340,15 @@ static void dump_afu_descriptor(struct cxl_afu
> *afu)
>  #undef show_reg
>  }
> =20
> +#define CPU_IS_NAPLES() (cur_cpu_spec->pvr_value =3D=3D 0x004c0000)

Use pvr_version_is(PVR_POWER8NVL))

> +
>  static int init_implementation_adapter_regs(struct cxl *adapter,
> struct pci_dev *dev)
>  {
>  	struct device_node *np;
>  	const __be32 *prop;
>  	u64 psl_dsnctl;
>  	u64 chipid;
> +	u64 phb_index;
> =20
>  	if (!(np =3D pnv_pci_get_phb_node(dev)))
>  		return -ENODEV;
> @@ -355,10 +358,20 @@ static int
> init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>  	if (!np)
>  		return -ENODEV;
>  	chipid =3D be32_to_cpup(prop);
> -	of_node_put(np);
> =20
>  	/* Tell PSL where to route data to */
>  	psl_dsnctl =3D 0x02E8900002000000ULL | (chipid << (63-5));
> +	if (CPU_IS_NAPLES()) {
> +		prop =3D of_get_property(np, "ibm,phb-index", NULL);
> +		if (!prop) {
> +			of_node_put(np);
> +			return -ENODEV;
> +		}
> +		phb_index =3D be32_to_cpup(prop);
> +		psl_dsnctl |=3D (phb_index << (63-11));

Looking at the psl docs, cappunitid in the dsndctl is bits 6 to 13.  So
why 11 here?

Can you abstract this better and make it clear what's happening?  Try
something like this:

int capp_unit()
{

	if (!pvr_version_is(PVR_POWER8NVL))
	/* For chips other than POWER8NVL, we only have CAPP 0
         * irrespective of which PHB is used */
		return 0;

	/* For POWER8NVL, assume CAPP 0 is attached to PHB0 and=20
         * CAPP 1 is attached to PHB1*/
	prop =3D of_get_property(np, "ibm,phb-index", NULL);
	if (!prop) {
		of_node_put(np);
		return -ENODEV;
	}
	return be32_to_cpup(prop);
}

Then you can do something like (although you need to fix the error
case)
        psl_dsnctl |=3D (capp_unit(p) << (63-13));

Mikey


> +	}
> +	of_node_put(np);
> +
>  	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
>  	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
>  	/* snoop write mask */
