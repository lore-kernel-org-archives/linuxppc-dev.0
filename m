Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF1967A45
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 08:27:51 +1000 (EST)
In-Reply-To: <20050625151105.GB32117@logos.cnet>
References: <20050625151105.GB32117@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <08634a569d62eb8cd1de1858cd58ab43@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 25 Jun 2005 18:27:35 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Kumar Gala <galak@freescale.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: merge 8xx longstanding MM bug workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 25, 2005, at 11:11 AM, Marcelo Tosatti wrote:

>  		if (!PageReserved(page)
>  		    && !test_bit(PG_arch_1, &page->flags)) {
>  			if (vma->vm_mm == current->active_mm)
> +#ifdef CONFIG_8xx
> +/* On 8xx, cache control instructions (particularly "dcbst" from
> + * flush_dcache_icache) fault as write operation if there is an
> + * unpopulated TLB entry for the address in question. To workaround
> + * that, we invalidate the TLB here, thus avoiding dcbst misbehaviour.
> + */
> +			_tlbie(address);
> +#endif
>  				__flush_dcache_icache((void *) address);
>  			else
>  				flush_dcache_icache_page(page);

You need some { } and proper indenting here :-)

Thanks.


	-- Dan
