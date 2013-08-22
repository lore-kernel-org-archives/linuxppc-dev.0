Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97BE62C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 16:21:50 +1000 (EST)
Message-ID: <1377152143.25016.289.camel@pasglop>
Subject: Re: [PATCH v4 03/19] powerpc: refactor of_get_cpu_node to support
 other architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Thu, 22 Aug 2013 16:15:43 +1000
In-Reply-To: <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-20 at 10:30 +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Currently different drivers requiring to access cpu device node are
> parsing the device tree themselves. Since the ordering in the DT need
> not match the logical cpu ordering, the parsing logic needs to consider
> that. However, this has resulted in lots of code duplication and in some
> cases even incorrect logic.
> 
> It's better to consolidate them by adding support for getting cpu
> device node for a given logical cpu index in DT core library. However
> logical to physical index mapping can be architecture specific.
> 
> PowerPC has it's own implementation to get the cpu node for a given
> logical index.
> 
> This patch refactors the current implementation of of_get_cpu_node.
> This in preparation to move the implementation to DT core library.
> It separates out the logical to physical mapping so that a default
> matching of the physical id to the logical cpu index can be added
> when moved to common code. Architecture specific code can override it.

So the patch unfortunately collides with other changes in powerpc -next,
though it's not a huge deal and not hard to fixup, but expect Linus
to tick unless we sort it out some other way.

Appart from that, it's fine, builds on all my test configs and doesn't
seem to negatively impact things as far as I can tell so far...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/powerpc/kernel/prom.c | 76 ++++++++++++++++++++++++++++------------------
>  1 file changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index eb23ac9..f7b8c0b 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -865,45 +865,63 @@ static int __init prom_reconfig_setup(void)
>  __initcall(prom_reconfig_setup);
>  #endif
>  
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +	return (int)phys_id == get_hard_smp_processor_id(cpu);
> +}
> +
> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
> +			const char *prop_name, int cpu, unsigned int *thread)
> +{
> +	const __be32 *cell;
> +	int ac, prop_len, tid;
> +	u64 hwid;
> +
> +	ac = of_n_addr_cells(cpun);
> +	cell = of_get_property(cpun, prop_name, &prop_len);
> +	if (!cell)
> +		return false;
> +	prop_len /= sizeof(*cell);
> +	for (tid = 0; tid < prop_len; tid++) {
> +		hwid = of_read_number(cell, ac);
> +		if (arch_match_cpu_phys_id(cpu, hwid)) {
> +			if (thread)
> +				*thread = tid;
> +			return true;
> +		}
> +		cell += ac;
> +	}
> +	return false;
> +}
> +
>  /* Find the device node for a given logical cpu number, also returns the cpu
>   * local thread number (index in ibm,interrupt-server#s) if relevant and
>   * asked for (non NULL)
>   */
>  struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
>  {
> -	int hardid;
> -	struct device_node *np;
> +	struct device_node *cpun, *cpus;
>  
> -	hardid = get_hard_smp_processor_id(cpu);
> +	cpus = of_find_node_by_path("/cpus");
> +	if (!cpus) {
> +		pr_warn("Missing cpus node, bailing out\n");
> +		return NULL;
> +	}
>  
> -	for_each_node_by_type(np, "cpu") {
> -		const u32 *intserv;
> -		unsigned int plen, t;
> +	for_each_child_of_node(cpus, cpun) {
> +		if (of_node_cmp(cpun->type, "cpu"))
> +			continue;
>  
> -		/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
> -		 * fallback to "reg" property and assume no threads
> +		/* Check for non-standard "ibm,ppc-interrupt-server#s" property
> +		 * for thread ids on PowerPC. If it doesn't exist fallback to
> +		 * standard "reg" property.
>  		 */
> -		intserv = of_get_property(np, "ibm,ppc-interrupt-server#s",
> -				&plen);
> -		if (intserv == NULL) {
> -			const u32 *reg = of_get_property(np, "reg", NULL);
> -			if (reg == NULL)
> -				continue;
> -			if (*reg == hardid) {
> -				if (thread)
> -					*thread = 0;
> -				return np;
> -			}
> -		} else {
> -			plen /= sizeof(u32);
> -			for (t = 0; t < plen; t++) {
> -				if (hardid == intserv[t]) {
> -					if (thread)
> -						*thread = t;
> -					return np;
> -				}
> -			}
> -		}
> +		if (__of_find_n_match_cpu_property(cpun,
> +				"ibm,ppc-interrupt-server#s", cpu, thread))
> +			return cpun;
> +
> +		if (__of_find_n_match_cpu_property(cpun, "reg", cpu, thread))
> +			return cpun;
>  	}
>  	return NULL;
>  }
