Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hG3L6DxNzF2SG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 11:34:06 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id ay10-v6so318112plb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 18:34:06 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
 by smtp.gmail.com with ESMTPSA id
 69sm40834246pfh.33.2018.05.09.18.34.01
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 May 2018 18:34:03 -0700 (PDT)
Date: Thu, 10 May 2018 11:33:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kbuild: set generic machine type for compile
 with 64-bit toolchain
Message-ID: <20180510113348.6d900e33@roar.ozlabs.ibm.com>
In-Reply-To: <20180510002637.3069-1-npiggin@gmail.com>
References: <20180510002637.3069-1-npiggin@gmail.com>
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

Bad title, should be set generic machine type for 32-bit compile with
64-bit toolchain

On Thu, 10 May 2018 10:26:37 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The 64-bit toolchain uses the wrong ISA variant for compiling 32-bit
> kernels, eve with -m32. Set -mcpu=powerpc which is the generic 32-bit
> powerpc machine type and scheduling model. 32-bit platforms and CPUs
> can override this with -mcpu= options that come later on the command
> line.
> 
> This fixes a lot of build failures due to incompatible assembly when
> compiling 32-bit kernel with 64-bit toolchain.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 95813df90801..aa6464c81a9f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -24,6 +24,12 @@ ifeq ($(HAS_BIARCH),y)
>  ifeq ($(CROSS32_COMPILE),)
>  CROSS32CC	:= $(CC) -m32
>  KBUILD_ARFLAGS	+= --target=elf32-powerpc
> +
> +# These options will be overridden by any -mcpu option that comes
> +# later on the command line, but they are needed to set a sane
> +# 32-bit cpu target for the 64-bit cross compiler.
> +KBUILD_CFLAGS		+= -mcpu=powerpc
> +KBUILD_AFLAGS		+= -mcpu=powerpc
>  endif
>  endif
>  
