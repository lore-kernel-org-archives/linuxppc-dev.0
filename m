Return-Path: <linuxppc-dev+bounces-19787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31C7F8A15D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 11:28:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxG352f1rz2yYq;
	Thu, 16 Apr 2026 21:28:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776338881;
	cv=none; b=EK5I5MMzXzNeh5Ko4nHhG/gMovANKFlBy8eX9QY+YTQqJaFNkL+Qzed1m3/uFO5t0jWQozpqje4gMxWibPpqKWWKGzoTmOl/AIvi3KrKpzcpwesOeLAGGPPs67hc7raQfZlUFkKGbCWoPEO4XsgpIXTLgOeQZYdfB8KWamABHzEXoAnhFMnJjL3idQUDPW+7mO6aFVyzN/LsdW2j0U9xwv7EQvpPYTExb8Z1+ydjZtHHWPhk7vDJAcmzXyzhmmeSZD8bRCfMWdy5GjpqoR7CDCNHYMm9NJiKlJFeBt5566q2UHqPJJS0t0r+xBpxz2GYhoOmusW9gYYoWQ4Sv7bVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776338881; c=relaxed/relaxed;
	bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WahsJUX27i93a6qg0wWNAmURjn11fFGTEJbsdCSMF4QMz63xV6JYspv3xm9UAcMkafAGVzpljjHYEp7ZT28810oCCbLbilenjOqzl1+W7KNYx7+UzhDeqWoKd5Vj26fqrkW1ZPo1Ko7bUxHrevIMca4jUoEwmiAUI0x8jmjdk7IB+Aft0Wpkju0uK/bBjH/xLai41/BTsD7k8GD63yLXusdJAa4XZWN4tSBPVUEMkQUvdgvjnTzJ+P0u9PmvyhjjzQpd6vPHv1GJxZ5Eomm835iIE1BV7rzGhMqEnXlUiiJch+ZkVbvjtveBBXUzejo3He1sYkx7B7r61MGhd0+9hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.174; helo=mail-qk1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.174; helo=mail-qk1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxG343H1Xz2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 21:27:59 +1000 (AEST)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d68bcf50fdso900798785a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338877; x=1776943677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=Jp1MLliUfXvNPxqF2A/MXznKDVohqSa1MJpkufeno0mA2mC8vtxGzSQBabfZDPEM6B
         j75IX9s/Sd3QPDbGl6hfLxwAq5OIIpRbuVXdC38FSKp83JKhe9bMifYR15AoFBOVJdCv
         zml14PlmYL+QzQUJWWU9AhJotsMlPgVSckFS7oj9hJlcwXtWk2O7rkbxZ9Qr5GpY+bWI
         OS14prR3o2Yx4pPN8GOjIVsVY29DqOubB814nTqBGDp+J+zk+qMxHiiZezY47q+12oGR
         yLy+gziyw+mRd/Au4NzmNQJIawgXsLAU4Hd3BNRc+jK8IenYXO5Pid+g6yJUzaeLketO
         EeOA==
X-Forwarded-Encrypted: i=1; AFNElJ8k2D55/9Gkw6K8HXUI2OCgvx8e86B6gK/nFTSGB1u+q0+OjQ0pgfDiHbF19MWLQ+i8ZI9IWZG98+CUXwk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyOFQQgxwyPQj4hRPeswYAl0yhWUfwniruatyJp0CkBmJeM3Vj
	p37x4vHDpPrwV9YVUJIVXcCM3a0whVKyeuO1WxgKSJQbgSrs5W2h7u+dlVRBvV32
X-Gm-Gg: AeBDieurMOB2QHK7bvXzIM6JocfsEBfZTK3oTkmNA3BfLP0tnz/0gydOmAjS1wG/X0P
	BlKzbHoydFZDGvNEuHcXZSVvHky2CoqBegRb2023ja6sLfqCfUuvZBYBZig3bpXxLNAwP8KpY/I
	eTyPnCkYN0+y8fbKPU0zG8nzwUFUj0bC87OZVCkRld9j0UBh6SFSQdHtFifu7p1v0vQj4dTjH46
	zwqtHpzjkI/JHKWEJn9U5UtoB3ABB/Y8VRKQEsqWCNdYytlJa016sbC49ztKAJQ6Xm3ZW2X29Yu
	xLVklyMVpsGmZkljb6pzVnAx+63rpTHKOSH8m7HcYJJV60smKx7umoOvX7ZO2bePUsrP74SW4af
	ynQI5gYicPyFvv0LLdoZcWPFLaXORxlvpftShs8J5LtziBnELyoRdPMwbVojPRC0sEYXvCbpvx7
	XPECsA2fwClww+yImhWbx4bfTRTVIrB/P36nyzrYPjS2MIXKPicUdCnH02LcccpMDFhlEilbJZU
	cgMpv2iuc8pRQ==
X-Received: by 2002:a05:620a:2953:b0:8cf:c1c2:904 with SMTP id af79cd13be357-8ddcd8ea018mr3561871685a.15.1776338877426;
        Thu, 16 Apr 2026 04:27:57 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2e00198sm331851285a.39.2026.04.16.04.27.57
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:27:57 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d428da4300so872498285a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ93PhO45jPVrhlLDdnYyk7au8LOAqiWR0H1WZVsOzkZyRUZnc1fKbYn0gqY3fgbItOiQoKJbvbovhPNtGw=@lists.ozlabs.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

