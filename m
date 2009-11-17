Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F38EEB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 13:03:57 +1100 (EST)
Subject: Re: [PATCH 10/13] mac68k: start CUDA early
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
In-Reply-To: <alpine.OSX.2.00.0911031502250.483@silk.local>
References: <alpine.OSX.2.00.0911031502250.483@silk.local>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 13:03:41 +1100
Message-ID: <1258423421.2140.555.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-04 at 00:46 +1100, Finn Thain wrote:
> The valkyriefb driver needs the CUDA to work in order to set the video 
> mode at boot. Initialising the device earlier, and bring the m68k code 
> closer to the powermac code.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Hi Finn !

> @@ -224,20 +249,9 @@ cuda_probe(void)
>  static int __init
>  cuda_init(void)
>  {
> -#ifdef CONFIG_PPC
>      if (via == NULL)
>  	return -ENODEV;
>      return 0;
> -#else 
> -    int err = cuda_init_via();
> -    if (err) {
> -	printk(KERN_ERR "cuda_init_via() failed\n");
> -	return -ENODEV;
> -    }
> -    out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from SR */
> -
> -    return via_cuda_start();
> -#endif
>  }
>  #endif /* CONFIG_ADB */

Can't we just get rid of cuda_init() completely ?
 
> @@ -430,9 +444,12 @@ cuda_poll(void)
>      /* cuda_interrupt only takes a normal lock, we disable
>       * interrupts here to avoid re-entering and thus deadlocking.
>       */
> -    disable_irq(cuda_irq);
> -    cuda_interrupt(0, NULL);
> -    enable_irq(cuda_irq);
> +    if (cuda_fully_inited) {
> +	disable_irq(cuda_irq);
> +	cuda_interrupt(0, NULL);
> +	enable_irq(cuda_irq);
> +    } else
> +	cuda_interrupt(0, NULL);
>  }

Wouldn't it be better that way ?

	if (cuda_irq)
		disable_irq(cuda_irq);
	cuda_interrupt(0, NULL);
	if (cuda_irq)
		enable_irq(cuda_irq);

Cheers,
Ben.
