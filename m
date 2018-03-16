Return-Path: <srs1=dc9a=kernel.org==p2sp=gg=goodmis.org=rostedt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402p8x07jGzDqmk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:42:57 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 402p8s5vPyz8w2x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:42:53 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 402p8r1c0cz9sDr
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2018 01:42:52 +1100 (AEDT)
Date: Fri, 16 Mar 2018 10:42:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 2/2] powerpc: Only support DYNAMIC_FTRACE not static
Message-ID: <20180316104248.6aa11792@gandalf.local.home>
In-Reply-To: <20180316134633.10584-2-mpe@ellerman.id.au>
References: <20180316134633.10584-1-mpe@ellerman.id.au>
 <20180316134633.10584-2-mpe@ellerman.id.au>
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

On Sat, 17 Mar 2018 00:46:33 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> We've had dynamic ftrace support for over 9 years since Steve first
> wrote it, all the distros use dynamic, and static is basically
> untested these days, so drop support for static ftrace.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig                           |  1 +
>  arch/powerpc/include/asm/ftrace.h              |  4 +---
>  arch/powerpc/include/asm/module.h              |  5 -----
>  arch/powerpc/kernel/trace/ftrace.c             |  2 --
>  arch/powerpc/kernel/trace/ftrace_32.S          | 20 ------------------
>  arch/powerpc/kernel/trace/ftrace_64.S          | 29 --------------------------
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  3 ---
>  arch/powerpc/kernel/trace/ftrace_64_pg.S       |  2 --
>  8 files changed, 2 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 73ce5dd07642..23a325df784a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -189,6 +189,7 @@ config PPC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_ONLY

I still think adding:

	select DYNAMIC_FTRACE			if FUNCTION_TRACER

is the better approach.

But I'm all for this patch. I've debated doing the same thing for x86,
but the only reason I have not, was because it's the only way I test
the !DYNAMIC_FTRACE code. I've broken the static function tracing
several times and only find out during my test suite that still tests
that case. But yeah, it would be nice to just nuke static function
tracing for all archs. Perhaps after we finish removing unused archs,
that may be the way to go forward.

-- Steve



>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
>  	select HAVE_EBPF_JIT			if PPC64
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
