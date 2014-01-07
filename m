Return-Path: <andi@firstfloor.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 0CB322C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 17:50:07 +1100 (EST)
From: Andi Kleen <andi@firstfloor.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
References: <20140107132100.5b5ad198@kryten>
Date: Mon, 06 Jan 2014 22:49:53 -0800
In-Reply-To: <20140107132100.5b5ad198@kryten> (Anton Blanchard's message of
 "Tue, 7 Jan 2014 13:21:00 +1100")
Message-ID: <871u0k5lri.fsf@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cl@linux-foundation.org, nacc@linux.vnet.ibm.com, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, mpm@selenic.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:
>
> Thoughts? It seems like we could hit a similar situation if a machine
> is balanced but we run out of memory on a single node.

Yes I agree, but your patch doesn't seem to attempt to handle this?

-Andi
>
> Index: b/mm/slub.c
> ===================================================================
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2278,10 +2278,17 @@ redo:
>  
>  	if (unlikely(!node_match(page, node))) {
>  		stat(s, ALLOC_NODE_MISMATCH);
> -		deactivate_slab(s, page, c->freelist);
> -		c->page = NULL;
> -		c->freelist = NULL;
> -		goto new_slab;
> +
> +		/*
> +		 * If the node contains no memory there is no point in trying
> +		 * to allocate a new node local slab
> +		 */
> +		if (node_spanned_pages(node)) {
> +			deactivate_slab(s, page, c->freelist);
> +			c->page = NULL;
> +			c->freelist = NULL;
> +			goto new_slab;
> +		}
>  	}
>  
>  	/*
-- 
ak@linux.intel.com -- Speaking for myself only
