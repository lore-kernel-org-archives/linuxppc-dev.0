Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0024.hostedemail.com
 [216.40.44.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2CA61A0065
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:48:08 +1100 (AEDT)
Date: Fri, 5 Feb 2016 09:48:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Jiri
 Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Jessica Yu
 <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160205094803.1e0c6c91@gandalf.local.home>
In-Reply-To: <20160205140517.GE3305@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
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

On Fri, 5 Feb 2016 15:05:17 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2016-01-25 16:29:54, Torsten Duwe wrote:
> > diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> > index ef8b916..29b7014 100644
> > --- a/arch/powerpc/kernel/ftrace.c
> > +++ b/arch/powerpc/kernel/ftrace.c
> > @@ -28,6 +28,11 @@
> >  
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && defined(CONFIG_PPC64) && \
> > +  !defined(CC_USING_MPROFILE_KERNEL)
> > +#error "DYNAMIC_FTRACE_WITH_REGS requires working -mprofile-kernel"
> > +#endif  
> 
> CONFIG_DYNAMIC_FTRACE_WITH_REGS is automatically enabled when
> both CONFIG_DYNAMIC_FTRACE and HAVE_DYNAMIC_FTRACE_WITH_REGS
> are enabled.
> 
> Therefore it is not possible to build kernel with broken gcc
> and DYNAMIC_FTRACE.
> 
> IMHO, we need to allow to explicitely disable DYNAMIC_FTRACE_WITH_REGS
> if the compiler is broken to get around this build error.
> 
> We either need to define DYNAMIC_FTRACE_WITH_REGS as a proper
> bool with description, help text, ... Or we need a way to
> explicitely disable HAVE_DYNAMIC_FTRACE_WITH_REGS. Or something
> like this.
> 

You mean something like this?

(not tested)

-- Steve

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e45db6b0d878..19377bacebfc 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -470,6 +470,19 @@ config DYNAMIC_FTRACE_WITH_REGS
 	def_bool y
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+	depends on !DISABLE_DYNAMIC_FTRACE_WITH_REGS
+
+config DISABLE_DYNAMIC_FTRACE_WITH_REGS
+       bool "Force build to not have function tracer pass in registers"
+       depends on DYNAMIC_FTRACE
+       depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+       help
+	 If the architecture supports passing in registers to the function
+	 tracer, then that is automatically enabled. But there may be some
+	 compilers out there that are broken and cause this to fail.
+	 This option makes the build think that the architecture does not
+	 support the register passing and allows the build to work even
+	 with compilers that do not support the feature.g
 
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
