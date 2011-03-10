Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: make MPIC honor the "pic-no-reset"
	device tree property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <4D790901.9000701@mentor.com>
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
	<1298671177-19572-3-git-send-email-meador_inge@mentor.com>
	<1299036140.8833.818.camel@pasglop>  <4D790901.9000701@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Mar 2011 09:13:48 +1100
Message-ID: <1299795228.22236.508.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-10 at 11:23 -0600, Meador Inge wrote:
> AFAIK, we can't rely on 'set_affinity' always being called.  I don't 
> think it is called at all when !defined(CONFIG_SMP) and if it was,
> then that would be an error:
> 
>         /* include/linux/irq.h */
> 
>         #else /* CONFIG_SMP */
> 
>         static inline int irq_set_affinity(unsigned int irq,
>                 const struct cpumask *m)
>         {
>                 return -EINVAL;
>         }

You are right. We do need to set a sane default then.

> > partially initialized in set_type, I'd say just modify set_type to
> > initialize the source as well, and problem solved, no ?
> 
> The priority has to be initialized as well.  They could both be done
> in 
> 'mpic_set_irq_type', but that seems like a weird place since it has 
> nothing to do with actually setting the type.
> 
> Since we already have 'mpic_irq_set_priority' and 'mpic_set_vector', 
> perhaps a better option is to add 'mpic_set_destination' and put the 
> following in 'mpic_host_map' (using the cpuid helper function
> suggested 
> above):
> 
>         /* Lazy source init when MPIC_NO_RESET */
>         if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
>                 mpic_set_vector(virq, hw);
>                 mpic_set_destination(virq, mpic_cpuid(mpic));
>                 mpic_irq_set_priority(virq, 8);
>         }
> 
> It is more overhead, but it reads well.  Thoughts?

No objection.

Cheers,
Ben.
