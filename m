Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0156.hostedemail.com
 [216.40.44.156])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95341A0065
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 03:30:39 +1100 (AEDT)
Date: Fri, 5 Feb 2016 11:30:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Jiri
 Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Jessica Yu
 <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160205113032.620c97f3@gandalf.local.home>
In-Reply-To: <20160205161834.GF731@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz>
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

On Fri, 5 Feb 2016 17:18:34 +0100
Petr Mladek <pmladek@suse.com> wrote:

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a138f6d..de6dab0 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -449,7 +449,7 @@ config PROBE_EVENTS
>  	def_bool n
>  
>  config DYNAMIC_FTRACE
> -	bool "enable/disable function tracing dynamically"
> +	bool "Enable/Disable function tracing dynamically"
>  	depends on FUNCTION_TRACER
>  	depends on HAVE_DYNAMIC_FTRACE
>  	default y
> @@ -472,9 +472,17 @@ config DYNAMIC_FTRACE
>  	  otherwise has native performance as long as no tracing is active.
>  
>  config DYNAMIC_FTRACE_WITH_REGS
> -	def_bool y
> +	bool "Pass registers to function tracer"
>  	depends on DYNAMIC_FTRACE
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
> +	default y
> +	help
> +	  This option enables passing the current state of processor
> +	  registers to the function tracer. It allows to do a more
> +	  detailed analyze and print more information.
> +
> +	  Say Y here if you are unsure. The only exception is if
> +	  you want to pass a build error caused by a broken compiler.
>  
>  config FUNCTION_PROFILER
>  	bool "Kernel function profiler"
> 
> 
> I made "enable/disable" uppercase because it looked weird in
> context of other descritions.
> 

This works too, and I'm fine with it.

-- Steve
