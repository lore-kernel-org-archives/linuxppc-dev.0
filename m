Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13548C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9020D2081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9020D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qg4f6w9jzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 19:46:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.194; helo=mail-vk1-f194.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com
 [209.85.221.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qg2d2GbZzF1x0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 19:44:41 +1100 (AEDT)
Received: by mail-vk1-f194.google.com with SMTP id t127so3523595vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 00:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wMoTerJKeg8lFio2Ljy91Dvj/RDjGUDC3iBhw/TWeqo=;
 b=CbT3BBtEQxWBfE2Dwnhr6Ky4DcHjLU0+qKhYz5sh+yNEIR5zUKyFJIXpm6iUQBBuBZ
 ya0XHUmmEcSXRIiw07G6Y7WvLGcbPf4lG837wFB+G6TGa7SOMBt8ZM+iAmEdk3eLomUG
 sd239+PL75Tdeml0+MfyOX1fjr4nOD4EatOz7Y5u6ePUWe2pt6XVwWFmzj26J2Eptf+G
 Wjjc7c3L39zOosFa6578I/CfloiKjpKZ6XpVoNDx2sVkkmZpMv+bv/Nsp6Ru7gnrrZvI
 /MBIVNapNN/j+BAwiorajsFrS4+SJPNY8EtUuH5+sncqgWK/PkFEX+7QAO3VpELzhW75
 lBUw==
X-Gm-Message-State: AGRZ1gIjhNRt39HPLxN3AYlL7Hc5nr5gW/v0zIF2xWREjPFfbESwCCyz
 Iiqt8GA6BGVIT41IjuZ1W7GMTsQ7yFZrv7Cks/c=
X-Google-Smtp-Source: AJdET5fsRCw7GQN+q0ICx1TvLdKbBYtMxJi9u0kREOAyyThJaPcJdUDP6+JrJr4y8W7ZJvYAsWAM945h/lBtLndcVkU=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr366907vkh.65.1541580277266;
 Wed, 07 Nov 2018 00:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <s5h36seyyae.wl-tiwai@suse.de>
In-Reply-To: <s5h36seyyae.wl-tiwai@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Nov 2018 09:44:25 +0100
Message-ID: <CAMuHMdUc6hcPp+Ca9tnWyHGWw-heKRJ82FTabDed5oqtbm7mjQ@mail.gmail.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
To: Takashi Iwai <tiwai@suse.de>
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
 Randy Dunlap <rdunlap@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Iwai-san,

On Tue, Nov 6, 2018 at 5:18 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 06 Nov 2018 02:04:47 +0100,
> Randy Dunlap wrote:
> >
> > On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> > > On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> Below is the list of build error/warning regressions/improvements in
> > >> v4.20-rc1[1] compared to v4.19[2].
> > >>
> > >> Summarized:
> > >>   - build errors: +3/-0
> > >>   - build warnings: +449/-2712
> > >>
> > >> Happy fixing! ;-)
> > >>
> > >> Thanks to the linux-next team for providing the build service.
> > >>
> > >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> > >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
> > >>
> > >>
> > >> *** ERRORS ***
> > >>
> > >>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> > >
> > > sh4-all{mod,yes}config
> > >
> > > Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> > > pci_iomap() on SH")
> > > is not sufficient?
> >
> > Different problem.  This is about "select":
> >
> > config SND_SOC_ALL_CODECS
> >       tristate "Build all ASoC CODEC drivers"
> >
> > That enables (sets):
> >       select SND_SOC_HDAC_HDA
> > which selects SND_HDA even though CONFIG_PCI is not enabled.
>
> Actually it is OK to enable CONFIG_SND_HDA_CODEC_CA0132 without
> CONFIG_PCI.  IIRC, there was a system like that, too.
> The commit above should have covered the build failure on SH, but
> apparently isn't enough for some arch setups, as it seems.
>
> The cause is clear now: pci_iomap() is defined in
> asm-generic/pci_iomap.h only when CONFIG_GENERIC_PCI_IOMAP is
> defined.  Including asm/io.h doesn't help unless CONFIG_PCI is set.
>
> Below is a quick fix for this.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
>
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda/ca0132 - Yet more fix on build breakage without PCI
>  support
>
> The recent change in CA0132 codec driver for supporting more
> Creative boards includes the pci_iomap() call to get the extra
> register accesses.  This is supposed to work on all archs and setups,
> by the implicit assumption that every arch would provide a dummy
> function returning NULL when no PCI is available.  But the reality
> bites, of course; as Geert's regular build test shows, some configs
> (at least SH4 without CONFIG_PCI) leads to a build error due to the
> implicit function declaration.
>
> So this is another attempt to fix the issue: now we add an ifdef
> CONFIG_PCI line, so that pci_iomap() won't be called unless PCI is
> really usable.  This should fall back to the standard quirk again with
> a warning.
>
> Fixes: d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of pci_iomap() on SH")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for your patch!

> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -8796,7 +8796,13 @@ static int patch_ca0132(struct hda_codec *codec)
>         }
>
>         if (spec->use_pci_mmio) {
> +               /*
> +                * ifdef below needed due to lack of pci_iomap() decleration
> +                * for some archs when no PCI is defined
> +                */
> +#ifdef CONFIG_PCI
>                 spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
> +#endif

I'm sorry, but that is not a proper fix.
This should be fixed in the SH-specific code, to behave like other
architectures.

>                 if (spec->mem_base == NULL) {
>                         codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
>                         spec->quirk = QUIRK_NONE;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
