Return-Path: <linuxppc-dev+bounces-22317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A943CD8CAC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZPRT5m0Rz2y8p;
	Tue, 09 Jun 2026 19:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780998933;
	cv=none; b=LRuGqKEB7U/4D6sxaNZiIhU5K3Jb4w+9NtMYXBxw/Mc9l4YVR0Iad+P5pWVwv5GntekQfO/MtHiLf+FnEJ5bBsr2YuqJ8DMDY+ipeIKWFxryAVA8+ipZ52HlKPusUH3gM1HLHJQHsizkAn+WgYEedJDmpvJ2mrzbdEZrcgq5GHXcxKH9K8Z3HXILphIrc22wJ6tnGzWT/16hALfa6nZy93br19gcubd3U+o99HiFzXUbdqRFCjhR7u5Wnk9cn7aWV+X4SPaj6I66gkz06/8At+sT7f+xYQ77NZY+h8YxPlHs/CBBksVXNyYbJHBYrRutUhykT5FBbnzZdkTy7Rm1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780998933; c=relaxed/relaxed;
	bh=J/QDHCd1pzNPKIKT6XsNCXh/My/ujozGgvsOiDCA3LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmoEVt+rhfk7bGHYraeGrmagT17kqRXBga0UhFW1MBuwvRi/vRfxhRhFTwkX8OEunqVD1DsBFP0XN2ELDKksKqwdAc90opQ+r0wGVul0hmURWPsG6sdIR3mXN8+FHwRBFJKlmcrlpS82tsGJDCY2MB+ir5VZBgJs5CsqWiDH/vQWEbsg+G16HBV8r72TjeN+iYrRqkqzEBGQlhYJMOEOxSrPsgJ/p2X/jbl+ogSEwH1XjUZej2Dgh+dpCPjz3GEV8NwOw3U6NoVLAB2CQmGzzApl6b4RzveQnC2VQJ+CffJHh97roLReVMH6u6hEIfgABCdskabenmhGUiKSDsDmig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.169; helo=mail-vk1-f169.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.169; helo=mail-vk1-f169.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZPRS0Wg5z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 19:55:31 +1000 (AEST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d07df448bso4175944e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 02:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998929; x=1781603729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/QDHCd1pzNPKIKT6XsNCXh/My/ujozGgvsOiDCA3LA=;
        b=iRmXAIyTVYY5dAy656KmcMBUb43Tj1jlVbS9tu7Av9MD5aC8mFckS9o0QCx0RSV0YY
         0L9iKpCnRm74+bxTp8Gq+IIJlU/+nen9JMGCvC/egMjzJIoHlylWhKbYtMu4KoILlv6S
         YuqyN6L+ko23SCf5nHgirlLegnUAFB/U++GQo/1Y/G9FvDmccrtp8lQJFOyOcm3TV9OM
         8KuSPLUujby+m5F3kFK43fu/iOhuzIe6KrUOKdRgOhPeuUx8eRnK7VOGper20bVh9pmd
         SGBhJ5XOVc0d0RAwCsueeRmCqLGHIINckTniGAdIGibgeM4q/mjAiEdk/N5qpYiqI2k9
         w9KA==
X-Forwarded-Encrypted: i=1; AFNElJ89hPWVQybfjoDQ48FRowqrzQgr4WqKTCGW7ul92c0iM1nxL30xrVd8ts6AOTnusp53TWEUtXQezHpsyK4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzk1O099+3BTdDyen3+EBB2MJ4DLC31t9iO74C7z4N2u6glmZiT
	K1y/ntjB1sFh+Qahy54PR8Q6wfC12taVW/f4PFEEPTqYPVgcpXus2XgmMKMeCZfP
X-Gm-Gg: Acq92OEGSLaDG3y3v+vx0KLl4W/WsokLue3vt54u0Vikaay7MCRcBYMnZyRamGtSV12
	jhqiLETcEoiqSU6/JOhP0taTDzzVrxSY02KPCUnGNAeg7fv4JZ680yFNhfP0yNgtKP0AjkaSHUK
	LQG7DaOBnHcz06ZHOKjxM6FA0QKkVzYx6Ya/OUzQVd6SXH+xWW6083k4igfxs2DnluVO6Zn+QET
	yeGrNevdll6BiM++mdiVh8Rsc6+5uDeXOJfjVEPFjvBCBZxsa8KAuKnkXRmLZadGFsuPjxDN+g4
	gLYxnp1OjTy9HmHzPzVs93K/Dc9EkAnW7X4ICDfJOiKYbeGGPavyf0uaaaKX62V+Wobwhxn6NW0
	35AuYeNdQ4JxbmCuuPwBsxuFaUR6K/x/qiiRwgLAiiOn8Gbxuy0hYY/0WTLSBrrfAV/FNyAdWME
	jA2QBnmaiGCijsNVl89/hngG9gNRHiH23mQVRRLKpAOOGGuSz2hsyOZ4vkrNkU4nrgLjEYSchb5
	r4=
X-Received: by 2002:a05:6102:c53:b0:65b:47:2c8 with SMTP id ada2fe7eead31-6feef48deafmr10334442137.10.1780998928716;
        Tue, 09 Jun 2026 02:55:28 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb66965b8bsm16844173137.12.2026.06.09.02.55.25
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:55:26 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5b22b023e1dso1438953e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 02:55:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ac0Rf+7QAfC/iXmJQtfK8fUF+6GEZ8tzWKCSER5pehghlZzorNqWLAR1Pl3g5k7fVGM1hwbtYopaNntQ=@lists.ozlabs.org
X-Received: by 2002:a05:6102:149a:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-6fef05f052fmr11135049137.11.1780998924802; Tue, 09 Jun 2026
 02:55:24 -0700 (PDT)
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
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com> <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com> <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 11:55:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
X-Gm-Features: AVVi8CfDur0wzec2mY_1awm30cbHrLvunVYojJnvz6Cb53IUltKkdZGFSORVN6A
Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 08:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
> > On 29.05.2026 17:02, Ard Biesheuvel wrote:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> The linear aliases of the kernel text and rodata are also mapped
> >> read-only in the linear map. Given that the contents of these regions
> >> are mostly identical to the version in the loadable image, mapping them
> >> read-only and leaving their contents visible is a reasonable hardening
> >> measure.
> >>
> >> Data and bss, however, are now also mapped read-only but the contents of
> >> these regions are more likely to contain data that we'd rather not leak.
> >> So let's unmap these entirely in the linear map when the kernel is
> >> running normally.
> >>
> >> When going into hibernation or waking up from it, these regions need to
> >> be mapped, so map the region initially, and toggle the valid bit so
> >> map/unmap the region as needed.
> >>
> >> Doing so is required because pages covering the kernel image are marked
> >> as PageReserved, and therefore disregarded for snapshotting by the
> >> hibernate logic unless they are mapped.
> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > This commit landed in yesterday's linux-next as commit 63e0b6a5b693
> > ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
> > In my tests I found that it breaks booting of RaspberryPi3 and
> > RaspberryPi4 boards with the following kernel panic:

Seeing the same panic on R-Car H3 ES2.0 (Cortex A57/A53), but not
on R-Car V4M (Cortex A76).

> One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
> change) on top of next-20260608 fixes this issue.

Confirmed, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

