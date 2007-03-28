Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3343DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 22:43:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix dcr_unmap()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean-Christophe Dubois <jdubois@mc.com>
In-Reply-To: <200703281207.41425.jdubois@mc.com>
References: <200703281207.41425.jdubois@mc.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 22:42:56 +1000
Message-Id: <1175085776.32220.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 11:07 +0100, Jean-Christophe Dubois wrote:
> Fix a bug in dcr_unmap(). 
> 
> At unmap time the DCR offset need to be added instead of substracted.
> 
> Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

If possible that should go in 2.6.21

> Index: linux-2.6.20/arch/powerpc/sysdev/dcr.c
> ===================================================================
> --- linux-2.6.20.orig/arch/powerpc/sysdev/dcr.c
> +++ linux-2.6.20/arch/powerpc/sysdev/dcr.c
> @@ -129,7 +129,7 @@ void dcr_unmap(dcr_host_t host, unsigned
>  
>  	if (h.token == NULL)
>  		return;
> -	h.token -= dcr_n * h.stride;
> +	h.token += dcr_n * h.stride;
>  	iounmap(h.token);
>  	h.token = NULL;
>  }
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
