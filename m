Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42J3Yl4pGnzF3Hj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 20:32:26 +1000 (AEST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w8NAVtbg007514
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 19:31:56 +0900
Received: by mail-vs1-f44.google.com with SMTP id w16-v6so850810vso.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 03:31:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 23 Sep 2018 06:31:14 -0400
Message-ID: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Michal Marek <michal.lkml@markovi.net>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
 Paul Burton <paul.burton@mips.com>, Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-09-13 11:51 GMT-04:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
>> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>> >> There is nothing arch specific about building dtb files other than their
>> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> >> The dependencies and supported targets are all slightly different.
>> >> Also, a cross-compiler for each arch is needed, but really the host
>> >> compiler preprocessor is perfectly fine for building dtbs. Move the
>> >> build rules to a common location and remove the arch specific ones. This
>> >> is done in a single step to avoid warnings about overriding rules.
>> >>
>> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> >> These pull in several dependencies some of which need a target compiler
>> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> >> All that is really needed is dtc, so adjust the dependencies to only be
>> >> dtc.
>> >>
>> >> This change enables support 'dtbs_install' on some arches which were
>> >> missing the target.
>> >
>> > [...]
>> >
>> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
>> >>                 $(srctree)/tools/testing/selftests/*/config
>> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>> >>
>> >> +# ---------------------------------------------------------------------------
>> >> +# Devicetree files
>> >> +
>> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
>> >> +dtstree := arch/$(SRCARCH)/boot/dts
>> >> +endif
>> >> +
>> >> +ifdef CONFIG_OF_EARLY_FLATTREE
>> >
>> > This can be true when dtstree is unset. So this line should be this
>> > instead to fix the 0-day reported error:
>> >
>> > ifneq ($(dtstree),)
>> >
>> >> +
>> >> +%.dtb : scripts_dtc
>> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>> >> +
>> >> +PHONY += dtbs dtbs_install
>> >> +dtbs: scripts_dtc
>> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
>> >> +
>> >> +dtbs_install: dtbs
>> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
>> >> +
>> >> +all: dtbs
>> >> +
>> >> +endif
>>
>>
>> Ah, right.
>> Even x86 can enable OF and OF_UNITTEST.
>>
>>
>>
>> Another solution might be,
>> guard it by 'depends on ARCH_SUPPORTS_OF'.
>>
>>
>>
>> This is actually what ACPI does.
>>
>> menuconfig ACPI
>>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>>         depends on ARCH_SUPPORTS_ACPI
>>          ...
>
> ACPI is a real platform feature, as it depends on firmware.
>
> CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> even if it has ACPI ;-)
>

OK, understood.

Thanks!



-- 
Best Regards
Masahiro Yamada
