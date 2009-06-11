Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2A4EFB7147
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 10:50:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D325DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 10:50:58 +1000 (EST)
Subject: Re: next branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090610175602.722bf68d@lappy.seanm.ca>
References: <1242890760.5109.1.camel@pasglop>
	<20090610175602.722bf68d@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 10:50:52 +1000
Message-Id: <1244681452.5739.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 17:56 -0400, Sean MacLennan wrote:
> What ever happened to this patch?

Dunno... It should have been in patchwork. I remember the patch
in fact and I intended to merge it... Can you re-submit with appropriate
cset comment, signed-off-by etc... ?

(Mistakes -do- happen, which is why we can be flexible with the rules,
btw, but heh, 33 new patches the day the merge window opens is a bit
over the top).

Cheers,
Ben.

> diff --git b/arch/powerpc/platforms/44x/warp.c
> a/arch/powerpc/platforms/44x/warp.c index c511880..7f3c1c7 100644
> --- b/arch/powerpc/platforms/44x/warp.c
> +++ a/arch/powerpc/platforms/44x/warp.c
> @@ -43,7 +43,13 @@ static int __init warp_probe(void)
>  {
>  	unsigned long root = of_get_flat_dt_root();
>  
> -	return of_flat_dt_is_compatible(root, "pika,warp");
> +	if (!of_flat_dt_is_compatible(root, "pika,warp"))
> +		return 0;
> +
> +	/* For __dma_alloc_coherent */
> +	ISA_DMA_THRESHOLD = ~0L;
> +
> +	return 1;
>  }
>  
> I don't see it in patchworks and I don't see it in Ben's or Josh's tree.
> 
> Cheers,
>    Sean
