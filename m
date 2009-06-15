Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B7A1B713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 11:49:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDA8EDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 11:49:29 +1000 (EST)
Subject: Re: [PATCH] powerpc: Make RTAS instantiation depend on CONFIG_PPC_RTAS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <56982642b8954ea193ae48c5d02e8dbd84d72f17.1244779685.git.michael@ellerman.id.au>
References: <56982642b8954ea193ae48c5d02e8dbd84d72f17.1244779685.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 11:49:14 +1000
Message-Id: <1245030554.19217.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 14:08 +1000, Michael Ellerman wrote:
> Currently prom_init.c always instantiates RTAS, even if the kernel
> is built without RTAS support - that seems wrong.

Nak :-)

We want to always instantiate it from prom_init.c because we can't do
it any more later. There's the vague possibility that you may want to
boot a non-RTAS kernel which then kexec's into an RTAS kernel, and that
isn't possible if the initial prom_init.c didn't instanciate RTAS and
put a reference to it in the flat device-tree.

Cheers,
Ben.

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/prom_init.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 2f0e64b..6c2dc59 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1052,6 +1052,7 @@ static void __init prom_init_mem(void)
>  }
>  
> 
> +#ifdef CONFIG_PPC_RTAS
>  /*
>   * Allocate room for and instantiate RTAS
>   */
> @@ -1109,6 +1110,9 @@ static void __init prom_instantiate_rtas(void)
>  
>  	prom_debug("prom_instantiate_rtas: end...\n");
>  }
> +#else
> +static inline void prom_instantiate_rtas(void) { }
> +#endif /* CONFIG_PPC_RTAS */
>  
>  #ifdef CONFIG_PPC64
>  /*
