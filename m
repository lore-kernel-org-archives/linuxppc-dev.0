Return-Path: <linuxppc-dev+bounces-19786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FE9F8A15D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 11:22:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxFwX1dqkz2yYq;
	Thu, 16 Apr 2026 21:22:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776338540;
	cv=none; b=CIcrnP65H+uCXA6Nrx6LX/j0cD9CnjyN3MaTzwP+EEBQAXVF7G47tzbH1KC5VaJtp85Puj4qG6fwMQEhzMrSpwVOZjVdaRT95Fx2w6WDl9dyPitEbVEOe8+h2+wdzcXQc0EYjJzkFWzccqiYs3nFuiHA2aRfDmIkQxj2+DTcDU7NwNpvoWaUjIOzatrWNwTkt79Pj0ra5iF0YDz0qyU8EuUN5EkIc8OlzujpM0avhMh7droukEGFQvIyU55+FVBQn6REYqYgmxAcizEYe7vkZyPURwfETevLlZ3YwdGtw+Ky7e0n7Wu/qFmqxDVE/GjXZpOk5QRtPRmECVBm+S4Pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776338540; c=relaxed/relaxed;
	bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyoW6caLX+iwoCATJD10mJzS4EOtRRZ0vn4TJ3/cv9rT8JxmzStJhTbDzAsRQreiDY0IETSvUJbZ54WEwm2bL8K8M8jfu/xRnz08G2HVeYrV2HlG44Pml0bm3NVyD1wHeOa/BWHyGGzkMIgGslTQbfwpvHyWWS8NN+k52c3obTKqng7yx9aFKor2dtV54hvJBsHad1ZOz8VyrPSVK4gniipMur6VaHcKdM6HDWTiB3WcnwvnroPpNBceicKro4vfBuy7wTSeBhFsDqlnAKAoRe3wbAol8dSipAGwOXQLTjQPmVODZ5YxEdfjZM4C1d7/rFXSeH0ggC5oD22+Y5pGiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.43; helo=mail-vs1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.43; helo=mail-vs1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxFwV5cnsz2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 21:22:17 +1000 (AEST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6055a0414d7so2270520137.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338535; x=1776943335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=TBQU3Kt00YdADCKsSwo48xPPx1zYXmQWrpiJXNsue00X0OYjp9coDzercxzN/sVqLU
         Yjq+M3gGi7u6g8KYUqqOfYGt4lciqsAoS8cf1gE4cc9QlxHN2MogkRjRnUZKYeQyQtG9
         nKNHCXd8nrK6exbV8wJiFcyn0Gb5GaZ/63dy3+6W0ubD5myGFJxh5J11jPcRfLbzILny
         b//FYXJkvbvGBZ5xIQW3yC0aXATgNQz3efzrfTdTSnZoOSOQVrsVKT0OwfvWsqNGFtus
         nE08Lp2iz4vG3dVNRby0d10R5UOTjTjk7aE+Ho+geJaBfXFnJEYDvmAW44A+AC9iJt2x
         XAZw==
X-Forwarded-Encrypted: i=1; AFNElJ+l/FNEESCCe6xFFMGT8z9QJvjeopodSI290HVj008UAYHuJjflFc/k3dgZUR8GCVcfOLPKGpnZxiQpaD4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzg8PAl3dyxQZPLCy5m7HW1Weg0LbJPA6/9sFnMan1akK6mwCLT
	76MLNghdPfPmT7jOafR6mGoD2hDFKUJKrkILQvfWLkxilpv5J/mAfRdW904nkpI5
X-Gm-Gg: AeBDietjQVBSw0ngn/j8DmVHl21o0ieiSF+I9s3rq8dol+uom2s7CRUcsr/z4cDYZ9V
	H9Y/YptRPRelzOmb6wzCB/OSUcYreCbkLuAReoDPM4uhWFGjxh71K84Phw2ddw0SdccheKxD+p3
	GEB7k+eOBt5n7xem6FozCNDQXZ4FiR6Z3RTt2SMsEsJIxXtyJN1jCDB2o79ANrX6RPjqSBqxjuX
	ufciiy+SBypvDQQYxKZh46pySXcMxbsA+3BjwdMHEtjVMJ0F9X5Onf0B913QYVxNTJRHY/Gl6sM
	UIemYgax8t+4ktHTZkmm22JOHZqtk8P3iA+GWkF3GFfL7+9y3n7hNKdc0p0AWF4jfuutuUkpWhq
	y0fFDuDCMDaR5YWkdHUof4SM/OnnZJikKWd5Xn/+Sn+ONIrSkYp/r/gFepizobvuUNgYeXWwTAo
	mXCgHrq4FlkZlTO5z8XK1RGU4jg0wkV6ckdrNLuG8KPvZp79EA+Jwsuzt06RWI4W8i2EsGKOpJ1
	uhVxAJyGbmqjQ==
X-Received: by 2002:a05:6102:2c0a:b0:602:6784:3eef with SMTP id ada2fe7eead31-60a0167fc4amr11802584137.28.1776338534674;
        Thu, 16 Apr 2026 04:22:14 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9586533d6a5sm2151426241.6.2026.04.16.04.22.13
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56adf76631cso3195219e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UqzWWxoNp+LM1v7JUDpZGXNJoMmDQjZ+SBdDdp4kTdZ8v1pkjLu2jGd5+c/1Rx5Sn6OkUIa15VRdVZYw=@lists.ozlabs.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
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
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

