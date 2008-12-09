Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B6D8DDF14
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 00:10:18 +1100 (EST)
Message-Id: <1F81A57A-19A9-4A1A-AE71-51BEFF8D8192@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081209065204.2614647526@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Add SMP support to no-hash TLB handling v3
Date: Tue, 9 Dec 2008 07:10:03 -0600
References: <20081209065204.2614647526@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long  
> vmaddr)
> +{
> +	unsigned int pid;
> +
> +	preempt_disable();
> +	pid = vma ? vma->vm_mm->context.id : 0;
> +	if (pid != MMU_NO_CONTEXT)
> +		_tlbil_va(vmaddr, pid);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(local_flush_tlb_page);

We are using this in highmem.h for kmap_atomic.. So you need to fix  
that call site.

- k
