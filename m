Return-Path: <linuxppc-dev+bounces-18322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC43FD877B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 14:32:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZvYg3sJzz2ySq;
	Wed, 18 Mar 2026 01:32:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773757943;
	cv=none; b=iNgYvPVnnSm2EvOyfg7wSKZhvTGdSdYCmPkKsbcgUw4zgh1jwsPp1HzZ3EDM9VFKEfB1m8G5c2/arEVuVRx+K/UKas/fBYUy5mZTlg6bUPfz7eEafDSjdL1SE+04FE6GHwQ5rsvFWpXeeUhmKGl7soK6Jz6XMBMCsOTprGKCQI/nydCt8qmWK4zmSrtBPiP2nPkUCZuQoNpELIN0NWN9M26Qon5dTDXee486rje/6mKBn/6SLZenxIRjyNrnuklmuS+bf9cOD4/NBiiK83mFzg7ehIMhG9RJU4ynrua0MfV8nkwUj0+W3k5aAsmwFgRuExq60GFBM6QW7Rwwx8/ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773757943; c=relaxed/relaxed;
	bh=zI0BuDEcVOCkgV2jfBlT8mTKf+2bIaYwMnS+rErU+CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiSNfUz/7o2HEN9IDjxPOIdg35/u7iHNjLmisO/5g639mKx/joSK8LJHSQL9KYqQS99wb9gq3ZeUj6W7FLzn2mOdhpOR17jTMCMQnxSQEHuoWRIcZZZf3V8rpYMXpHgpPdoav7Zsfj2Y11obOd7jJ5JGG6Fd822GRomdA/Izs7PO8re8gsGib0E9E/gqKkSNLXymQ/zSv54hn3XhF8bB/zMD/4+FBZaJkyFm5D/Vhi1j3SBMtaJBgCzHfQzmc6sy6ZJKOZv5Xa/9OgGJjQD8XQ0vDgGLPwZOzm6IrrBHdsnl4etRGhKykpf7wreyHweA6ISmmFKUaXnJqias6Tv8OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.208.46; helo=mail-ed1-f46.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.46; helo=mail-ed1-f46.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZvYd6rgpz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 01:32:21 +1100 (AEDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so8394385a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 07:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773757937; x=1774362737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI0BuDEcVOCkgV2jfBlT8mTKf+2bIaYwMnS+rErU+CI=;
        b=nTfNq4AS97p26xCXDEvV31oyq8//U2N1e/9dUQuR8bINR/TSGKTOWYKwmuBvP+iDMS
         Qf7cFlQQW/ezcCH0dVQ52T5RdPkHQP0tagbCjH1bRqnq29MdLVGSwaRtvXbmOTUuPi6C
         sO1iDlCpfd/gNhhSdjGrMm8e1lrnElpFc2MocjQvzuQ46AHzGGyevssdkHuRtt4hQZ0u
         XrcJszooJ7y4Z6R40syNfMHLskBU0eFVH6oXh+pV4pkq0mgWJiVJ8rKPnyRNbp3SuJIw
         2v6o1vkB88N0A2GqhbHxjX5x+luhPoylUTqZqIWqL3Q/dR0x5b+iCh5MkBcMNwCtZ7ZY
         LmXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/PMpOgRM9t+UyDpns5UiMzgJsrfhO0u2dCUQwsFP9rsYOvktxFLY5l7igQaBMlqmgqiBejtmxw512wS0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVt2j7qWjxMcV5vxbqV9uXQwoSpnGKdM6Joe9OBMNyjlftkMeg
	Ts3PrqfXAfU6DLqFGdVy7GPVM6Zogoaq0ZZv6TkZRAUjuDFoRjph1CEOBRfNzE8Zs5g=
X-Gm-Gg: ATEYQzxfkPyUC8JxUDWAsXIZLN9U6RN42GvJYldYKdoH4KM+OnqzzpmjzimylajnMt4
	om0ZLtdRAMHneKuhVFnsAxB6VCqAXKB4CnM0sDAmUjyeqnrdD3TOv2z42yv5Fl+kobJotkZ2ye1
	+CyvPasiasdOYSdz/l9Xu3pixUNONWQ4sDJPOlX+6Lf5u3x1hQgdH/rPqH6nFcw3PUpMxnKnYYe
	Z8AxIaZ0Jbs3wDpmd6qQZIKytxxGh57gc0LezJF1WaEv2TSxTDCSRgX/oJgXY+N+Xd5Oqz266C8
	jGvaRZxKB2CHDA2I1Z4B1Tf5Zo8nXni+CnQIbJ1iaExMPHyhzzrLHEaTgFJWFTwB7KufbNwTMd+
	/iFC23lXUnRXfLunyzTRJgQZP6QKtGLvtB86lAsc4JpJ7Nuxn/yiyczWNoZFp++JlLHgDWEGPT2
	XQpKg2A6IFPE5JGQs6EVT6HjTWqt+9IrL1g07pcdgM2M9pQRw9gd8Qhsjfpuno
X-Received: by 2002:a05:6402:f05:b0:667:53aa:d27e with SMTP id 4fb4d7f45d1cf-66753aad34bmr924628a12.18.1773757936408;
        Tue, 17 Mar 2026 07:32:16 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66703fdba49sm1515030a12.1.2026.03.17.07.32.13
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:32:14 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97c44417ffso241099566b.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 07:32:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUEHE1QXG054AkpmYuYIzWZfJVIh7n+MgyGpYQaOvhTghXohxNKqzY466J1eJm3xXjg5uB0qQhDXnHpL0=@lists.ozlabs.org
X-Received: by 2002:a17:906:d7df:b0:b96:d6cd:29e6 with SMTP id
 a640c23a62f3a-b97650145aemr992999966b.2.1773757933018; Tue, 17 Mar 2026
 07:32:13 -0700 (PDT)
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
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 15:32:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXHeCN8PkC1qBai794JEapLkhFtPLe+=jqOwi-m3WFGA@mail.gmail.com>
X-Gm-Features: AaiRm50sR-ZrpQ_NXFXjoxfq1AzUMdtH807Z92qPl3UkRr2Nn3UdH_SFQUevIwo
Message-ID: <CAMuHMdXXHeCN8PkC1qBai794JEapLkhFtPLe+=jqOwi-m3WFGA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Geoff Levand <geoff@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 14:15, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
> Return value of ps3_start_probe_thread() is not used, so code can be
> simplified to fix W=1 clang warnings:
>
>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

