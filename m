Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1579DE542
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 17:06:24 +1000 (EST)
Date: Fri, 18 Apr 2008 00:06:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel stack allocation alignment
Message-Id: <20080418000618.0c46c78f.akpm@linux-foundation.org>
In-Reply-To: <20080418065727.5FE1CDE247@ozlabs.org>
References: <20080418065727.5FE1CDE247@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Apr 2008 16:56:17 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The powerpc kernel stacks need to be naturally aligned, as they
> contain the thread info at the bottom, which is obtained by
> clearing the low bits of the stack pointer.
> 
> However, when using 64K pages (the stack is smaller than a page),
> we use kmalloc to allocate it, which doesn't provide that guarantee.
> 
> It appeared to work so far... until one enables SLUB debugging
> which then returns unaligned pointers. Ooops...
> 
> This patch fixes it by using a slab cache with enforced alignment
> for those. It replies on my previous patch that adds a
> thread_info_cache_init() callback.
> 
> ...
>
> +void thread_info_cache_init(void)
> +{
> +	thread_info_cache = kmem_cache_create("thread_info", THREAD_SIZE,
> +					      THREAD_SIZE, 0, NULL);
> +	BUG_ON(thread_info_cache == NULL);
> +}

so...  the "0" defeats all of SLAB_DEBUG_FREE, SLAB_RED_ZONE, SLAB_POISON
and SLAB_STORE_USER, if the comment in slab.h is to be believed.

Was that overkill?
