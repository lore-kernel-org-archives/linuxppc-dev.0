Return-Path: <linuxppc-dev+bounces-27297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0875C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkZJ24zBDz2y2B;
	Tue, 15 Sep 2026 18:02:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789459362;
	cv=none; b=N/00GqRqvFGQr1ipfxXICLZy1PU/PdTCiO+Z/0iBertW2X4VyS/YhtOjw5D88hGoziuCVF6RHhF8rdZLTveUDvSrn5MAYKaMUcvcnb7u7bs+sqXewEsaAKm7GngNxb8a6+0NN4j3Tf5Ll9uqjogWCOcUWqJ/C6ApyoTBpY73z8czQaRIMOw4S7+BL4lol8jEShGtWH1nV9I9wwGYJAeLq5eqHKsI2MsTNECgD/4/LDt+W6jPNcbd7HPr6Ij9N2wZTy0puI8t41oftRcWrFCjYBYfrkkxretndKxNsVNRJimYkEcH7dkBd0Nr0z3g3SVv3Ae8p/DNzVjl8G+2oKuUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789459362; c=relaxed/relaxed;
	bh=51S+pj+NMPpYQZLFg4RlFKvBNKhAajYHE1g36uEsn0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAN/YXnfkM/f+o9iHsYk1yTfkbjmgEQcAxAGCJ/cH5Oy9A7NYQbkQaq4xG5QmV7PwcXAtieOrqhI9Fn+DGVTOBxSr8IpnSq5cXhkivlpHvxwWzJ6NL8toYLuxVjNgHuUp83oIadpmzV8irz6oEj0RF/6phBTLVFlIK17L9DL3ENgb54riaMoKXvq0QQpRUvpyMIulUaH/WQpsqgBud2vzBuswSSGvNQ/DWPwA94sBiJATJVzBv6trg+n7c1HXkxXD5j4dzj9byN5SoMydojmrmRhrmh/U/IH7IbI2vqr3TK6Q/oiustQXO+HC/rabCfk65F+fGZzCFi4I/VkYeGggQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.46; helo=mail-vs1-f46.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.46; helo=mail-vs1-f46.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkZJ10kY8z2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:02:40 +1000 (AEST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-782af6c753cso4648190137.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 01:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459357; x=1790064157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=51S+pj+NMPpYQZLFg4RlFKvBNKhAajYHE1g36uEsn0Y=;
        b=tYllWekEQlaYemjj9RGv4iVbXoguyIJVuz19Of1RBK2Icx2AVfjmVcF3uM+i/lek8a
         QxnUlRMkr1lgmR/opyzsfFf+rafGRP24JoX4rRaOzo+geZjUf/Zlzau/yoka/BwYBv8x
         x7Po55JDYSwuxv5dZItKPsDgO3FQFJilhl0VkFRqVJndn7c6/q4fRCrJtPzvtNFCkxqC
         te7sxEOMbSzCZt8Q8ogjoaB2lm21Xr0qSctSsCh3N+foYhLe+ExaMHdxrA52/i4qXB3a
         4glrQYMaYjHu3JzyAxFK9OhfzyTBH1RptKKUxq6uNqUcomHLJKPEHzz2MrSci8bLN2Ah
         d4qQ==
X-Forwarded-Encrypted: i=1; AKwUvByPz/cPukG7wk5LHwJ1n3jBY2YI0q9yaO0Wvo66EQszcM4gPn30uNDRcUPriCwRZcoUGOUSwK8NFW+7R4A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mAzqGihOho1S/9TiZjHkEtTwGgbQp9fv5+OyWq9tjy0XrTVcmb
	FxyDA4cmfcyNcwOUax8qGNO1R5jaJqCiOLc0Qmub05x6jAK0Ll8u8j9bwd+XdQby
X-Gm-Gg: AYBFou3sv6vz6HvfjlTq/3U/GqcQklIe/QA6kiDmTBCfqA5p9S/eXiTJlsArirZiF2q
	Exdj8tZhTqsvdB3iAfyP0R/E29F26Jff8hyMltWl0cy6o1f6p5RBwvCu6gq50VWpRW6s860GwW7
	iuoqnSbOBykt0xxMtPKNn5UKZ4CFG7hWxaZJROb947Sx8FwAe/m30kbIe83x9EJt3IwhCh8+yIs
	e4IKPHLQifZUM8UIWPaQQoacEtnDZbb6xme/XGx6XYXbhhz04LIfhkbXCNWFl3igP56j9bnKyXr
	CWQAvIrTx7151dJj2ejE0x5fhsEcEO00MoHEdU0xNhTIDb9Z42879Gnyst7FOMvNBvaj16FwX/c
	u6IvoU8qsuIeblXEGsfySCpM7C43AfKGh1oawXkSy5qFHuUHGJlnPoyeEntJsTodPfm58Mq5yO/
	9OYivyEGB7e9iF0f3JZ9oDoHuujjnbg+UJaPT6CGQcps1sslz6y+cZMwYX9fwcTIjCvFrDRG8wH
	K+c/uVCr+JgrROCW8GS9XNKe5Zq6XdVB+qRw69BTZWjnZpQKp4=
X-Received: by 2002:a05:6122:488c:b0:5c8:228:5ea6 with SMTP id 71dfb90a1353d-5c981d5fb29mr7945935e0c.5.1789459357292;
        Tue, 15 Sep 2026 01:02:37 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982b9ed9257sm13393285241.5.2026.09.15.01.02.36
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 01:02:37 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c7c25d9f6fso3984053e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 01:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBynwo1JBCrnwYwMl+Agcu2UGrQ+DfA9Kk2flF5dBOiHhGCxd038WhCPXCtrgxjZyRiWCcy0Hn+0UkKtwnY=@lists.ozlabs.org
X-Received: by 2002:a05:6122:1d04:b0:5bf:d3cd:3d64 with SMTP id
 71dfb90a1353d-5c98188436dmr7062831e0c.0.1789459356510; Tue, 15 Sep 2026
 01:02:36 -0700 (PDT)
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
References: <20260914215900.84712-2-blum@kernel.org>
In-Reply-To: <20260914215900.84712-2-blum@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Sep 2026 10:02:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwiVjs-Dqiwoa_oOerDyz58=P3SJfdyT3PsODFDPU20g@mail.gmail.com>
X-Gm-Features: AcwNN1VJlmmjReTQUYQHfnyOvudBS9IClSvuXQXbg53716FCHoIlz6aoWDjejv0
Message-ID: <CAMuHMdVwiVjs-Dqiwoa_oOerDyz58=P3SJfdyT3PsODFDPU20g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()
To: Thorsten Blum <blum@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 23:59, Thorsten Blum <blum@kernel.org> wrote:
> In ps3_virq_setup() and ps3_irq_plug_setup(), remove the goto statements
> and handle errors directly.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

