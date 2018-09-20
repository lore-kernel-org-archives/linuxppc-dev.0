Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sc4k0tzF3CZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:04 +1000 (AEST)
In-Reply-To: <20180914040649.1794-4-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [v2,3/5] powerpc/boot: Ensure _zimage_start is a weak symbol
Message-Id: <42G3Sc3W8Dz9sCm@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 04:06:47 UTC, Joel Stanley wrote:
> When building with clang crt0's _zimage_start is not marked weak, which
> breaks the build when linking the kernel image:
> 
>  $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
>  0000000000000058 g       .text  0000000000000000 _zimage_start
> 
>  ld: arch/powerpc/boot/wrapper.a(crt0.o): in function '_zimage_start':
>  (.text+0x58): multiple definition of '_zimage_start';
>  arch/powerpc/boot/pseries-head.o:(.text+0x0): first defined here
> 
> Clang requires the .weak directive to appear after the symbol is
> declared. The binutils manual says:
> 
>  This directive sets the weak attribute on the comma separated list of
>  symbol names. If the symbols do not already exist, they will be
>  created.
> 
> So it appears this is different with clang. The only reference I could
> see for this was an OpenBSD mailing list post[1].
> 
> Changing it to be after the declaration fixes building with Clang, and
> still works with GCC.
> 
>  $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
>  0000000000000058  w      .text	0000000000000000 _zimage_start
> 
> Reported to clang as https://bugs.llvm.org/show_bug.cgi?id=38921
> 
> [1] https://groups.google.com/forum/#!topic/fa.openbsd.tech/PAgKKen2YCY
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ee9d21b3b3583712029a0db65a4b7c

cheers
