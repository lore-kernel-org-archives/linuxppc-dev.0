Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjpxz6DJ7zDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:18:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 2/5] powerpc/smp: add set_cpus_related()
In-Reply-To: <20170302004920.21948-2-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-2-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:18:31 +1100
Message-ID: <8760jalreg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index dfe0e1d9cd06..1c531887ca51 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -377,6 +377,25 @@ static void smp_store_cpu_info(int id)
>  #endif
>  }
>  
> +/*
> + * Relationships between CPUs are maintained in a set of per-cpu cpumasks. We
> + * need to ensure that they are kept consistant between CPUs when they are
> + * changed.
> + *
> + * This is slightly tricky since the core mask must be a strict superset of
> + * the sibling mask.
> + */
> +static void set_cpus_related(int i, int j, bool related, struct cpumask *(*relation_fn)(int))
> +{
> +	if (related) {
> +		cpumask_set_cpu(i, relation_fn(j));
> +		cpumask_set_cpu(j, relation_fn(i));
> +	} else {
> +		cpumask_clear_cpu(i, relation_fn(j));
> +		cpumask_clear_cpu(j, relation_fn(i));
> +	}
> +}

I think you pushed the abstraction one notch too far on this one, or
perhaps not far enough.

We end up with a function called "set" that might clear, depending on a
bool you pass. Which is hard to parse, eg:

	set_cpus_related(cpu, base + i, false, cpu_sibling_mask);

And I know there's two places where we pass an existing bool "add", but
there's four where we pass true or false.

If we want to push it in that direction I think we should just pass the
set/clear routine instead of the flag, so:

	do_cpus_related(cpu, base + i, cpumask_clear_cpu, cpu_sibling_mask);

But that might be overdoing it.

So I think we should just do:

static void set_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
{
        cpumask_set_cpu(i, mask_func(j));
        cpumask_set_cpu(j, mask_func(i));
}

static void clear_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
{
        cpumask_clear_cpu(i, mask_func(j));
        cpumask_clear_cpu(j, mask_func(i));
}


So the cases with add become:

	if (add)
		set_cpus_related(cpu, i, cpu_core_mask(i));
	else
		clear_cpus_related(cpu, i, cpu_core_mask(i));

Which is not as pretty but more explicit.

And the other cases look much better, eg:

	clear_cpus_related(cpu, base + i, cpu_sibling_mask);

??

cheers
