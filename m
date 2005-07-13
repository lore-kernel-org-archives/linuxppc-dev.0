Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8486B67C1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 10:11:38 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Autran <gautran@mrv.com>
In-Reply-To: <42D3D277.106@mrv.com>
References: <42D3D277.106@mrv.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 10:09:52 +1000
Message-Id: <1121213392.31924.399.camel@gaston>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix destroy_context() race condition
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-07-12 at 10:23 -0400, Guillaume Autran wrote:
> Fix for a race condition when a task gets preempted by another task
> while executing the destroy_context(...) in a FEW_CONTEXTS environment.
> mm->context == NO_CONTEXT but the context_map may indicate all contexts
> are in use.
> The solution to this problem is to disable kernel preemption while
> destroying a MMU context.
> 
> Signed-off-by: Guillaume Autran <gautran@mrv.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> ---
> 
> diff -Nru a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
> --- a/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
> +++ b/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
> @@ -149,6 +149,7 @@
>  */
> static inline void destroy_context(struct mm_struct *mm)
> {
> +	preempt_disable();
> 	if (mm->context != NO_CONTEXT) {
> 		clear_bit(mm->context, context_map);
> 		mm->context = NO_CONTEXT;
> @@ -156,6 +157,7 @@
> 		atomic_inc(&nr_free_contexts);
> #endif
> 	}
> +	preempt_enable();
> }
> 
> static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> 
> 
> 
> 
> 
