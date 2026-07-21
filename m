Return-Path: <linuxppc-dev+bounces-24586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D618C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:58:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4BB141w8z2xlb;
	Tue, 21 Jul 2026 18:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784624297;
	cv=pass; b=khRaE/oefdEbngYD+5dCyGT187oqxi/BfOZrJiYeC56lgmd8rRsn5bsX4isePjdjUsVToyLpik6xAsbK8rQN38Ovw3p/g3+MLWwaUJOeK8StuSYJRJ+XxOGyUCcUK6lG1NzCATtEhI3tgLcJnLCqAtCKPEwiwmWJKNOgPz9ZQFXc6PMESHz7d8G49ulSYBbyA7iidBn7ynKgLv8SdGrVOnoJk4cARQZft3LGsDTj2QlxHUfpm0B/EcJxOflQPn/tAFxjogGE7c0ddW9G9/qEvHujiw9GFnDvvuARziL243VUO9Gmdj5X/ebDLI9odc/x7salYIjynsONGGJjFJXoog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784624297; c=relaxed/relaxed;
	bh=o3orbY6NhqfjfstnAFooB/Z50XxpaSPbmYmh8aGbV/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYvqIB4UJ8NqxmiDNz7LxBnLAztEcgIBGU8GVYvjSMnQahp16tird2Yoc/3mrYLSBe6xdfVHFNgoJz77WX/K2WnARaJhAUChHjMrYF/aEKc/anp9S2+1kx3XNjwon53EV6oiuBIztuPzb6XlT4KoWIkK4LfL2MhjW1bO6pVYopiNHWhT/dAoAcJPkDUfkWp9Q6V2zPIRg4jP3c1lqfXzchyE9m9y2j3vpJBp7UuBdY0labuOhrn28BYpdz+O4G28MzPWSgZlbD+v1uDlC6XZLKowkjyu7ENDidU0vy0sIWUziv34bNgGg6ZJhSz33TjgJf19Iz3LpOjzjT1BxQ/u1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rDhG2Gef; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rDhG2Gef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4BB04ftFz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:58:16 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c999f162c9aso6930788a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784624294; cv=none;
        d=google.com; s=arc-20260327;
        b=DC7cuzsWcV73JgKzUCvY4TV28bFPVkd2HUYPSQkNR37BsYeegvt6pVEswgUcO5Z4ZS
         g0zvvbbsDzmfl98gFeD0nNnj0HwUZ4Rm0LxeTNf0785O0o8Tgq/VkZS6RNMWu6NOEjcp
         zoboUuHIasZfDNQ5QOgJ4x2mc2KVfEwbxaU5iLE0+oZwSjlPPUNxNc+TBh7tfYVGLVSd
         KXavaStpPi3HZ0a9f4bws+iijPo1XKDkkMJVZkoNUsV1Y7Y8H5Slq3O793QZNvfmZyax
         RfM/KTXKgmncoE1jFWmRj/y0BqFD+iclwqbYR52zzoIwG+DywLdJsyAZ8+TMsfhRB1Xh
         8yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3orbY6NhqfjfstnAFooB/Z50XxpaSPbmYmh8aGbV/4=;
        fh=334i1whbKii9OsYWXLDPvwAFpRbW0Bap1sEZq0DRbLg=;
        b=jnDzSIGoRAvCqz16G06ncxBuGKf7FSrW/5sASx0kejn9KNvNeIX7hSNFEHc8zWc7sJ
         lz1AeByQqZ5IbfGCTK4z5HnEqkf4LtcSBweyoif+Rj6Ct4VK87dLTKv5oYGUMjdsFaRq
         hRg613F6T68d2Ht2zWHdIxKjkx+K58K5RdZ9V3rzh9B2kWF9HQ0b3YMmqiZ5yjpU+MAx
         MDZqdD9ROLyg76981SzZqN9B/37UjzF5Sgo11zky85rQDnESna6DSdIGtiSGHWARo+6X
         XRaF77pPPuwkr3efOMu5rZ3ru+kofb4AIfr2bXvW+pTtw2Us8AzCXW77VyTUFhZ+ad3z
         7CCQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624294; x=1785229094; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o3orbY6NhqfjfstnAFooB/Z50XxpaSPbmYmh8aGbV/4=;
        b=rDhG2Gef2WFTAhWZSWoaj+E84FJHyzMmHgDmWaCSoLqereKjgruOu8SBu3tZ3IqW3/
         5mqQVUIq7jjol2PR/L2Phvw/MUc0a1Y6UGAwf1iBcv9C3tXfdNZQW/7wZ+Y3xUHoSxC7
         Qm4WO6JVTvpOybNXXzJJ/wgB32frIDgT4NK0ekMwShzTrlOGx4CRgT1iuUEQAU0nuaZS
         bTR9V2bnfMEezVqHy7JkAZMDmueOcJnt4uNmNtgPA12CdyquCd5PadBPOEx1Y0Wpqx7j
         jcUEH8R+BZ6p5mvYdbx1alrxNRWBmtUKUWockHFlWopu9ZgwiALID/JzWYXgcOtYIDET
         MHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624294; x=1785229094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3orbY6NhqfjfstnAFooB/Z50XxpaSPbmYmh8aGbV/4=;
        b=Cwx+8hKPabMUsWUcBN1KJ+hl1mMUbWJQlszrMx6UXgymhtlTQB1JJcZn9OVGpjU7om
         C1m8E7roGVvHidiZAQgiNUkzcEpK0h/q8ho0Lf3WaAATDGXbmEUAJbr/O2cz/QqeMVs3
         Kz8AKmdRxAk2xMs7x/WgM+W5sLLbVkrOXBp4FfOnxkxF+hNR9ualX484rm2sTbkfA1kH
         Vt3gw65YWMQ3Rv2p0H9Kx/ckil8T/2eW20XP3XkrWUQupoJ9cwrP1sipcYR8AWQogKBc
         NZutNyozRdKDTeDsM7r0BYWuLBo9mbbldlxNu64D786S0h2wWFuGfRqq0AGjwNlAZ2r3
         2olw==
X-Forwarded-Encrypted: i=1; AHgh+RpmAeA4toEaptiLz29LTCtP8eL6obH4XpS+k678Mmhz/ZiOwUR4Jiph44VWw7xbOP/8+5KlhNOW+V5VsN0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7a0Q98jNsVE3CDxXuAXSZZE5S1exD3EHLz4sI9e1JR8zNj5e6
	jLWH3K8Y3Boo68T+r+i7E11iamcCZ5N26UZYTWANrWhywtK9+xJGCo1Q6SahdJq6Ooyd9MXfnNl
	NuNOzOJsOF+4fqdOyT1ka7VlGnqBOXAU=
X-Gm-Gg: AfdE7cm/enXLY/hZZZ9iUqyOLSzS0zWYakxPnJOMaByHL+jh6hgpYdDFDG5D1HrVfh+
	unXD63R1176Y5qOvXnKu2mmAEjLRpHFIBB12qhwuwOARxdHE2dfM5pFzSjIwKFfE/x04GKCRTWy
	ucULcB3SoisjSS7S0UpuWbAImOh5ZQCSU8pHuUpFT+oNAI3jr7x1mVRIumAUYVMLLgKWdf3JP5F
	0WALFVPOcTUQIb6+WxActrYZWmf+0DJFjX0KaRT57stzO6ENxXkEyYSBQB+1QprUJopgpVN
X-Received: by 2002:a05:6a20:734f:b0:3c3:6af8:ab24 with SMTP id
 adf61e73a8af0-3c3ad9d5fe8mr19173494637.56.1784624294467; Tue, 21 Jul 2026
 01:58:14 -0700 (PDT)
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
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
 <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com> <3ce4bfa8-b051-40af-9478-00540019680b@sirena.org.uk>
In-Reply-To: <3ce4bfa8-b051-40af-9478-00540019680b@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 Jul 2026 16:58:02 +0800
X-Gm-Features: AUfX_mxyjKglcWDGiHlL7pHojtmA7GYBRqbKLhdnlf4NA0C5KwDC9Zvpc1PZDyM
Message-ID: <CAA+D8ANTBSgzhEQ-fsj9jpKnOBKCQiJeY5pv2-zck0O4DTM04Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: fsl,imx-asrc: update port binding
 to support multiple pairs
To: Mark Brown <broonie@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:28=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Mon, Jul 20, 2026 at 05:54:47PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > The existing binding exposed only a single generic audio-graph port,
> > which cannot represent the individual pair endpoints.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Thanks for pointing this out. There are also some comments from sashiko.dev
I will try to address in the next version.

Best regards
Shengjiu Wang

