Return-Path: <linuxppc-dev+bounces-20999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA2CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 May 2026 14:55:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHnDy3rnjz2xjN;
	Sun, 17 May 2026 00:55:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778943346;
	cv=none; b=koSlemBht2KiaqXqMi60kN0g8Odj62scD1VDrAaM+llkJn4CSbNzYR5f80vXnk7xn8WFfa19GiYjOuPeVSXEDtwV7zCE8JDhqhMb/QosVWESW3kr/15HVBY+vDqdqLDeqfQZGyjDISnQCRPsYjsxTKHeDdH+l6e51u3V2Lyh8aMURmdt98qXjWjtKRu3/c2uix0Z3nmy9bCC/G6t1sKFV3WawOYMRzvDOR1J53gD3OEdd2m4K2zbOo7cxBgxiPmgaLh300kylukPuaU4l180+PBzOU7hWXimG9OTMgwCh9e+RD4MxxtDDEMr+Cf8Mo9sCoU7fcmdjazWoi1kdlJBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778943346; c=relaxed/relaxed;
	bh=zgRJxzLEDtFowP5Q3FLxvf4LqLwGNm2a9mKuXD9Zaog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGHhB4HJx0q5RbdtLBNNhtNjTg7Y+rOIeufOJwCUZi0PvpR1e1khyM573H93C6AFvoTQ5iM9z+ImBYpFHY7zO7S1t1/PE1f084Dm1fpsoFUZIymp+PEikvdOQUp9Xu67SJxhiImFGEx16D+wW73S62GwOUGEwKMUNqUXp0XLF0d3R09KGtrMg0OU1nH7d5SVuupJ8hwt7JxtyqNL3kGa+9BlSKyLxPG7ZVcZ4Ej2J3O7MIC62MI2NQkRo5V333rMxUPKwA8JHjoy1hD+dLaLvnexPxvx6LFIvNdtsYLlqT0mMWWyCX1ruC8dBG2zX8B95TfMCxQkfxD1xbaWm70CMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qEhb+crZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qEhb+crZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHnDx3YTFz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 00:55:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82E2D40994
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 14:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68515C2BCF6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778943342;
	bh=zgRJxzLEDtFowP5Q3FLxvf4LqLwGNm2a9mKuXD9Zaog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qEhb+crZVWpFSoMJkfE17mxXWAzwvuF2DwD+aZszAZGak/959iNHmpSdByoNdfep2
	 GuMpjP7R7gyux1hm+iMvKzDlJz5Ol9mroe0QvAGJc5DXD723vGehcHse+F7dTnilM3
	 OyrDHtWo2poS/Dyp/rJQwtQCX5AfTCcwd/KkUpfuO7zGeQ7Hjzvtld4mqVPOUgf5/6
	 V1OhJYR+mhKowmzmpOMJu9qJrOEkiQWHzzDGOw9sMg75s0oJ07pbB3PWzA8u5nx/XX
	 yne2VJKPYe+phDa9PR6giL8altmSPMHFcVo8ymThu7k3KcU4qMOH/3CQjsyNrICyMo
	 /h76ugVIQ38Nw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso814257e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 07:55:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHYLmq9LCAKapZovOzB1Rcb005FBUDHfGWr3YNvoDJSMmqVEvK
	65eOHglYHWYz+oMwnDhx5z19VXlfe2Y5D+C+FFZk+hn8sOH3qp97CF0rcVbwI9rIDSicfbAcMNL
	FDInZ1X5m7Ll1R7A/M7znP5yVKvizRSA=
X-Received: by 2002:a05:6512:3c8c:b0:5a8:84a5:bffa with SMTP id
 2adb3069b0e04-5aa0e6191a0mr2379623e87.5.1778943341081; Sat, 16 May 2026
 07:55:41 -0700 (PDT)
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
References: <20260515231913.1154801-1-rosenp@gmail.com>
In-Reply-To: <20260515231913.1154801-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 16:55:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLnuJDs=Zkba5H0L0Wrny+Wej2YLTWF9mCrb1PBownw=kA@mail.gmail.com>
X-Gm-Features: AVHnY4JPwB4FkmhmuViVtOdAMVQugTpjJTOZnsGDTQudk_nd3IvSj6bSowVJncQ
Message-ID: <CAD++jLnuJDs=Zkba5H0L0Wrny+Wej2YLTWF9mCrb1PBownw=kA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Set GPIO chip firmware node
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 1:19=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> The PPC4xx GPIO driver stopped assigning an explicit firmware node
> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
>
> Restore that association from the platform device so OF GPIO lookup
> can match phandles to the registered gpiochip.
>
> Tested on: Cisco MX60W. No more probe deferral.
>
> Assisted-by: Codex:GPT-5.5
> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platfor=
m driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

