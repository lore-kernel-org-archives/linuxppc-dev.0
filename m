Return-Path: <linuxppc-dev+bounces-25853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AACC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:41:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvL96L33z2yqd;
	Fri, 14 Aug 2026 17:41:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693281;
	cv=pass; b=jR3HoetPO1BTUWqFCSDToGwkgCplf13ty1y1NrKuNTJ7L2/ObT/2omHBij4xHxt9Bd5m6RYfIJ97sjhipYKrdK5FDsF7II+RL+IMLqTeNL6xzmWYmv2oUhfmMWA/Cm8qyXi7h+3y//PZnA8ciddes6oKmJXVBw20xw7B6+QhSJwtCsVyVhTxdQtcp35/OObTunf7YYB/wq8FHOzu4L9Rmf86YiYmI1jNs9F7cLtAIcXlFHtWyE3ezoaagTh5WlCD2dMg658qHz8eR9p8YGiQzMaTlaQfteBo/sT1qy+KdMORpSCr/jKtjYoZ28dk6q6nkqZORO4XTtpNUGlyVC7qRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693281; c=relaxed/relaxed;
	bh=W4o1ZmlBfyrCH3y2jdCkwEByqgWhppc/8xEUvhcD0rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSX0n+ZSkoZDAtuty/vlfOyDbqDgH1YPUrGC8GeP2xAivlqDGzdI7TsaMgxEwwQCj53Pa/Zgo8JZISBtq9yXd2wSaha0SVJrxKx5kK1xJwRn1v+ySrLEAr0G6nyzf+OtKKDQi2U4+FTcMMlkoVPMaE1ZBKhgKn6q0einFFN5q2cTMDNOxwHT7eol+ueIjTQvf74pOeZpXBbWLp+ixoU7TJ+cEVWZP36CMeFlswEv3vjBz1J5aZ61uVVy13P+SCx2bOFdcJDsvVdUl5vOW0kHSxWveaJ8l79NDtc3n7ZKNLKk0DqNdpW9Yrsa/vz2FvQ2pdY7+ub5B182VkCOPiaQqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZgcoM6x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZgcoM6x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvL82tHNz2ynr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:41:20 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38511175ad3so682181a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 00:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786693277; cv=none;
        d=google.com; s=arc-20260327;
        b=e3PEe7oTUoP+/jOUK/WsyPmRoGalk7nnZuWGRX6xh+WRrHKV1wEC4f2volXJr/Cf3l
         cWXzYdcCdfrG8nKNacDDK5ma7IKi2L0VZF8pdgRpwRw4GQgDVCuAqoZ23UdTg/djmWKI
         45PMQPj0SRnBCpOqM+uxJSA24uUpnEE2cZkHYcLTfhKepb6HSGPVoMa7wMsknIghnRcu
         pe74Sr2KaDXcmn/KpIvUzaQqD5BHuxENDYinfv8UaiqU16Scz/KgMe7mhNDGpdKE1DDf
         N12P7q9U1ExJ5BPUk+myE5Zfj+V8RCBcoSFvVf820abUyovGcyfgNJaW83ep2S3tjjWW
         WvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W4o1ZmlBfyrCH3y2jdCkwEByqgWhppc/8xEUvhcD0rE=;
        fh=iC/3IXMHn7bUEVbQmjihQYphC0PYS84p2nGX7QT6Wvk=;
        b=PLOagn86ElHxiIn0uXAKZfujPbKsDukUh9fmnT1waL+SReyEpGjtQp3zPEe7ofasY+
         iL95NootnKtnuOKNCHCaZtrGRO1sq4hl+1pHE8RzxQIoNkOetDQBBngalva3kkiGeX4W
         hRVak0h10w6rOYUgIK7qlQAftOgyG092Mh2+vzjku+p3p0yVGkv1Cdg/nx2SkoiNZawI
         xzCk2KkUkyq9rMqpUjMcRdY/zt3DP3NwSB0QafSMrAM7JNqH91xbQwXZdmJg3JIbAplo
         NCWkteP26Cv8JIFUI3dxtOjUBm1H9rO8JZLeXvr8EnmWDyRcZemMdLgwkmVkSlL3jSyB
         gpjw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693277; x=1787298077; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W4o1ZmlBfyrCH3y2jdCkwEByqgWhppc/8xEUvhcD0rE=;
        b=RZgcoM6xn8I3rODNvZZAWL5Vk5Ns8bt8yoQl+IjYwi1qoC0ZOsFl6ZBfSH+LBmkMd/
         rhlUf6T6LJic3nbyTC3kXlyPLWj0labO0vkFSSAzE9DoWeRLXdxyy9aT2/2/pO0Rd44y
         hqiIc/lmkRVjlM5Cxn1uXhfiB2bZKvEucD5R5uKUKaZzzb3oiRr9KCr/VwGw+doom+A+
         rzPqt5ToGhvc9HAAe8O0U9S93rK+NRPNCKKJgqUEte78Q5ai3dGRBvFR2jiKoDoL20aM
         gmz8sqFLRjvkutf15ysbNhLG9xmvNgNhi8nxOxFW1y5ajTwfYHF2yYZ0elnJSDaSNE1E
         zKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693277; x=1787298077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4o1ZmlBfyrCH3y2jdCkwEByqgWhppc/8xEUvhcD0rE=;
        b=dEbIywHyCdhM7R/KP2/p4WZMKTJ0t6Ecn1BQtZ/sZf4Y1ipTtbS6ndVpIPPSWv4dy2
         3FsivVrPkODqPkx5HBC9Z+YLXGqc7EeUglQVKNMxX/i1GNcSbjG4kB5wymV0z8AlbVx8
         TpQBEyWHkmEMKp0JaaY5vC1z2GQ79hWo+17j6MKPmmwGc8PoaKOYiWNBMDsWe5oO9geT
         2q5qxqFATMSO2fJW9kyVTNDDPYv4GhijV4k41tVzxYzumKwUEhME5XMg2m5atMBeoELE
         gJBi3umVWdc0d9M2Vfvul2R7scxZfWPwGslCr4mYaMzu0w6a95S3JAXgJLBzV/IG2Qq4
         eFqg==
X-Forwarded-Encrypted: i=1; AHgh+RrWd5vlJRan71NMPjtHgUOjb7AuVPHv4nRTDsxmRtTWXMkKxess9wcLqjSEqrt0t6JU8fZP0FPnD1FB50Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPBlsZfQIOoq4rDhv0K9qkTYS7Iq7nH7TCoTgmf7C6UEKHkC0w
	NVXNeftg/DSEt+1eOmnrKsV2Qj8GrpsUJ5rB4ZwV4O9bU4g3lHfXUwn/VTR3Gzm15wYU25PDNK8
	qc9JIN91ymOSaxPUq8XsbKiEVwZ5cOBA=
X-Gm-Gg: AR+sD10Sep3cW82PiL/aP72J7teKY9jKMk6y1cgm1IfArWHGNADpevlaYUqli+56XjK
	Vf5L7dpSjMsalSoAuDhTy6PZbvz2KFIWtgwKzgx7rZ6vLZiVKwFXVBuyI0J6vhQ65pX9IONQhkc
	YtnzCj4iieBLDvHZbkn6SqZIm2yozj0Xoyd6aMpEpRvqqrB9WwTLGeE8zUl+LMBFZ8bMnzaiXaA
	aYEfTIMmkeHuyJW4vcvw55kZaYhnxCzgmerUxvGd234bfR5PWg/Ar2Zka4007r2+HRtCZI3o9zq
	7lCOtgWN4CM1hYeX8QM4wjyHsKp9tIGcuuumxRfKTuFZMQ==
X-Received: by 2002:a17:90b:3d8b:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-3933b77ece8mr4578497a91.1.1786693276690; Fri, 14 Aug 2026
 00:41:16 -0700 (PDT)
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
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
 <20260813070020.719810-2-shengjiu.wang@oss.nxp.com> <20260814-lean-classy-hyrax-60aab2@quoll>
In-Reply-To: <20260814-lean-classy-hyrax-60aab2@quoll>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 14 Aug 2026 15:41:01 +0800
X-Gm-Features: AUfX_mxVp0mCUmIh3cD49Kgp4iw4sN-NjfTifnUiJEeotRXNzWAYJPCWyxB1G3Y
Message-ID: <CAA+D8AOdF08PyOqQX6HTz-bWZmyB0bmKoW2DxYtnGS3g72aWrA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Aug 13, 2026 at 03:00:16PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
>
> Each one or only the newest? You will be getting the same questions.

Each one.

Best regards
Shengjiu Wang

>
> > The existing binding exposed only a single generic audio-graph port,
> > which cannot represent independent conversion paths when multiple pairs
> > are in use simultaneously.
>
> Best regards,
> Krzysztof
>

