Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51E3DDDF7F
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 00:39:07 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3JEd4XY015532
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:39:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3JEd4U6264858
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:39:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3JEd3Nm001544
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:39:03 -0400
Date: Sat, 19 Apr 2008 09:35:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/2] [v3][POWERPC] refactor dcr code
Message-ID: <20080419093500.752c1930@zod.rchland.ibm.com>
In-Reply-To: <20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
References: <1206914576.10388.132.camel@pasglop>
	<20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Apr 2008 14:55:03 -0700
Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:

> Previously, dcr support was configured at compile time to either using
> MMIO or native dcr instructions.  Although this works for most
> platforms, it fails on FPGA platforms:
> 
> 1) Systems may include more than one dcr bus.
> 2) Systems may be native dcr capable and still use memory mapped dcr interface.
> 
> This patch provides runtime support based on the device trees for the
> case where CONFIG_PPC_DCR_MMIO and CONFIG_PPC_DCR_NATIVE are both
> selected.  Previously, this was a poorly defined configuration, which
> happened to provide NATIVE support.  The runtime selection is made
> based on the dcr controller having a 'dcr-access-method' attribute
> in the device tree.  If only one of the above options is selected,
> then the code uses #defines to select only the used code in order to
> avoid introducing overhead in existing usage.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Hi Stephen,

Sorry for the late review.  See some comments below.  Mostly minor
stuff and I think the general direction here is good.

> diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
> index 437e48d..d3de0ff 100644
> --- a/arch/powerpc/sysdev/dcr.c
> +++ b/arch/powerpc/sysdev/dcr.c
> @@ -23,6 +23,68 @@
>  #include <asm/prom.h>
>  #include <asm/dcr.h>
> 
> +#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
> +
> +bool dcr_map_ok_generic(dcr_host_t host)
> +{
> +	if (host.type == INVALID)
> +		return 0;
> +	else if (host.type == NATIVE)
> +		return dcr_map_ok_native(host.host.native);
> +	else
> +		return dcr_map_ok_mmio(host.host.mmio);
> +}
> +EXPORT_SYMBOL_GPL(dcr_map_ok_generic);
> +
> +dcr_host_t dcr_map_generic(struct device_node *dev,
> +			   unsigned int dcr_n,
> +			   unsigned int dcr_c)
> +{
> +	dcr_host_t host;
> +	const char *prop = of_get_property(dev, "dcr-access-method", NULL);
> +
> +	if (!strcmp(prop, "native")) {
> +		host.type = NATIVE;
> +		host.host.native = dcr_map_native(dev, dcr_n, dcr_c);
> +	} else if (!strcmp(prop, "mmio")) {
> +		host.type = MMIO;
> +		host.host.mmio = dcr_map_mmio(dev, dcr_n, dcr_c);
> +	} else
> +		host.type = INVALID;
> +
> +	return host;
> +}
> +EXPORT_SYMBOL_GPL(dcr_map_generic);
> +
> +void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
> +{
> +	if (host.type == NATIVE)
> +		dcr_unmap_native(host.host.native, dcr_c);
> +	else
> +		dcr_unmap_mmio(host.host.mmio, dcr_c);

What happens if host.type == INVALID?  Same question for the other
accessors in dcr_*_generic.

<snip>

> diff --git a/include/asm-powerpc/dcr-generic.h b/include/asm-powerpc/dcr-generic.h
> new file mode 100644
> index 0000000..0ee74fb
> --- /dev/null
> +++ b/include/asm-powerpc/dcr-generic.h
> @@ -0,0 +1,49 @@

<snip> 

> +enum host_type_t {MMIO, NATIVE, INVALID};

Should these be DCR_HOST_MMIO, DCR_HOST_NATIVE, DCR_HOST_INVALID?

I worry about the generic nature of the names.

josh
