Return-Path: <linuxppc-dev+bounces-22295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACECD8CA7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 22:59:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ6tf0PvQz2xdb;
	Tue, 09 Jun 2026 08:59:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780959577;
	cv=none; b=l8C2KBoPuhFJ5KkfbIqe08ltaXV539mB9avtJ3Ck7CjWKLmSu7KdobFGrVwb4+9ouxKP3yaXAe9YnjGjFoBf3urgdbyn7Mle33xC5AvNPg8Zy18n/8uKx6V7O+ofOE5vXny6TO1hmO+tqE/mKB44eBSNFFzQCgrdMdX9ADlv7e/ZSkri8nNwSJYGqfXU8LTPXC/YwGkFpsPKDtJrr50Se37WlA/tM3G9GkPZgAkBDUlr252LYyDW1co6YWI9X4f6g54Lq30x/mqbJZz0o7ZaUqgEZ+ah84GkfjKbfqiHluVc0FjaQgoDTeb46dwPr8sYl0cwTGUaHjuQSs21fJCsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780959577; c=relaxed/relaxed;
	bh=5PLaBUKqZTYk5LOlycb0JBN0OKZWCStG5EVaUjFxPuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZPBtotdwoZ85m2C7V1uIv99M3yw1ajxf2KRTnyjsnLA7CMe9DH7whv+6tAP5DRg7uo96YRjM7s8YY8Y++/M0rGEj1ad0Ht59pydTdA8j86Dj3wYCtSkYKAp8TFPNYq0WDPXXMk50i7SXcyOQtI139rnSmwl82ksLbS6yNhDvdZm9ne0MOJfI6DT4A6pkUeVIkgzkN4TycRY1K71EdQ+2f8HoU3Ng0758wNRf0Mhp8jZVtnv+8Sir45y9FmCMBzWbfadRbNZA0EJCQe9Ti5sUIWbybCMVQ3Y4W5nYQDNcRs444cF6V/fRC0fnHYMTRxYQD4cIU73ZHfkCk799rZ6tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQJxBFb4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQJxBFb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ6td0Bblz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 08:59:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E4B540111
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2026 22:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1DD1F0089C
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959574;
	bh=5PLaBUKqZTYk5LOlycb0JBN0OKZWCStG5EVaUjFxPuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NQJxBFb4p5sUYDri68nzY8692QexR6IHxZT6p8XkGswr3jxJmVwaXyaCwHJfyjpeW
	 GvjSDwN/k5q3xUGBBnqE/RK/5JImEllullNQ4xTCqZBRHNHJG0JCFBsOeq2CdXcPiZ
	 qpVykYRtYISS1gpEzvLbvtX3lyMOwO9ZSnA8OqlKmLxohzeHlWZYiLfojfrJIgwq9l
	 H58056CqAS5yMnIWhZgzyl45CbF/S2DboXH5jERR4gd+9DpAJ5vjYhVN7vYdRtSxss
	 DnZIPqByLXsR5yfEXLEA0UcZ9LbPC0t1gz5MYEY7jaNfCU0zsxTxvON+0kUkWOttMZ
	 2ZOsgAjLk+Sfg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso4855457e87.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 15:59:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/okJ5Qh3KTufOydKb40F4dc9ocEVyEiLvnGc78DBL0PGM4XSjo63Hvw95ogj2zla3nXgTpu3xZk1UuDkQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5vDV42BNOnxMpFq5kWsacbiSicpRMtjI4KC+N9GKa1Z+3Efa1
	BYzWnroBKN8/Hn4ronOXl7TV/UYBdOnL8TEIE5OuVXcqiBHZh8rZ7HcoF4DNnKdIkDQ4HWcZbDb
	DdQ5Dzjw5KYpiWEmsH74BHNXWGPyExCU=
X-Received: by 2002:a05:6512:1344:b0:5aa:62cf:751d with SMTP id
 2adb3069b0e04-5aa87bef9admr4425594e87.30.1780959573089; Mon, 08 Jun 2026
 15:59:33 -0700 (PDT)
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
References: <20260602050131.856789-1-rosenp@gmail.com> <CAD++jLmk3jMFS0DD0GGTV9AWu-oHJAoxymcyOKQycVFqKCRnzA@mail.gmail.com>
 <CAKxU2N_LhgDj-+-gd0_N9gQOzCddq7dypYhayFQ_09zggpor6Q@mail.gmail.com>
In-Reply-To: <CAKxU2N_LhgDj-+-gd0_N9gQOzCddq7dypYhayFQ_09zggpor6Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 9 Jun 2026 00:59:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLmFrbU9zUUL1FEdKC64tLyzQF0r-VpKyLHTPi96yXqi3g@mail.gmail.com>
X-Gm-Features: AVVi8CcRuaZwfaPCc4SHxkGITmv1yJGytK0CQnYqQOJ5k3xuZt3zkb7MW9gJGj4
Message-ID: <CAD++jLmFrbU9zUUL1FEdKC64tLyzQF0r-VpKyLHTPi96yXqi3g@mail.gmail.com>
Subject: Re: [PATCH 0/7] gpio: move ppc4xx driver to drivers/gpio and modernize
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:20=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> > I guess we should provide some slack so someone from the PPC
> > camp can test it, and if they don't test it, then it is abandoned and
> > we should then just apply it anyway.

> Hmm? I have the hardware. It works fine.

I missed it because it's only mentioned briefly in patch 3.
But sounds all solid then!

Yours,
Linus Walleij

