Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sr0F35WTpzDqBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 17:37:26 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u976XmMq038181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Oct 2016 02:37:25 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25wu5dt9j4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Oct 2016 02:37:24 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Oct 2016 00:37:24 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 4/5] mm: make processing of movable_node arch-specific
In-Reply-To: <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
Date: Fri, 07 Oct 2016 12:07:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zimgmzqg.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Currently, CONFIG_MOVABLE_NODE depends on X86_64. In preparation to
> enable it for other arches, we need to factor a detail which is unique
> to x86 out of the generic mm code.
>
> Specifically, as documented in kernel-parameters.txt, the use of
> "movable_node" should remain restricted to x86:
>
> movable_node    [KNL,X86] Boot-time switch to enable the effects
>                 of CONFIG_MOVABLE_NODE=y. See mm/Kconfig for details.
>
> This option tells x86 to find movable nodes identified by the ACPI SRAT.
> On other arches, it would have no benefit, only the undesired side
> effect of setting bottom-up memblock allocation.
>
> Since #ifdef CONFIG_MOVABLE_NODE will no longer be enough to restrict
> this option to x86, move it to an arch-specific compilation unit
> instead.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/x86/mm/numa.c  | 35 ++++++++++++++++++++++++++++++++++-
>  mm/memory_hotplug.c | 31 -------------------------------
>  2 files changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index fb68210..e95cab4 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -887,6 +887,38 @@ EXPORT_SYMBOL(cpumask_of_node);
>  #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
>
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +
> +static int __init cmdline_parse_movable_node(char *p)
> +{
> +#ifdef CONFIG_MOVABLE_NODE
> +	/*
> +	 * Memory used by the kernel cannot be hot-removed because Linux
> +	 * cannot migrate the kernel pages. When memory hotplug is
> +	 * enabled, we should prevent memblock from allocating memory
> +	 * for the kernel.
> +	 *
> +	 * ACPI SRAT records all hotpluggable memory ranges. But before
> +	 * SRAT is parsed, we don't know about it.
> +	 *
> +	 * The kernel image is loaded into memory at very early time. We
> +	 * cannot prevent this anyway. So on NUMA system, we set any
> +	 * node the kernel resides in as un-hotpluggable.
> +	 *
> +	 * Since on modern servers, one node could have double-digit
> +	 * gigabytes memory, we can assume the memory around the kernel
> +	 * image is also un-hotpluggable. So before SRAT is parsed, just
> +	 * allocate memory near the kernel image to try the best to keep
> +	 * the kernel away from hotpluggable memory.
> +	 */
> +	memblock_set_bottom_up(true);
> +	movable_node_enabled = true;
> +#else
> +	pr_warn("movable_node option not supported\n");
> +#endif
> +	return 0;
> +}
> +early_param("movable_node", cmdline_parse_movable_node);
> +
>  int memory_add_physaddr_to_nid(u64 start)
>  {
>  	struct numa_meminfo *mi = &numa_meminfo;
> @@ -899,4 +931,5 @@ int memory_add_physaddr_to_nid(u64 start)
>  	return nid;
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> -#endif
> +
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9d29ba0..79c709a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1738,37 +1738,6 @@ static bool can_offline_normal(struct zone *zone, unsigned long nr_pages)
>  }
>  #endif /* CONFIG_MOVABLE_NODE */
>
> -static int __init cmdline_parse_movable_node(char *p)
> -{
> -#ifdef CONFIG_MOVABLE_NODE
> -	/*
> -	 * Memory used by the kernel cannot be hot-removed because Linux
> -	 * cannot migrate the kernel pages. When memory hotplug is
> -	 * enabled, we should prevent memblock from allocating memory
> -	 * for the kernel.
> -	 *
> -	 * ACPI SRAT records all hotpluggable memory ranges. But before
> -	 * SRAT is parsed, we don't know about it.
> -	 *
> -	 * The kernel image is loaded into memory at very early time. We
> -	 * cannot prevent this anyway. So on NUMA system, we set any
> -	 * node the kernel resides in as un-hotpluggable.
> -	 *
> -	 * Since on modern servers, one node could have double-digit
> -	 * gigabytes memory, we can assume the memory around the kernel
> -	 * image is also un-hotpluggable. So before SRAT is parsed, just
> -	 * allocate memory near the kernel image to try the best to keep
> -	 * the kernel away from hotpluggable memory.
> -	 */
> -	memblock_set_bottom_up(true);
> -	movable_node_enabled = true;
> -#else
> -	pr_warn("movable_node option not supported\n");
> -#endif
> -	return 0;
> -}
> -early_param("movable_node", cmdline_parse_movable_node);
> -
>  /* check which state of node_states will be changed when offline memory */
>  static void node_states_check_changes_offline(unsigned long nr_pages,
>  		struct zone *zone, struct memory_notify *arg)
> -- 
> 1.8.3.1
