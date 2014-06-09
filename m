Return-Path: <rientjes@google.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96B1C1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:38:31 +1000 (EST)
Received: by mail-ig0-f176.google.com with SMTP id a13so4376616igq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jun 2014 14:38:28 -0700 (PDT)
Date: Mon, 9 Jun 2014 14:38:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: NUMA topology question wrt. d4edc5b6
In-Reply-To: <537E6285.3050000@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1406091436090.5271@chino.kir.corp.google.com>
References: <20140521200451.GB5755@linux.vnet.ibm.com>
 <537E6285.3050000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Hansen <dave@sr71.net>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Linux MM <linux-mm@kvack.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com,
 Cody P Schafer <cody@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 May 2014, Srivatsa S. Bhat wrote:

> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index c920215..58e6469 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -18,6 +18,7 @@ struct device_node;
>   */
>  #define RECLAIM_DISTANCE 10
>  
> +#include <linux/nodemask.h>
>  #include <asm/mmzone.h>
>  
>  static inline int cpu_to_node(int cpu)
> @@ -30,7 +31,7 @@ static inline int cpu_to_node(int cpu)
>  	 * During early boot, the numa-cpu lookup table might not have been
>  	 * setup for all CPUs yet. In such cases, default to node 0.
>  	 */
> -	return (nid < 0) ? 0 : nid;
> +	return (nid < 0) ? first_online_node : nid;
>  }
>  
>  #define parent_node(node)	(node)

I wonder what would happen on ppc if we just returned NUMA_NO_NODE here 
for cpus that have not been mapped (they shouldn't even be possible).  
This would at least allow callers that do
kmalloc_node(..., cpu_to_node(cpu)) to be allocated on the local cpu 
rather than on a perhaps offline or remote node 0.

It would seem better to catch callers that do 
cpu_to_node(<not-possible-cpu>) rather than blindly return an online node.
