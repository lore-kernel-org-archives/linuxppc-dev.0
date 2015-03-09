Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4225A1A0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 10:55:06 +1100 (AEDT)
Message-ID: <1425945305.19022.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/numa: set node_possible_map to only
 node_online_map during boot
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Tue, 10 Mar 2015 10:55:05 +1100
In-Reply-To: <20150306052750.GA9576@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <20150305231555.GB30570@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051527281.2184@chino.kir.corp.google.com>
 <20150306052750.GA9576@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-05 at 21:27 -0800, Nishanth Aravamudan wrote:
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 0257a7d659ef..0c1716cd271f 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -958,6 +958,13 @@ void __init initmem_init(void)
>  
>  	memblock_dump_all();
>  
> +	/*
> +	 * Reduce the possible NUMA nodes to the online NUMA nodes,
> +	 * since we do not support node hotplug. This ensures that  we
> +	 * lower the maximum NUMA node ID to what is actually present.
> +	 */
> +	node_possible_map = node_online_map;

That looks nice, but is it generating what we want?

ie. is the content of node_online_map being *copied* into node_possible_map.

Or are we changing node_possible_map to point at node_online_map?

cheers
