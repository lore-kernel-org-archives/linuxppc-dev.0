Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8698668430
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2005 11:40:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20051009202301.GC21977@colo.lackof.org>
References: <20051009202301.GC21977@colo.lackof.org>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 11:37:45 +1000
Message-Id: <1128908266.17365.107.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: pmd_alloc() usage incorrect?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-09 at 14:23 -0600, Grant Grundler wrote:
> Hi,
> I stumbled across what looks like incorrect code in
> arch/ppc/kernel/dma-mapping.c:
> 
> static int __init dma_alloc_init(void)
> {
> ...
>         do {
>                 pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
>                 pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
>                 if (!pmd) {
> ...
> 
> Doesn't pmd_alloc() want a pud_t * for the second parameter?
> ie also need to call pud_alloc() or the equivalent.
> 
> I've very little clue how this works...just looking at different
> bits of code in my quest to understand it well enough to enable
> USE_HPPA_IOREMAP in include/asm-parisc/io.h.

In theory you are right... However, ppc32 uses a 2 level page tables, so
this doesn't matter, pud is folded into pgd (and pmd too in fact, you
probably don't need it neither). It would still be nicer to do the full
conversion to pud types though.

Ben.
