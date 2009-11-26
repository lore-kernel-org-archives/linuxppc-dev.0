Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/11] of/flattree: merge early_init_devtree() and
	early_init_move_devtree()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20091124081853.6216.68105.stgit@angua>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081853.6216.68105.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:04:08 +1100
Message-ID: <1259208248.16367.230.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:

>  
> -static int __init early_init_dt_scan_cpus(unsigned long node,
> -					  const char *uname, int depth,
> -					  void *data)
> +int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
> +				   int depth, void *data)
>  {

So now you make this one non-static as well with little hope of making
it static ever again

>  	static int logical_cpuid;
>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> @@ -113,8 +112,8 @@ void __init early_init_dt_scan_chosen_arch(unsigned long node)
>  	/* No Microblaze specific code here */
>  }
>  
> -static int __init early_init_dt_scan_memory(unsigned long node,
> -				const char *uname, int depth, void *data)
> +int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> +				     int depth, void *data)
>  {

And this one

>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>  	u32 *reg, *endp;
> @@ -201,7 +200,7 @@ static inline unsigned long phyp_dump_calculate_reserve_size(void)
>   * without reserving anything. The memory in case of dump being
>   * active is freed when the dump is collected (by userland tools).
>   */
> -static void __init phyp_dump_reserve_mem(void)
> +void __init phyp_dump_reserve_mem(void)
>  {

And this one...

>  /**
> + * early_init_move_devtree - move tree to an unused area, if needed.
> + *
> + * The device tree may be allocated beyond our memory limit, or inside the
> + * crash kernel region for kdump. If so, move it out of the way.
> + */
> +#if defined(CONFIG_PPC)
> +static void __init early_init_move_devtree(void)

And you still end up with an ifdef mess in the common code ...

Would it be possible instead to have one common early_init_devtree()
that calls into the "common" ones (which you can then make static again,
inside the common code) and then calls one arch_early_init_devtree()
which regroups the arch specific ones ?

Or there's too many ordering issues ?

Another option then is to call from that early_init_devtree() something
like:

	arch_early_init_dt_mem()
	arch_early_init_dt_cpu()
	arch_early_init_move_devtree()

etc... in the right spots in the common code and have the archs who
don't do anything there just have them as empty inlines.

Cheers,
Ben.
