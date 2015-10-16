Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA30B1A037C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:27:01 +1100 (AEDT)
Message-ID: <1444962421.28419.3.camel@ellerman.id.au>
Subject: Re: [RFC] powerpc/numa: Use VPHN based node ID information on
 shared processor LPARs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, nacc@linux.vnet.ibm.com
Date: Fri, 16 Oct 2015 13:27:01 +1100
In-Reply-To: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
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

On Wed, 2015-10-14 at 14:32 +0530, Anshuman Khandual wrote:
> On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
> dynamic virtual-physical mapping for any given processor. Currently we
> use VPHN node ID information only after getting either a PRRN or a VPHN
> event. But during boot time inside the function numa_setup_cpu, we still
> query the OF device tree for the node ID value which might be different
> than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
> scenario where there are no PRRN or VPHN event after boot, all node-cpu
> mapping will remain incorrect there after.
> 
> With this proposed change, numa_setup_cpu will try to override the OF
> device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
> hcall fetched node ID value. Right now shared processor property of the
> LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
> during boot time. So initmem_init function has been moved after ppc_md.
> setup_arch inside setup_arch during boot.
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 8b9502a..e404d05 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -553,6 +557,17 @@ static int numa_setup_cpu(unsigned long lcpu)
>  
>  	nid = of_node_to_nid_single(cpu);
>  
> +	/*
> +	 * Override the OF device tree fetched node number
> +	 * with VPHN based node number in case of a shared
> +	 * processor LPAR on PHYP platform.
> +	 */
> +#ifdef CONFIG_PPC_SPLPAR
> +	if (lppaca_shared_proc(get_lppaca())) {
> +		nid = vphn_get_node(lcpu);
> +	}
> +#endif


That logic exposes a potential problem which you don't seem to have addressed.

You're not updating the logic in of_node_to_nid[_single](), instead you're
overriding it in *this one location*. But what about other code that uses
of_node_to_nid()? It will still get the old device-tree value and so will have
the wrong nid, won't it?

cheers
