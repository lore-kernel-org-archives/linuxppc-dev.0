Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B1E2474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 07:09:57 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add SMP support to no-hash TLB handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1F81A57A-19A9-4A1A-AE71-51BEFF8D8192@freescale.com>
References: <20081209065204.2614647526@ozlabs.org>
	<1F81A57A-19A9-4A1A-AE71-51BEFF8D8192@freescale.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 07:07:47 +1100
Message-Id: <1228853267.22413.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-09 at 07:10 -0600, Kumar Gala wrote:
> > +void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long  
> > vmaddr)
> > +{
> > +	unsigned int pid;
> > +
> > +	preempt_disable();
> > +	pid = vma ? vma->vm_mm->context.id : 0;
> > +	if (pid != MMU_NO_CONTEXT)
> > +		_tlbil_va(vmaddr, pid);
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL(local_flush_tlb_page);
> 
> We are using this in highmem.h for kmap_atomic.. So you need to fix  
> that call site.

Ah yes, I forgot, will fix, thanks.

Cheers,
Ben.
