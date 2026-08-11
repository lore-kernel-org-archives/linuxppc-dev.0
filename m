Return-Path: <linuxppc-dev+bounces-25729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4245DC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 06:50:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK2LL0HYNz2yvG;
	Tue, 11 Aug 2026 16:50:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786431001;
	cv=none; b=Dp13v6M9cQGOjpe1Naj4asWiRUdN7RBB+XEONd9hx3KZkUcDyAVaTmB+JJvE7KDwG5IHSchbQYpyz7Exj2nsziGtV/8iw5IqSkuKamSLmnatKrc6Xh1SNcFjfqt42SghKky203GRAnX4kg0FETLglyUtRts+00DIlq1aM7Zlrl/bN/t+X4xPg6pIz1oBHMj5guBmvqcsLWtmKBhBjw8AJ+7ksEaaOf7dPKxxhmzWLPDri2cXac7HFbncY/27s1ZaqtGTPKdHsDi97Y+D7YfNKMAyHF1kw0VhAUmEYhjapSbk4TZekwUlcJBHJRlxI3coXP235zog7rNragxPKdIlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786431001; c=relaxed/relaxed;
	bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfyUTpMKsQVbCbm+zSXB94NQ0n+Yfa07IUdIrqhexFDVpf3p8A/JScPhqOUxrOXsx6Ayqrl65z9fu7x1M8b2KkWmBpJbE8naiWJNXdnlBoICeP+Su2x2DQLd5jIxIFYyMfq5mLzV6lAa36uV3eTsXa5PFruRBI3lr9nXHbNST7c8k5zfq7stRdoyi1zKiZiMQE3ghtGsFRl4aAlPhuZfzzgHToHsl1M27HER4xvhQdYPe+28KlvZ9K4rgDPV2xSgOArLrHD4VzOl25VHCw8HHoBz5aapyIoyvUen3z9BQeKs4e/bcXzTctn0+rzR5l2nYMu+dzNNhLi3qO6OfdsqSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK2LJ2k6Sz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 16:50:00 +1000 (AEST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ac3ea9c60so675607137.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430996; x=1787035796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=IGPCFfsme6htfsIowOp4h1WzKIZhFSuQqZlCnDWlgeZyZp8aCB+BvzFqPXgeeU3z5+
         aRObd6a2pvly8k48pU3U+s24x+OVweoy1zawGF8U1hS3op+K8K9ZztfhGsg3OhelCBTQ
         /qAchdC+55RgOi33MyMfq5AwaXxv3D9ZzjyhgXqX916f7GEzur10obvntA6rpmEN3IKL
         KTyZVRsfb4dMxziGkXVzCXkn4IUGG3l1RAzUsDA9WYjW3+wpQ74AjkvG0XPi82HIj7u9
         8wbBafITHRkyencP4cmydIb5qHejNglBQC6iZx9rvvN8tBicRQ5Q4uU4r87x9w5FOMn3
         002g==
X-Forwarded-Encrypted: i=1; AHgh+RqXssWMiiJbREL4Xn1C/zm0WSaoeHmTPCG+87hhfkLLRNre3oX2MqR2BVsUEYH0C4+fvHeRx30nHIxxrC8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy42utgf2zEK2XbGn6bqxwFLTF79RjEhBXhPVph4x+Nr9kr73mz
	FNL45uZ2f244fxE6nMkbXEveIjLJ0Q/CiCK1uLXCAnL74UHObakA/VGNsZOJz7df
X-Gm-Gg: AR+sD10HJFd8LYBU4Fxvucv1A0qJEOEJz7ZXNa0ak2eoA5/y15WuLUg9i46sNXaFFfr
	JtKMn+JB5WluUZhaJJKvZx/wR8uQkjoq55QLguaDfof9IePx2SFtwaB94ivqM8lEqCW2Y4P/cOl
	l+55w+XAnJ8RJbxmd7CBhB2NyRnWuXMelIifhqdLLmx2NF2haPoyn6mD86BbooSNqcTqrgn/+Jh
	ds0fy1SRSU6xgV2KUAOqiH8+iNvNOyhbqYh4WfBUCyMLcDMRgFf1BALagcqsp2iOPbWUMsi5XhJ
	rEcPxDRSHLMDy80srCwe4MqmURc8aHXuytn3OEUE5a1c5JI176JZdlo8VeKWeam0j+syek4gqxQ
	ZrzU4Xm7BsgROqQK0wPd9nz9Jq88M0/7eVfAwC/wcIo8xkQw121kCfSSjxuBw/OvoveA6lOZpT8
	JpRXzdKuv63Zu2oG1QvHMDQHIn4tUJp1ITA0KQqrl9oKk8bTxPVV0S0UO4bo0be+gTx00wBjlJ5
	qrnA4Oehbr+zqJnMhmifhzLjA==
X-Received: by 2002:a05:6102:f95:b0:737:4cac:52f8 with SMTP id ada2fe7eead31-76b54f87261mr306539137.4.1786430995932;
        Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76b65bb530dsm197428137.11.2026.08.10.23.49.55
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-765c077b5c1so700957137.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqnr1zj1evA7o/p+K344oMabhyVfrz3Lbkx8FI9F02SLZMA2PhH07iccTY5BzZ543UQm7id6bF0+ac1yws=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
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
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

