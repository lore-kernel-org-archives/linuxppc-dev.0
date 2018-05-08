Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMbm5dVBzF156
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:40:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Khem Raj <raj.khem@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/ptrace: Disable array-bounds warning with gcc8
In-Reply-To: <20180504192313.18625-2-raj.khem@gmail.com>
References: <20180504192313.18625-1-raj.khem@gmail.com>
 <20180504192313.18625-2-raj.khem@gmail.com>
Date: Wed, 09 May 2018 00:40:35 +1000
Message-ID: <87y3guyzvg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Khem Raj <raj.khem@gmail.com> writes:

> This masks the new gcc8 warning
>
> regset.h:270:4: error: 'memcpy' offset [-527, -529] is out
> of the bounds [0, 16] of object 'vrsave' with type 'union <anonymous>'

Why would we want to mask the warning rather than fix it?

cheers

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 7ac5a68ad6b1..ab159a34704a 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' $(call cc-disable-warning, attribute-alias)
> +CFLAGS_ptrace.o		+= $(call cc-disable-warning, array-bounds)
>  CFLAGS_syscalls.o	+= $(call cc-disable-warning, attribute-alias)
>  
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
> -- 
> 2.17.0
