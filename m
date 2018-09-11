Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428pyb2RFVzF39H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:40:23 +1000 (AEST)
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com
 [209.85.216.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AD9520898
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 15:40:21 +0000 (UTC)
Received: by mail-qt0-f180.google.com with SMTP id z8-v6so28671217qto.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
In-Reply-To: <20180910150403.19476-7-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Sep 2018 10:40:07 -0500
Message-ID: <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>,
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-xtensa@linux-xtensa.org,
 Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.

[...]

> @@ -1215,6 +1215,33 @@ kselftest-merge:
>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> +# ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree := arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE

This can be true when dtstree is unset. So this line should be this
instead to fix the 0-day reported error:

ifneq ($(dtstree),)

> +
> +%.dtb : scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs dtbs_install
> +dtbs: scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs
> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +all: dtbs
> +
> +endif
