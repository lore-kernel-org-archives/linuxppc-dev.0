Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48648DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 01:12:51 +1100 (EST)
Message-Id: <76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "<dayu@datangmobile.cn>" <dayu@datangmobile.cn>
In-Reply-To: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
Date: Tue, 17 Feb 2009 08:12:33 -0600
References: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2009, at 6:44 AM, <dayu@datangmobile.cn> <dayu@datangmobile.cn 
 > wrote:

> From: Da Yu <dayu@datangmobile.cn>
> Date: Tue, 17 Feb 2009 19:58:20 +0800
> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC  
> (2.6.23)
>
> Signed-off-by: Da Yu <dayu@datangmobile.cn>
> ---

Please provide a bit more description as to why this fixes the issue.

- k

>
>
> --- a/arch/powerpc/sysdev/ipic.c	2009-02-17 15:10:18.000000000 +0800
> +++ b/arch/powerpc/sysdev/ipic.c	2009-02-17 20:05:28.000000000 +0800
> @@ -561,8 +561,7 @@ static void ipic_ack_irq(unsigned int vi
>
> 	spin_lock_irqsave(&ipic_lock, flags);
>
> -	temp = ipic_read(ipic->regs, ipic_info[src].pend);
> -	temp |= (1 << (31 - ipic_info[src].bit));
> +	temp = 1 << (31 - ipic_info[src].bit);
> 	ipic_write(ipic->regs, ipic_info[src].pend, temp);
>
> 	spin_unlock_irqrestore(&ipic_lock, flags);
> @@ -581,8 +580,7 @@ static void ipic_mask_irq_and_ack(unsign
> 	temp &= ~(1 << (31 - ipic_info[src].bit));
> 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
>
> -	temp = ipic_read(ipic->regs, ipic_info[src].pend);
> -	temp |= (1 << (31 - ipic_info[src].bit));
> +	temp = 1 << (31 - ipic_info[src].bit);
> 	ipic_write(ipic->regs, ipic_info[src].pend, temp);
>
> 	spin_unlock_irqrestore(&ipic_lock, flags);
