Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 67886DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 17:57:50 +1100 (EST)
Date: Fri, 29 Feb 2008 08:56:30 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: undefined references to __udivdi3 on powerpc
Message-ID: <20080229065630.GA16851@cs181133002.pp.htv.fi>
References: <20080228133718.GA8383@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080228133718.GA8383@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2008 at 02:37:18PM +0100, Olaf Hering wrote:
> 
> While debugging __divdi3 calls in drivers/crypto/hifn_795x.c (due to the
> ndelay() delay call with a s64), I found even more breakage of that
> sort. This is after a allnoconfig with ARCH=powerpc in 2.6.25-rc3,
> plus CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_HIFN_795X=y:
> 
>   LD      .tmp_vmlinux1
>   kernel/built-in.o: In function `update_xtime_cache':
>   (.text+0x221a0): undefined reference to `__umoddi3'
>   kernel/built-in.o: In function `update_xtime_cache':
>   (.text+0x221c0): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `getnstimeofday':
>   (.text+0x22330): undefined reference to `__umoddi3'
>   kernel/built-in.o: In function `getnstimeofday':
>   (.text+0x22350): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `timekeeping_resume':
>   timekeeping.c:(.text+0x226a0): undefined reference to `__udivdi3'
>   timekeeping.c:(.text+0x22778): undefined reference to `__umoddi3'
>   timekeeping.c:(.text+0x22798): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `update_wall_time':
>   (.text+0x22c7c): undefined reference to `__umoddi3'
>   kernel/built-in.o: In function `update_wall_time':
>   (.text+0x22c9c): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `update_wall_time':
>   (.text+0x230f8): undefined reference to `__umoddi3'
>   kernel/built-in.o: In function `update_wall_time':
>   (.text+0x23118): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `do_settimeofday':
>   (.text+0x23520): undefined reference to `__udivdi3'
>   kernel/built-in.o: In function `timekeeping_init':
>   (.init.text+0x1870): undefined reference to `__udivdi3'
>   make[1]: *** [.tmp_vmlinux1] Error 1
> 
> But its not a regression, 2.6.24 allnoconfig does not link either on
> powerpc32. 
>...

You didn't mention your gcc version, but you should only get these 
errors when using the not yet released gcc 4.3.

And this issue is known for at about half a year.

> Olaf

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
