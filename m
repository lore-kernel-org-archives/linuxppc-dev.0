Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5E95DDDA0
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 09:08:49 +1100 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1LYSgl-0000Ga-4J
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 23:08:43 +0100
Date: Sat, 14 Feb 2009 23:03:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090214220326.GA5200@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090214195702.GB1241@uranus.ravnborg.org>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Wed, Feb 04, 2009 at 10:26:12PM +0100, Ingo Molnar wrote:
> > 
> > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > 
> > > This patch gives arches more freedom on overwriting CFLAGS, specifically
> > > on PowerPC we want to remove -fno-omit-frame-pointer flag.
> > > 
> > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > ---
> > >  Makefile |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 7715b2c..d1ba93f 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -525,8 +525,6 @@ else
> > >  KBUILD_CFLAGS	+= -O2
> > >  endif
> > >  
> > > -include $(srctree)/arch/$(SRCARCH)/Makefile
> > > -
> > >  ifneq (CONFIG_FRAME_WARN,0)
> > >  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
> > >  endif
> > > @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
> > >  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
> > >  endif
> > >  
> > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > +
> > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > -- 
> > 
> > this patch is really for Sam to judge - Cc:-ed him.
> 
> If we move the include further down then the following:
> 
>     # Force gcc to behave correct even for buggy distributions
>     # Arch Makefiles may override this setting
>     KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
> 
> will most likely fail.

ah, ok. (I long ago made the mental note of "dont change the toplevel Makefile
if you can avoid it" - this reinforces that.)

> If popwerpc needs to get rid of "-fno-omit-frame-pointer" then
> we need a way to express this at KConfig level and NOT by doing
> some tricks with CFLAGS.

Here is what we have in the toplevel Makefile at the moment:

 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
 KBUILD_CFLAGS   += -fomit-frame-pointer
 endif

My original suggestion (more than a week ago) was to make PPC always
select FRAME_POINTERS.

It was pointed out that -fno-omit-frame-pointers (i.e.: generate frame
pointers) not only makes the code less optimal on PPC, but it can also be 
miscompiled.

But instrumentation really needs to know whether __builtin_return_address(1)
[etc] is reliable, whether stack tracing is fast - and other details -  and PPC
is the odd one out.

So the question is: even with FRAME_POINTERS disabled on PPC, is 
__builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
can it walk down the stack frame efficiently, or does it have to scan the full
kernel stack) I.e. does PPC have all the material advantages of frame pointers?

	Ingo
