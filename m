Return-Path: <linuxppc-dev+bounces-22739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F281CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggKpT2Jhbz2yfD;
	Wed, 17 Jun 2026 20:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781692145;
	cv=pass; b=ovjNudylqBvtJvY9Kq3IG8UXH4mpqyrGH6vZrXQn8L5k2AVn1rOuFYq9jrOKsikTFIRwoPuODqCl4pMV04haCa8TeqAbsqb+IdOq9f4xBusU5ai5mFHUXcix8YbAmSjBGpnSssGe0RCAA6dUn4B8nCK7ywPd7fREyj6tRh8na0rAoc+B7+iLVxeZ2DxP4eSwSpM/X8xE7b3qD9Zsv91FRGnSXrOFnKX2IqPQbGELkLXXybNOrcr5/yx98lDWLGcpNmBTTsrIY0vJ0Sw9xyHPuLdDiSJZev2IBL3SMw0db1Y6m0vylsq7bX6ZXxlwQ6I/mZF70N1wuovEktrIqSJU2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781692145; c=relaxed/relaxed;
	bh=kRjUtdAZ1X8edMk+uEk4qOuv5l+aTxpMz/Az3+07hSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY2RF4pR8AQ0b1uFrKRfVqngUR2qVKTiM/12xHlpBpk9ZS11sHdGlyNhme2iPf3gQ0FZNLooRr+3QSxXEX0Dk2sXV5XZ4Z23iW43pkcQN8vAq6875BHaoufxIugdvCxhTbSybs6RI4W6O3Bwqt5Jp8/eHn2DWzo1wOvY3+aHvdWsDzp8rz6LhsXQDG6flkQchfvGLsTV1IZJWQSyuPRpKPLgRuTHPyoKWPMAX0CY9eQElel8J26tnVKpKhCkgA8ZGWOXeZlB/D8HSWVM/HtN1o99tJBbj/WzHFfho4rvjL3w+Fn5x+IdFFVVW51ZDPHda9UESFxOj0g5R/OExieW+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pW5aqirM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pW5aqirM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggKpR1q4Xz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 20:29:02 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c858cc9870aso324973a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 03:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781692135; cv=none;
        d=google.com; s=arc-20240605;
        b=MtMDHXhf7eywvXWgaANAmjKQoBqUlNAMpdwzEhEg0HUZVtRDaWte4nbkaG79shB7Y1
         U21PH9KU2TUV003xQTcZpsTKI0MTfQYbPrkoxn8CS/YYdOTk57PF/imaf/Ng/wKQGGWl
         R65DmHbHhBJeW6jpf/126Eo6Ui2dMjc306dCtaImTqdLAt9iEfLP8RebqsgGo7gseGiC
         uCR+dBar3BsEBIJHW+oviFGvEnxyvRIN/rFWtFtlGKtMbMbXcMn18cZM1ZmhYLm1k83y
         sidJXcS8xtcNAvU8WhBKyX5m0mypc42EnP64C4sO4ezMxy4rjhPkQzNNJ4Wexgr10UzG
         s2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kRjUtdAZ1X8edMk+uEk4qOuv5l+aTxpMz/Az3+07hSo=;
        fh=3Hxg+7WNM30ahkMypl2p073Lu4ep3edpsarPOllhxNk=;
        b=OsJmDahsC6GK0qMufojCtOSbhQ31/39OCIVLub2LtlmTUwJSr5dyjnlIUG1JSvLfRf
         ARBjDGNgJtF+OX8xm6Kj5rFLAMMAR/p5kheMYWOWp/3GmI8KDDra+TyuMLQnvW4+jH9h
         OE2P++gD9+gXidkgjdY8G4Gke4z1QIrVwKFiKl3rZT80GkIp8HAOE3JfTZE1flbs9W96
         2dabJBtP5AEdx2GmFZ1PJyrlYpaiwvwzo9b6/RfPo2hANTHJddImojOTWtEs8QO1uqli
         8GQ+jS5LLzNDPLVdNWgVKbf5TqtFEs4I6y6sRRJnAwma2HiLRSDpy23wSefDsb4Mh7+2
         A2kg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781692135; x=1782296935; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRjUtdAZ1X8edMk+uEk4qOuv5l+aTxpMz/Az3+07hSo=;
        b=pW5aqirMJE4Lic8BFytD6SYdpMoIBep340WUWnBv8zgAJ27uzqy9Hlcpll6a9Nhnvk
         awoXeyt0RtVLK/8c7+VWkgZftLofM7/ZJm+rK8eNMTDDyEgIuMKeOYd3KZXOlV/TLuct
         6RcRo7qHFtNX1ViWlvUG6jMFcZdqJCq+WH3Kl3+lD4w4ifY2152gHGGkvMpcz3IibYQ4
         cgUlfxQwo4J5H99rMLD1a2gtyO1RxWnHUdZavbTSr/6O/r3SU43pZGMyerlUOK0vEPB0
         1zFtIZT5yiJTXLwUoDRoHFGcylhQy0xEU3XUIcvfcFUy9BDA4KRcVIQivsa8pOqMQFne
         AXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692135; x=1782296935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRjUtdAZ1X8edMk+uEk4qOuv5l+aTxpMz/Az3+07hSo=;
        b=lH+UsDJf23wdjskaDD4bC/gP/4e10JQkYH+W9On8bSLnz+EV/fvDWkch87nmD3AIMs
         6SlRxjvpAUzCQWQMiXQ0J959Oq+mC8gJNfmVxOOW1u1fSYqW3FXzqN7X1ZD6js8Uj7ge
         dCzd9YRBJ/2qKWSnnX4qxkyZQjH7nTdngoOK/UPcQgU6UJOvSrZGIP+Ea2RwVKpgbt56
         kCMpPYtWXEYEcktw6lwnsW0GIr9ibe+mqJbqrqfA3dnPtROYZl7SGbUSTb66LBZr6xtQ
         ozetSLqnHYBF0lVoyZNnhM4EEl3ZordEPNWHR0PvQxW0RFTyU2Ye8wtz2wrPNWSsrmBd
         A2IA==
X-Forwarded-Encrypted: i=1; AFNElJ+GUZhWEoQnLNvKUYKI7H+isM56JRU4tYvyIWLOISp3d7WGJ1rIQiPbH1n/+ItForbihmk3EX28GmtuzzE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyNuJ+52Ug/5pF5GJKuhn+OVs22N728QdZeC3/bMZ1xhMrivYPd
	14EQ38gVSjlerOVY4l2tYoF960IDUxcLxoz0rbUb0Fj3voH7W/YkcD84M0UtHHrxNZjscRGMMus
	9ZnGhpxHiKtgX+0XxuBMf4AVWtC4LcBk=
X-Gm-Gg: Acq92OGv2inGNr5UL6g1+/a0j6wHscoJR5As3FsB4Tj8F6bOE5Jku47MPwYkaUqRVl6
	Cls4n1nH4Ad3Y/Ne1AsJfB/rlLL+O1RaRQhsu36U4OeFHlq4ZWxCuRhcFc7wsL1bNkQ2zPh3csz
	zMwkiROcajRAqe5B8vh3zyqc6zIMeKPQj8aGBxhF9uxVOEO5GDjq91pJLrmPSb2PlV35KRieKXL
	W0alq+8lfV12FYGDH8F2PGtDCDe7akuk43GQsS4CR0vg60U8yxwBkBS3f4bup7fcvfNQev/
X-Received: by 2002:a05:6a21:3315:b0:3b3:6db1:5986 with SMTP id
 adf61e73a8af0-3b8dce967b4mr2334359637.30.1781692134673; Wed, 17 Jun 2026
 03:28:54 -0700 (PDT)
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
References: <20260616030038.4170204-1-shengjiu.wang@oss.nxp.com> <a5a652cb-d6bb-45a2-a1f5-ca540b34c115@sirena.org.uk>
In-Reply-To: <a5a652cb-d6bb-45a2-a1f5-ca540b34c115@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 17 Jun 2026 18:28:35 +0800
X-Gm-Features: AVVi8Ccnexg7hf0koZrghXGJFMY7u-UOLAfnr_vjOBeW40Mj9iwT9-M8wbHva8Y
Message-ID: <CAA+D8AONvb2PJX871g8yUEtUhq7EGRFMdLm-6yFdTzbTvMGn2g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_audmix: switch regmap to cache-only mode after probe
To: Mark Brown <broonie@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:48=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Jun 16, 2026 at 11:00:38AM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > After pm_runtime_enable() the AUDMIX hardware block is powered off and
> > remains suspended until the first runtime resume. Any register write
> > issued between probe() and the first resume (for example from DAPM or
> > ALSA control paths) would target unpowered hardware and be silently
> > lost.
>
> >       platform_set_drvdata(pdev, priv);
> >       pm_runtime_enable(dev);
> > +     regcache_cache_only(priv->regmap, true);
>
> How does the cache get turned off again when runtime PM is configured
> off?  I'd expect the device to probe powered up and then be powered down
> and put into cache only mode as a result of runtime PM running.

Thanks for the comments.
Yes. need to consider when runtime PM off case.  I will refine it.

Best regards
Shengjiu Wang

