Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdT01RTzF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:25 +1000 (AEST)
In-Reply-To: <20180810122535.11710-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
Message-Id: <41ptdS0svWz9sCR@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-10 at 12:25:35 UTC, Michael Ellerman wrote:
> Currently if you build a 32-bit powerpc kernel and use get_user() to
> load a u64 value it will fail to build with eg:
> 
>   kernel/rseq.o: In function `rseq_get_rseq_cs':
>   kernel/rseq.c:123: undefined reference to `__get_user_bad'
> 
> This is hitting the check in __get_user_size() that makes sure the
> size we're copying doesn't exceed the size of the destination:
> 
>   #define __get_user_size(x, ptr, size, retval)
>   do {
>   	retval = 0;
>   	__chk_user_ptr(ptr);
>   	if (size > sizeof(x))
>   		(x) = __get_user_bad();
> 
> Which doesn't immediately make sense because the size of the
> destination is u64, but it's not really, because __get_user_check()
> etc. internally create an unsigned long and copy into that:
> 
>   #define __get_user_check(x, ptr, size)
>   ({
>   	long __gu_err = -EFAULT;
>   	unsigned long  __gu_val = 0;
> 
> The problem being that on 32-bit unsigned long is not big enough to
> hold a u64. We can fix this with a trick from hpa in the x86 code, we
> statically check the type of x and set the type of __gu_val to either
> unsigned long or unsigned long long.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f7a6947cd49b7ff4e03f1b4f7e7b22

cheers
