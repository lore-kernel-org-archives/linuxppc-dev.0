Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKGRg2G73zDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 13:43:43 +1000 (AEST)
In-Reply-To: <1464523432-12605-3-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] powerpc: Avoid load hit store when using
 find_linux_pte_or_hugepte()
Message-Id: <3rKGRg1Mkbz9t6g@ozlabs.org>
Date: Wed,  1 Jun 2016 13:43:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-29-05 at 12:03:52 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> In many cases we disable interrupts right before calling
> find_linux_pte_or_hugepte().
> 
> find_linux_pte_or_hugepte() first checks interrupts are disabled
> before calling __find_linux_pte_or_hugepte():
> 
>         if (!arch_irqs_disabled()) {
>                 pr_info("%s called with irq enabled\n", __func__);
>                 dump_stack();
>         }
>         return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
> 
> We know interrupts are disabled, but since the arch_irqs_*() macros
> are hidden from the compiler with inline assembly, gcc does not. We
> end up with a pretty awful load hit store:
> 
> 	li      r9,0
> 	lbz     r24,570(r13)
> 	stb     r9,570(r13)	<----
> 	lbz     r9,570(r13)	<---- ouch
> 	cmpdi   cr7,r9,0
> 	bne     cr7,c000000000049d30
> 
> Find these cases, and call __find_linux_pte_or_hugepte() directly.

I'd really rather __find_linux_pte_or_hugepte() was an internal detail, rather
than the standard API.

We do already have quite a few uses, but adding more just further spreads the
details about how the implementation works.

So I'm going to drop this in favor of Aneesh's patch to make irqs disabled check
a VM_WARN().

cheers
