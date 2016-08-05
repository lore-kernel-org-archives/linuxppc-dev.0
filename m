Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5P4H34KzzDqcy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 21:01:03 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ez1so19148356pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 04:01:03 -0700 (PDT)
Date: Fri, 5 Aug 2016 21:00:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 agraf@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Align hot loops of memset() and
 backwards_memcpy()
Message-ID: <20160805210052.0f9a8c43@roar.ozlabs.ibm.com>
In-Reply-To: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
References: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  4 Aug 2016 16:53:22 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> Align the hot loops in our assembly implementation of memset()
> and backwards_memcpy().
> 
> backwards_memcpy() is called from tcp_v4_rcv(), so we might
> want to optimise this a little more.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/lib/mem_64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 43435c6..eda7a96 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -37,6 +37,7 @@ _GLOBAL(memset)
>  	clrldi	r5,r5,58
>  	mtctr	r0
>  	beq	5f
> +	.balign 16
>  4:	std	r4,0(r6)
>  	std	r4,8(r6)
>  	std	r4,16(r6)

Hmm. If we execute this loop once, we'll only fetch additional nops. Twice, and
we make up for them by not fetching unused instructions. More than twice and we
may start winning.

For large sizes it probably helps, but I'd like to see what sizes memset sees.
