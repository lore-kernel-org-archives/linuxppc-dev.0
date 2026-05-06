Return-Path: <linuxppc-dev+bounces-20527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3362CD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 17:30:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9j8b5SwYz2xdL;
	Thu, 07 May 2026 03:30:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778088655;
	cv=none; b=DAnaeJ7LlWxDhxWulcS8eFURkYYCdGXth91COiNrEyXHECa7KOFSMI+E54NDtNzoT/eNKe6R0lAoRVDwavP2Wa5PSuy9glLDanfX28/O4v+7C8RCquymOSP1v4d7bA9Vpq4UwA6C2thdvRgEjx6Z8fFffdiWU9VroAKjw6bi3C4TLckLohdqkX2KwwuFTCDiqGSUO6U39axPLC/LhlqJWHbq9aV4EGHYYHlVcYl1MAv2T+rTLu8NItnf+AXbnRbJ+AwooWFjM7G+/360ya7HtRZYGNS6f8u5uIBGUMRmojzXfvO9eyflEZUOnl6/Qqrs6D+fEsgJCQuhBVyJ7A/pkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778088655; c=relaxed/relaxed;
	bh=3OChlM+Qu2q9uUlehmwSry5EzI0yRics7WMFtJHq5U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5jG/V9ZWbXfIXEF+w3Scpy+xjeR2TtJAMLcCwJdyn338Z0JyT3U9NVHzXTRwpVaYZG/WU2qCypmzSjVdQfPjwL+0XfjxMKKZayVEnGw7eiOdQjm60PX7CK3cQ+UWV1tURl83VLBrvcYHBDrOTWEgrPzPg25XW3KQQyqCzHsWwm+N28xiOOKoCSEcOhNrzJ4aTCCTTLiLR6HZUCl/SGLwnOgvKI4PCceS1BgtLx0ec6YXarqeLbrdSJqMN4TaweQFi4WbSyY7dmwZCuSwAPDctMNXpIKO8f0UmIMXhMwN2vr4ROaSPL7bt0Rj63pP9Z5oHBR1Q8Be2+f3Tnam/V4Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=myhDlr5i; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=myhDlr5i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9j8b1M0xz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 03:30:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C5B86405FC
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2026 17:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B16C2BCF4
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778088652;
	bh=3OChlM+Qu2q9uUlehmwSry5EzI0yRics7WMFtJHq5U0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=myhDlr5iPhNdNTVF/bho5gcqZ+NqOMH5OhyM0R4aL9xwCl2a6UdpUdtzKNQurl7Os
	 /X17TkCkif7jdTqlFgJWNCzJVPZxQ5mUyT1Onhl3n6hFkKYPBuj0M0tGOnWwmO9pu1
	 GX3dhwXg7Dl4bVaaTqZAnJUwEUeqjyNldxLF5noxs//X27WN6TWlEZVyVDFYDnuIGL
	 ExhrT56eTKMker+rGb0qqfxsTu81DptgsuIwVK67BGZfovIYAkYEXj+yDuhogffmC6
	 ugnRBNhTCRYgj1qDxOnKuo2grYV6i2BlPoPwHQZrh/C4Ah38gxSOHUaT3t9CM/mLo4
	 WI5VqTAe2f/Dw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so5654187e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 10:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Rjl02uyhy5kdMzHgQd3Q621UqrI2fJvKKL1YcugHjSEiuYJO+3d6c5B3pf6RATyxMoOKdahjodBBscw8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyCS2QqwmSl96Pxu8dYT7ZK9YOSQUKHQiFonUKQFxHI8qCwhOzU
	QDEmyMIwiTCVkzbGEqUSNSaf7EOpYzsAat58h17Qy8x0fPrU0KgC85pzvIZ5FaT7zFi5D/CqOIi
	PXhIc4y50fA0T9RZO5+i4hUh/16st0q8=
X-Received: by 2002:a05:6512:3986:b0:5a8:5288:5bf with SMTP id
 2adb3069b0e04-5a887ce5fdemr1450573e87.28.1778088651317; Wed, 06 May 2026
 10:30:51 -0700 (PDT)
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
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org> <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
In-Reply-To: <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 6 May 2026 19:30:39 +0200
X-Gmail-Original-Message-ID: <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
X-Gm-Features: AVHnY4JMkFBGe8TxZXwKExR-c_33SSxSe6eH9zD6yBpAKvkRFehC2CyGUCoq0g4
Message-ID: <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Michael Ellerman <mpe@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:41=E2=80=AFPM Michael Ellerman <mpe@kernel.org> wr=
ote:

> I don't have any G5s anymore, but the ones I did have used the other
> windfarm drivers so I never hit this.
>
> You might be the last person on earth booting Linux on those :)

Not really, Sean (Action Retro) did this thing and follow-ups on
YouTube:
https://www.youtube.com/watch?v=3Dg-Ugfqj1ank

Including installing a contemporary graphics card:
https://www.youtube.com/watch?v=3DWPDd1Y0flSg

This likely means he inspired a whole bunch of geeks to
go and do the same. :)

Yours,
Linus Walleij

