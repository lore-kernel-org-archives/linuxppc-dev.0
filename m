Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6700DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:38:33 +1000 (EST)
Date: Sat, 20 Oct 2007 11:37:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] synchronize_irq needs a barrier
Message-ID: <20071020033752.GA20760@gondor.apana.org.au>
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710200402.43106.maximlevitsky@gmail.com>
Cc: akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 20, 2007 at 02:02:42AM +0000, Maxim Levitsky wrote:
>
> Thus I now understand that .suspend() should do:
> 
> 	saa_writel(SAA7134_IRQ1, 0);
> 	saa_writel(SAA7134_IRQ2, 0);
> 	saa_writel(SAA7134_MAIN_CTRL, 0);
> 
> 	dev->insuspend = 1;
> 	smp_wmb();

If we patch synchronize_irq() as discussed here then you can
use it in place of smp_wmb() and remove the smp_rmb from the
interrupt handler (the latter is the path that matters).

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
