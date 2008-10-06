Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 52ED7DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 07:41:22 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so672543qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Oct 2008 13:41:20 -0700 (PDT)
Message-ID: <48EA77EF.6080502@genesi-usa.com>
Date: Mon, 06 Oct 2008 15:41:19 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
In-Reply-To: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a simple problem with the patch which is that an "IRQ 0" can and does
actually exist on a bunch of platforms, at least to the best of my knowledge.

Checking for -1 (which means for definite, no irq at all, because it is
totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.

The problem is the check against an unsigned value for interrupts (is there
any reason why you would need 4 billion interrupts possible instead of just
2 billion?) although I must say, the patch will work, and probably 99.9999999%
of people will never see a problem with it :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Anton Vorontsov wrote:
> When no irq specified the pata_of_platform fills the irq_res with -1,
> which is wrong to do for two reasons:
> 
> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>    is unsigned type, the check will be true for `-1'.
> 
> Reported-by: Steven A. Falco <sfalco@harris.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Resending again...
> 
>  drivers/ata/pata_of_platform.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 408da30..1f18ad9 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
>  
>  	ret = of_irq_to_resource(dn, 0, &irq_res);
>  	if (ret == NO_IRQ)
> -		irq_res.start = irq_res.end = -1;
> +		irq_res.start = irq_res.end = 0;
>  	else
>  		irq_res.flags = 0;
>  
