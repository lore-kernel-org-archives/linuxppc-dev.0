Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4289ZT25nfzF31F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 00:35:45 +1000 (AEST)
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com
 [209.85.216.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 356BA20890
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 14:35:43 +0000 (UTC)
Received: by mail-qt0-f172.google.com with SMTP id m13-v6so24447603qth.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 07:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180905235327.5996-1-robh@kernel.org>
 <20180905235327.5996-7-robh@kernel.org>
 <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
In-Reply-To: <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 10 Sep 2018 09:35:29 -0500
Message-ID: <CAL_JsqKS+h0B5AuUh=vk0m1_7KSj4h2zZUo22rdt1w7oee=QwA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>,
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

On Sun, Sep 9, 2018 at 6:28 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
> > There is nothing arch specific about building dtb files other than their
> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> > The dependencies and supported targets are all slightly different.
> > Also, a cross-compiler for each arch is needed, but really the host
> > compiler preprocessor is perfectly fine for building dtbs. Move the
> > build rules to a common location and remove the arch specific ones. This
> > is done in a single step to avoid warnings about overriding rules.
> >
> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> > These pull in several dependencies some of which need a target compiler
> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> > All that is really needed is dtc, so adjust the dependencies to only be
> > dtc.
> >
> > This change enables support 'dtbs_install' on some arches which were
> > missing the target.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: uclinux-h8-devel@lists.sourceforge.jp
> > Cc: linux-mips@linux-mips.org
> > Cc: nios2-dev@lists.rocketboards.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-xtensa@linux-xtensa.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack so I can take the whole series via the DT tree.
> >
> > v2:
> >  - Fix $arch/boot/dts path check for out of tree builds
> >  - Fix dtc dependency for building built-in dtbs
> >  - Fix microblaze built-in dtb building
> >
> >  Makefile                          | 32 +++++++++++++++++++++++++++++++
> >  arch/arc/Makefile                 |  6 ------
> >  arch/arm/Makefile                 | 20 +------------------
> >  arch/arm64/Makefile               | 17 +---------------
> >  arch/c6x/Makefile                 |  2 --
> >  arch/h8300/Makefile               | 11 +----------
> >  arch/microblaze/Makefile          |  4 +---
> >  arch/microblaze/boot/dts/Makefile |  2 ++
> >  arch/mips/Makefile                | 15 +--------------
> >  arch/nds32/Makefile               |  2 +-
> >  arch/nios2/Makefile               |  7 -------
> >  arch/nios2/boot/Makefile          |  4 ----
> >  arch/powerpc/Makefile             |  3 ---
> >  arch/xtensa/Makefile              | 12 +-----------
> >  scripts/Makefile.lib              |  2 +-
> >  15 files changed, 42 insertions(+), 97 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2b458801ba74..bc18dbbc16c5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1212,6 +1212,32 @@ kselftest-merge:
> >                 $(srctree)/tools/testing/selftests/*/config
> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >
> > +# ---------------------------------------------------------------------------
> > +# Devicetree files
> > +
> > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > +dtstree := arch/$(SRCARCH)/boot/dts
> > +endif
> > +
> > +ifdef CONFIG_OF_EARLY_FLATTREE
> > +
> > +%.dtb %.dtb.S %.dtb.o: | dtc
> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
>
> Hmm, I was worried about '%.dtb.o: | dtc'
> but seems working.
>
> Compiling %.S -> %.o requires objtool for x86,
> but x86 does not support DT.

Well, x86 does support DT to some extent. There's 2 platforms and the
DT unittests build and run on x86.

Actually, we can remove "%.dtb.S %.dtb.o" because we don't need those
as top-level build targets. Must have been a copy-n-paste relic from
before having common rules.

>
> If CONFIG_MODVERSIONS=y, scripts/genksyms/genksyms is required,
> %.dtb.S does not contain EXPORT_SYMBOL.

Okay, but that shouldn't affect any of this. We only build *.dtb.S
when doing built-in dtbs.

> BTW, 'dtc' should be a PHONY target.

Right, I found that too.

Rob
