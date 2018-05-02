Return-Path: <srs1=hzuy=kernel.org==dzsu=hv=goodmis.org=rostedt@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdRG2D4vzF2SV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 22:50:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40bdRG1YrCz8vKh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 22:50:18 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40bdRF4bdwz9s0W
 for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2018 22:50:17 +1000 (AEST)
Date: Wed, 2 May 2018 08:50:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] tracing: Remove PPC32 wart from config TRACING_SUPPORT
Message-ID: <20180502085013.2571183b@gandalf.local.home>
In-Reply-To: <20180502112948.1747-1-mpe@ellerman.id.au>
References: <20180502112948.1747-1-mpe@ellerman.id.au>
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

On Wed,  2 May 2018 21:29:48 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> config TRACING_SUPPORT has an exception for PPC32, because PPC32
> didn't have irqflags tracing support.
> 
> But that hasn't been true since commit 5d38902c4838 ("powerpc: Add
> irqtrace support for 32-bit powerpc") (Jun 2009).
> 
> So remove the exception for PPC32 and the comment.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Feel free to take this patch through the PPC tree.

Thanks!

-- Steve

> ---
>  kernel/trace/Kconfig | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c4f0f2e4126e..dd6c0a2ad969 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -110,11 +110,7 @@ config GENERIC_TRACER
>  #
>  config TRACING_SUPPORT
>  	bool
> -	# PPC32 has no irqflags tracing support, but it can use most of the
> -	# tracers anyway, they were tested to build and work. Note that new
> -	# exceptions to this list aren't welcomed, better implement the
> -	# irqflags tracing for your architecture.
> -	depends on TRACE_IRQFLAGS_SUPPORT || PPC32
> +	depends on TRACE_IRQFLAGS_SUPPORT
>  	depends on STACKTRACE_SUPPORT
>  	default y
>  
