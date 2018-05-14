Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kmF42k1GzF3LH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 13:21:12 +1000 (AEST)
Message-ID: <1526268071.30369.20.camel@neuling.org>
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with
 interleaved threads
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 13:21:11 +1000
In-Reply-To: <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
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

Thanks for posting this... A couple of comments below.

On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> A pair of IBM POWER9 SMT4 cores can be fused together to form a
> big-core with 8 SMT threads. This can be discovered via the
> "ibm,thread-groups" CPU property in the device tree which will
> indicate which group of threads that share the L1 cache, translation
> cache and instruction data flow.  If there are multiple such group of
> threads, then the core is a big-core. The thread-ids of the threads of
> the big-core can be obtained by interleaving the thread-ids of the
> thread-groups (component small core).
>=20
> Eg: Threads in the pair of component SMT4 cores of an interleaved
> big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.
>=20
> This patch introduces a function to check if a given device tree node
> corresponding to a CPU node represents an interleaved big-core.
>=20
> This function is invoked during the boot-up to detect the presence of
> interleaved big-cores. The presence of such an interleaved big-core is
> recorded in a global variable for later use.
>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cputhreads.h |  8 +++--
>  arch/powerpc/kernel/setup-common.c    | 63 +++++++++++++++++++++++++++++=
++++-
> -
>  2 files changed, 66 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputhreads.h
> b/arch/powerpc/include/asm/cputhreads.h
> index d71a909..b706f0a 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -23,11 +23,13 @@
>  extern int threads_per_core;
>  extern int threads_per_subcore;
>  extern int threads_shift;
> +extern bool has_interleaved_big_core;
>  extern cpumask_t threads_core_mask;
>  #else
> -#define threads_per_core	1
> -#define threads_per_subcore	1
> -#define threads_shift		0
> +#define threads_per_core		1
> +#define threads_per_subcore		1
> +#define threads_shift			0
> +#define has_interleaved_big_core	0
>  #define threads_core_mask	(*get_cpu_mask(0))
>  #endif
> =20
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-
> common.c
> index 0af5c11..884dff2 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -408,10 +408,12 @@ void __init check_for_initrd(void)
>  #ifdef CONFIG_SMP
> =20
>  int threads_per_core, threads_per_subcore, threads_shift;
> +bool has_interleaved_big_core;
>  cpumask_t threads_core_mask;
>  EXPORT_SYMBOL_GPL(threads_per_core);
>  EXPORT_SYMBOL_GPL(threads_per_subcore);
>  EXPORT_SYMBOL_GPL(threads_shift);
> +EXPORT_SYMBOL_GPL(has_interleaved_big_core);
>  EXPORT_SYMBOL_GPL(threads_core_mask);
> =20
>  static void __init cpu_init_thread_core_maps(int tpc)
> @@ -436,8 +438,56 @@ static void __init cpu_init_thread_core_maps(int tpc=
)
>  	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
>  }
> =20
> -
>  u32 *cpu_to_phys_id =3D NULL;
> +/*
> + * check_for_interleaved_big_core - Checks if the core represented by
> + *	 dn is a big-core whose threads are interleavings of the
> + *	 threads of the component small cores.
> + *
> + * @dn: device node corresponding to the core.
> + *
> + * Returns true if the core is a interleaved big-core.
> + * Returns false otherwise.
> + */
> +static inline bool check_for_interleaved_big_core(struct device_node *dn=
)
> +{
> +	int len, nr_groups, threads_per_group;
> +	const __be32 *thread_groups;
> +	__be32 *thread_list, *first_cpu_idx;
> +	int cur_cpu, next_cpu, i, j;
> +
> +	thread_groups =3D of_get_property(dn, "ibm,thread-groups", &len);
> +	if (!thread_groups)
> +		return false;

Can you document what this property looks like? Seems to be nr_groups,
threads_per_group, thread_list. Can you explain what each of these mean?

If we get configured with an SMT2 big-core (ie. two interleaved SMT1 normal
cores), will this code also work there?

> +
> +	nr_groups =3D be32_to_cpu(*(thread_groups + 1));
> +	if (nr_groups <=3D 1)
> +		return false;
> +
> +	threads_per_group =3D be32_to_cpu(*(thread_groups + 2));
> +	thread_list =3D (__be32 *)thread_groups + 3;
> +
> +	/*
> +	 * In case of an interleaved big-core, the thread-ids of the
> +	 * big-core can be obtained by interleaving the the thread-ids
> +	 * of the component small
> +	 *
> +	 * Eg: On a 8-thread big-core with two SMT4 small cores, the
> +	 * threads of the two component small cores will be
> +	 * {0, 2, 4, 6} and {1, 3, 5, 7}.
> +	 */
> +	for (i =3D 0; i < nr_groups; i++) {
> +		first_cpu_idx =3D thread_list + i * threads_per_group;
> +
> +		for (j =3D 0; j < threads_per_group - 1; j++) {
> +			cur_cpu =3D be32_to_cpu(*(first_cpu_idx + j));
> +			next_cpu =3D be32_to_cpu(*(first_cpu_idx + j + 1));
> +			if (next_cpu !=3D cur_cpu + nr_groups)
> +				return false;
> +		}
> +	}
> +	return true;
> +}
> =20
>  /**
>   * setup_cpu_maps - initialize the following cpu maps:
> @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
>  	vdso_data->processorCount =3D num_present_cpus();
>  #endif /* CONFIG_PPC64 */
> =20
> -        /* Initialize CPU <=3D> thread mapping/
> +	dn =3D of_find_node_by_type(NULL, "cpu");
> +	if (dn) {
> +		if (check_for_interleaved_big_core(dn)) {
> +			has_interleaved_big_core =3D true;
> +			pr_info("Detected interleaved big-cores\n");

Is there a runtime way to check this also?  If the dmesg buffer overflows, =
we
lose this.

Mikey

> +		}
> +		of_node_put(dn);
> +	}
> +
> +	/* Initialize CPU <=3D> thread mapping/
>  	 *
>  	 * WARNING: We assume that the number of threads is the same for
>  	 * every CPU in the system. If that is not the case, then some code
