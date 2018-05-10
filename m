Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hYVs0Xw8zF2C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:10:25 +1000 (AEST)
Date: Thu, 10 May 2018 08:10:03 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/5] powerpc/kbuild: set default generic machine type
 for 32-bit compile
Message-ID: <20180510131002.GN17342@gate.crashing.org>
References: <20180510051659.15356-1-npiggin@gmail.com>
 <20180510051659.15356-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510051659.15356-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 10, 2018 at 03:16:55PM +1000, Nicholas Piggin wrote:
> The 64-bit toolchain uses the wrong ISA variant for compiling 32-bit
> kernels, eve with -m32. Set -mcpu=powerpc which is the generic 32-bit
> powerpc machine type and scheduling model. 32-bit platforms and CPUs
> can override this with -mcpu= options that come later on the command
> line.
> 
> This fixes a lot of build failures due to incompatible assembly when
> compiling 32-bit kernel with 64-bit toolchain.

So what ISA is set for gas without this patch?  With what GCC version?
And, why is that wrong?


Segher


> +ifdef CONFIG_PPC32
> +# These options will be overridden by any -mcpu option that comes
> +# later on the command line, but they are needed to set a sane
> +# 32-bit cpu target for the 64-bit cross compiler.
> +KBUILD_CFLAGS		+= -mcpu=powerpc
> +KBUILD_AFLAGS		+= -mcpu=powerpc
> +endif
