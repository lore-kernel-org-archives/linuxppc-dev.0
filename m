Return-Path: <srs0=juda=j3=gmail.com=mathieu.malaterre@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QVZL2dpDzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:10:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41QVZL0ZxSz8xZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:10:02 +1000 (AEST)
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41QVZJ48b5z9s01
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2018 17:10:00 +1000 (AEST)
Received: by mail-oi0-f53.google.com with SMTP id v8-v6so47416992oie.5
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2018 00:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <CA+7wUsz3hADry_O7MCO8pJRmWb84dbQYu8zOyEYQ01P=R8WoDA@mail.gmail.com>
 <874lh7b3tj.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lh7b3tj.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 11 Jul 2018 09:09:44 +0200
Message-ID: <CA+7wUszg2EnuExY=Wx0JWebvFmdYwRSN2nvjkvwTtmD1vS4AJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2018 at 3:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
> > On Mon, Jul 9, 2018 at 4:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> Because the allmodconfig logic just sets every symbol to M or Y, it
> >> has the effect of always generating a 64-bit config, because
> >> CONFIG_PPC64 becomes Y.
> >>
> >> So to make it easier for folks to test 32-bit code, provide a phony
> >> defconfig target that generates a 32-bit allmodconfig.
> >>
> >> The 32-bit port has several mutually exclusive CPU types, we choose
> >> the Book3S variants as that's what the help text in Kconfig says is
> >> most common.
> >
> > Ok then.
>
> That was just me taking a stab in the dark. You suggested we should
> mimic the Debian config, what does that use?

Sorry got confused for a minute. This is the correct value (at least
the one used in Debian).

> >> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> >> index 2ea575cb3401..2556c2182789 100644
> >> --- a/arch/powerpc/Makefile
> >> +++ b/arch/powerpc/Makefile
> >> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
> >>         $(call merge_into_defconfig,mpc86xx_basic_defconfig,\
> >>                 86xx-smp 86xx-hw fsl-emb-nonhw)
> >>
> >> +PHONY += ppc32_allmodconfig
> >> +ppc32_allmodconfig:
> >> +       $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
> >> +               -f $(srctree)/Makefile allmodconfig
> >> +
> >
> > I this a good time to update line 34 at the same time:
> >
> > KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> >
> > ?
>
> 34 or 36?
>
>   ifeq ($(CROSS_COMPILE),)
>   KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>   else
>   KBUILD_DEFCONFIG := ppc64_defconfig
>   endif
>
> Do you mean the else case?

As far as I know uname -m on powerpc returns 'ppc' so the following
has always failed from a ppc32be machine:

$ make ARCH=powerpc defconfig

I was simply suggesting to mimic what was done for ppc64:

ifeq ($(CROSS_COMPILE),)
KBUILD_DEFCONFIG := ppc32_defconfig
else
KBUILD_DEFCONFIG := ppc64_defconfig
endif

If I followed the discussion one would want the file `ppc32_defconfig`
to contains pretty much the same thing as the .config generated from
`book3s_32.config`, right ?

> cheers
