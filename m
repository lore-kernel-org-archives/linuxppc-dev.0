Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1291968050
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 04:02:47 +1000 (EST)
Date: Thu, 18 Aug 2005 14:56:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050818175642.GA7523@dmt.cnet>
References: <521x4tha7i.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521x4tha7i.fsf@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PPC: Don't sleep in flush_dcache_icache_page()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Roland,

On Tue, Aug 16, 2005 at 01:56:49PM -0700, Roland Dreier wrote:
> flush_dcache_icache_page() will be called on an instruction page
> fault.  We can't sleep in the fault handler, so use kmap_atomic()
> instead of just kmap() for the Book-E case.
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Why do you need to disable interrupts during the kmap_atomic/flush_dcache_icache
operation ? 

I fail to see how an interrupt could have any reference to the data
being dealt with here (the user page).

> diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
> --- a/arch/ppc/mm/init.c
> +++ b/arch/ppc/mm/init.c
> @@ -560,8 +560,16 @@ void flush_dcache_page(struct page *page
>  void flush_dcache_icache_page(struct page *page)
>  {
>  #ifdef CONFIG_BOOKE
> -	__flush_dcache_icache(kmap(page));
> -	kunmap(page);
> +	unsigned long flags;
> +	void *start;
> +
> +	local_irq_save(flags);
> +
> +	start = kmap_atomic(page, KM_PPC_SYNC_PAGE);
> +	__flush_dcache_icache(start);
> +	kunmap_atomic(start, KM_PPC_SYNC_PAGE);
> +
> +	local_irq_restore(flags);
>  #elif CONFIG_8xx
>  	/* On 8xx there is no need to kmap since highmem is not supported */
>  	__flush_dcache_icache(page_address(page)); 
