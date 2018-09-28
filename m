Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6C1C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:44:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D0B20779
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D0B20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MGFG1wGGzF3J7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:44:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MGBV40cJzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 01:41:54 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id e21-v6so6425480otk.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 08:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Awlj99FgZ/YEXpgjtWqB9fdQVuQH2oVxCsOpG+r2+7E=;
 b=gYYstF6Ys+CNtFTVXSxFJuDNGTno3pqnZTeBYIqKQfPtBwY23FhAw70cjByx9D40A3
 XRq0323j8hmB+zy/fv5Il/u8Z3h3R3qPpzTG++KBcrGd6Yvvfh++wGIaL0A7v+qYzP29
 z10DJiThcbyv451BvSTLVJTmMmps40Gom+tG25ZGl43jqtSyAJW4qfbVFG1RzBpX1an9
 ihBWNQ7dIcQRne71arMG7TOQmXgy2iKnOaovjEr0SWJIGmLEKWKFrNmhR2GnKwR9f8X3
 BC8R8Nt0sH58lj6wwh7vUTTs6SaN0rBQl66LMwja+wNM+e5AG20XEq9VaxFsKrpxRlQi
 3+EQ==
X-Gm-Message-State: ABuFfojuGR+v8D3PKVBwJcGyLB+2YmYyqaPj24h15L3N8zYE8GCdDMCf
 UTL92cgB+D9aRdl+lDV/6w==
X-Google-Smtp-Source: ACcGV63Srp0ldQSrIctZT4UQV6IqBMA8o6ihwirFprd6xuVCSZCJqUWFTEixZBqscIfRTKuidGdkCQ==
X-Received: by 2002:a9d:3cb9:: with SMTP id
 z54-v6mr9422754otc.22.1538149312058; 
 Fri, 28 Sep 2018 08:41:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r3-v6sm662372oih.44.2018.09.28.08.41.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Sep 2018 08:41:51 -0700 (PDT)
Date: Fri, 28 Sep 2018 10:41:50 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
Message-ID: <20180928154150.GA25013@bogus>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Michal Marek <michal.lkml@markovi.net>, Vineet Gupta <vgupta@synopsys.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 23, 2018 at 06:31:14AM -0400, Masahiro Yamada wrote:
> 2018-09-13 11:51 GMT-04:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > Hi Yamada-san,
> >
> > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> >> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
> >> >> There is nothing arch specific about building dtb files other than their
> >> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> >> >> The dependencies and supported targets are all slightly different.
> >> >> Also, a cross-compiler for each arch is needed, but really the host
> >> >> compiler preprocessor is perfectly fine for building dtbs. Move the
> >> >> build rules to a common location and remove the arch specific ones. This
> >> >> is done in a single step to avoid warnings about overriding rules.
> >> >>
> >> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> >> >> These pull in several dependencies some of which need a target compiler
> >> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> >> >> All that is really needed is dtc, so adjust the dependencies to only be
> >> >> dtc.
> >> >>
> >> >> This change enables support 'dtbs_install' on some arches which were
> >> >> missing the target.
> >> >
> >> > [...]
> >> >
> >> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
> >> >>                 $(srctree)/tools/testing/selftests/*/config
> >> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >> >>
> >> >> +# ---------------------------------------------------------------------------
> >> >> +# Devicetree files
> >> >> +
> >> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> >> >> +dtstree := arch/$(SRCARCH)/boot/dts
> >> >> +endif
> >> >> +
> >> >> +ifdef CONFIG_OF_EARLY_FLATTREE
> >> >
> >> > This can be true when dtstree is unset. So this line should be this
> >> > instead to fix the 0-day reported error:
> >> >
> >> > ifneq ($(dtstree),)
> >> >
> >> >> +
> >> >> +%.dtb : scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >> >> +
> >> >> +PHONY += dtbs dtbs_install
> >> >> +dtbs: scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
> >> >> +
> >> >> +dtbs_install: dtbs
> >> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> >> >> +
> >> >> +all: dtbs
> >> >> +
> >> >> +endif
> >>
> >>
> >> Ah, right.
> >> Even x86 can enable OF and OF_UNITTEST.
> >>
> >>
> >>
> >> Another solution might be,
> >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> >>
> >>
> >>
> >> This is actually what ACPI does.
> >>
> >> menuconfig ACPI
> >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >>         depends on ARCH_SUPPORTS_ACPI
> >>          ...
> >
> > ACPI is a real platform feature, as it depends on firmware.
> >
> > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > even if it has ACPI ;-)
> >
> 
> OK, understood.

Any other comments on this? I'd like to get the series into linux-next 
soon.

There was one other problem 0-day reported when building with 
CONFIG_OF=n while setting CONFIG_OF_ALL_DTBS=y on the kernel command 
line. The problem is dtc is not built as setting options on the command 
line doesn't invoke kconfig select(s). This can be fixed by also 
adding CONFIG_DTC=y to the command line, always building dtc regardless 
of Kconfig, or making 'all' conditionally dependent on 'dtbs'. I've gone 
with the last option as that is how this problem was avoided before. 

So the hunk in question with the 2 fixes now looks like this:

@@ -1215,6 +1215,35 @@ kselftest-merge:
                $(srctree)/tools/testing/selftests/*/config
        +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
+# 
---------------------------------------------------------------------------
+# Devicetree files
+
+ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
+dtstree := arch/$(SRCARCH)/boot/dts
+endif
+
+ifneq ($(dtstree),)
+
+%.dtb : scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
+PHONY += dtbs dtbs_install
+dtbs: scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree)
+
+dtbs_install: dtbs
+       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
+
+ifdef CONFIG_OF_EARLY_FLATTREE
+all: dtbs
+endif
+
+endif
+
+PHONY += scripts_dtc
+scripts_dtc: scripts_basic
+       $(Q)$(MAKE) $(build)=scripts/dtc
+
 # 
---------------------------------------------------------------------------
 # Modules
 
