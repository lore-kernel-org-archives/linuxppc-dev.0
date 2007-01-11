Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com (unknown [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3E1CDDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 01:22:12 +1100 (EST)
In-Reply-To: <200701110627.l0B6RGn1001140@jupiter.etinsys.com>
References: <200701110627.l0B6RGn1001140@jupiter.etinsys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6EAF2EA8-8414-4A4A-9A9A-44AA2FDC8B9D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] kvme080 board support patch
Date: Thu, 11 Jan 2007 08:21:23 -0600
To: Sangmoon Kim <dogoil@etinsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2007, at 12:26 AM, Sangmoon Kim wrote:

> Hi,
>
> This patch add supports for kvme080 board to linux-2.6.20-rc4 kernel.
> kvme080 is a VME board with PowerPC MPC8245 processor.
> It has 128MB memory, 2 Ethernets, 4 UARTs and a VME interface.
>
> Regards,
> Sangmoon Kim
>
> Signed-off-by: Sangmoon Kim <dogoil@etinsys.com>
>

>
> +static void
> +kvme080_restart(char *cmd)
> +{
> +	unsigned long srr;
> +
> +	local_irq_disable();
> +	asm volatile(
> +	" lis %0,0xfff0\n \
> +	  ori %0,%0,0x0100\n \
> +	  mtspr 26,%0\n \
> +	  sync\n \
> +	  lis %0,0x0000\n \
> +	  ori %0,%0,0x0000\n \
> +	  mtspr 27,%0\n \
> +	  sync\n \
> +	  rfi "
> +	  : "=r" (srr));
> +}

Does this restart actually work for you?  Do you not have any issues  
with devices being in a funny state and not actually being restated?

Also, you can do mtspr(SPRN_SRR0, val); mtspr(SPRN_SRR1, val); and  
then the asm for the "rfi".

- k
