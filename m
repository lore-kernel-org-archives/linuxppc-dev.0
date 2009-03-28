Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 7092BDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 21:48:59 +1100 (EST)
Date: Sat, 28 Mar 2009 13:48:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 1/3] powerpc, Makefile: Make it possible to safely
	select CONFIG_FRAME_POINTER
Message-ID: <20090328104857.GA10897@oksana.dev.rtsoft.ru>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
	<20090320164429.GA28037@oksana.dev.rtsoft.ru>
	<1237607369.17367.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1237607369.17367.7.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2009 at 11:49:29PM -0400, Steven Rostedt wrote:
> Ben,
> 
> Can you ACK this patch? Or even take it in your tree?

Benjamin, have you had a chance to look into this? Sam, could
you also take a look?

Thanks!

> On Fri, 2009-03-20 at 19:44 +0300, Anton Vorontsov wrote:
> > This patch introduces ARCH_HAS_NORMAL_FRAME_POINTERS Kconfig symbol.
> > When defined, the top level Makefile won't add -fno-omit-frame-pointer
> > cflag (the flag is useless in PowerPC kernels, and also makes gcc
> > generate wrong code).
> > 
> > Also move ARCH_WANT_FRAME_POINTERS's help text.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  Makefile             |    7 +++++--
> >  arch/powerpc/Kconfig |    1 +
> >  lib/Kconfig.debug    |   16 ++++++++++------
> >  3 files changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 46c04c5..bf41b05 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -538,9 +538,12 @@ KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
> >  endif
> >  
> >  ifdef CONFIG_FRAME_POINTER
> > -KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> > +  KBUILD_CFLAGS	+= -fno-optimize-sibling-calls
> > +  ifndef ARCH_HAS_NORMAL_FRAME_POINTERS
> > +    KBUILD_CFLAGS	+= -fno-omit-frame-pointer
> > +  endif
> >  else
> > -KBUILD_CFLAGS	+= -fomit-frame-pointer
> > +  KBUILD_CFLAGS	+= -fomit-frame-pointer
> >  endif
> >  
> >  ifdef CONFIG_DEBUG_INFO
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 97f9a64..4587e66 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -113,6 +113,7 @@ config PPC
> >  	select HAVE_FUNCTION_TRACER
> >  	select HAVE_FUNCTION_GRAPH_TRACER
> >  	select ARCH_WANT_OPTIONAL_GPIOLIB
> > +	select ARCH_HAS_NORMAL_FRAME_POINTERS
> >  	select HAVE_IDE
> >  	select HAVE_IOREMAP_PROT
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 4b63b6b..fc8cd1f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -661,20 +661,24 @@ config DEBUG_NOTIFIERS
> >  	  This is a relatively cheap check but if you care about maximum
> >  	  performance, say N.
> >  
> > -#
> > -# Select this config option from the architecture Kconfig, if it
> > -# it is preferred to always offer frame pointers as a config
> > -# option on the architecture (regardless of KERNEL_DEBUG):
> > -#
> >  config ARCH_WANT_FRAME_POINTERS
> >  	bool
> >  	help
> > +	  Select this config option from the architecture Kconfig, if it
> > +	  it is preferred to always offer frame pointers as a config
> > +	  option on the architecture (regardless of KERNEL_DEBUG).
> > +
> > +config ARCH_HAS_NORMAL_FRAME_POINTERS
> > +	bool
> > +	help
> > +	  Architectures should select this symbol if their ABI implies
> > +	  having a frame pointer.
> >  
> >  config FRAME_POINTER
> >  	bool "Compile the kernel with frame pointers"
> >  	depends on DEBUG_KERNEL && \
> >  		(CRIS || M68K || M68KNOMMU || FRV || UML || S390 || \
> > -		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
> > +		 AVR32 || SUPERH || BLACKFIN || MN10300 || PPC) || \
> >  		ARCH_WANT_FRAME_POINTERS
> >  	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
> >  	help
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
