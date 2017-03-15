Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjpxt0SclzDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:18:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
In-Reply-To: <20170302004920.21948-1-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:18:22 +1100
Message-ID: <877f3qlrep.fsf@concordia.ellerman.id.au>
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

> To determine which logical CPUs are on the same core the kernel uses the
> ibm,chipid property from the device tree node associated with that cpu.
> The lookup for this this information is currently open coded in both
> traverse_siblings() and traverse_siblings_chip_id(). This patch replaces
> these manual lookups with the existing cpu_to_chip_id() function.

Some minor nits.

cpu_to_chip_id() actually searches recursively up the parents until it
finds a ibm,chip-id, so it's not a 1:1 replacement for the existing
logic, but it's probably still an OK conversion. It's still worth
mentioning in the change log thought.

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 893bd7f79be6..dfe0e1d9cd06 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -664,23 +655,19 @@ static void traverse_core_siblings(int cpu, bool add)
>  {
>  	struct device_node *l2_cache, *np;
>  	const struct cpumask *mask;
> -	int i, chip, plen;
> -	const __be32 *prop;
> +	int chip_id;
> +	int i;
>  
> -	/* First see if we have ibm,chip-id properties in cpu nodes */
> -	np = of_get_cpu_node(cpu, NULL);
> -	if (np) {
> -		chip = -1;
> -		prop = of_get_property(np, "ibm,chip-id", &plen);
> -		if (prop && plen == sizeof(int))
> -			chip = of_read_number(prop, 1);
> -		of_node_put(np);
> -		if (chip >= 0) {
> -			traverse_siblings_chip_id(cpu, add, chip);
> -			return;
> -		}
> +	/* threads that share a chip-id are considered siblings (same die) */

You might know it means the "same die", but AFAIK there's no actual
definition for what the chip-id means, so let's not write comments that
might be wrong in future. Just saying they're considered siblings is
sufficient.

Also "Threads" :)

cheers
