Return-Path: <linuxppc-dev+bounces-21001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B6CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 05:44:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJ8yK08Rkz2xfB;
	Sun, 17 May 2026 15:44:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778996664;
	cv=pass; b=fnBZwJgwFqpnScvzyxSpvVAiY8+So+RNFsnOzlDsM5dAZk66j15/6akbIy+iGxOlPteCQ/BcggmIB5AHSI+VWEbBLURzvRcmlL98zujcP/WAkqBGiUbtH5Danu7YFUPnyOxD65HQPtgzI7rHgcbAVIIJlvp0e9bHKAG6PglIiTXW38mmQrhKIwARFLWQd1FWD8w3k3WnmS5HNl/HBm3/S+VrvBCaVBjtCbwoeAVqb5Rv9ky7pNwi1v3zaevALFCzpaqMIV7V1J0VSJiiuftmKSj7kqYzH5v6lMpcIimVEkWYJUmpK0DWHUDo3nXmoXDO39K4M6po02NMLD50zZ7k3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778996664; c=relaxed/relaxed;
	bh=zJ0Her01fUERuq6UNXxLc9TUkx/Xlff3Qxk3pw57hRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3Ueb0X6MA8qlO76sOi1+iZGwF+W4nvgVONkWxzNWDLpaZHo7EixGV6wYN50LFDrdUzBNyYToscQafTBiT3GpMFEvEc1CaEw7Wg0Ovj+dmUyTnZrW7eD6UOE87qLJNGpipfUVkkcWhTQQsRfbynzNM3kOlVc1M5hDH4cQn/rVxTmD3EcH6AslLk2oeiOvYYUDThnFCm9siZX3bfqrHQhHqa2zF7JmrdlUCHxIKiEZNVbtLZF/+SP2OjdhhbjrkSpKF/UyHZ0sWniJfWpxpB0Z7X2N8Cuqjcp0+LePx/E18ojm5+jE/pIcUMWlwFHu/sI1pYghc/9Gda0IJHLqCOsIA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1ods3bV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1ods3bV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJ8yH1sG5z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 15:44:22 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-67e9b3037dcso2909808a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 22:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778996659; cv=none;
        d=google.com; s=arc-20240605;
        b=W8/lGlZkGLKtf09ZHumQ3wmdwBt1TusObWZVIYphpgDzzEPw9+GemCzt8VNxFMiLMP
         lwEQz51C18pP8Jj1MRxT7HRxnxGkjh96YYyYHxE9TEOol60Ywdy9azM/UiZGVPNANKFn
         dMtFCQ1Z5RO6Mr8Gdd6NbY2XRjidCAQ6zjzXs4M9XTNdNHhkmV6zVuptzH8N2MaS5gye
         wpR7PbujWuz0V1JojGcKKfVaqbbjua2p2tcpDn/Di2Jl7um10zi2VAB38OOXONradom1
         WZJ6BJ+tiFOuNmrSW+kx7O6YuRbs2iHKNMXxV9xFoc1UYSVuKjcVXsAf2hPKcZqwSvPy
         LaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJ0Her01fUERuq6UNXxLc9TUkx/Xlff3Qxk3pw57hRE=;
        fh=yIiGJRU6HrPeRHEZORnAPTBSVVdGvb4GZY7zcXQCVHQ=;
        b=N++RLIZ/J6ERmUpRn7hy0f+t+VNWJF6j66AWq4YnAvscWNay43IhZSHyJMMQFhQEWe
         62zRevWbtLe6d2D202BorEDyispSaVNfzQtJQozMEd9M4kSh2LKiZH+IwXGgart8wrwz
         DKmPul+jIAgtmkqNzlvPIjYRhvzDLVOTSR6ggjchlKNzFPveRyEGYjGhYYGA2K2SDoWB
         abejTu9H9R4VdTX5vyKoZgK3dcsgEJL3XyLpcKAcHgrvd0Ws7/E6CN1KBkjON5f+j5cC
         HGPGle6vTwb5FIyZlfbbFpTv27kSzB3Allpb9KMovXzryLZbZ7+ydm22nxQ+W9jNronB
         sG/g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778996659; x=1779601459; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ0Her01fUERuq6UNXxLc9TUkx/Xlff3Qxk3pw57hRE=;
        b=b1ods3bVod249kb8VLh45nHbcXe2Xy0EtjX9mc1ifG8khC94mm0NYgf1qts/TM6gkh
         DmaHFHdWkmLF4ItntAp9e4wWNI53P8lklQ6e7FxYqgq0Z+oekzPs9mZ7a/7bGuYjlN7c
         StR6cLHg1nsZtZ5ejxO1Lo4k6h4uYU8AtS0sVR0ONFbdFrrrAQ+tiT1e9zbg+owAxw0j
         4vV7Iqeoxqqdw5Ar7d7hkgxn4lW9Y0qgq4xNPIfeelqrxkXdndQ/WM5mJ46Q1EyK4aZO
         pWUQmEj5L87GMHsBwSCPJYL/oRjRGJG2nmE23+7MRfogEl6Ube7xyYhkuyUDTVFD3eMr
         SufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778996659; x=1779601459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJ0Her01fUERuq6UNXxLc9TUkx/Xlff3Qxk3pw57hRE=;
        b=m2GH2aO1hArSNGHaEBPL45Xc2SrNgvhiaUyQ6u0UEeRMn1uHaGFVtSiCOhZ/3VG/2n
         Y6JMO9D0Y1uxQ9Vp+35IXJQn7RgBEJGnQb+44ejyDiemi7YAWkmmDFZjG3ip8JEoCaaX
         T9dlWUYTaLjl9EC8jRpVZAz8h0xYQUu7y4oYv1RxFqrtNDqsElJdPeuVz9+PF93oj04w
         XId8XQIzsqOxAPKN+ovbivCjU9CCD9hLgkFj3VDGYNt1EM1h7OXy7PbYcyeYs6UgPXEw
         8Fif7pn5v86tLQEo9aAx+1UoXI/Vw1ZiCj2juLZGgc07ZntAfUnc+N0XZf3KE/0Q+Y5l
         Wx6w==
X-Gm-Message-State: AOJu0YzpdyU8naJkV3puT6q0lBddCEtwu5ZXfhe5aCMuw0isZyGMxUPI
	I3VBunq7tuu8rTmxnVnIAeBSBJRDr4nyukch0S9TxhKZwVRfyf+hcHe6E/OvatJCcgvlDGrMVyT
	nnvr0GpBHaczldixfcYTBuNoggpQiSdI=
X-Gm-Gg: Acq92OE4Di7FslxpYtV39MnUXpj+o817JeZELW/DUHabilbKzT7b10mwtxZnttlHrpL
	pEkV+xEKE6Js0B/LyN9rnPsdILAs9oEOOqmR75taql9uIKyXUmMvKCe6m2GGCCWP5gjsdFJrYrI
	/FgcUG6mU/L46Br0BsIGzzWs2rjPhEuDYf0W28OSfI/daNIqxRGHjDLpZ8izA6pEIHXO/kx5pmD
	96hfHUVy/eIs28GxwyJb1pJhIM0Ix4kE+afEThDRrLwVEtiHm7+Ij1aG2TWW3plKk1JxXuB3Yy1
	QNbbco7Xw/0nAPptTKD9gtPRvcyNqIz+zIjC8nryQee3UdqtbxnKeOjtNsVwOpAwmAmEkXjSnOr
	mHKFpZtDhOmTzucr/ZkCocxXyYJRqw98u9D7k0wICDtWBqNXvKqoSJ4chJg==
X-Received: by 2002:a05:6402:a584:10b0:672:7145:21bb with SMTP id
 4fb4d7f45d1cf-683bc5ba401mr3704535a12.8.1778996658512; Sat, 16 May 2026
 22:44:18 -0700 (PDT)
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
References: <20260515231913.1154801-1-rosenp@gmail.com> <CAD++jLnuJDs=Zkba5H0L0Wrny+Wej2YLTWF9mCrb1PBownw=kA@mail.gmail.com>
In-Reply-To: <CAD++jLnuJDs=Zkba5H0L0Wrny+Wej2YLTWF9mCrb1PBownw=kA@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 16 May 2026 22:44:06 -0700
X-Gm-Features: AVHnY4J1M83WqBCCDl8TelZl90TAncktoHcmSicUyYKOM7ehSYSArpohXSA5Tpo
Message-ID: <CAKxU2N_=TnpEaaAY=OZZONg-KAq_GvW7LYchNHsFAfC3A=h0qw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Set GPIO chip firmware node
To: Linus Walleij <linusw@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 7:55=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Sat, May 16, 2026 at 1:19=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
>
> > The PPC4xx GPIO driver stopped assigning an explicit firmware node
> > to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
> >
> > Restore that association from the platform device so OF GPIO lookup
> > can match phandles to the registered gpiochip.
> >
> > Tested on: Cisco MX60W. No more probe deferral.
> >
> > Assisted-by: Codex:GPT-5.5
> > Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platf=
orm driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
dev was needed, not fwnode. Which makes sense as this is specified in dts.

https://patch.msgid.link/20260427-gpio-mmio-more-v3-1-fe1882351424@kernel.o=
rg
fixes this but that's not in a released kernel.
>
> Yours,
> Linus Walleij

