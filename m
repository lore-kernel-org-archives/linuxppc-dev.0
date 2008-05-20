Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F6ECDE643
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:31:26 +1000 (EST)
Message-ID: <48332732.5000805@freescale.com>
Date: Tue, 20 May 2008 14:32:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH] Fix pq2fads irq handling with PREEMPT_RT
References: <20080520192857.3C3E95AF22@innovsys.com>
In-Reply-To: <20080520192857.3C3E95AF22@innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Fix interrupt threading issue on pq2fads when running with CONFIG_PREEMPT_RT
> 
> Signed-off-by: Rune Torgersen <runet@innovsys.com>
> 
> diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> index a801381..9876d7e 100644
> --- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> +++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> @@ -109,7 +109,7 @@ static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
>  {
>  	get_irq_desc(virq)->status |= IRQ_LEVEL;
>  	set_irq_chip_data(virq, h->host_data);
> -	set_irq_chip(virq, &pq2ads_pci_ic);
> +	set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
>  	return 0;
>  }

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
