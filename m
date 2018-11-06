Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36CBC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 08:03:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D802085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 08:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D802085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q29b5MYtzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 19:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.196; helo=mail-vk1-f196.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
 [209.85.221.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q27Q1trWzF39r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 19:01:38 +1100 (AEDT)
Received: by mail-vk1-f196.google.com with SMTP id u62so2665281vkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 00:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T0Ix/0bIGw6OsEI0LrY5rkA9hhTbYLHvl/qo4fPrRBk=;
 b=rYBVn3MeqAgiRfZC07St+NB8QIBOPsaC1DJ2L+YzCx1/3rmHqQD2uKjsKxFwKZRLet
 fgwrTjXCZSU32ClahjUjU5vg9wXRGSSRX1rDWjUiW/AdmYQz0Myz6ACWj4hUmVxThFd+
 i7CME2Y/aI+6CFRPLQyzJR8WjCxH8QaxKoGjAg9iTTUCVMQCA5WhkmEC07D8WtYKdt0H
 hZ16yjsSAH63G/255NpZXHMicMnNzFdhEFsoCD9w6+95YXqg3n649B3XBiTOODy3bLZp
 gVCAxfoTOuOvcA4FQxYgjLVSQka0NMek3nfk5+vIOG/QtfGolfh2uCSRSziAhtXQbh/e
 pIhA==
X-Gm-Message-State: AGRZ1gL1cCGqSLcAC0JKSoJmYfeFMeHsbjvIAozf8+KK/0+FfERxf8ch
 3gyp2ElrIPND4rDg/ljBv6Pn74pJdZZ2KhZ4hhs=
X-Google-Smtp-Source: AJdET5ewbKFORQ9x1DhND2Q43p9VeYab7xI9mCbQynqP/hmCGmI7jzUqB8EogrA4sYLZZNGFkZOQwvQZjggBrXjsq4U=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr11145554vkh.65.1541491295531; 
 Tue, 06 Nov 2018 00:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
In-Reply-To: <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Nov 2018 09:01:23 +0100
Message-ID: <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
To: Randy Dunlap <rdunlap@infradead.org>
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Randy,

On Tue, Nov 6, 2018 at 2:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> > On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v4.20-rc1[1] compared to v4.19[2].
> >>
> >> Summarized:
> >>   - build errors: +3/-0
> >>   - build warnings: +449/-2712
> >>
> >> Happy fixing! ;-)
> >>
> >> Thanks to the linux-next team for providing the build service.
> >>
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
> >>
> >>
> >> *** ERRORS ***
> >>
> >>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> >
> > sh4-all{mod,yes}config
> >
> > Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> > pci_iomap() on SH")
> > is not sufficient?
>
> Different problem.  This is about "select":
>
> config SND_SOC_ALL_CODECS
>         tristate "Build all ASoC CODEC drivers"
>
> That enables (sets):
>         select SND_SOC_HDAC_HDA
> which selects SND_HDA even though CONFIG_PCI is not enabled.
>
> After SND_HDA is selected (above), the Kconfig symbols in
> sound/pci/hda/Kconfig are available for enabling, so
> SND_HDA_CODEC_CA0132 is enabled but will not build.

Thanks for looking into this!

> One simple solution (but possibly too naive) is:
>
> ---
>  sound/soc/codecs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_ES7241
>         select SND_SOC_GTM601
>         select SND_SOC_HDAC_HDMI
> -       select SND_SOC_HDAC_HDA
> +       select SND_SOC_HDAC_HDA if PCI
>         select SND_SOC_ICS43432
>         select SND_SOC_INNO_RK3036
>         select SND_SOC_ISABELLE if I2C

I guess that will work. There are already plenty of "select foo if bar" lines.
However, looking at what else can enable SND_HDA, I think it should be

    select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

That still leaves the issue that pci_iomap() on SH should be an empty stub if
PCI is not available, like on other architectures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
