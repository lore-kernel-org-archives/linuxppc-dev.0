Return-Path: <linuxppc-dev+bounces-19126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F44FD3515E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 08:55:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flzN64LQQz2ygY;
	Wed, 01 Apr 2026 19:55:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775033734;
	cv=none; b=VgoYfFW6DL4lXos4tTfCEmH8t9THVmXKkqE9HKP4lmae4OhIlhNiQtWKEP1NvMkmrwRJ/RSo4lqZTdYYNmw4XBRj516dfm5d2XYpZdpCul5VAF80QlBSaqM+aKg5T0ybk6tFzQ/uD68b2AXT9OEyb9+ot5l3clDp8kW1qOtryy9nmt1ZFUhlD1plW+0ZUNkIbG1toBMYmihxx94/cvNmoBzHjFDJp/K6cS2s/L0rKy7LlgQWRmqTaPN2s8r9o1UxNM4y+91GV6QAXonLQZEg30wxAeTawM+RuzlADvcRIpxrJzKBkqC+cPI6VEl2uIXAd0s74kxMvC28v4op6sNMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775033734; c=relaxed/relaxed;
	bh=JovjSUZC1lNxdv0gpf2LIekR3ONpuaO8xMZDQYnx+qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzo/uf2zEQP04KLQyZeX5KyneV+GC8Gg6eT7U5CS4sb8SVHu7bofg/ig8MHShW+LHM3Cwdu+XC85JznlBwx1pyCCxSF63K+LoJksFfEGTYE4+0bH1NYFSMggnzUVqlzaJUQ+HpbgHhuJlvWF7jN+8PqZ3CUDhsWki2Xvvxxq1QJ2Q2Z7ngGqyM3nvmNvGd0QbLD6E1cq4Z6rHOKJvhxIbqBfw7IhE6/O7qkBNUPdFtVkzNR2PHg7zPAZXq6RiirQMaontY3+Yn8MBGLJX+W9eREBv7JNUWDN2SbiY6+GiXTocZjRE17DeCzKWmmgiLC2tlbzIjVJKLrwZiQfYBDFGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flzN50L6Tz2ySY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 19:55:31 +1100 (AEDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-60579b9c0ccso94173137.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 01:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775033729; x=1775638529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JovjSUZC1lNxdv0gpf2LIekR3ONpuaO8xMZDQYnx+qs=;
        b=KN9ezlLYHIVnhEAJFKfO3PgtCK9HNzqpTylFh8ETNyeTgK2TJ+FBjlrp9h8+EcpL7C
         +g9Y+xL+tAGOeEtmWxfv7BEDUQrPRR1MgcoCW0KF73RGZvnnWArskaQ49D5Tvr4niEV+
         T2ozDmign71OmF6x7J3GhoLsKRVPvx9eiNZnM1ofF/9XP6uUQK0j4K2g04iJuXeWE0m7
         KnJsiUv4/L+MW6pTV5hnFuF3Lll0sFWJcdPTBGclL9ZUGoW5n17hBUNcJfwt2sevpPeu
         JaFdarY3MHopOT4zo89Xm71ioW3xkUElvVkEn9MN1sIf0fmm6z2rp+3P1uuRH6k7cJDu
         gF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaOkyjg/GI4YFEYaX/Bn7kP74Nf9C79uey+XeoLJnbn/hLxzMsU6EX5Aaje00CrxtwOrxoWBlKoBq/Myw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTF2N3skDCtng3GnMlkHVvoR8ONy1P7mVLLutPvF7vyAH9rZT6
	qSycEbLi0SBByoQB4jXeMYikJrLkEf5Vg61O0pl9Ve8AGTpBpiRMp1RXFeCg+9aO
X-Gm-Gg: ATEYQzyIuFteU7IDnzB5eHDAee90MUhbjVggbpOJx9DsFBKnlqss35Tmx1bMFxDoimT
	ZyG1dLCKFkAw/wmtiNU+YF1C5brA9EQ3GfZKhUv9+dxz9rQVMDjbGQ35D4Syx2Ljnr13iJKALI8
	/upt/ECWzZ1EUx3p/nwhXo/kj2xbS7W3ai9kWUHoh+O4hSzV9gHi5xCAOiDw+cSFF32kaR2T2gd
	lVFbbRhgadizn2NdTtiMdbIc8Sc5KHpPd6+ECpCb5CkJPoOuUkfcDMyjqSVcG5fJm5amqa7RPy9
	TZsJVh82jTTpCbLsOp2IECgWqsCSlIhQ5cfZ8thnoXzOtsCROvDEo6iHo7MVcgR1vEQv9SJCXg8
	HkICfzQoKCSbbaxNurE+ospqxe6gcsM4A0GZKb36sYQB2BmoeigWQeGh9FaALfEf/mb3MrXgDFi
	qngaDgtVqoL6CfFJJ2KTVRb7mPfw14Z5Oem+hf217RQpLvxD6oXTeR71teV74eQqia6FPnQVY=
X-Received: by 2002:a05:6102:598b:b0:602:80fa:ee9a with SMTP id ada2fe7eead31-60567a90092mr1110821137.0.1775033728665;
        Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605129b95e2sm16171603137.2.2026.04.01.01.55.28
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-953a8eed138so2222301241.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1YYB++++61d/aoyndhMfWmYWr1+gGF0oVqv3j4U6RXPjKB6YHAijXQCkn8kG/gIbrxbyZoeOwtGVscdo=@lists.ozlabs.org
X-Received: by 2002:a05:6102:14a5:b0:5ff:d434:b507 with SMTP id
 ada2fe7eead31-6056811633cmr1013502137.17.1775033728220; Wed, 01 Apr 2026
 01:55:28 -0700 (PDT)
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
References: <20260401083242.214492-1-tzimmermann@suse.de>
In-Reply-To: <20260401083242.214492-1-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 10:55:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
X-Gm-Features: AQROBzAaKXfPphxAx92Ddhxtbq8urMrWt59bUWKyg2D17bALeZWDk-W7fhNxXrk
Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	arnd@arndb.de, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

CC arm/mips/ppc, as you sent similar patches for these arches.

On Wed, 1 Apr 2026 at 10:40, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

Upon first look, your changes match the (current) dependencies
of FIRMWARE_EDID.  The dependency on X86 was added in commit
7e35fc7ab433683f ("video: Make CONFIG_FIRMWARE_EDID generally
available") in v6.17-rc1.
However, CONFIG_FIRMWARE_EDID also protects fb_firmware_edid(),
which seems to extract the EDID from the PCI ROM, and is thus not
x86-specific?  That function is only ever called by three fbdev drivers
(i810, nv, savagefb), though.

I assume none of these work on SuperH, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

