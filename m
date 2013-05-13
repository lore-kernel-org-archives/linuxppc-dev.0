Return-Path: <anton@samba.org>
Date: Mon, 13 May 2013 16:48:19 +1000
From: Anton Blanchard <anton@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Message-ID: <20130513164819.1c9331b9@kryten>
In-Reply-To: <1368220707.3378.57.camel@shinybook.infradead.org>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, viro@zeniv.linux.org.uk, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 May 2013 22:18:27 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <David.Woodhouse@intel.com>
> 
> Some versions of GCC apparently expect this to be provided by libgcc.

Thanks Dave. We were discussing this with Alan Modra and he doesn't
think the 64bit target should ever emit a call to __bswapdi2. Did you
only see it on 32bit, or 64bit as well?

Alan: I notice Dave is adding calls to __builtin_bswap, perhaps some
versions of the 64bit compiler did emit __bswapdi2 calls for that.

Anton

> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> ---
> Untested.
> 
> diff --git a/arch/powerpc/kernel/misc_32.S
> b/arch/powerpc/kernel/misc_32.S index 19e096b..f077dc2 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -657,6 +657,17 @@ _GLOBAL(__ucmpdi2)
>  	li	r3,2
>  	blr
>  
> +_GLOBAL(__bswapdi2)
> +	rlwinm	10,4,8,0xffffffff
> +	rlwinm	11,3,8,0xffffffff
> +	rlwimi	10,4,24,0,7
> +	rlwimi	11,3,24,0,7
> +	rlwimi	10,4,24,16,23
> +	rlwimi	11,3,24,16,23
> +	mr	4,11
> +	mr	3,10
> +	blr
> +
>  _GLOBAL(abs)
>  	srawi	r4,r3,31
>  	xor	r3,r3,r4
> diff --git a/arch/powerpc/kernel/misc_64.S
> b/arch/powerpc/kernel/misc_64.S index 5cfa800..3b2e6e8 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -234,6 +234,18 @@ _GLOBAL(__flush_dcache_icache)
>  	isync
>  	blr
>  
> +_GLOBAL(__bswapdi2)
> +	srdi	8,3,32
> +	rlwinm	7,3,8,0xffffffff
> +	rlwimi	7,3,24,0,7
> +	rlwinm	9,8,8,0xffffffff
> +	rlwimi	7,3,24,16,23
> +	rlwimi	9,8,24,0,7
> +	rlwimi	9,8,24,16,23
> +	sldi	7,7,32
> +	or	7,7,9
> +	mr	3,7
> +	blr
>  
>  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
>  /*
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c
> b/arch/powerpc/kernel/ppc_ksyms.c index 78b8766..c296665 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -143,7 +143,8 @@ EXPORT_SYMBOL(__lshrdi3);
>  int __ucmpdi2(unsigned long long, unsigned long long);
>  EXPORT_SYMBOL(__ucmpdi2);
>  #endif
> -
> +long long __bswapdi2(long long);
> +EXPORT_SYMBOL(__bswapdi2);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memmove);
> 
