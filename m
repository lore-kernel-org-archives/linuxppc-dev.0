Return-Path: <linuxppc-dev+bounces-21998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD240CD6E68
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:20:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWHYt2spHz2y1Y;
	Thu, 04 Jun 2026 18:20:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780561218;
	cv=none; b=Cxa68xLCwaEt7z+TLIvYpaf4k9MwL0IQObZQak+14Lrla5iKLJuNImaPJBWcK8m5sagv/+6OQoZtpvrbdXTxCzIsClXR9pmlLw7FCA1EDdQo2/FJ1OJ/eAf84KjRVMow35xQqaMUplcUpkXCxMOcChrcTsRqQTvEnReMoutvtFX54pKk/cWoTSej2u2DAEefgr6yXAWRwqgyLa4M6rjxGSiB+PqUEUt2O5gyZYOGzkJAHGbQwMxLQ7MTfwZVaqBp4+9oEF6YV+ZV5IzsAF/M7A9s3zpDUzpcZ5+6oZNCvwrfUvbnjPbUtbQiYtzHcmDtsRqqXUPEC7orNCTXwdyskw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780561218; c=relaxed/relaxed;
	bh=Tz1t+xbkaHzNyGYZ8QczxzF6igOnGE2Og4Cr5SOUj/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol41BW770DoZzy7juM/L/ddGO6cKvR3BPo34yt3NzhzEWkey8bVnW7Msodn0P2aYqWxBI1x2UDI8aCuuPSu3bLmj/RSM5Yn7QnS76qRPdS8YrVP/SiPYz4MWrO4Q0ze5aQf0rzVqFmLjK5Fal1fJ8QDBfvbdYGY09MABjQU9PEQDpNHzixgTWARcbBHvH9/IAlLM5Kq2YGoXiOd2sdRZ++5wBsRVU9IhceSSVz6OGYCajttxj2eAueysATHSU0TalbD6LJoZ+BRctCyh9Bly8QYbMWpZ7Qhi3mFok1ufnvlY/MTSt7G5eA/apO9QwG+6/LHvRzoUEn/uut23o53rEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTBjid6p; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTBjid6p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWHYs5jDZz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:20:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DBAC8601D6
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 08:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950121F00898
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561215;
	bh=Tz1t+xbkaHzNyGYZ8QczxzF6igOnGE2Og4Cr5SOUj/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fTBjid6pIuosV4e8R6lPetOV2dH7lxq/T5zbVqQlHIQKAwNfe63HNOThEbabEkEMz
	 VTH56ZD3eDvrnjG0K5G3e8KlcDSRewJ926stxKGu4snyjObiEZ/xooKs3Koe3o/Z1l
	 TRzXruRNltb3ptO+W72QUjRPa5/trwoLdvTncC2N4EIBMnaTBO5wZxPDKa/iQ/dtYL
	 jBc60S5P/M0/4ATJi8zedKZjxzxLS+5AwIGot9dPjpHcpyilIOMAyifb+JQNaf49bP
	 aj4Nb7rsGjMJdqybz+kngVOjLLOtGOY+MvBTj41kchaNK+LedI/A0GVLJ2RKEV5rj2
	 yZCMcJrlFFypA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so208400e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 01:20:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8XcqlgS86Q8mOiTIVDEN2lIywbffBsgC+SAxF7rRhv20r1yjC/ujNhhdHI3MEdR61UA6KURK6M5Ghcy2c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGCtdZIOs+51v42IQO9ENz5z3NGrHEzdcNtByGUWhEjdXonIJE
	seRcUhzCt5/G1GQvY4uILXbqLgkYf/0ZtQUvlahb8WEO8oNKoeex1D8aSppQfN9G/Bv9xAkKxV6
	zHGaQ7LymSm93jG3v0TOVmUR+BXoYgFA=
X-Received: by 2002:ac2:51ca:0:b0:5aa:6cfc:a208 with SMTP id
 2adb3069b0e04-5aa7c09b983mr2472657e87.15.1780561214410; Thu, 04 Jun 2026
 01:20:14 -0700 (PDT)
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
Date: Thu, 4 Jun 2026 10:20:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLkxaohgsMiEdGRMY0nHJGcWK5wQMge3p3Teo03XeG4q3A@mail.gmail.com>
X-Gm-Features: AVVi8Ceml-RDzZwBfWKtfi2K8JN2CfSPBZqQp4CLD_TvOmhwVEJuRjqGMto0QtI
Message-ID: <CAD++jLkxaohgsMiEdGRMY0nHJGcWK5wQMge3p3Teo03XeG4q3A@mail.gmail.com>
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

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

