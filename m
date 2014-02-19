Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DDBDF2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 10:32:48 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 18:32:46 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6B20B38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 18:32:44 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JNWia18716726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:32:44 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JNWh9v004875
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 18:32:44 -0500
Date: Wed, 19 Feb 2014 15:32:37 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@suse.cz>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
Message-ID: <20140219233237.GF413@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140219231714.GB413@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Grr, sorry for not including you originally Andrew, if this ends up
being ok with others, it will probably need to go through your tree. ]

On 19.02.2014 [15:17:14 -0800], Nishanth Aravamudan wrote:
> We can call local_memory_node() before the zonelists are setup. In that
> case, first_zones_zonelist() will not set zone and the reference to
> zone->node will Oops. Catch this case, and, since we presumably running
> very early, just return that any node will do.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Christoph Lameter <cl@linux.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
> Cc: Anton Blanchard <anton@samba.org>
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3758a0..5de4337 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3650,6 +3650,8 @@ int local_memory_node(int node)
>  				   gfp_zone(GFP_KERNEL),
>  				   NULL,
>  				   &zone);
> +	if (!zone)
> +		return NUMA_NO_NODE;
>  	return zone->node;
>  }
>  #endif
