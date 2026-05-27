Return-Path: <linuxppc-dev+bounces-21562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3288CD6E41
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 09:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQPg91cWYz2xLs;
	Wed, 27 May 2026 19:37:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779874677;
	cv=none; b=UEbpgTShPy3BIxOYgJN4mIiAH9a67YxQJBriH7fKT6zLUftd7BcSCM0zwz5ZTWlaprmsMt7aEEvXeHB66mlN3wgojGHPC8rKcSs7LSLIsS5uvBU277O1uvyW7CKwZIZ2BrgdX8D8dQruYOUYedlOxuOAkrw80mFDtYm8xZOyPwZGMD8ZI2XocttyhVjy//RjkLHbXdB5+L69zx4zJBtXejW+yoxpGq/EQHgEa+4cmWkl+vZxIhiKW1yRW3Iez/dpIeG8UcnR/lBIfQ9/FazQi2SXOLDID12140SaDCRgSzKT9dmd2Qg61l7SmJ45jZgrhJrbd04bRvK5y5gzgegQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779874677; c=relaxed/relaxed;
	bh=1jh4B5AC2q6XDT+EhwYr9A0M1dYuh/w8VgN+zze6pNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPFB8uen0D29hqtfy1gDHMVwUVj3KXRi6TOIoyihQdX8b3eGc3ZnHYDIt9oTbno9f6D0DJQpLwbwna9ySR1G3Fm+LkKkbMksyMxyO6XH2U1wMFnmUAS3h1YK4zdX/p5fygZsegTlHu5AkPc1zp92V/s+YdTJmrOFsGnwR7pTkJ1V2sR+gil6jwlxI8ky9Xuwxy7LiWT5ZNEeg5a/7iyIL1I8yqzeBsFCAAn11HBR0ugp+EwJ3g8wnwsHSAtmGEej0/gga8iks7tidO1fHdbKJ6aM35hPfFA9jTL4VJTzd0SjAUE81CI12S9Jb/cSBptkVFAodnu6D1Ue9qzW0B9VDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.178; helo=mail-qk1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.178; helo=mail-qk1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQPg72GZxz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:37:55 +1000 (AEST)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-914ae4101b4so728554485a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 02:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874671; x=1780479471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jh4B5AC2q6XDT+EhwYr9A0M1dYuh/w8VgN+zze6pNI=;
        b=nlh8j88YlRYoo81Z9XZI5cuCLXf68kFEakX2h5aunpcOmfXx1vSKMM5XbzEwV/wQoC
         ewDcaXu6oG+QdoEXb0NM7tZh/ZWPCz2/iuKkO5Z8pCcxDMu2VT3kKhLK9spDL7hmYqc3
         8DUnKlDOHPMxInhgynuCFoRsqhsol6NN6iitBidJ3gdA8AZ1VjKmDTyWHCO0TTLV40ez
         Byd94lBiIDrtidx4EfMa8aN7XiN14/fLUb04AD8WMEp/3PxOFCNMe1G/nTbgNocJ4RTG
         FfNokLMUANgAl4hAoUEOUVcAmJ0m1+ixSs4owS/F/rEyrpkptNqE2Gdziyt3IvYzdl7t
         s3/A==
X-Forwarded-Encrypted: i=1; AFNElJ8NVSRxQAVBKukqitz07ZGGs8LI7f/IIJXJC/oaIr1Z1TVPeHT9TmyLUZs8q5KfUnRZwcLV6P7G91AK2mQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwclaQO4vRTR1BQwtTBlV3pXAxdNT1CjQjk5fw/a/tvFk4QYhRf
	ee7kmnJupTibTZckPhBy40Gu4IOJaFoGymvX6+wj5pZccP72bWFxKhl6V2rS8NuBEkw=
X-Gm-Gg: Acq92OFrFgeO48I2J9e74EAb95MyxrnDM4bt8qERNFeoZG38eiSIN7KsS11syZtviq/
	tW0RRkXpgxBko30wzloHeY7/1Za2yrxcw4jZ1yG/Fim020pML7XYYwqH2ImgDwjoX4D4uZpCndK
	F+WQXHGDA6OdV7JTQSQRCrcycrvERkirX2F2mYBAATXhFNguH4vyRSZ5+pp06eZ7Z/7YtW0z1YK
	QJu3KOyhEpNnNvtp9txvQhbbOm8Epxqo9tFgllLBsxRbt6+aeFoOi8iDQkfC+ips4AyJl+I+Ufo
	pSXMuQ3fcpeS82cUnmqiWjK1SGinmmubAHzOlciqBuRMkTWPTd8Cd8O95jkn+5NGvU4B37bk8xW
	/vv1xuKeQbZYJ3cJWnGST8jr9YhVyA455+FBBsaEWQSCX+P/1Enf+c6yTVXGP/XXhmetmOINHY3
	so3gME72L5UQcrAryn7bal/25NHzJ9u3T4o2tiwLl91GHMt/r8gYBeZVwdGQKR7VMdUmE6t1SSA
	Se/obYz6g==
X-Received: by 2002:a05:620a:6f01:b0:910:d1cf:915f with SMTP id af79cd13be357-914b48b39a0mr2959102985a.9.1779874671096;
        Wed, 27 May 2026 02:37:51 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87f4b93sm422602185a.33.2026.05.27.02.37.50
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:37:50 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b98482b253so188734606d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 02:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9L9tW7PYG5Jzx2DPiYWB6OwMGMvGdwWgf5uCrIc8UKRxsan2zCThNgU3+o/7Qt2Y3sUaOhd27/C7eL1oU=@lists.ozlabs.org
X-Received: by 2002:a05:6102:54aa:b0:633:75d3:3545 with SMTP id
 ada2fe7eead31-67c84ad8af0mr10485506137.30.1779874287601; Wed, 27 May 2026
 02:31:27 -0700 (PDT)
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
References: <20260526175846.2694125-17-ardb+git@google.com> <20260526175846.2694125-30-ardb+git@google.com>
In-Reply-To: <20260526175846.2694125-30-ardb+git@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 11:31:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
X-Gm-Features: AVHnY4LA7PW8Q0XMk7lUiX1q-1VC5_AKr651tENC3X6CCFiZsD9Tq-B3NK3PBjs
Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 20:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> SH performs cache maintenance on the zero page during boot, presumably
> to ensure that any clearing of BSS that has occurred at startup is
> visible to other CPUs and DMA devices.
>
> The __flush_wback_region() function takes a void* argument, which is
> conceptually sound, but given that empty_zero_page[] must never be
> modified, it is being repainted as const, making it incompatible with a
> void* formal parameter.
>
> Given the above, and the fact that __flush_wback_region() is in fact a
> function pointer variable with multiple implementations, take the easy
> way out, and cast away the constness in this particular invocation.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

