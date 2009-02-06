Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4995DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:44:58 +1100 (EST)
Message-Id: <53A787DC-EDA9-4961-87D8-75ECB79DA60B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: paulfax <paulfax@conspiracy.net>
In-Reply-To: <497EC957.2050205@conspiracy.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/cpm2 Fix set interrupt type
Date: Fri, 6 Feb 2009 10:44:52 -0600
References: <497EC957.2050205@conspiracy.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 27, 2009, at 2:44 AM, paulfax wrote:

> This is a simple change to correct problems when using set_irq_type  
> on platforms using CPM2.
> This code correct the problem on most platform but still fails on  
> 8272 derived platforms for some interrupts.
> On 8272 PC2 & 3 are missing and PC 23 & 29 are added, which this  
> patch does not address.
>
> Signed-off-by: Paul Bilke <paul at conspiracy.net>
> ---
>
>
>
>
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/ 
> cpm2_pic.c
> index b16ca3e..78f1f7c 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -165,7 +165,7 @@ static int cpm2_set_irq_type(unsigned int virq,  
> unsigned int flow_type)
>                        edibit = (14 - (src - CPM2_IRQ_EXT1));
>        else
>                if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
> -                       edibit = (31 - (src - CPM2_IRQ_PORTC15));
> +                       edibit = (31 - (CPM2_IRQ_PORTC0 - src));
>                else
>                        return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 :  
> -EINVAL;


applied

- k
