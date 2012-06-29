Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2C2CB700A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 10:45:43 +1000 (EST)
Message-ID: <1340930720.2563.5.camel@pasglop>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2012 10:45:20 +1000
In-Reply-To: <1340618099.13778.39.camel@ThinkPad-T420>
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christoph Lameter <cl@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-25 at 17:54 +0800, Li Zhong wrote:

> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 620b7ac..c9d2a7f 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -130,6 +130,9 @@ void pgtable_cache_add(unsigned shift, void
> (*ctor)(void *))
>  	align = max_t(unsigned long, align, minalign);
>  	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>  	new = kmem_cache_create(name, table_size, align, 0, ctor);
> +#ifdef CONFIG_SLUB
> +	kfree(name); /* SLUB duplicates the cache name */
> +#endif
>  	PGT_CACHE(shift) = new;
>  
>  	pr_debug("Allocated pgtable cache for order %d\n", shift);

This is very gross ... and fragile. Also the subtle difference in
semantics between SLUB and SLAB is a VERY BAD IDEA.

I reckon you should make the other allocators all copy the name
instead.

Ben.
