Return-Path: <linuxppc-dev+bounces-19788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9511F8A160
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 11:29:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxG4z2Zfkz2yvT;
	Thu, 16 Apr 2026 21:29:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776338979;
	cv=none; b=iyAuh0vTFs6/lNBooKV3FxMo3q3mFBloPysZuU8Yfzwf9dw73rW9Krad7vnFBqon7PSwk06OIY6MqF/g98DYQQsionoq3bGinV0FDTxkiQKQcApqaBITY5HDloa0vtYoX5wDmMxiOhx03bLDvo5Xy9W7HI5Paney/Vh8J6Vy3J91NhB9zUJcjXo73I9zwsCm2w/Sug1EDtjRlmYGSx1TZNq0dpEMBHUMPgKvIQqYQVUw99YIfcMovveq9iLD1IPEoqccTMCSNrweRiCTQkYEyb4l699rMYzjuZDmw9BgZMKoDgoxsz1EHSd3mPPlMI9i+hi/0fbgd7hSzTuzCUSBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776338979; c=relaxed/relaxed;
	bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITFjhHhKXnp7x2pZy9ecBF87zX85dgBPBa2hKao36DhVkKjxpnQT+gAuGYg9Q2aHqr5prdu8Pp1rRCb71hUWPBap2zsASU4pMztVELobmm4N+lT9WOL7Oi94J3/bx+5y7IRoyppfsjv/OmZv+akDfg5l3TTXod0Pt6PxeS5R794Lkw6r+SBur8krN/tOJIvosg9CLsDIIJecfQDGf9IPuxTBgBNMuZsiRNTp8SsIntXvaFWhMlC5jCA6J+lqS1VNbVVxeV5tbWHiUQxVaJYDCg8TGFCBAgUvQ2cCmJcpCNT0cEZ5j1hwhF+qt4JbevoBFN58BdQTDIIDwN78GywGaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.160.170; helo=mail-qt1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.160.170; helo=mail-qt1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxG4y4FFkz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 21:29:38 +1000 (AEST)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50da9a7928cso64481581cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338976; x=1776943776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=SLwhbV/nD75AdZAAUblQHTzHpEeN/pq9lFYqk8pNyX2l+WrP4kngPBY3c2ttzQr7Oe
         BJKGiOKodphS/LL7hk/k2rrwGXR126GfNQG73QxxZaKYzgVJ40bi9wt2YFwEtHTPXsfB
         N7W+2p3rFDIRFhReYdafGGdTeoKmBNqsGwU94Sa9DIG3CRQoc7sRnp5sxDDO3N0GMZzM
         EqgfdDGb3ZV8Dssu5nPJtxZtbzYo+0RMqxDRJCnMD7sd1XgXt1ZLVmGCpCGSC3lur5Tu
         5QVloLOt6iYksdbvJdMRNhEFwPwQW088NYzGqJQ0b4wsD4JW9GGftWGtCXcE/LQ/yOpj
         jB2g==
X-Forwarded-Encrypted: i=1; AFNElJ9UlLj/ztF8gwN41igG1TwyMlPeohYCZJ4N+m6Ui9kQnbO1AmnhtAjVA0s8a2kMWExR5S7OpMRjLqlP9+4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzlGKJ52b/6NfaSjbB/+tNYoTnMaFZ+lS22ZR4d5FovPyEm9UP
	tNdjd915A6LVAUmRAHnUJFGFUqeCs3FZNOiuJxu0l9EdpB4wCSLRPdeDPWQkLpGi
X-Gm-Gg: AeBDieuriRPY/1NsOj+/mTvDF3kDopgvflTmla3L6YrKmAJdR95GzKXntIqvsfDch64
	YE3p+jncXPtP6c/V3RaYOwyAHpdbV9MizFRqbj+tzxCOD1exnmEGNvdIR68AQKQnQTiq6Zy90UV
	dwn0GyOF974IIyoZ29NMSQPBojjwMJQY5w1G4aKobxfmO7jgbE0s5BBnX/ELQ1Bg8gVxD0hVCcK
	yf43awkL97YlYSBV/1uqV0MStXytMWdt+tVw3lk3Wj683r6Eb5gMr6uPrJlhxTg3t3BfQdZtjTs
	64DVmQyYeZnJ97Gxb0vNURmh2pP0Cq1Md3CtKL5pwN4YcqMhlODEhQW06PLF2hkFgrUD64v+Dil
	Nhnt5c5BOiFu+v7WsW51E36xEBbITiwNf2RQyvVmOGxXnN0bFfw1Ti2SRpFwqCeBn6eQdix9SlG
	oo9pDTybiy7GxbAgMAkYBDglhNaXobceNDP0cFveSHcXi59z7GnrsCJlnioCqTepQDTeanp6w=
X-Received: by 2002:a05:622a:1818:b0:50d:afcc:983c with SMTP id d75a77b69052e-50dd5c4279fmr364787831cf.60.1776338975979;
        Thu, 16 Apr 2026 04:29:35 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ac0ca45sm40295591cf.0.2026.04.16.04.29.35
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:29:35 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89fc4147f2eso94840466d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:29:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+i6G8lNQ8yXqnb8byzcl+MSJvtyFlS+HNEgDUXZpMTKvyBOkTO7K39XI5PFaGe9zDgHr7A356MTPSyXSc=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
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

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

