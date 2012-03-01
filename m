Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 1FEB7B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 10:02:59 +1100 (EST)
Date: Thu, 1 Mar 2012 15:02:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] atomic: Allow atomic_inc_not_zero to be overridden
Message-Id: <20120301150256.9a7d0b06.akpm@linux-foundation.org>
In-Reply-To: <20120301180953.0f61576f@kryten>
References: <20120301180953.0f61576f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: vapier@gentoo.org, eric.dumazet@gmail.com, linux-kernel@vger.kernel.org,
 Richard Kuo <rkuo@codeaurora.org>, paulus@samba.org,
 linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Mar 2012 18:09:53 +1100
Anton Blanchard <anton@samba.org> wrote:

> 
> We want to implement a ppc64 specific version of atomic_inc_not_zero
> so wrap it in an ifdef to allow it to be overridden.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-build/include/linux/atomic.h
> ===================================================================
> --- linux-build.orig/include/linux/atomic.h	2012-02-11 14:59:23.284714257 +1100
> +++ linux-build/include/linux/atomic.h	2012-02-11 15:01:14.894764555 +1100
> @@ -24,7 +24,9 @@ static inline int atomic_add_unless(atom
>   * Atomically increments @v by 1, so long as @v is non-zero.
>   * Returns non-zero if @v was non-zero, and zero otherwise.
>   */
> +#ifndef atomic_inc_not_zero
>  #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
> +#endif

Please merge this via the ppc tree?


And let's ask the hexagon maintainers to take a look at the definition
in arch/hexagon/include/asm/atomic.h.  I assume that it can be removed,
but that might cause problems with files which include asm/atomic.h
directly.  I have found two such files in non-arch code and have queued
fixes.  There are no such files in arch/hexagon code, so I think it's
safe to zap the hexagon definition of atomic_inc_not_zero().


> +static __inline__ int atomic_inc_not_zero(atomic_t *v)

Curious: is there a technical reason why ppc uses "__inline__" rather
than "inline"?
