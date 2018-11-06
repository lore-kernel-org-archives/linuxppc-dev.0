Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4262CC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 15:28:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF452081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 15:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF452081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qD2l1zrmzF3DQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 02:28:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.65; helo=mail-ua1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com
 [209.85.222.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qCzj1FgVzF3D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 02:25:36 +1100 (AEDT)
Received: by mail-ua1-f65.google.com with SMTP id j3so2164051uap.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5bzwxXLTuZIkYi1+oDy9WcbQ21yhzr5FkooL8IpTbKQ=;
 b=HnUdViXQwyMsX2OeYUejh1Ki8Vm9anvKUIxNm0z//pxn/NEk9yFcc2xtIHhyXCfE3I
 WVAwUeoayIkrjKWsSRUx8ZHAQlPfI7LRdWXDlO8vMW//jdKUBacVfyePN+zfrFaDUBgK
 1VND4irbUP7o8oHJ/p9BOnZhVQBbFfzNoIBWqeQKcRgQmyDdQRExR/g0ee2ASfqhtVsV
 RuwyI+VIfbbvV1jUpIh2DUGoerVYPc3AdxvuVL1o5lPNclLUS/5OkrExCA0aPnjBk1rb
 6tQjGr5jEwvEzCr+6sAdtcNQ95GMgFif8dlhCmcHnvAHxNWCMUMyaVlI9jxBhaJPwoES
 BD1w==
X-Gm-Message-State: AGRZ1gKTLDibCzU2bNsM1uD0XWuyKiyfQZ4npTgdBDo2pGlt395CLtAe
 MSD2k99EaHcZQTcTihlxEa5wqbOcPsFUjEl/zzQ=
X-Google-Smtp-Source: AJdET5cKZBHkvYCvNrPkAsfD+RUizrsz+u52iWhXmeTx/85JtDrSRJojeBxlixA422MjSXFU48YWS2lhCDCnVMQivdM=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr489643ual.20.1541517933483;
 Tue, 06 Nov 2018 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
 <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
In-Reply-To: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Nov 2018 16:25:21 +0100
Message-ID: <CAMuHMdWMO5yE7vjWsyz6dWQ6eswVRcWO8A43vTrJn26D1EsfVQ@mail.gmail.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Pierre,

On Tue, Nov 6, 2018 at 3:56 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> >>>>
> >>>> *** ERRORS ***
> >>>>
> >>>>    + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> >>> sh4-all{mod,yes}config
> >>>
> >>> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> >>> pci_iomap() on SH")
> >>> is not sufficient?
> >> Different problem.  This is about "select":
> >>
> >> config SND_SOC_ALL_CODECS
> >>          tristate "Build all ASoC CODEC drivers"
> >>
> >> That enables (sets):
> >>          select SND_SOC_HDAC_HDA
> >> which selects SND_HDA even though CONFIG_PCI is not enabled.
> >>
> >> After SND_HDA is selected (above), the Kconfig symbols in
> >> sound/pci/hda/Kconfig are available for enabling, so
> >> SND_HDA_CODEC_CA0132 is enabled but will not build.
> > Thanks for looking into this!
> >
> >> One simple solution (but possibly too naive) is:
> >>
> >> ---
> >>   sound/soc/codecs/Kconfig |    2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
> >> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
> >> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
> >>          select SND_SOC_ES7241
> >>          select SND_SOC_GTM601
> >>          select SND_SOC_HDAC_HDMI
> >> -       select SND_SOC_HDAC_HDA
> >> +       select SND_SOC_HDAC_HDA if PCI
> >>          select SND_SOC_ICS43432
> >>          select SND_SOC_INNO_RK3036
> >>          select SND_SOC_ISABELLE if I2C
> > I guess that will work. There are already plenty of "select foo if bar" lines.
> > However, looking at what else can enable SND_HDA, I think it should be
> >
> >      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA
>
> This codec can only be used by the Skylake driver (and the upcoming SOF
> one). For Tegra this module will never be used unless they follow the
> same path of enabling ASoC to deal with the HDaudio codecs instead of
> the legacy.
>
> Likewise HDAC_HDMI will only work on Intel platforms for now.
>
> >
> > That still leaves the issue that pci_iomap() on SH should be an empty stub if
> > PCI is not available, like on other architectures.
>
> I thought Mark Brown provided a fix to SH maintainers?

Indeed, https://patchwork.kernel.org/patch/10597409/

As usual, no response from the J^HSH maintainers :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
