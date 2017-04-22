Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w94p658gBzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 18:02:22 +1000 (AEST)
Message-ID: <1492848130.25766.185.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 22 Apr 2017 18:02:10 +1000
In-Reply-To: <20170422005854.17128-2-npiggin@gmail.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-04-22 at 10:58 +1000, Nicholas Piggin wrote:
> +static void __init init_mmu_tlb_sets_hash(unsigned long node)
> +{
> +       const __be32 *ptr;
> +
> +       ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-hash", NULL);
> +       if (ptr)
> +               cur_cpu_spec->tlb_sets_hash = be32_to_cpup(ptr);
> +}
> +
> +static void __init init_mmu_tlb_sets_radix(unsigned long node)
> +{
> +       const __be32 *ptr;
> +
> +       ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-radix", NULL);
> +       if (ptr)
> +               cur_cpu_spec->tlb_sets_radix = be32_to_cpup(ptr);
> +}
>  #else
>  #define init_mmu_slb_size(node) do { } while(0)
> +#define init_mmu_hash_sets(node) do { } while(0)
> +#define init_mmu_radix_sets(node) do { } while(0)
>  #endif

Why 2 functions ? I would have done one checking both props :-)

Anothe thing to do is remove the assembly TLB flush from cpu_setup_power.S.

That happens too early anyway and do it later, at MMU init.

In fact, I wonder ... a lot of the stuff in there still requires us to more
or less know the PVR of the CPU. We could move the call to after we've done
the early DT parsing I reckon.

That way we can use arch level to set things like LPCR appropriately.

Cheers,
Ben.
