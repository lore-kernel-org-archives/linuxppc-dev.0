Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2944DDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 13:40:53 +1100 (EST)
Date: Tue, 17 Feb 2009 20:43:12 -0600
From: Olof Johansson <olof@lixom.net>
To: dayu@datangmobile.cn
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc IPIC
	(2.6.25-2.6.28)
Message-ID: <20090218024312.GA14848@lixom.net>
References: <D728AD1FA2543948B89DE29C5BF4CD0716AC37FD@bjmail1.bj.datangmobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D728AD1FA2543948B89DE29C5BF4CD0716AC37FD@bjmail1.bj.datangmobile.com>
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 18, 2009 at 10:16:07AM +0800, dayu@datangmobile.cn wrote:
> From: Da Yu <dayu@datangmobile.cn>
> Date: Wed, 18 Feb 2009 19:58:20 +0800
> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.25-2.6.28)
> 
> Signed-off-by: Da Yu <dayu@datangmobile.cn>

Still no proper explanation in the patch.

Also, with this change, is 'temp' really needed, or can you just pass in the
mask by hand?


-Olof

> ---
> 
> --- a/arch/powerpc/sysdev/ipic.c	2009-02-18 09:47:04.000000000 +0800
> +++ b/arch/powerpc/sysdev/ipic.c	2009-02-18 09:46:34.000000000 +0800
> @@ -568,8 +568,7 @@ static void ipic_ack_irq(unsigned int vi
> 
>  	spin_lock_irqsave(&ipic_lock, flags);
> 
> -	temp = ipic_read(ipic->regs, ipic_info[src].ack);
> -	temp |= (1 << (31 - ipic_info[src].bit));
> +	temp = 1 << (31 - ipic_info[src].bit);
>  	ipic_write(ipic->regs, ipic_info[src].ack, temp);
> 
>  	/* mb() can't guarantee that ack is finished.  But it does finish
