Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5D981A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 03:18:39 +1100 (AEDT)
Date: Fri, 5 Feb 2016 17:18:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160205161834.GF731@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160205094803.1e0c6c91@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2016-02-05 09:48:03, Steven Rostedt wrote:
> On Fri, 5 Feb 2016 15:05:17 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2016-01-25 16:29:54, Torsten Duwe wrote:
> > > diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> > > index ef8b916..29b7014 100644
> > > --- a/arch/powerpc/kernel/ftrace.c
> > > +++ b/arch/powerpc/kernel/ftrace.c
> > > @@ -28,6 +28,11 @@
> > >  
> > >  
> > >  #ifdef CONFIG_DYNAMIC_FTRACE
> > > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && defined(CONFIG_PPC64) && \
> > > +  !defined(CC_USING_MPROFILE_KERNEL)
> > > +#error "DYNAMIC_FTRACE_WITH_REGS requires working -mprofile-kernel"
> > > +#endif  
> > 
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS is automatically enabled when
> > both CONFIG_DYNAMIC_FTRACE and HAVE_DYNAMIC_FTRACE_WITH_REGS
> > are enabled.
> > 
> > Therefore it is not possible to build kernel with broken gcc
> > and DYNAMIC_FTRACE.
> > 
> > IMHO, we need to allow to explicitely disable DYNAMIC_FTRACE_WITH_REGS
> > if the compiler is broken to get around this build error.
> > 
> > We either need to define DYNAMIC_FTRACE_WITH_REGS as a proper
> > bool with description, help text, ... Or we need a way to
> > explicitely disable HAVE_DYNAMIC_FTRACE_WITH_REGS. Or something
> > like this.
> > 
> 
> You mean something like this?
> 
> (not tested)
> 
> -- Steve
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e45db6b0d878..19377bacebfc 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -470,6 +470,19 @@ config DYNAMIC_FTRACE_WITH_REGS
>  	def_bool y
>  	depends on DYNAMIC_FTRACE
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
> +	depends on !DISABLE_DYNAMIC_FTRACE_WITH_REGS
> +
> +config DISABLE_DYNAMIC_FTRACE_WITH_REGS
> +       bool "Force build to not have function tracer pass in registers"
> +       depends on DYNAMIC_FTRACE
> +       depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
> +       help
> +	 If the architecture supports passing in registers to the function
> +	 tracer, then that is automatically enabled. But there may be some
> +	 compilers out there that are broken and cause this to fail.
> +	 This option makes the build think that the architecture does not
> +	 support the register passing and allows the build to work even
> +	 with compilers that do not support the feature.g

s/feature.g/feature/


>  config FUNCTION_PROFILER
>  	bool "Kernel function profiler"

It works but the extra option and reverse logic makes things even
more complicated. Whem I think about it, the change below does similar
job and looks more strightforwad:

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a138f6d..de6dab0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -449,7 +449,7 @@ config PROBE_EVENTS
 	def_bool n
 
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool "Enable/Disable function tracing dynamically"
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y
@@ -472,9 +472,17 @@ config DYNAMIC_FTRACE
 	  otherwise has native performance as long as no tracing is active.
 
 config DYNAMIC_FTRACE_WITH_REGS
-	def_bool y
+	bool "Pass registers to function tracer"
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+	default y
+	help
+	  This option enables passing the current state of processor
+	  registers to the function tracer. It allows to do a more
+	  detailed analyze and print more information.
+
+	  Say Y here if you are unsure. The only exception is if
+	  you want to pass a build error caused by a broken compiler.
 
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"


I made "enable/disable" uppercase because it looked weird in
context of other descritions.

Best Regards,
Petr
