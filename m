Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQl2y6GjKzDvny
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 18:30:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/3] powerpc: allow compilation on cross-endian toolchain
In-Reply-To: <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
 <20161123130209.1667-3-npiggin@gmail.com>
 <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
Date: Sat, 26 Nov 2016 18:30:15 +1100
Message-ID: <87lgw6snp4.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Thu, 24 Nov 2016 00:02:08 +1100
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 617dece..8828807 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -73,13 +73,18 @@ MULTIPLEWORD	:= -mmultiple
>  endif
>  
>  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
> +cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
> +cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)

This blew up the world:

  http://kisskb.ellerman.id.au/kisskb/head/1ba4cb3d67e181bdc9a911d7be81f64e3d7597d2/

  Successful:	24% 63/258

I suspect you need to make -mcall-aixdesc 64-bit only.

cheers
