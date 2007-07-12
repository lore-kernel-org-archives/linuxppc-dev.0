Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95200DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 10:30:51 +1000 (EST)
Subject: Re: [PATCH 5/5] Add dcr_map_reg() helper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <4c7183d665eed57f8ef2067c1f2c71b3c0e5246c.1182493056.git.michael@ellerman.id.au>
References: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
	<4c7183d665eed57f8ef2067c1f2c71b3c0e5246c.1182493056.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 10:30:42 +1000
Message-Id: <1184200242.6059.127.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-22 at 16:18 +1000, Michael Ellerman wrote:
> Add a helper routine to map dcr's based on the "dcr-reg" property of
> a device node.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/dcr.c |   17 +++++++++++++++++
>  include/asm-powerpc/dcr.h |    1 +
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
> index f3c5646..da2ac7c 100644
> --- a/arch/powerpc/sysdev/dcr.c
> +++ b/arch/powerpc/sysdev/dcr.c
> @@ -123,6 +123,23 @@ dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
>  	return ret;
>  }
>  
> +dcr_host_t dcr_map_reg(struct device_node *dev, unsigned int index)
> +{
> +	dcr_host_t ret = { .token = NULL };
> +
> +	unsigned int dcr_n, dcr_c;
> +
> +	dcr_n = dcr_resource_start(dev, index);
> +	if (!dcr_n)
> +		return ret;
> +
> +	dcr_c = dcr_resource_len(dev, index);
> +	if (!dcr_c)
> +		return ret;
> +
> +	return dcr_map(dev, dcr_n, dcr_c);
> +}
> +
>  void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c)
>  {
>  	dcr_host_t h = host;
> diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
> index 9338d50..4d42f01 100644
> --- a/include/asm-powerpc/dcr.h
> +++ b/include/asm-powerpc/dcr.h
> @@ -38,6 +38,7 @@ extern unsigned int dcr_resource_start(struct device_node *np,
>  				       unsigned int index);
>  extern unsigned int dcr_resource_len(struct device_node *np,
>  				     unsigned int index);
> +extern dcr_host_t dcr_map_reg(struct device_node *np, unsigned int index);
>  #endif /* CONFIG_PPC_MERGE */
>  
>  #endif /* CONFIG_PPC_DCR */
