Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QgSM1s9hzF35d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:50:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
In-Reply-To: <CA+7wUszg2EnuExY=Wx0JWebvFmdYwRSN2nvjkvwTtmD1vS4AJQ@mail.gmail.com>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <CA+7wUsz3hADry_O7MCO8pJRmWb84dbQYu8zOyEYQ01P=R8WoDA@mail.gmail.com>
 <874lh7b3tj.fsf@concordia.ellerman.id.au>
 <CA+7wUszg2EnuExY=Wx0JWebvFmdYwRSN2nvjkvwTtmD1vS4AJQ@mail.gmail.com>
Date: Wed, 11 Jul 2018 23:50:25 +1000
Message-ID: <87fu0panku.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:
> On Tue, Jul 10, 2018 at 3:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Mathieu Malaterre <malat@debian.org> writes:
>> > On Mon, Jul 9, 2018 at 4:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >> Because the allmodconfig logic just sets every symbol to M or Y, it
>> >> has the effect of always generating a 64-bit config, because
>> >> CONFIG_PPC64 becomes Y.
>> >>
>> >> So to make it easier for folks to test 32-bit code, provide a phony
>> >> defconfig target that generates a 32-bit allmodconfig.
>> >>
>> >> The 32-bit port has several mutually exclusive CPU types, we choose
>> >> the Book3S variants as that's what the help text in Kconfig says is
>> >> most common.
>> >
>> > Ok then.
>>
>> That was just me taking a stab in the dark. You suggested we should
>> mimic the Debian config, what does that use?
>
> Sorry got confused for a minute. This is the correct value (at least
> the one used in Debian).

OK cool.

>> >> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> >> index 2ea575cb3401..2556c2182789 100644
>> >> --- a/arch/powerpc/Makefile
>> >> +++ b/arch/powerpc/Makefile
>> >> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
>> >>         $(call merge_into_defconfig,mpc86xx_basic_defconfig,\
>> >>                 86xx-smp 86xx-hw fsl-emb-nonhw)
>> >>
>> >> +PHONY += ppc32_allmodconfig
>> >> +ppc32_allmodconfig:
>> >> +       $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
>> >> +               -f $(srctree)/Makefile allmodconfig
>> >> +
>> >
>> > I this a good time to update line 34 at the same time:
>> >
>> > KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>> >
>> > ?
>>
>> 34 or 36?
>>
>>   ifeq ($(CROSS_COMPILE),)
>>   KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>>   else
>>   KBUILD_DEFCONFIG := ppc64_defconfig
>>   endif
>>
>> Do you mean the else case?
>
> As far as I know uname -m on powerpc returns 'ppc' so the following
> has always failed from a ppc32be machine:

Oh yep it does.

I've never built a kernel *on* a 32-bit machine ;)

> $ make ARCH=powerpc defconfig
>
> I was simply suggesting to mimic what was done for ppc64:
>
> ifeq ($(CROSS_COMPILE),)
> KBUILD_DEFCONFIG := ppc32_defconfig
> else
> KBUILD_DEFCONFIG := ppc64_defconfig
> endif

That wouldn't work, CROSS_COMPILE isn't a ppc/ppc64 thing.

In fact setting CROSS_COMPILE doesn't actually mean you're cross
compiling, it just means you're using a different toolchain. I do that
all the time, because I want to use a specific version of GCC, not the
distro one.


What about:

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ea575c..e70d223 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,10 +30,13 @@ endif
 endif
 endif
 
-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
+host_arch := $(shell uname -m)
+ifeq ($(host_arch),ppc)
+       KBUILD_DEFCONFIG := ppc32_defconfig
+else ifeq ($(host_arch),ppc64)
+       KBUILD_DEFCONFIG := ppc64_defconfig
 else
-KBUILD_DEFCONFIG := ppc64_defconfig
+       KBUILD_DEFCONFIG := ppc64le_defconfig
 endif
 
 ifeq ($(CONFIG_PPC64),y)


We obviously need a ppc32_defconfig to make that work.

> If I followed the discussion one would want the file `ppc32_defconfig`
> to contains pretty much the same thing as the .config generated from
> `book3s_32.config`, right ?

Can you boot the resulting kernel if you build ppc32_allmodconfig ?

Maybe we should just make that be ppc32_defconfig.

cheers
