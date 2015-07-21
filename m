Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E0F51A1D1C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 08:02:31 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 16:02:28 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 372CD1FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 15:53:35 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LM2PMi45219934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 15:02:25 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LM2NEE012189
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:02:24 -0600
Date: Tue, 21 Jul 2015 15:02:22 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: pshelar@nicira.com, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, linux-numa@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openvswitch: allocate nr_node_ids flow_stats instead
 of num_possible_nodes
Message-ID: <20150721220222.GB29402@linux.vnet.ibm.com>
References: <20150721162418.GM38815@linux.vnet.ibm.com>
 <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.07.2015 [12:36:33 -0500], Chris J Arges wrote:
> Some architectures like POWER can have a NUMA node_possible_map that
> contains sparse entries. This causes memory corruption with openvswitch
> since it allocates flow_cache with a multiple of num_possible_nodes() and
> assumes the node variable returned by for_each_node will index into
> flow->stats[node].
> 
> Use nr_node_ids to allocate a maximal sparse array instead of
> num_possible_nodes().
> 
> The crash was noticed after 3af229f2 was applied as it changed the
> node_possible_map to match node_online_map on boot.
> Fixes: 3af229f2071f5b5cb31664be6109561fbe19c861
> 
> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>  net/openvswitch/flow_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
> index 4613df8..6552394 100644
> --- a/net/openvswitch/flow_table.c
> +++ b/net/openvswitch/flow_table.c
> @@ -752,7 +752,7 @@ int ovs_flow_init(void)
>  	BUILD_BUG_ON(sizeof(struct sw_flow_key) % sizeof(long));
> 
>  	flow_cache = kmem_cache_create("sw_flow", sizeof(struct sw_flow)
> -				       + (num_possible_nodes()
> +				       + (nr_node_ids
>  					  * sizeof(struct flow_stats *)),
>  				       0, 0, NULL);
>  	if (flow_cache == NULL)
> -- 
> 1.9.1
> 
