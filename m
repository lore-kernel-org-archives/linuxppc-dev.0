Return-Path: <linuxppc-dev+bounces-19785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877CCF8A157
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 10:32:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxDpS6tc4z2yYq;
	Thu, 16 Apr 2026 20:32:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776335520;
	cv=none; b=UqFq641f72AdfVEcI+dO4P7TtCg3O86cUvOC373YJcRHryPTSlGvVfc7SAhYayLbVaQDyn3rTvGZ06cnHsUG5SPGSkuq5YlLZp/aNem9qfqTecfPablJLIHWlsLhvdsw6M/qO6ZW4MtZ0x4LSPkpZ5mFCpowXGB9Hqzo7MaJEGs3ajrVe7b56NiaDq2CFUKo5LGz/gCjWSkwHIpitQCM9zgCUCAVtHBoaqvd29V9VoGcOl3x15oZrAsLYBWbLyG09SEq+lIYmDH4tEwOyhU2chc6p1UNAUIGMpag6og6EvW1rAzE3KGYC9Eh2+GHO3NwzltTxvzBtsRbgUL6XfHrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776335520; c=relaxed/relaxed;
	bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSWpWBmrpmyKhyIFdUxG/k9OMw8nzXTqEfEXcmr7UiD1nLGu/UixMVgo8W+j8qmiwPM4dKUOET8TBmnCgKKTP45m9uM+JVtxcZ938M+TXFCjbwPuPjDW0zeHJC09Qwm5JsIVxPhWFEBm4QSFzHyUToDTf3gJFSTxlrluURgkLNALlcaO2USmV2PpLaG8zrap7UdOj2Db9EI+PGSGVEaPYvoE798MvCNaxQImSct/QLpjk5B6Bdg6W5ymSAkw7tFK6m3G48/bQ82HwqUZHxIm83fp4UL2C+VCq6LeM1/7QQs8gVme2AcGWErqAZQIXlVQeWrELcJfdDHmoJUubyzatQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.160.50; helo=mail-oa1-f50.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.160.50; helo=mail-oa1-f50.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxDpR2Qkfz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 20:31:58 +1000 (AEST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-409de4132b5so4996953fac.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 03:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335516; x=1776940316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=T9cWP7sJnO3Qhbdoh6BqDwrAqf10EDmC2fJzp94oX5CmYcYLoqzwpPb28l0mqAr1nx
         4TxbCTM+9kkRR9Su6D5AXEyJdMnHeFzaJ+zLVo8mpkqs0WQSRm09SxVjW8bM2uZmukrR
         0IjLtPoKi40eiyXKGAG+6o31b0FIrQ10SabnMj+bwpVI/yyb2N7cQYlof4kgrujIzG0n
         hxc+K5PVZaEhlYkrQQgHy9mTetbfa2PzN7CD1bjl32w8y2d1344IQPZhsBV3DVF/lB/c
         JglKqRXD6ofmqi2XWKeRsjzcM+l/Kid4+J7Opsq/jD0j52ZKSsQSebzkWtaZ/rzDlcGq
         QTmA==
X-Forwarded-Encrypted: i=1; AFNElJ9JUnLIR/JMlsTWZPe/34GnyrWPheLnSHjhUmDzbmUdsQN5b6C0ef+thH/GLfXBROqxriZoENKPkQNVoZQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8X6ubnTMMYWdfUFIJFRIgbAmBVxL6GZRx1i0esoah7weZvvZD
	5do3W4YOT4e8BgKPDE5zymDnJdPuIgpdE639HLUEBSaW++IKjEkDGu6wPqE/YME2
X-Gm-Gg: AeBDiestw7IL1W7kjjGOR3AUBLS3DulWJFeh/ZvfjKIW11OaT2zfo8jo7AfnxS4a15M
	GLuLdt2Ctfg8Y1gSqPUufS8pADncQ3TMKq7aU+l15E5FbFcGJnWrWdSxQ2h4JhgPBUKjGBgOhL5
	+jQ4XYnxd2Nwe9JwPCpu2VQ/2+VcKA3FfnHvG0hoFFSzxPcBHpjGXh9U7LKBVPpsu/JfA4UWfzp
	/lg+/wx2zT8chMTh6LwVS5kBP28FSMHQRUIY/GjG1BHCuS2Bsq15EW6CETOsjqmfbDyu9fYLV+L
	6cJjGUjhg3G3gI6Pccw5HWrUcqTe3+eYy4wR3XlihNq0mnZh8R9SI9QsLHPLG6wNqw0uczxDS0F
	l/Yrq2T8znPSnye0zUJG4Y87y7RH609iPlXJlYxpvFciyL7XcPvULf6JiW6eJGuao52nnD+czbA
	l3ztMTM8lIoutNJqK32TKj7pANHEoAfEAIc60Wj1VWZHG2xf8zUYTqTKktaX/8Zkf4mrd99Rjgw
	5o=
X-Received: by 2002:a05:6870:c6a4:b0:3e8:92a5:3287 with SMTP id 586e51a60fabf-423e0e5e75emr14807448fac.1.1776335515446;
        Thu, 16 Apr 2026 03:31:55 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42689699dc8sm3577144fac.14.2026.04.16.03.31.55
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:31:55 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-470145d7df5so4649655b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 03:31:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8rzparrEddUtZ+MR0fBs/v+UBNY7vZlBtPsVZgW5EDe74ppz6KyFDwa7zPBO5a6xeyriTvhmCUK8Ca9RE=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

