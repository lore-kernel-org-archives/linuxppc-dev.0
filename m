Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BC7DDDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 20:27:38 +1100 (EST)
Subject: Re: [PATCH 4/4] Use of_find_node_with_property() in pmac_setup_arch()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <cf9d9fddba10efbfd006706d6c5e2e201ff80c67.1226550015.git.michael@ellerman.id.au>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
	<cf9d9fddba10efbfd006706d6c5e2e201ff80c67.1226550015.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 13 Nov 2008 20:27:25 +1100
Message-Id: <1226568445.7178.47.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-13 at 15:20 +1100, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> ---
>  arch/powerpc/platforms/powermac/setup.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index 82c14d2..1293772 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -310,9 +310,7 @@ static void __init pmac_setup_arch(void)
>  	}
>  
>  	/* See if newworld or oldworld */
> -	for (ic = NULL; (ic = of_find_all_nodes(ic)) != NULL; )
> -		if (of_get_property(ic, "interrupt-controller", NULL))
> -			break;
> +	ic = of_find_node_with_property(NULL, "interrupt-controller");
>  	if (ic) {
>  		pmac_newworld = 1;
>  		of_node_put(ic);
