Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C2DA1400B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 11:38:05 +1000 (EST)
Message-ID: <1398649066.30694.2.camel@pasglop>
Subject: Re: [PATCH v2 21/21] of: push struct boot_param_header and defines
 into powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Mon, 28 Apr 2014 11:37:46 +1000
In-Reply-To: <1398215901-25609-22-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
 <1398215901-25609-22-git-send-email-robherring2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-22 at 20:18 -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Now powerpc is the only user of struct boot_param_header and FDT defines,
> so they can be moved into the powerpc architecture code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---

I assume we want to get rid of that too eventually ? :-)

We should be able to get the definitions from libfdt too....

In the meantime:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

> v2: no change
> 
>  arch/powerpc/include/asm/prom.h | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_fdt.h          | 37 -------------------------------------
>  2 files changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index d977b9b..74b79f0 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -26,6 +26,45 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
> +#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
> +#define OF_DT_END_NODE		0x2		/* End node */
> +#define OF_DT_PROP		0x3		/* Property: name off, size,
> +						 * content */
> +#define OF_DT_NOP		0x4		/* nop */
> +#define OF_DT_END		0x9
> +
> +#define OF_DT_VERSION		0x10
> +
> +/*
> + * This is what gets passed to the kernel by prom_init or kexec
> + *
> + * The dt struct contains the device tree structure, full pathes and
> + * property contents. The dt strings contain a separate block with just
> + * the strings for the property names, and is fully page aligned and
> + * self contained in a page, so that it can be kept around by the kernel,
> + * each property name appears only once in this page (cheap compression)
> + *
> + * the mem_rsvmap contains a map of reserved ranges of physical memory,
> + * passing it here instead of in the device-tree itself greatly simplifies
> + * the job of everybody. It's just a list of u64 pairs (base/size) that
> + * ends when size is 0
> + */
> +struct boot_param_header {
> +	__be32	magic;			/* magic word OF_DT_HEADER */
> +	__be32	totalsize;		/* total size of DT block */
> +	__be32	off_dt_struct;		/* offset to structure */
> +	__be32	off_dt_strings;		/* offset to strings */
> +	__be32	off_mem_rsvmap;		/* offset to memory reserve map */
> +	__be32	version;		/* format version */
> +	__be32	last_comp_version;	/* last compatible version */
> +	/* version 2 fields below */
> +	__be32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
> +	/* version 3 fields below */
> +	__be32	dt_strings_size;	/* size of the DT strings block */
> +	/* version 17 fields below */
> +	__be32	dt_struct_size;		/* size of the DT structure block */
> +};
> +
>  /*
>   * OF address retreival & translation
>   */
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 1f882e1..5c0ab05 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -17,45 +17,8 @@
>  
>  /* Definitions used by the flattened device tree */
>  #define OF_DT_HEADER		0xd00dfeed	/* marker */
> -#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
> -#define OF_DT_END_NODE		0x2		/* End node */
> -#define OF_DT_PROP		0x3		/* Property: name off, size,
> -						 * content */
> -#define OF_DT_NOP		0x4		/* nop */
> -#define OF_DT_END		0x9
> -
> -#define OF_DT_VERSION		0x10
>  
>  #ifndef __ASSEMBLY__
> -/*
> - * This is what gets passed to the kernel by prom_init or kexec
> - *
> - * The dt struct contains the device tree structure, full pathes and
> - * property contents. The dt strings contain a separate block with just
> - * the strings for the property names, and is fully page aligned and
> - * self contained in a page, so that it can be kept around by the kernel,
> - * each property name appears only once in this page (cheap compression)
> - *
> - * the mem_rsvmap contains a map of reserved ranges of physical memory,
> - * passing it here instead of in the device-tree itself greatly simplifies
> - * the job of everybody. It's just a list of u64 pairs (base/size) that
> - * ends when size is 0
> - */
> -struct boot_param_header {
> -	__be32	magic;			/* magic word OF_DT_HEADER */
> -	__be32	totalsize;		/* total size of DT block */
> -	__be32	off_dt_struct;		/* offset to structure */
> -	__be32	off_dt_strings;		/* offset to strings */
> -	__be32	off_mem_rsvmap;		/* offset to memory reserve map */
> -	__be32	version;		/* format version */
> -	__be32	last_comp_version;	/* last compatible version */
> -	/* version 2 fields below */
> -	__be32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
> -	/* version 3 fields below */
> -	__be32	dt_strings_size;	/* size of the DT strings block */
> -	/* version 17 fields below */
> -	__be32	dt_struct_size;		/* size of the DT structure block */
> -};
>  
>  #if defined(CONFIG_OF_FLATTREE)
>  
