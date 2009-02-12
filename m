Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC patch] powerpc: Add topology_ready to machdep calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <49935F81.7060203@am.sony.com>
References: <49935F81.7060203@am.sony.com>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 15:21:09 +1100
Message-Id: <1234412469.29851.40.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-11 at 15:30 -0800, Geoff Levand wrote:
> Add a new member topology_ready to the powerpc machdep_calls
> structure.
> 
> The NUMA hot plug memory routines require the NUMA node to have
> been registered via register_one_node() prior to adding memory
> to the node.  The powerpc arch registers NUMA nodes during
> startup in its topology_init() routine.
> 
> Currently, there is no mechanism for the platform code to know
> when the nodes have been registered, and hence, when it is safe
> to add hot plug memory.

No objection other than the confusion with the /* Optional may be NULL
*/ comment above the line you added that becomes weirdly placed since
it applies, I think, to show_cpuinfo.

Cheers,
Ben.

> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/include/asm/machdep.h |    1 +
>  arch/powerpc/kernel/sysfs.c        |    3 +++
>  2 files changed, 4 insertions(+)
> 
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -106,6 +106,7 @@ struct machdep_calls {
>  	void		(*setup_arch)(void); /* Optional, may be NULL */
>  	void		(*init_early)(void);
>  	/* Optional, may be NULL. */
> +	void		(*topology_ready)(void); /* Optional, may be NULL */
>  	void		(*show_cpuinfo)(struct seq_file *m);
>  	void		(*show_percpuinfo)(struct seq_file *m, int i);
>  
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -647,6 +647,9 @@ static int __init topology_init(void)
>  			register_cpu_online(cpu);
>  	}
>  
> +	if (ppc_md.topology_ready)
> +		ppc_md.topology_ready();
> +
>  	return 0;
>  }
>  subsys_initcall(topology_init);
> 
