Return-Path: <linuxppc-dev+bounces-28555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C875CA5FAC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 13:27:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvwnb2Xwwz2xbQ;
	Wed, 30 Sep 2026 23:27:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790774835;
	cv=none; b=WmXRbzIGw4HgOy9yE+xLJvKzTv9jP9H1dccvOC5ehjbxuUe8Gpca+fGeSkfQrGHGcLVlw24Yf6x3pXtjryJmIU7RX9hnUyYpeVVQPfIgl8iEu0aPV7ScPJLQzhl0gq2kwIgFOnuSERuBUSgnZlARL5Ien9eeygeHhGqv/LfQHGcjPabJdxM+LUt6Z4vhYv6Ie9IQLtq/+bPsGiqEZ8AhuyaPKchalNLuL617zTIAADMLigNMrJDioFF1Sk2hlMw0WpXpfkQdS2TNEwTBy6zUrXfoB8VOI5JjZrmq0vYuj8yLZFA+P4wMmVDU4EjRBdvJxNSwpmwEPEXL5P405FAs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790774835; c=relaxed/relaxed;
	bh=OpSmVL4hqTjWvE1WR/oUH8A/JGaoOj3L6zfCJwDU9FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkP+9Buszj2TVF8DO14Kf8IJdjHOs+A1rW0rpbIgnKsl77ib3fUy5ELyEmKkjma3MEO/Z1YrtXKLfzXOknjKzbNAFgJVnDdKTdS/BAp4qzJ98e+L1pKnGAuYHnMqJsONqseO+z0P/jTE63xnoFEBJ45Y7MVUl+ASy6p7MC8R8zI7SPMbiDw28tNQRiTT22SE9q4dis4Yt3Xa6I+AqyurGWIVfI/Rr5PhtIxeyIuSB329imWc+bvuoh+y9PyBDSinMzz+SA+h9106nZf0JriHrc87n9jbdLGjrCi2ABn9C3Gt0Ujd0LaCCaUncuG/mz95NWd9nBof5DbFsipUb7VKTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He0p0C2G; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He0p0C2G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvwnV0NGQz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 23:27:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE5E143EA5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 13:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F721F008A1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774822;
	bh=OpSmVL4hqTjWvE1WR/oUH8A/JGaoOj3L6zfCJwDU9FQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=He0p0C2GEmvWcs3QascPblvBjga4iuGgh4pATvGNfHJPBwXoZSz5+rXqm1bNcaurk
	 jcIjD1SyLBjDKGPKdNFupFTAyobxtJ1EAWb2GHBrWexPkB56ZymrVpu1cd4m1O99Eq
	 zpK2vVJRlrhk9QKePv7sYZ5pWg1Wsd/MjD5VUryPztPWjE1xViUCmtDFViUhcBKI4d
	 JGPCyhndt1THNfsOJh4a/rteMDVrCWaWlaauLWUBKhSQacYHaRuG9cxGUxBwA61//a
	 t9nJk4bTk+OlpGxp4AykifQhcHs3nEtC6HDj+poWtdfMuPtgDvB2RDpheI0SLu/jKq
	 2w01hRV4BvDag==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8eacb7c8fso4678568e87.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 06:27:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/c6lAALyAo7/rKl6X3ZuBaCbwDojqu0c3WIsHEtgYkpvENE7E5OvAvSTUm8fRfL0eJ/Fd4x8z57YTjLM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIwopS4rupdBMZ3HQmD9zoYwreqJ41Ii+NjIWRCW4DoyU4w9oKo
	XRpHQH0yiODCtlW33KuwALm32hVG57qmGZTan3EpmxQJe/cldi79C0QbVs/zv4uicvKZOIMkBRA
	8ovN5yVwWrEa63DZhjiRMJSeMKxlUJaY=
X-Received: by 2002:a05:6512:3a8a:b0:5ba:36c4:c953 with SMTP id
 2adb3069b0e04-5ba402b8597mr589624e87.8.1790774821501; Wed, 30 Sep 2026
 06:27:01 -0700 (PDT)
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
References: <20260918072852.501420-1-wei.fang@oss.nxp.com> <20260918072852.501420-2-wei.fang@oss.nxp.com>
In-Reply-To: <20260918072852.501420-2-wei.fang@oss.nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 15:26:48 +0200
X-Gmail-Original-Message-ID: <CAD++jLnFo1yd2AXyu8XdZ5VV4RooXGP1xEXS9vtAsoSfwPKY=Q@mail.gmail.com>
X-Gm-Features: AclHuK-Cq3rn8OBffcZs3OkTTOIAYyYq7qYSn2XcIAzlvfiwp3W9Cp7NWkyTaAU
Message-ID: <CAD++jLnFo1yd2AXyu8XdZ5VV4RooXGP1xEXS9vtAsoSfwPKY=Q@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/8] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi
 for 64-bit register access
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	richardcochran@gmail.com, linux@armlinux.org.uk, wei.fang@nxp.com, 
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:24=E2=80=AFAM <wei.fang@oss.nxp.com> wrote:

> From: Wei Fang <wei.fang@nxp.com>
>
> Replace the open-coded 64-bit register read/write sequences with
> ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
> netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
> them throughout the driver. This reduces boilerplate and makes the intent
> of each operation clearer.
>
> The high-half register defines (NETC_TMR_*_H) are kept to document the
> register map; they are not used directly since netc_timer_rd/wr64()
> address the 64-bit register pair via the low-half offset, relying on the
> hardware layout where H is always at L + 4.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

That's neat.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

