Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56BC2DE0EE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 07:31:43 +1000 (EST)
Message-ID: <48C1A4F9.50909@freescale.com>
Date: Fri, 05 Sep 2008 16:30:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: 1MB alignment dma_alloc question
References: <mailman.1.1220580004.22796.linuxppc-embedded@ozlabs.org>
	<CBF4EB06A92A4901B32659109487513E@absolutdaddy>
In-Reply-To: <CBF4EB06A92A4901B32659109487513E@absolutdaddy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:
> Putting together a driver, IMA for ATM in a MPC83xx. Anyway the manual
> states that one of the data structures for the QE needs to be allocated on a
> 1MB boundary in external memory.
> 
> Normally these come in 128/64/32byte boundaries and are easy to self align,
> with some bit logic. However, after reading up on dma_alloc_coherent I see
> that a limitation is that dma cannot span 64K page boundaries.

That sounds like something related to legacy PC DMA.  I doubt there's 
any such limitation in the API itself.

> So this begs a question is their a better way to get a 1MB aligned table?
> Other than allocating almost 2MB of memory and then trying to mask off the
> LSBs? Seems like an awful waste of memory. I guess the real question is
> there a better kernel call that returns already aligned DMA memory?

It looks like allocations will be naturally aligned on powerpc (due to 
coming straight from alloc_pages), though it's probably not guaranteed 
by the API.

-Scott
