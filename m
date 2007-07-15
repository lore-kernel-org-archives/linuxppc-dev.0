Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD763DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 07:41:06 +1000 (EST)
Subject: Re: [PATCH] the wrong variable checked after request_irq()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <E1IAAFp-00053g-Ti@ZenIV.linux.org.uk>
References: <E1IAAFp-00053g-Ti@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 07:40:38 +1000
Message-Id: <1184535638.25235.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-07-15 at 20:59 +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Out of curiosity, how did you pick it up ? You have some automated tool
to catch that (or sparse changes) or you just did -lots- of code
inspection ?

Cheers,
Ben.

> ---
>  arch/powerpc/platforms/pseries/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 470db6e..a031d99 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -176,7 +176,7 @@ static void __init pseries_mpic_init_IRQ(void)
>  		return;
>  
>  	cascade_irq = irq_of_parse_and_map(cascade, 0);
> -	if (cascade == NO_IRQ) {
> +	if (cascade_irq == NO_IRQ) {
>  		printk(KERN_ERR "mpic: failed to map cascade interrupt");
>  		return;
>  	}
