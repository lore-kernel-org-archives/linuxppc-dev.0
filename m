Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcqs10nHpzDq7q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:42:28 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7NEdMNB016960
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 10:42:27 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ch8hqwv9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 10:42:26 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 23 Aug 2017 08:42:25 -0600
Subject: Re: [PATCH V9 2/2] powerpc/nodes: Ensure enough nodes avail for
 operations
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>,
 9e5050e1-e0cc-0e0e-7b31-5dcb38b307f4@linux.vnet.ibm.com
References: <83b05ed2-8d18-3d5c-2003-b022d0d55eb2@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 09:42:22 -0500
MIME-Version: 1.0
In-Reply-To: <83b05ed2-8d18-3d5c-2003-b022d0d55eb2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <b9d193ee-107c-a138-84ea-b621138800f7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2017 04:44 PM, Michael Bringmann wrote:
> To: linuxppc-dev@lists.ozlabs.org
> 
> From: Michael Bringmann <mwb@linux.vnet.ibm.com>
> 
> To: linux-kernel@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Cc: John Allen <jallen@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Subject: [PATCH V9 2/2] powerpc/nodes: Ensure enough nodes avail for operations
> 
> powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
> or memory resources, it may occur that the new resources are to be
> inserted into nodes that were not used for these resources at bootup.
> In the kernel, any node that is used must be defined and initialized
> at boot.
> 
> This patch extracts the value of the lowest domain level (number of
> allocable resources) from the "rtas" device tree property
> "ibm,max-associativity-domains" to use as the maximum number of nodes
> to setup as possibly available in the system.  This new setting will
> override the instruction,
> 
>     nodes_and(node_possible_map, node_possible_map, node_online_map);
> 
> presently seen in the function arch/powerpc/mm/numa.c:initmem_init().
> 
> If the property is not present at boot, no operation will be performed
> to define or enable additional nodes.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 3fd4536..3ae6510 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -893,6 +893,48 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
>  }
> 
> +static void __init node_associativity_setup(void)
> +{
> +	struct device_node *rtas;
> +	printk(KERN_INFO "%s:%d\n", __FUNCTION__, __LINE__);

Is there a reson we need to have all these KERN_INFO printk's?

This looks like debug statements that accidentally were left in.

> +
> +	rtas = of_find_node_by_path("/rtas");
> +	if (rtas) {
> +		const __be32 *prop;
> +		u32 len, entries, levelval, i;
> +	printk(KERN_INFO "%s:%d\n", __FUNCTION__, __LINE__);
> +
> +		prop = of_get_property(rtas, "ibm,max-associativity-domains", &len);

You could put the of_node_put() call here after getting the property and get
rid of all the goto's.

> +		if (!prop || len < sizeof(unsigned int)) {
> +	printk(KERN_INFO "%s:%d\n", __FUNCTION__, __LINE__);
> +			goto endit;
> +		}
> +
> +		entries = of_read_number(prop++, 1);
> +
> +		if (len < (entries * sizeof(unsigned int))) {
> +	printk(KERN_INFO "%s:%d\n", __FUNCTION__, __LINE__);
> +			goto endit;
> +		}
> +
> +		for (i = 0; i < entries; i++)
> +			levelval = of_read_number(prop++, 1);

Couldn't you just read the last enbtry instead of doing a loop reading each
entry until you get to the last one?

-Nathan

> +
> +		printk(KERN_INFO "Numa nodes avail: %d (%d) \n", (int) levelval, (int) entries);
> +
> +		for (i = 0; i < levelval; i++) {
> +			if (!node_possible(i)) {
> +				setup_node_data(i, 0, 0);
> +				node_set(i, node_possible_map);
> +			}
> +		}
> +	}
> +
> +endit:
> +	if (rtas)
> +		of_node_put(rtas)> +}
> +
>  void __init initmem_init(void)
>  {
>  	int nid, cpu;
> @@ -912,6 +954,8 @@ void __init initmem_init(void)
>  	 */
>  	nodes_and(node_possible_map, node_possible_map, node_online_map);
> 
> +	node_associativity_setup();
> +
>  	for_each_online_node(nid) {
>  		unsigned long start_pfn, end_pfn;
> 
