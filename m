Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 87EB967B7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 02:39:23 +1000 (EST)
Date: Tue, 12 Jul 2005 09:39:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20050712163921.GE25918@gate.ebshome.net>
References: <42D3D277.106@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42D3D277.106@mrv.com>
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

On Tue, Jul 12, 2005 at 10:23:51AM -0400, Guillaume Autran wrote:
> Fix for a race condition when a task gets preempted by another task
> while executing the destroy_context(...) in a FEW_CONTEXTS environment.
> mm->context == NO_CONTEXT but the context_map may indicate all contexts
> are in use.
> The solution to this problem is to disable kernel preemption while
> destroying a MMU context.
> 
> Signed-off-by: Guillaume Autran <gautran@mrv.com>
> 
> ---
> 
> diff -Nru a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
> --- a/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
> +++ b/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
> @@ -149,6 +149,7 @@
> */
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

Could you explain, why this patch is needed?

AFAIK, destroy_context() is only called from switch_mm(), which in 
turn is called from schedule() with preemption already disabled. If 
not, IMHO we have bigger problems, and "fixing" destroy_context() will 
only hide such problems.

-- 
Eugene
