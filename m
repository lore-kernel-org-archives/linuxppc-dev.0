Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425Yvg0vJjzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 18:41:35 +1000 (AEST)
Date: Thu, 6 Sep 2018 10:41:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/29] memblock: replace alloc_bootmem_node with
 memblock_alloc_node
Message-ID: <20180906084131.GB14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-18-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536163184-26356-18-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 05-09-18 18:59:32, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

ENOCHAGELOG again

The conversion itself looks good to me
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/alpha/kernel/pci_iommu.c   | 4 ++--
>  arch/ia64/sn/kernel/io_common.c | 7 ++-----
>  arch/ia64/sn/kernel/setup.c     | 4 ++--
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
> index 6923b0d..b52d76f 100644
> --- a/arch/alpha/kernel/pci_iommu.c
> +++ b/arch/alpha/kernel/pci_iommu.c
> @@ -74,7 +74,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
>  
>  #ifdef CONFIG_DISCONTIGMEM
>  
> -	arena = alloc_bootmem_node(NODE_DATA(nid), sizeof(*arena));
> +	arena = memblock_alloc_node(sizeof(*arena), align, nid);
>  	if (!NODE_DATA(nid) || !arena) {
>  		printk("%s: couldn't allocate arena from node %d\n"
>  		       "    falling back to system-wide allocation\n",
> @@ -82,7 +82,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
>  		arena = alloc_bootmem(sizeof(*arena));
>  	}
>  
> -	arena->ptes = __alloc_bootmem_node(NODE_DATA(nid), mem_size, align, 0);
> +	arena->ptes = memblock_alloc_node(sizeof(*arena), align, nid);
>  	if (!NODE_DATA(nid) || !arena->ptes) {
>  		printk("%s: couldn't allocate arena ptes from node %d\n"
>  		       "    falling back to system-wide allocation\n",
> diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
> index 102aaba..8b05d55 100644
> --- a/arch/ia64/sn/kernel/io_common.c
> +++ b/arch/ia64/sn/kernel/io_common.c
> @@ -385,16 +385,13 @@ void __init hubdev_init_node(nodepda_t * npda, cnodeid_t node)
>  {
>  	struct hubdev_info *hubdev_info;
>  	int size;
> -	pg_data_t *pg;
>  
>  	size = sizeof(struct hubdev_info);
>  
>  	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
> -		pg = NODE_DATA(0);
> -	else
> -		pg = NODE_DATA(node);
> +		node = 0;
>  
> -	hubdev_info = (struct hubdev_info *)alloc_bootmem_node(pg, size);
> +	hubdev_info = (struct hubdev_info *)memblock_alloc_node(size, 0, node);
>  
>  	npda->pdinfo = (void *)hubdev_info;
>  }
> diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
> index 5f6b6b4..ab2564f 100644
> --- a/arch/ia64/sn/kernel/setup.c
> +++ b/arch/ia64/sn/kernel/setup.c
> @@ -511,7 +511,7 @@ static void __init sn_init_pdas(char **cmdline_p)
>  	 */
>  	for_each_online_node(cnode) {
>  		nodepdaindr[cnode] =
> -		    alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
> +		    memblock_alloc_node(sizeof(nodepda_t), 0, cnode);
>  		memset(nodepdaindr[cnode]->phys_cpuid, -1,
>  		    sizeof(nodepdaindr[cnode]->phys_cpuid));
>  		spin_lock_init(&nodepdaindr[cnode]->ptc_lock);
> @@ -522,7 +522,7 @@ static void __init sn_init_pdas(char **cmdline_p)
>  	 */
>  	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++)
>  		nodepdaindr[cnode] =
> -		    alloc_bootmem_node(NODE_DATA(0), sizeof(nodepda_t));
> +		    memblock_alloc_node(sizeof(nodepda_t), 0, 0);
>  
>  	/*
>  	 * Now copy the array of nodepda pointers to each nodepda.
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
