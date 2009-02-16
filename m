Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4A812DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 01:53:19 +1100 (EST)
Date: Mon, 16 Feb 2009 17:53:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090216145317.GA3616@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090216142001.GA27869@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090216142001.GA27869@oksana.dev.rtsoft.ru>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2009 at 05:20:01PM +0300, Anton Vorontsov wrote:
> On Sat, Feb 14, 2009 at 08:57:02PM +0100, Sam Ravnborg wrote:
> [...]
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -525,8 +525,6 @@ else
> > > >  KBUILD_CFLAGS	+= -O2
> > > >  endif
> > > >  
> > > > -include $(srctree)/arch/$(SRCARCH)/Makefile
> > > > -
> > > >  ifneq (CONFIG_FRAME_WARN,0)
> > > >  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
> > > >  endif
> > > > @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
> > > >  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
> > > >  endif
> > > >  
> > > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > > +
> > > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > > -- 
> > > 
> > > this patch is really for Sam to judge - Cc:-ed him.
> > 
> > If we move the include further down then the following:
> > 
> >     # Force gcc to behave correct even for buggy distributions
> >     # Arch Makefiles may override this setting
> >     KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
> > 
> > will most likely fail.
> 
> Hm... I don't get it, the comment says that the arch "may override
> this setting", but currently it may not, since arch makefile is
> included before this line. So my patch also fixes this "bug", no?
> 
> Or arches supposed to overwrite "cc-option" behaviour? Hm..
> 
> There is an interesting commit:
> 
> commit e06b8b98da071f7dd78fb7822991694288047df0
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Wed Feb 13 22:43:28 2008 +0100
> 
>     kbuild: allow -fstack-protector to take effect
> [...]
> --- a/Makefile
> +++ b/Makefile
> @@ -507,6 +507,10 @@ else
>  KBUILD_CFLAGS  += -O2
>  endif
> 
> +# Force gcc to behave correct even for buggy distributions
> +# Arch Makefiles may override this setting
> +KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
> +
>  include $(srctree)/arch/$(SRCARCH)/Makefile
>  
>  ifdef CONFIG_FRAME_POINTER
> @@ -525,9 +529,6 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
>  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
>  endif
>  
> -# Force gcc to behave correct even for buggy distributions
> -KBUILD_CFLAGS         += $(call cc-option, -fno-stack-protector)
> -
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> 
> 
> ^^ Which does the same (wrt fno-stack-protector) as the patch I
> sent, i.e. includes arch Makefile later.
> 
> But then, this commit reverted things back (w/o your Ack):
> 
> commit bef5b54bd7bf8117c75cb943d64549134c6d9a1f
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed Jul 16 13:02:24 2008 +0100
> 
>     Fix MIPS cross-compile problem
>     [...]
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Ok, I think I got it. It seems that Ralf was using this feature
of arch/mips/Makefile:

ifneq ($(SUBARCH),$(ARCH))
  ifeq ($(CROSS_COMPILE),)
    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
  endif
endif

There are few arches that have "auto detection" of CROSS_COMPILE
variable: mips, m68k, parisc, xtensa, h8300 and blackfin.

So `normal' arches don't have any chance to overwrite the flags
because of the few offenders above. ;-)

> [...]
> --- a/Makefile
> +++ b/Makefile
> @@ -508,6 +508,8 @@ else
>  KBUILD_CFLAGS  += -O2
>  endif
>  
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -516,8 +518,6 @@ endif
>  # Arch Makefiles may override this setting
>  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
