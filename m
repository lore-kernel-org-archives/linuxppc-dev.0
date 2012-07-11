Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C218C2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:37:08 +1000 (EST)
Message-ID: <1341985013.18850.29.camel@pasglop>
Subject: Re: [PATCH] [powerpc] Export memory limit via device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 11 Jul 2012 15:36:53 +1000
In-Reply-To: <20120702114855.22333.95335.stgit@suzukikp.in.ibm.com>
References: <20120702114855.22333.95335.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index c957b12..0c9695d 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -207,6 +207,12 @@ static struct property crashk_size_prop = {
>  	.value = &crashk_size,
>  };
>  
> +static struct property memory_limit_prop = {
> +	.name = "linux,memory-limit",
> +	.length = sizeof(phys_addr_t),
> +	.value = &memory_limit,
> +};
> +

AFAIK. phys_addr_t can change size, so instead make it point to a known
fixes size quantity (a u64).

> +
> +	/* memory-limit is needed for constructing the crash regions */
> +	prop = of_find_property(node, memory_limit_prop.name, NULL);
> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	if (memory_limit)
> +		prom_add_property(node, &memory_limit_prop);
> +

There's a patch floating around making prom_update_property properly
handle both pre-existing and non-pre-existing props, you should probably
base yourself on top of it. I'm about to stick that patch in powerpc
-next

Cheers,
Ben.
