Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB36FC41535
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Dec 2023 08:32:11 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dUU5yJ9a;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SvVL24bZtz30YN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Dec 2023 19:32:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dUU5yJ9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=daniel.baluta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SvVK70fNMz2y1j
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2023 19:31:21 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a235500d0e1so256378666b.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2023 00:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702974672; x=1703579472; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5VFZBXoek/PmoENd13wHvQBkwNetTGq8HZiKbqScho=;
        b=dUU5yJ9asdjAFoxLPH8CK3e4BtDMDn4X/2MdMVYSVmaTfDlN7ovlzoZ0XwemWmhy7m
         uOhB5WweO058a6pWgyN4azLbhq2H6yuik+JvagTqmT4a+R5HkDESZMwwIH92gHXoSo3n
         arhQUqb0YMvgLt6zd8d40RQ30f6hf8mAlX1r7Eukw8Krbi2cj/WEgS8N/5H2OZmb+JwN
         O3iq814wHza6w+2SJG/lXMN6sS1lFFnWmhjrFuEBRRq50dg6kKjCEk02cvy3gIlzJmsA
         uc4YwpOmzmbbw4Y3oeJZgNcSgQRuPlhMoKqZOxqt01NYZZZO06zvwJpi1TAIxlqtxHnI
         7ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974672; x=1703579472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5VFZBXoek/PmoENd13wHvQBkwNetTGq8HZiKbqScho=;
        b=Njgei3GjrPDcB6LCXYIvMIsoC9Yz5wYuF7KgFmPhRy+8NBs7v/vcvH6Cis5WYirvTE
         qRlwy82vfjWzHzs4gde1NShpJzwIA0Caz4oxXt9tBB14XrFhZHfTAdpofygTvu2FF+3x
         u6eUcv26y7Zt1kbHFEb/VBl9JM4c1XMQ997eNDk+TyeM+UDD1EvrLBVYMBpKWBTLjwzC
         UcV4tnPwFJCnYukgtdZV1JtEICGNiJ0e1Qome+WqGPUOjBPt73iW4+YUpYrZmoDyd0NT
         BynRDibqkj9+mSr0wKBx2CwEVz1MLyWX9KngW1WQePI217ulSHXbdMdFRCYlSPzhJSgA
         o2BQ==
X-Gm-Message-State: AOJu0Yz1vx0t1CQCVT/1TqzOV+iDMaP9+KfHeV+VYkR9k0UwpN9Y1VEN
	csFxE6+gDzod3+biijlOqcA0tKHBnIpdH6VVlHU=
X-Google-Smtp-Source: AGHT+IER0EeD0F3ccRgxlejZrbYe3okE2GAyGDFMLJmQCmcEpMASztGNOjgzLjUdLJ3YpMtcTgLDZ6UTQoCoNj/9/Fg=
X-Received: by 2002:a17:906:d6:b0:a23:ff8:cda6 with SMTP id
 22-20020a17090600d600b00a230ff8cda6mr4758403eji.75.1702974672002; Tue, 19 Dec
 2023 00:31:12 -0800 (PST)
MIME-Version: 1.0
References: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 19 Dec 2023 10:31:00 +0200
Message-ID: <CAEnQRZDHrihcP5TGLWKTYW=C27XSrBis7pLd2nMrQ2byJQhAJg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, linux-sound@vger.kernel.org, perex@perex.cz, nicoleotsuka@gmail.com, broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 19, 2023 at 5:12=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> When flag mclk_with_tere and mclk_direction_output enabled,
> The SAI transmitter or receiver will be enabled in very early
> stage, that if FSL_SAI_xMR is set by previous case,
> for example previous case is one channel, current case is
> two channels, then current case started with wrong xMR in
> the beginning, then channel swap happen.
>
> The patch is to clear xMR in hw_free() to avoid such
> channel swap issue.
>
> Fixes: 3e4a82612998 ("ASoC: fsl_sai: MCLK bind with TX/RX enable bit")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
