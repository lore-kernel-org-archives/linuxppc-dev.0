Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 188C21A05D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 11:20:24 +1100 (AEDT)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B32CB140180
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 11:20:23 +1100 (AEDT)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id E8DBB179370D
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:15:07 +0900 (JST)
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id CFF153EE1F3
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:15:05 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id BF1C9AC0240
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:15:04 +0900 (JST)
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CBE7E08005
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:15:04 +0900 (JST)
Message-ID: <547BB2F0.5040708@jp.fujitsu.com>
Date: Mon, 1 Dec 2014 09:14:40 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] slab: Fix nodeid bounds check for non-contiguous node IDs
References: <20141130221606.GA25929@iris.ozlabs.ibm.com>
In-Reply-To: <20141130221606.GA25929@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
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

(2014/12/01 7:16), Paul Mackerras wrote:
> The bounds check for nodeid in ____cache_alloc_node gives false
> positives on machines where the node IDs are not contiguous, leading
> to a panic at boot time.  For example, on a POWER8 machine the node
> IDs are typically 0, 1, 16 and 17.  This means that num_online_nodes()
> returns 4, so when ____cache_alloc_node is called with nodeid = 16 the
> VM_BUG_ON triggers.

Do you have the call trace? If you have it, please add it in the description.

> To fix this, we instead compare the nodeid with MAX_NUMNODES, and
> additionally make sure it isn't negative (since nodeid is an int).
> The check is there mainly to protect the array dereference in the
> get_node() call in the next line, and the array being dereferenced is
> of size MAX_NUMNODES.  If the nodeid is in range but invalid, the
> BUG_ON in the next line will catch that.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Do you need to backport it into -stable kernels?

> ---
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

How about use:
	VM_BUG_ON(!node_online(nodeid));

When allocating the memory, the node of the memory being allocated must be
online. But your code cannot check the condition.

Thanks,
Yasuaki Ishimatsu

>   	n = get_node(cachep, nodeid);
>   	BUG_ON(!n);
>
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
