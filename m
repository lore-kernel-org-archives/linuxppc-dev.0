Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpKBy5cQLzDrb0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 11:15:54 +1000 (AEST)
Date: Fri, 8 Sep 2017 11:15:47 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mikey@neuling.org,
 npiggin@gmail.com, paulus@samba.org, bharata@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
Message-ID: <20170908111547.0f30e1a5@kryten>
In-Reply-To: <20170907155902.kpzhgqqsxbwxwce5@arbab-laptop.localdomain>
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
 <20170907151741.41ee33a8@kryten>
 <20170907155902.kpzhgqqsxbwxwce5@arbab-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Reza,

> I may be misunderstanding this, but what if we did something like x86 
> does? When trying to unplug a region smaller than the mapping, they
> fill that part of the pagetable with 0xFD instead of freeing the
> whole thing. Once the whole thing is 0xFD, free it.
> 
> See arch/x86/mm/init_64.c:remove_{pte,pmd,pud}_table()
> 
> ---%<---
> 	memset((void *)addr, PAGE_INUSE, next - addr);
> 
> 	page_addr = page_address(pte_page(*pte));
> 	if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
> 		...
> 		pte_clear(&init_mm, addr, pte);
> 		...
> 	}
> ---%<---

But you only have 1GB ptes at this point, you'd need to start
instantiating a new level in the tree, and populate 2MB ptes.

That is what Ben is suggesting. I'm happy to go any way (fix hotplug
to handle this, or increase the memblock size on PowerNV to 1GB), I just
need a solution.

Anton
