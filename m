Return-Path: <linuxppc-dev+bounces-18325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D703FED9E8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZxVT6Kw9z2yfP;
	Wed, 18 Mar 2026 02:59:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773763185;
	cv=none; b=Q1T8F2cNiWYJHwGxy03o8b5OiVknzCoNN6BwGqdBl/bvxLU7N39jSJbrdcxr/QqqHSIFYqc4+Bra7iPXsDGDy18rX8Aae9RFe8KkTywYQ9TqSNF7tCmwvvrZPZTwMrVcJxb2FaLBguhSod3NetiVgkfJmQZB5kURfYMAEvdVUUsj+y2tcuoakNUNm3mKv/Be3XXls6ueI4I1nx8ggKU9HTrTr6qXzmLvPFSRLZpBhpIBxJIqLIC8k2JOXL6FhXEs7DVFz3GWcU+inWzOBj2JWl1OVDuGv43kO70BUOoOk7d2qdVYDPunghF12Q0G9RXHALuRDmZ2p9uQ6os0sUJjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773763185; c=relaxed/relaxed;
	bh=twLG+LiXs44QUcz9Iwy6OkpeTFkusmg+ejXI1TbxJ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHC84/kH4HzNMZkBnG4CP5m7Moq04NtEeXSZqhInBuOjIlMciH01WzzmAfGBdHnUZmI4xU6kUPGSO7xWYSDDMkCDamkheP4dueWPODJvWEfUKE7cHIGhdR/yGhBvbe1j8wUda1vMsMY59hCP4HlOZDIY4McLIGnS4MBfIvzxy0NtmURg3VgoPuHgmKHEYUgVCcszTAQXpTc4MkBqB6ltrQEzFLZHKJSIwgUYHhNw69L9rqiiDIOOlUj5qxaOC/241xcB2U5TbcmGPch8CLrJsWSXvFB7yR1rJadl0ErjCHzWkrYuDFt1aMn4iVAYaBTQvEYyAmIltkbevcWUTpaCnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.208.170; helo=mail-lj1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.170; helo=mail-lj1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZxVS1JXHz2ySq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 02:59:43 +1100 (AEDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a723b2b29so42751361fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 08:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763179; x=1774367979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twLG+LiXs44QUcz9Iwy6OkpeTFkusmg+ejXI1TbxJ+E=;
        b=stzLI/YnV6Ef1NpWeH6yHZz2G3zuiaIEgL0xFDpNkwNzOhcGNCpyAspV3jugPrjWlQ
         hZlsr3e88tl89KKGL2J9u0sBQnuQHf1DmV4E4djGh8PJdO0mswTRkT0sahjsizXEMeya
         SrOWMf02+1EOdfCiRU4W+nuVaQArI5RtyxJjV7fLMdnmvoVz6D2GwTzw1wBDjY0yrx3x
         EVwRLHiXqH+6taG0BrXxKCbtK2fRWtJ+riYzxAzHs7bczVEHR/F0RGyEP+QkSjoPl+Lz
         wPAab+CCErgct2PbupGqxT5YXQoMl8P1hfzh7YMVYg9ScF1JZ3YoRiwEBGm0A5yzHqUF
         4SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWFjX9cMz7a+L0Au+l9oLeVIWvY6MA+ZCnfIZhCCOaQcuBePoTFKA5hoJjIE4bHxAizAMTfjnV56Fyl7A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrIc/UCbu0zQbHuA/9ywXbz7ds9Jg8Qw4pRj1N9TtrmNY3D1kH
	5LbJmmNl0GOqMZoMGiAcC+J7Ju1bF8rNa8A6tZfvaFrArHo+7fK0E6WiajZCpBl+GbA=
X-Gm-Gg: ATEYQzzDh1oKGfcq34ObokQ6mwNkFDfJ9t9TUsML2LALs4P7iKWQuDgRZCNM94RJk5j
	VyCBB3MASX779Dd+pe7DvRZrYnuSFxZ0NLVlOLc8C0rm4CyAB6DhOZywsrGayBrtezakrjOrRtQ
	qSfNVKsK6pQM1Ua+WBdn7a3/BRO0DuPyXu3lJc267vIVmiCgk73oLkG6v0ILJ7TW2uRmBxYmaOo
	fovDhcmq5lY/x9MOTKZ9qnxgFzTFPkhuSmIYs0kpN2fRKBbu2qE7mK8M0OXeCyaoQdeQW+woHQX
	xfbjnuEdFKEYUM6XUua2FvC0caBgaypfCq2fhjss1z+lp6hJLYNd4FwZhTx8VHjBnVj2h4SUdVW
	SWKCMVjUPyZG0vO33YskCQdo4tsUhtAG24WWYr5WP1tULROma8KkLsAI+/dpw7u2xZ5OuCWHiIb
	eowisaXXuJLK3nw715wpagUQGnv8uBaWILCqO9b5+n8k3Evvkgyc934xh3L1b/
X-Received: by 2002:a2e:96d2:0:b0:38a:902:dcd with SMTP id 38308e7fff4ca-38bd5856593mr473641fa.20.1773763179019;
        Tue, 17 Mar 2026 08:59:39 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd54bdb39sm304531fa.33.2026.03.17.08.59.38
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:59:38 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so8407836e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 08:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMYoeFA/NI+HpaBZvi/p41o5vFrhMqIfQaCZ76Joxwwzdgkrf00seewAOsQ+k7j2G+4hXwNk+otho7a3U=@lists.ozlabs.org
X-Received: by 2002:a17:907:d1e:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b976505a45fmr1113540866b.18.1773762847178; Tue, 17 Mar 2026
 08:54:07 -0700 (PDT)
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
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org> <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
In-Reply-To: <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 16:53:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV50nOT06wKfj_X5LU2z=1XZZGd6Gac0C41qWWNZHRLXg@mail.gmail.com>
X-Gm-Features: AaiRm53kA4BcUnu8DzmJWc_bmCImw2GJpSjbqTP7vNJFqk2-PxsMkq0NOVh2FgU
Message-ID: <CAMuHMdV50nOT06wKfj_X5LU2z=1XZZGd6Gac0C41qWWNZHRLXg@mail.gmail.com>
Subject: Re: [PATCH 3/9] configs: remove obsolete assignments to CONFIG_NFS_V4_1
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Alexandre Gonzalo <alexandre.gonzalo@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 17 Mar 2026 at 10:16, Vincent Mailhol (Arm) <mailhol@kernel.org> wrote:
> CONFIG_NFS_V4_1 was revomed in commit 7537db24806f ("NFS: Merge
> CONFIG_NFS_V4_1 with CONFIG_NFS_V4"). However, some defconfigs are
> still referring the old configuration.
>
> Clean-up all the leftover references to CONFIG_NFS_V4_1.
>
> FYI, the suppressions were done using:
>
>   git grep -z -l '^CONFIG_NFS_V4=' -- 'arch/*/configs/*defconfig' |\
>     xargs -0 sed -i -E '/^CONFIG_NFS_V4_1=/d'
>
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN and CONFIG_NFS_V4_1_MIGRATION
> were not in scope of the renaming and still use V4_1 in their name, so
> keep those two untouched.
>
> Fixes: 7537db24806f ("NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4")
> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>

Thanks for your patch!

> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -217,7 +217,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
> -CONFIG_NFS_V4_1=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y

Already done, cfr. commit 8c6cccefb33e2022 ("ARM: shmobile: defconfig:
Refresh for v7.0-rc1") in next-20260309 and later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

