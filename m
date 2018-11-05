Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBCB20827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBCB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pn5d4PfvzF1fK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 09:14:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.65; helo=mail-vs1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pn3b3JsQzF1fK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 09:12:26 +1100 (AEDT)
Received: by mail-vs1-f65.google.com with SMTP id s9so6113338vsk.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 14:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gh3AuZIfe0zXP71uemtOcyqyiQLDcUXZMs2NYEEDjIM=;
 b=hl8xhBv7bBtAraM7b+zIldy1qaDdm6ZDFcOmgxRO1qcH1U90DJfcUjh+pF76oQWD8o
 EbIKO/qUQXGwHxAy+vNBpFb9lkYIAuCK1T5myMey07XOUq6g8NPtJdZgd0TGLu0+2UPB
 VNpYpVoFuyFV9cOhG6T+ebbq44uwwzQ5HI3q3InZWBbgKvUM/PkpRsSRX/RbLILT7C9R
 NbwNV1/pVNfyzGS+axNixt0bD7CLQe1p4q9hkhrPWa7pDNMaQAmZSnIaRJCxPBZ+DBLW
 OiInNtkT0VCry1wvhZJNJBbNodEN0FV3v5TJhD4rg2lWlM481x4TeyhWpSmX4UDAZE+/
 C5vw==
X-Gm-Message-State: AGRZ1gJpG7cI+h3Dk//FpOTc5K6MhFahxTVET2oT2QNC0dcVYlA+ASFt
 r0ST5MKZNbke+Qal31hM+yVGMoKMz0XAd1HECp+QegEn
X-Google-Smtp-Source: AJdET5f+xAXErfXdCjdJzGwNDibs9jRKoNN7jq+MjcXmj6ln4GNZzALe1+vMHmvZkIItOu0bQ48LR4YxaXnuOKOEU+E=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9242706vsj.11.1541455944606;
 Mon, 05 Nov 2018 14:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org>
In-Reply-To: <20181105220559.27458-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Nov 2018 23:12:12 +0100
Message-ID: <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.20-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.20-rc1[1] compared to v4.19[2].
>
> Summarized:
>   - build errors: +3/-0
>   - build warnings: +449/-2712
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>   + /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3:  => 130:61

s390-all{mod,yes}config

>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3

sh4-all{mod,yes}config

Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
pci_iomap() on SH")
is not sufficient?

>   + {standard input}: Error: Unrecognized opcode: `slbfee.':  => 89, 37

powerpc-all{mod,yes}config

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
