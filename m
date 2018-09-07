Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426P5l3b0DzF3S8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 03:08:10 +1000 (AEST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w87H7ptw001165
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Sep 2018 02:07:51 +0900
Received: by mail-ua1-f43.google.com with SMTP id c12-v6so12469961uan.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 10:07:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJJ6DCT8AjVYqkbFuJ+fO0VmVch24B=XRp4pJPkUQYAww@mail.gmail.com>
References: <20180821215524.23040-1-robh@kernel.org>
 <20180821215524.23040-7-robh@kernel.org>
 <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
 <CAL_JsqJJ6DCT8AjVYqkbFuJ+fO0VmVch24B=XRp4pJPkUQYAww@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 8 Sep 2018 02:07:09 +0900
Message-ID: <CAK7LNAR1-G+eg-dAmiDvEo3JJHoXefm2eu+Aorgjv9BP48+qvw@mail.gmail.com>
Subject: Re: [PATCH 6/8] kbuild: consolidate Devicetree dtb build rules
To: Rob Herring <robh@kernel.org>
Cc: DTML <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Michal Marek <michal.lkml@markovi.net>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Ley Foon Tan <lftan@altera.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Linux-MIPS <linux-mips@linux-mips.org>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-08-27 8:56 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Sat, Aug 25, 2018 at 9:06 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Hi Rob,
>>
>>
>> 2018-08-22 6:55 GMT+09:00 Rob Herring <robh@kernel.org>:
>> > There is nothing arch specific about building dtb files other than their
>> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> > The dependencies and supported targets are all slightly different.
>> > Also, a cross-compiler for each arch is needed, but really the host
>> > compiler preprocessor is perfectly fine for building dtbs. Move the
>> > build rules to a common location and remove the arch specific ones. This
>> > is done in a single step to avoid warnings about overriding rules.
>> >
>> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> > These pull in several dependencies some of which need a target compiler
>> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> > All that is really needed is dtc, so adjust the dependencies to only be
>> > dtc.
>> >
>> > This change enables support 'dtbs_install' on some arches which were
>> > missing the target.
>> >
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Michal Marek <michal.lkml@markovi.net>
>> > Cc: Vineet Gupta <vgupta@synopsys.com>
>> > Cc: Russell King <linux@armlinux.org.uk>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> > Cc: Michal Simek <monstr@monstr.eu>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Paul Burton <paul.burton@mips.com>
>> > Cc: James Hogan <jhogan@kernel.org>
>> > Cc: Ley Foon Tan <lftan@altera.com>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: Chris Zankel <chris@zankel.net>
>> > Cc: Max Filippov <jcmvbkbc@gmail.com>
>> > Cc: linux-kbuild@vger.kernel.org
>> > Cc: linux-snps-arc@lists.infradead.org
>> > Cc: linux-arm-kernel@lists.infradead.org
>> > Cc: uclinux-h8-devel@lists.sourceforge.jp
>> > Cc: linux-mips@linux-mips.org
>> > Cc: nios2-dev@lists.rocketboards.org
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Cc: linux-xtensa@linux-xtensa.org
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> >  Makefile                 | 30 ++++++++++++++++++++++++++++++
>> >  arch/arc/Makefile        |  6 ------
>> >  arch/arm/Makefile        | 20 +-------------------
>> >  arch/arm64/Makefile      | 17 +----------------
>> >  arch/c6x/Makefile        |  2 --
>> >  arch/h8300/Makefile      | 11 +----------
>> >  arch/microblaze/Makefile |  4 +---
>> >  arch/mips/Makefile       | 15 +--------------
>> >  arch/nds32/Makefile      |  2 +-
>> >  arch/nios2/Makefile      |  7 -------
>> >  arch/nios2/boot/Makefile |  4 ----
>> >  arch/powerpc/Makefile    |  3 ---
>> >  arch/xtensa/Makefile     | 12 +-----------
>> >  scripts/Makefile         |  1 -
>> >  scripts/Makefile.lib     |  2 +-
>> >  15 files changed, 38 insertions(+), 98 deletions(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index c13f8b85ba60..6d89e673f192 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -1212,6 +1212,30 @@ kselftest-merge:
>> >                 $(srctree)/tools/testing/selftests/*/config
>> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>> >
>> > +# ---------------------------------------------------------------------------
>> > +# Devicetree files
>> > +
>> > +dtstree := $(wildcard arch/$(SRCARCH)/boot/dts)
>
> BTW, there's an error here too. It doesn't work right with
> KBUILD_OUTPUT set and should be:
>
> ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> dtstree := arch/$(SRCARCH)/boot/dts
> endif
>
>> > +
>> > +ifdef CONFIG_OF_EARLY_FLATTREE
>> > +
>> > +%.dtb %.dtb.S %.dtb.o: | dtc
>>
>> I think the pipe operator is unnecessary
>> because Kbuild will descend to $(dtstree) anyway.
>
> The pipe means 'order-only', right?

Yes.

> So it is just a weaker dependency
> for things which are not input files as dtc is not. The 'dtc' here is
> just the dtc rule below, not the actual executable. Or am I missing
> something?


The pipe is used when

  - we want to make sure the weaker prerequisite exists

  - but, we do not want to execute the recipe
    even if the weaker prerequisite is updated


In this case, we want to execute the recipe _all_the_time_.

We compare the timestamp between %.dtb and %.dts in the sub-directory.

We never know the real depenency until the following recipe is run
     $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@



PHONY += dtbs
dtbs: | dtc
      $(Q)$(MAKE) $(build)=$(dtstree)

Here 'dtbs' is a PHONY target.
We always want to run the recipe.
The pipe operator is not sensible.


-- 
Best Regards
Masahiro Yamada
