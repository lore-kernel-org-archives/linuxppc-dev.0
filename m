Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425XlT4M10zF381
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 17:49:25 +1000 (AEST)
Date: Thu, 6 Sep 2018 09:49:19 +0200
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
Subject: Re: [RFC PATCH 10/29] memblock: replace __alloc_bootmem_node_nopanic
 with memblock_alloc_try_nid_nopanic
Message-ID: <20180906074919.GS14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-11-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536163184-26356-11-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 05-09-18 18:59:25, Mike Rapoport wrote:
> The __alloc_bootmem_node_nopanic() is used only once, there is no reason to
> add a wrapper for memblock_alloc_try_nid_nopanic for it.

OK, it took me a bit longer to see they are equivalent. Both zero the
memory and fallback to a different node if the given one doesn't have a
proper range. So good. Lack of proper documentation didn't really help.
 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/kernel/setup_percpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index ea554f8..67d48e26 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -112,8 +112,10 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
>  		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
>  			 cpu, size, __pa(ptr));
>  	} else {
> -		ptr = __alloc_bootmem_node_nopanic(NODE_DATA(node),
> -						   size, align, goal);
> +		ptr = memblock_alloc_try_nid_nopanic(size, align, goal,
> +						     BOOTMEM_ALLOC_ACCESSIBLE,
> +						     node);
> +
>  		pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
>  			 cpu, size, node, __pa(ptr));
>  	}
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
