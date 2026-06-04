Return-Path: <linuxppc-dev+bounces-21997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FDCD6E68
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:20:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWHYW0PdGz2y1Y;
	Thu, 04 Jun 2026 18:19:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780561198;
	cv=none; b=Jb7w6d6PeZDcxuo0Px+jhPKqPrPsPL5NCAUGYbjzkWu5/JpLHLqGxy6YzD3D7e/6DkqXAVialExQ/plHwMu0O9CyxiqdMqVPzZLVzhTgcmf5bE0EOYr3Pqk6nkqFes7Xffc0FMT6PJQYosX0g0S7SKQFd/tgB+zMG38ckqsbGJ9DOhqMBDddnyaZ7A5wHQPnYuMGyEqkogwHbcpuHA5A7SZ9OLuC3uXXnM+PHvO40q9t1Y2hU9zh4+gSlVyVnIN1OQsx4Qdf+5cfTGB0UoNHwlb9yLxryX1vZ1MZRdnST++7FOJeDW0vDW/kAmTuE5Qq/b/94fBrV00EB7rjHUhPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780561198; c=relaxed/relaxed;
	bh=SDS1A6hcukGhid0L/k5/ECkIN6Tj+VdZT/Re4E8MEgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb4Ov/X7ZTEk4HJDJbhnI1TKh8/ahabwv0pNah2A912pIRP/Mq3CtUSUMsv1lPn2FSSfTReWr/b7XKOMfBuSXg4gyC2Y+qpMuQd5r/9Rhh/YuUNFh5htpj42iNZH+p7hWjFUTK3f6sArWyT+ICB2iRQc2JuwHKx6m42YdU/kKsPBgW6M2D/UYh02ZZozodGvpXm8PhNlvywxscGXq8T3k01qcMrEjGx6np83t+nUuCac0Q1H/i5XfzaUov6XoTz2bZGtASdFXbO5gCE18rm95efiwBoA22/UCBitJt3QuhizMaStmS9XDAxfDFTOyFKtPVSUvcSj78Z17ovlLmr/0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADm9KiSC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADm9KiSC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWHYV10N4z2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:19:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D8D843C9E
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 08:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4336C1F0089B
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561195;
	bh=SDS1A6hcukGhid0L/k5/ECkIN6Tj+VdZT/Re4E8MEgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ADm9KiSCjDNkoGJDH+R3Zn8ZzVGFjrmH4zW1PKcxiJXbYBw34xhs0NrOsEdUnaSCC
	 UjDnbbROSJtUahFsiqO9maWw3DJwior9qfn0dwgz7Cgk96IzeZUtCiuhpcC2QMsnhF
	 SAcuP3IfkHRqt5g1wsCC36t6kINEQ15RM2qRJ9B3Fl3c4ljc6HGxnxFJK7uBU0edIG
	 bga3BVB8p/N7anEYcm69mBAOv/IAFXtzhFhFlgcuFoLSJC02QxBGGS3HbwRCqq/5xB
	 /YEJDFiS+g5qzM6utcfVUgbDQcU0cneaJY5uQ3O/nKImh1n/C6MkR24UePwdXXDKXg
	 SNiX5/Nqz69Yg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so388395e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 01:19:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2joEznhDb6gsx0ng+awIUqC4yuJdbHIg4KvmhDPC3ZrPOgqTjimgm5vkIgz62Fja82gHI8t32BYq5x6Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+9dWGtqOLU5yDPptZoiQO7gh/4WT/92N/Jg/lxrROszU//Mph
	Cxtaz1EbOQJwpyM0oIQ1jbgbEbyCUrfcF2/WQG76WABSDky7zkWYKnFpSpk73Xm+tLKbIpvix8O
	pxGrPYUiT1zxnS6dBHxQsWHvm49c6Zec=
X-Received: by 2002:a05:6512:3d16:b0:5aa:64b4:13dc with SMTP id
 2adb3069b0e04-5aa7c038415mr2282554e87.5.1780561194063; Thu, 04 Jun 2026
 01:19:54 -0700 (PDT)
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
References: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
In-Reply-To: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 4 Jun 2026 10:19:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLnuzeTX+xi6oC+_69BWZ=GUi7HwXWw0bQMULUKfPq4__w@mail.gmail.com>
X-Gm-Features: AVVi8CdQzpeOfq8Jei3XmSM_bbZ-_XlxT0uFqDxW4iTG9jEoY4DE3k7-oNdh18M
Message-ID: <CAD++jLnuzeTX+xi6oC+_69BWZ=GUi7HwXWw0bQMULUKfPq4__w@mail.gmail.com>
Subject: Re: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, brgl@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 10:26=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> The lack of get_direction() callbacks in this driver causes GPIOLIB to
> emit a warning. Implement them for 16- and 32-bit variants.
>
> Reported-by: Christophe Leroy <chleroy@kernel.org>
> Closes: https://lore.kernel.org/all/63487206f6e5a93eaf9f41784317fe99d3943=
12f.1780399750.git.chleroy@kernel.org/
> Fixes: ec2cceadfae7 ("gpiolib: normalize the return value of gc->get() on=
 behalf of buggy drivers")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

