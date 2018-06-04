Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgd1BXrzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:25 +1000 (AEST)
In-Reply-To: <20180530121922.22122-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5,
 1/4] powerpc/kbuild: set default generic machine type for 32-bit
 compile
Message-Id: <40zxgc4r2sz9s4b@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 12:19:19 UTC, Nicholas Piggin wrote:
> Some 64-bit toolchains uses the wrong ISA variant for compiling 32-bit
> kernels, even with -m32. Debian's powerpc64le is one such case, and
> that is because it is built with --with-cpu=power8.
> 
> So when cross compiling a 32-bit kernel with a 64-bit toolchain, set
> -mcpu=powerpc initially, which is the generic 32-bit powerpc machine
> type and scheduling model. CPU and platform code can override this
> with subsequent -mcpu flags if necessary.
> 
> This is not done for 32-bit toolchains otherwise it would override
> their defaults, which are presumably set appropriately for the
> environment (moreso than a 64-bit cross compiler).
> 
> This fixes a lot of build failures due to incompatible assembly when
> compiling 32-bit kernel with th Debian powerpc64le 64-bit toolchain.
> 
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4bf4f42a2febb449a5cc5d79e7c58e

cheers
