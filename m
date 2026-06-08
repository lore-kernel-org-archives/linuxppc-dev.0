Return-Path: <linuxppc-dev+bounces-22292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00FECD6E79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 22:11:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ5pX5nDjz2xSb;
	Tue, 09 Jun 2026 08:11:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780956660;
	cv=none; b=NlbVzwMNCwdeweUoIWmOTJqyXZ08QcxfqQtghEL0B8vQP1wkg1VDiS+qjgjv+QiTv06Am4EtGKZC97vr9XPqx+8Cib4uR2oqYfJauCrjUmR3/GI23OHX7aCEKUc9HxQVwFiT/8+7UIvrBtecX8rCi73oiuWVC75frTItbR1UzCOGsXq7bWmmgmyHHK2tbKTgGxtITcntnfUj2dt0vDNlh8TQR9ExyDtvrnPHdT+rEiv8OV7Gkxn9nrBix68yy1LjZ0Okp4IQdN+J5xO400HufEOUhzGbPwbP86V8+zdZAEUf2IYkjhNiktwo+LA95Ff8kB3EPaH4mIrHdhrw5uW9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780956660; c=relaxed/relaxed;
	bh=yl96KyAOKI/KCR7Eg2tTmR7DWCsK7ag3KqvU5NrC8HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqRwVHRUo6umkqjsOfc16Gu3CPeaEiaJmGkh5iGELPYhZzKmMibrrESIkhAplN1M8kj726B6QxlTRIxziW3J7uCi+jTf/ToKfG8FoKfrfI0W276BKju7X5w2cy6v2iW8N9x9LmP/LaKMT8bDlQ1UEExvhMQxJJmqnLqAbdubtUpRPvkgbpMKGb3lLIq/Q47bLy1rggLyXWZqWVud0EM7jMaxqYm79E+NziilGJN7MM0fq9bPKikxz2CojCs/KZBj4tW4xMsmE1+FlHGWfeGEgLAtw75mxiqxfNahqN0r3xoc1Ac5znP8Nfxny/BkDsXIkebASUV4NrIMsJTr5kfmvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUwJ9KFg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUwJ9KFg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ5pW5ZJFz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 08:10:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9A4943C62
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2026 22:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5451F00899
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2026 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956656;
	bh=yl96KyAOKI/KCR7Eg2tTmR7DWCsK7ag3KqvU5NrC8HQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZUwJ9KFgnAK6m9dBqc2JIJifbdPi14k0yZE5bTJiaFnBv8v85Zr+JrQTYdBhB22Td
	 2ikj2E2mGW7ohOFa5D+fUwffgD9IW4rp1VV9QU3BYMKvLUEMLcngBZoQefkFVt0s7O
	 d567ghr+NC8YFDaRbp+1ENESpZiVhZYkW6r+lubzI8zI/F+nJgbaVvB02yV+eu2P27
	 seqUx+nClvRk4mlTaWXn0Vj872Smh+5dr8Lc6RyYPUgH3Dqg0z+mHPsFk0NMUyBJ4M
	 FAW0jMkRl/z9RYIiLyZsoDKCHfhffBk5ywUUiL00pRsWP74Oe7c8Iz6Tn8t4wyWVs3
	 VaKoo1NNwdRhw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so4860529e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 15:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Zz/2IB2/9A6OhxWjW7xQBiKE9XzFpBYnHAliE/dfg9t79eHhLWMO38PIxSoOMTEghUm99a/5Ra2lPQc0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylgwqNZcI0RRGhMfBkaRsAHLQkj3ai6vtLjsVjlq7gX5YVtbJn
	aYPBX7YgS0C5swQef0sdNKk5MfC7t6m/3IQedPI7AUTzrjN/30b7wBR0CFXb45uI4Qop+Zehi9E
	GYA0nIRUFgZJBZLa+7iLu91znl60hB0M=
X-Received: by 2002:a05:6512:1108:b0:5a8:fc25:3843 with SMTP id
 2adb3069b0e04-5aa87bd6d14mr5212366e87.39.1780956655364; Mon, 08 Jun 2026
 15:10:55 -0700 (PDT)
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
References: <20260602050131.856789-1-rosenp@gmail.com>
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 9 Jun 2026 00:10:42 +0200
X-Gmail-Original-Message-ID: <CAD++jLmk3jMFS0DD0GGTV9AWu-oHJAoxymcyOKQycVFqKCRnzA@mail.gmail.com>
X-Gm-Features: AVVi8CcbvxAfF0YZQkWVIynJTrTr8MpcRrvWZwvgNzmeRyxUg8684sKBAKbCtpY
Message-ID: <CAD++jLmk3jMFS0DD0GGTV9AWu-oHJAoxymcyOKQycVFqKCRnzA@mail.gmail.com>
Subject: Re: [PATCH 0/7] gpio: move ppc4xx driver to drivers/gpio and modernize
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On Tue, Jun 2, 2026 at 7:01=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrote=
:

> This series moves the ppc4xx GPIO driver from arch/powerpc to
> drivers/gpio, converts it to be a proper platform driver using
> generic MMIO helpers, drops architecture-specific accessors, and
> prepares it for module build and COMPILE_TEST.
>
> Patches 1-4 move the driver and convert it to standard platform
> driver infrastructure. Patch 5 switches to generic MMIO helpers.
> Patch 6 drops PPC-specific IO accessors and enables COMPILE_TEST.
> Patch 7 adds the missing MODULE metadata so the driver can actually
> be built as a module.
>
> Rosen Penev (7):
>   gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
>   gpio: ppc44x: Use module platform driver helper for GPIO
>   gpio: ppc44x: Set GPIO chip firmware node
>   gpio: ppc44x: Use platform resource helper for GPIO MMIO
>   gpio: ppc44x: Convert GPIO to generic MMIO
>   gpio: ppc44x: drop PPC-specific IO helpers and rename to ppc44x
>   gpio: ppc44x: add MODULE info

Overall a very nice patch series and happy to see that AI can
assist with this kind of refactoring!

I guess we should provide some slack so someone from the PPC
camp can test it, and if they don't test it, then it is abandoned and
we should then just apply it anyway.

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

