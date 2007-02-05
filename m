Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D02A8DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:18:41 +1100 (EST)
Subject: Re: [PATCH] Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20070205193310.GA12412@Krystal>
References: <20070205193310.GA12412@Krystal>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 07:18:35 +1100
Message-Id: <1170706715.2620.126.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-05 at 14:33 -0500, Mathieu Desnoyers wrote:
> Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
> 
> A missing structure forward declaration causes a lot of warnings when
> compiling for a powerpc 405. Because this header is used for assembly
> too, the declaration must be put within #ifndef __ASSEMBLY__, as should
> be the function prototypes.
> 
> This patch applies on 2.6.20.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Out of curiosity, are you working on 405 support for arch/powerpc ?

Ben.

> --- a/include/asm-powerpc/dcr.h
> +++ b/include/asm-powerpc/dcr.h
> @@ -33,10 +33,13 @@
>   * base from the device-tree
>   */
>  #ifdef CONFIG_PPC_MERGE
> +#ifndef __ASSEMBLY__
> +struct device_node;
>  extern unsigned int dcr_resource_start(struct device_node *np,
>  				       unsigned int index);
>  extern unsigned int dcr_resource_len(struct device_node *np,
>  				     unsigned int index);
> +#endif
>  #endif /* CONFIG_PPC_MERGE */
>  
>  #endif /* CONFIG_PPC_DCR */
