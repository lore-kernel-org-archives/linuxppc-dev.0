Return-Path: <linuxppc-dev+bounces-21465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5279FCD5BBF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 09:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP9dW6Gf1z2xnK;
	Mon, 25 May 2026 19:32:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779701535;
	cv=none; b=Jq18gWRBUWi6ZZMaBzzvX/zf1P009rymE6qR0mbPcjFptAzcpU3nzuBBGZi1g9eKiLJFvIN12rCNPLdb+Ho6NJAvJ4V5N+51iS352kMja5Q0AllRfnGYUQ3G4JT19I54K6UiEl6GbYwxJv5QJZJ/8U59H9gTLsSKBCnlRhzVIfk+Hq+SwRS9e9aW34Et9zJkNl/+6l3BY4T/C2eLiVwivibtz1c44Q8NQn7eZEGjChDKaHbePWHvnG0z6g0mK5hqyegrup6JSUFDltAs9Re1GPs40T/OnGisr8/hMTqdncnFWuXjmfS3ESCzmTcz/iOhi46bHJLizsy/iTwWUXrIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779701535; c=relaxed/relaxed;
	bh=6rWcIUH/SvbVRnVZe/oNltSq1THolH7A9MSmV5+ZKew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly4hnldwA4MFXDU9GQaM0K2hyBfvamb2pHhwZAGaGKeF8kDskrKB7k4B9kyfFfSoczQzp/NfG+K3ilplSrR4tDFQwZRgFtAoOFL0yrO9DedWDhWp70LdDKjAYoEI9QVmvXMB7cFoCYSyC+/YlRoAd/qPSy99UiRSq3mPDKFZHmSDRj5+8YcOBRGiJZOPNsyVY87eqxQA0IvCWcmgydm82WZhCcFGDG958ZFEnuksRPfhpze0AlqlZst+oLRLgQc9948veeh4LxYwUjtLzv66qkOFCZujS/FDXXurvydutgaN2vu/ophY7WOBmoyyH0XaYQIFUrKZjiefaPEvnWposw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.179; helo=mail-vk1-f179.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.179; helo=mail-vk1-f179.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP9dV1zGYz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 19:32:13 +1000 (AEST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-57512a429d1so7872616e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 02:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701530; x=1780306330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rWcIUH/SvbVRnVZe/oNltSq1THolH7A9MSmV5+ZKew=;
        b=Y3xtW5EzWP5tPJCBxuIfQXNHPNkQhIHewfD5rleWRsjtHRi1ul7Y+lxEkEeqFhDcZf
         WvVL77XMTAOiTahp8OReYaOCHU83UEg/QUGrB32qR68852DkG8Z/5BfzS1MQxQW+lc+D
         JKmsPcIn1HeI8dVElrTBqIPqRnyht/0+gSu46YHFZ9qLa9RScyiVoKATgHQkl506w60E
         nElNO480Oy5EoQwJnOcayrYWX7AFojQrF8se2qPVEdRPDOaoxKL+pKr7BISGvHpY2Stj
         +zmWLNxR97VCuJkdp3cv0pDNKFkad9NAKgS7887om8RxFqeVEIn33RQE29LVRGZ7FvE/
         IPHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ia9o+QxeTGVhgC5KDsSTFDh5HBId+hVj8mjHeg97yJnVrWn9m2atAAzyVaAdO32nDUNgRDN4Zf4dXq2k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAWBaxrz0MxOKoykyzLZYY0KnDdmjGPsSDHRE1M3lqkCrAk1km
	oigfBBarwajIAkI7MwuF4awe3BCdUg1zU9ucr6jp+5qUCI4skPgt2vEzP9ZPBdlF
X-Gm-Gg: Acq92OEHwhTtxhvP96d1/n5PcnIeH8ra/PqmThXDBhVCYJ7gCvEWHFaVrlxkjRKaSl4
	PRsbupJ02OzxpTuJ22aiD7N3Dzvb+6jZJAagUio0LcqOalP6z7bni9S8o12v/4pJm0c23nBO2TY
	xX6ETSW43/EG9WyFpxoC6PfJj+bj5wLG0LPPrQEptmWUzsNd/MQzu937WmvkIgrTk/kSntBI75y
	eVUfD/xR4nTS0mZ1qbnshi926SyVPJEAgQK6XAr5g7raxcLNBzbIuEaRYo6qeyWUjVM+zN/0BLP
	P0HhK9Hw9cWfrzjr5GGDvLlYQL4ek/bXr/LuALmNvYlnvWBHMZ517FvXM/8pSjDVJPSmiijrIB1
	FNZK4OlRNIl6qiPmWhGVFD8UTsshSAAgJocm7HrH6t6EQy39iKlPd+1S4JZGOE4+FRNaeqqibAY
	dAwt8825ZRvbdAcbZsxk3wZrK3QMmWssL/ITNvakfJcTXVpK0zA9kjE1VbOtO3
X-Received: by 2002:a05:6123:a7:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-586648f67aemr6877589e0c.12.1779701530172;
        Mon, 25 May 2026 02:32:10 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f791fa49sm11545774e0c.12.2026.05.25.02.32.08
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:32:08 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95cc3522c40so6685599241.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 02:32:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Lt1EnqAdwu1LbtSKmpQpUnb4FBQ6W915nG7VooOIDchr+kDO5Ob8Clnn8fq/xWt/YeuxzQ2TzuFBtNV0=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3f4c:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-67c70e6750amr7086176137.1.1779701528081; Mon, 25 May 2026
 02:32:08 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260522123019.211059-1-tzimmermann@suse.de> <20260522123019.211059-4-tzimmermann@suse.de>
In-Reply-To: <20260522123019.211059-4-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 May 2026 11:31:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
X-Gm-Features: AVHnY4KfFcrlo4zm05PN319uvgzumHDBn_61S2KqpCQpRdYnyThN8ALdwa-6KzM
Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 22 May 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
> invokes this functionality before switching physical outputs to a new
> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
> implementation details.
>
> Vga-switcheroo is used for switching physical outputs among graphics
> hardware. This functionality is only supported by DRM drivers. A later
> update will further move fb_switch_output() into DRM's fbdev emulation;
> thus fully decoupling vga-switcheroo from fbdev.
>
> v2:
> - use '#if defined' (Helge)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 91458b3f2a84bc7b ("fbdev:
Wrap fbcon updates from vga-switcheroo in helper") in fbdev/for-next.

> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -31,11 +31,9 @@
>  #define pr_fmt(fmt) "vga_switcheroo: " fmt
>
>  #include <linux/apple-gmux.h>
> -#include <linux/console.h>
>  #include <linux/debugfs.h>
>  #include <linux/fb.h>
>  #include <linux/fs.h>
> -#include <linux/fbcon.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pm_domain.h>
> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
>         if (!active->driver_power_control)
>                 set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>
> +#if defined(CONFIG_FB)
>         if (new_client->fb_info)
> -               fbcon_remap_all(new_client->fb_info);
> +               fb_switch_outputs(new_client->fb_info);
> +#endif

What if CONFIG_FB is modular?
CONFIG_VGA_SWITCHEROO is bool.

>
>         mutex_lock(&vgasr_priv.mux_hw_lock);
>         ret = vgasr_priv.handler->switchto(new_client->id);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

