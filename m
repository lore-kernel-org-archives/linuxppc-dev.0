Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFyvj11XszDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 23:54:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/hotplug: Ensure nodes initialized for hotplug
In-Reply-To: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
References: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 23:54:39 +1100
Message-ID: <87y3objlrk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU,
> it may occur that the new resources are to be inserted into nodes
> that were not used for memory resources at bootup.  Many different
> configurations of PowerPC resources may need to be supported depending
> upon the environment.

Give me some detail please?!

> This patch fixes some problems encountered at

What problems?

> runtime with configurations that support memory-less nodes, but which
> allow CPUs to be added at and after boot.

How does it fix those problems?

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b385cd0..e811dd1 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1325,6 +1325,17 @@ static long vphn_get_associativity(unsigned long cpu,
>  	return rc;
>  }
>  
> +static int verify_node_preparation(int nid)
> +{

I would not expect a function called "verify" ...

> +	if ((NODE_DATA(nid) == NULL) ||
> +	    (NODE_DATA(nid)->node_spanned_pages == 0)) {
> +		if (try_online_node(nid))

.. to do something like online a node.

> +			return first_online_node;
> +	}
> +
> +	return nid;
> +}
> +
>  /*
>   * Update the CPU maps and sysfs entries for a single CPU when its NUMA
>   * characteristics change. This function doesn't perform any locking and is
> @@ -1433,9 +1444,11 @@ int numa_update_cpu_topology(bool cpus_locked)
>  		/* Use associativity from first thread for all siblings */
>  		vphn_get_associativity(cpu, associativity);
>  		new_nid = associativity_to_nid(associativity);
> -		if (new_nid < 0 || !node_online(new_nid))
> +		if (new_nid < 0 || !node_possible(new_nid))
>  			new_nid = first_online_node;
>  
> +		new_nid = verify_node_preparation(new_nid);

You're being called part-way through CPU hotplug here, are we sure it's
safe to go and do memory hotplug from there? What's the locking
situation?

cheers
