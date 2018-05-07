Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fdCX2yYhzF151
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 19:50:31 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m21-v6so19842545pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 02:50:31 -0700 (PDT)
Date: Mon, 7 May 2018 19:50:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 1/2] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Message-ID: <20180507195018.1ec8a8ea@roar.ozlabs.ibm.com>
In-Reply-To: <CAK7LNAT3nowJ=CCE0OARdADyvuXOH+zFyQBBg3HOgp+W=ezT0g@mail.gmail.com>
References: <20180430012351.28814-1-npiggin@gmail.com>
 <20180430012351.28814-2-npiggin@gmail.com>
 <CAK7LNAT3nowJ=CCE0OARdADyvuXOH+zFyQBBg3HOgp+W=ezT0g@mail.gmail.com>
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

On Mon, 7 May 2018 14:25:12 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi.
> 
> 
> 2018-04-30 10:23 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > The powerpc toolchain can compile combinations of 32/64 bit and
> > big/little endian, so it's convenient to consider, e.g.,
> >
> >   CC -m64 -mbig-endian
> >
> > To be the C compiler for the purpose of invoking it to build
> > target artifacts.  
> 
> Right, but this is not possible in the new Kconfig scheme
> because CPU_BIG/LITTLE_ENDIAN can be turned on/off
> from Kconfig menus.
> 
> 
> > Rather than override, use kbuild defined variables to pass these
> > flags around. Importantly, they must be passed to things like
> > cc-option, so the usual cflags-y is not sufficient. This multitude
> > of inconsistently named variables is a mess, but it's marginally
> > better than overriding the toolchain because it matches what other
> > architectures do.
> >
> > This allows powerpc builds to work with the new kconfig macro
> > language branch. XXX: not exactly sure why it fails in the first
> > place.  
> 
> 
> Without this patch, 'scripts/kconfig/conf  --syncconfig Kconfig'
> continues eternally.
> 
> This is because the change of environment variable $(CC) will
> trigger syncconfig.
> 
> So, this patch is the right thing to do.

Thanks for looking, yes I like it better. I'm still having some
trouble with 32-bit cross compilation with 64-bit toolchain. I'm
trying to work through this, may need some help though.

> > XXX: 32-bit builds with 64-bit toolchain gain some additional options
> > like -funit-at-a-time from cc-option. Unclear why that is. Build
> > appears to be correct otherwise.
> > ---
> >  arch/powerpc/Makefile | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 95813df90801..046b5dde9ff5 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -74,13 +74,15 @@ endif
> >  endif
> >
> >  ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> > -override LD    += -EL
> > +KBUILD_CPPFLAGS        += -mlittle-endian  
> 
> 
> IMHO, I personally prefer
> 
> KBUILD_CFLAGS        += -mlittle-endian
> KBUILD_AFLAGS        += -mlittle-endian
> 
> like the current arch/powerpc/Makefile add the flag
> to cflags-y / aflags-y separately.

The problem I found is that we need this option to be invoked
with 'cc-option'. I know this is probably not the right way to
go about it though, but arm64 seems to have the same hack.

Any suggestions for how to solve that? Should the cc-option
take KBUILD_CFLAGS as well?


> Only the difference would be whether -mlittle-endian
> is passed to pre-processing the linker script, though.
> 
> 
> 
> 
> > +LDFLAGS                += -EL
> >  LDEMULATION    := lppc
> >  GNUTARGET      := powerpcle
> >  MULTIPLEWORD   := -mno-multiple
> >  KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
> >  else
> > -override LD    += -EB
> > +KBUILD_CPPFLAGS += $(call cc-option,-mbig-endian)
> > +LDFLAGS                += -EB
> >  LDEMULATION    := ppc
> >  GNUTARGET      := powerpc
> >  MULTIPLEWORD   := -mmultiple
> > @@ -93,8 +95,6 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)               += $(call cc-option,-mabi=elfv1)
> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mabi=elfv2
> >  endif
> >
> > -cflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mlittle-endian
> > -cflags-$(CONFIG_CPU_BIG_ENDIAN)                += $(call cc-option,-mbig-endian)
> >  ifneq ($(cc-name),clang)
> >    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mno-strict-align
> >  endif
> > @@ -103,9 +103,9 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mbig-endian)
> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mlittle-endian
> >
> >  ifeq ($(HAS_BIARCH),y)
> > -override AS    += -a$(BITS)
> > -override LD    += -m elf$(BITS)$(LDEMULATION)
> > -override CC    += -m$(BITS)
> > +KBUILD_CPPFLAGS        += -m$(BITS)  
> 
> 
> Do you mean this?
> 
> KBUILD_CFLAGS        += -m$(BITS)

IIRC it was the same cc-option problem.

> > +KBUILD_AFLAGS  += -m$(BITS) -Wl,-a$(BITS)  
> 
> 
> Both KBUILD_CPPFLAGS and KBUILD_AFLAGS are added
> to orig_a_flags in scripts/Makefile.lib
> 
> So, -m$(BITS) will be doubled for *.S files.

Yes, I haven't got things quite right yet.

Thanks,
Nick
