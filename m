Return-Path: <penberg@iki.fi>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DEA61A0259
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 20:32:25 +1100 (AEDT)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 246E914014D
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 20:32:25 +1100 (AEDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8F6DC20B46
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 04:22:29 -0500 (EST)
Message-ID: <547C3353.9030502@iki.fi>
Date: Mon, 01 Dec 2014 11:22:27 +0200
From: Pekka Enberg <penberg@iki.fi>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] slab: Fix nodeid bounds check for non-contiguous node
 IDs
References: <20141201042844.GB11234@drongo>
In-Reply-To: <20141201042844.GB11234@drongo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, linuxppc-dev@ozlabs.org,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/1/14 6:28 AM, Paul Mackerras wrote:
> ---
> v2: include the oops message in the patch description
>
>   mm/slab.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index eb2b2ea..f34e053 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3076,7 +3076,7 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>   	void *obj;
>   	int x;
>   
> -	VM_BUG_ON(nodeid > num_online_nodes());
> +	VM_BUG_ON(nodeid < 0 || nodeid >= MAX_NUMNODES);
>   	n = get_node(cachep, nodeid);
>   	BUG_ON(!n);

Reviewed-by: Pekka Enberg <penberg@kernel.org>
