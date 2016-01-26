Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 352C91A114D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 05:52:42 +1100 (AEDT)
Date: Tue, 26 Jan 2016 12:52:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
 Will.Deacon@arm.com, catalin.marinas@arm.com,
 grant.likely@linaro.org, leif.lindholm@linaro.org,
 rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com,
 robh+dt@kernel.org, steve.capper@linaro.org, hanjun.guo@linaro.org,
 al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org,
 marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
 bhelgaas@google.com, tony.luck@intel.com, fenghua.yu@intel.com,
 james.hogan@imgtec.com, benh@kernel.crashing.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 jonathan@jonmasters.org, rrichter@cavium.com,
 Prasun.Kapoor@caviumnetworks.com, gpkulkarni@gmail.com
Subject: Re: [PATCH v9 1/6] arm64, numa: adding numa support for arm64
 platforms.
Message-ID: <20160126185238.GB17600@localhost>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-2-git-send-email-gkulkarni@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453134965-6125-2-git-send-email-gkulkarni@caviumnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 18, 2016 at 10:06:00PM +0530, Ganapatrao Kulkarni wrote:
> Adding numa support for arm64 based platforms.
> This patch adds by default the dummy numa node and
> maps all memory and cpus to node 0.
> using this patch, numa can be simulated on single node arm64 platforms.

> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> new file mode 100644
> index 0000000..2cd804d
> --- /dev/null
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -0,0 +1,18 @@
> +#ifndef __ASM_MMZONE_H
> +#define __ASM_MMZONE_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <linux/mmdebug.h>
> +#include <linux/types.h>
> +
> +#include <asm/smp.h>
> +#include <asm/numa.h>

Are all these #includes really necessary?  s390 looks very similar and
doesn't need the #includes.

> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[(nid)])
> +
> +#endif /* CONFIG_NUMA */
> +
> +#endif /* __ASM_MMZONE_H */

> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> new file mode 100644
> index 0000000..f28f15b0
> --- /dev/null
> +++ b/arch/arm64/include/asm/numa.h
> @@ -0,0 +1,40 @@
> +#ifndef __ASM_NUMA_H
> +#define __ASM_NUMA_H
> +
> +#include <linux/nodemask.h>
> +#include <asm/topology.h>
> +
> +#ifdef CONFIG_NUMA
> +
> +/* currently, arm64 implements flat NUMA topology */
> +#define parent_node(node)	(node)
> +
> +extern int __node_distance(int from, int to);

Below you add some extern function declarations without the "extern"
keyword.  I don't know what the convention is for arm64 (I omit the
"extern" for PCI), but it seems like you should at least be
consistent.

> +#define node_distance(a, b) __node_distance(a, b)
> +
> +extern int cpu_to_node_map[NR_CPUS];
> +extern nodemask_t numa_nodes_parsed __initdata;
> +
> +/* Mappings between node number and cpus on that node. */
> +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +extern void numa_clear_node(unsigned int cpu);
> +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> +extern const struct cpumask *cpumask_of_node(int node);
> +#else
> +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> +static inline const struct cpumask *cpumask_of_node(int node)
> +{
> +	return node_to_cpumask_map[node];
> +}
> +#endif
> +
> +void __init arm64_numa_init(void);
> +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> +void __init numa_set_distance(int from, int to, int distance);
> +void __init numa_reset_distance(void);
> +void numa_store_cpu_info(unsigned int cpu);
