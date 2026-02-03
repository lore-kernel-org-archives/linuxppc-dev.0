Return-Path: <linuxppc-dev+bounces-16542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89276E83060
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:32:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4xZB38w7z30GV;
	Tue, 03 Feb 2026 19:32:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1236" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770107570;
	cv=pass; b=JMneVLdAa8rcatznpw3HGE1omZ1CuA0ENnDa9Qo+6a9hQaOT1LiX9NvPn8Yr1+XjeKsYHKfFyjD8fmUBtUcomrSoG99yIpZCQduBoDMJ15cCIuJFRcehXqHZBnsYF9wokof7NIwR42s6MRJz0bdHb5e0WUH6BL+XFeF2paJspC+/UUeLtaoYKoGfTaBO1fBwF/wgkQqRvqyEVo+WUOIOAAyoQBdWnXz+iR9MlX1Rpn03+jm1FxHJ/ebdncn6+BU5bJlX1uIcplbfVg04707chd5U2q/8dlCxnMIHaNhBeSEPpIUSKU8vSiUV6f0TqmQ8fyI+AOaih5jiwntmjtiExQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770107570; c=relaxed/relaxed;
	bh=ry0FHVTHq/pJe0PrqW5meMtNFTvAS6/0OqoEfkOx9WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwEwP9NhlWDOq9UjC1/G0/qa1ZNU0BC5e/yWbBS3xHbn5xkKcCe50sqFdlcX4BWbcba75r2gtpsASQft3fqeR8iB1WPYPYDB6BgxFbi+1hCkqdfGP6HvTXUc07z1ykOfAU5szv8ckhJm3Tipdvqcqf6i+Ddkavt6dDuWdfxpYdK/Q1E/zLqV+gkINjt87hECY7raotGQAyrEEpV5AduHau5BLH93g9Xaug7h6+PduF6vY7sDn8er1EuBsx3IFKse8xiiRw4RFSm8frQL78O0weObyRvx9OJnQBvrcOn2uDsk45NtOXCEjYIHCFqjwSJSIRNH8OrUN68kaan6X5DMWg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nAbxDQ8U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=daniel.baluta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nAbxDQ8U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=daniel.baluta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4xZ90cSMz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 19:32:48 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-12460a7caa2so8127397c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 00:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770107566; cv=none;
        d=google.com; s=arc-20240605;
        b=gXUb555ww811UABGNDZsJSiCKmaB2NvSV/O7MvHGLQUxkhBpBvCuiJrQuyhwNxe5ah
         4yCQgVEG/Z0oOD0xmkwiVr+5QrQ2dqiItlHgihG9foIYXaPpum7svVScIKtsilM1iisq
         j3Rosbxpj7VWEh/0Lg4z4iLTMZ38pYTnv4oWUbmxG5lS3qD0rh6aLMX5GCjaMNZGma4h
         uBAEifiCfbUNsNXh4wJJjP1f3lXyKrn0b7yXxATnfMQFupIZhRlDKG7qCIvSHM4slHQC
         PHoMp/PfXRYLt0VKwZJCeF0/1Unq7KtvUM5Xcwcl0JDJCiDJzJvqKFxjRg6YJ/SHVDc1
         E2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ry0FHVTHq/pJe0PrqW5meMtNFTvAS6/0OqoEfkOx9WI=;
        fh=T5RKsLiRPZPaHw/ZuP0BkGGSJhp7fVWOfrgiWM5F0CM=;
        b=RpmoqzszD5xvtH1bIxobX87ohC8kSh2nMbA1JofKAOm3fWM5K0RCrmv++62HNLuHl9
         jRJYCiUD2icHNDTxCCr2yjXy5w1XX/00YHJXQ2DjOXU8bEvAkK5xukyCqmPPG/5z3HRP
         XI+TO8yWVSqG2yswSzo7RO/Z2SFcGKprZ6dXk/JAucKKQi2fZYdYjKoQBxEsgIyBgv0+
         hklhl55ScI9YANIiwKwkLpCaNMD1hhSfwyqEMLZtSkqvk9hr0IY6XBoZp2iIkt6U/pk7
         T+Hm/CNZJhOkBxfCZ8fHLdGuVSAYJMcQ0ULzFegFFiOUazzrujrG8w55h3RM2vsEky7q
         Q1qg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770107566; x=1770712366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry0FHVTHq/pJe0PrqW5meMtNFTvAS6/0OqoEfkOx9WI=;
        b=nAbxDQ8UPfOyKLN3bKrxEx56zlRYswhaeZNGxwdkhtE89Dwx9P6sTW/hvV4g6JCa6i
         nIVN6KY8NM5YdM+9kuchVhPApKP/ToeHW40O6hXTueGXLIauh5/1v2gUfTgNaNFEMreD
         O1vJ35JEo9IDP9uyWThre2J1fkwKREEocZCasUcxCgDg173JlU6cYwbPX7ri2m1rwayU
         YALZgfbrdaK8aX9N5m3w5X/AXy3KBMfER/Org8SwuKcKMu0iCPQbRR/y1nyK0DIY2XEJ
         QEIROV//V5NkdQMqdQKsNLFlrSBiYCFvsjGqHdBd+RYhH566JtBHCItI0XxA20Flv6ea
         qTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107566; x=1770712366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ry0FHVTHq/pJe0PrqW5meMtNFTvAS6/0OqoEfkOx9WI=;
        b=Y8PNn1ZqYZRhJRg+CAtdNj1do+NyTj99UH/TDj6VkLzLymP7tdcF/LlC+gq+5BgM+P
         KHDICQHuYXyc1gAeN3vv2+gKPlvxp8FlAUuQldEQhTsf2GeGq14A/mxfRgzzhdajsRIm
         9/PbMT0MPkWkXIDbvxohY7EU1sER/1PWWhQDITJ6oBOh1LIOJrw21X/niTp8ALNrIzNS
         7RFzrBPTjVUw0awYTVzKgpw0gnNDfYDT1ugAnuj5+dB8SSZPk8A9lyUSekFwZCGEmNTh
         laSoT3QEUX/CN546bpX5smF3Xljj6Mbjg7khWXz1pMxSLNUClfgax00ZYf/P49DOwPZe
         ZWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWAzCodM+RHtnZyXF6dcE+idQOFAdL/lKjHXNhdo/QXXIErnhPikGlwwYQimesJ5tWNbrM1KTGSmeqqyjs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxff1lVvWtsC8ATwdB8w4/NFXWdr4nF33dsM4Q7QqeqGL/nUWNE
	aI6CJcxCROn1OKx6VFq8LZLJwHponSZbwgC6dAKNLNFhZsyD8jgX0lNcfBYxYAcI/LcxLfLKnEP
	b0HV0ItmOsenhffEvuPC4nuqPMia5KBY=
X-Gm-Gg: AZuq6aK6w+qVtb64XZVWBsUUAlCvXx4dXGs87KcJA70pmdkPB7G81DiTgOmiUemQ2qp
	3pFaMlPIV6kGs43UaCDO2c7it+Jj9xUpqgu/CAPI+iWNu/BpEovMpoyTyzsC5SZlF9N+K//IGrG
	QhlTraDakWLc+84PaW+/FyL7qV5Z/+xaJtYjbN5+4lVgIDxTE/8ck0ohKS8PAcBaVav4+obX8EN
	AK9mGQVvYQ7PU2VATorxf26V6aomhAP7IGStrOrvLGPvb9GPMHvGKL1VAtSk5cUUrOq7GKJ7vzR
	9bwsssKa0PDhps1tFLuEboHA0Q5gBiNoE72f+F9hEIsKgCaKXP7vaK3Alh6WGb1vPsxvWvUqEdB
	NwU7m9irseA==
X-Received: by 2002:a05:7022:160b:b0:119:e569:f60d with SMTP id
 a92af1059eb24-125c0f8c302mr7264388c88.6.1770107566507; Tue, 03 Feb 2026
 00:32:46 -0800 (PST)
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
References: <20260203031345.3850533-1-shengjiu.wang@nxp.com> <20260203031345.3850533-3-shengjiu.wang@nxp.com>
In-Reply-To: <20260203031345.3850533-3-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 3 Feb 2026 10:35:27 +0200
X-Gm-Features: AZwV_Qgw24M2z0kseZy1hei1NjvsOXkgK0vaXVyKxBbNrRS-X0jSjdoVh3qv9-s
Message-ID: <CAEnQRZAgjyKYZEJ9FVqRsCfzLOqwbRZXahqMMNdJpP54NAQ1PQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: fsl_asrc_m2m: Add option to start ASRC
 before DMA device for M2M
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:13=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> There is a limitation on i.MX952 that dma request is not cleared at the
> end of conversion with dma slave mode. Which causes sample is dropped
> from the input fifo on the second time if dma is triggered before the
> client device and EDMA may copy wrong data from output fifo as the output
> fifo is not ready in the beginning.
>
> The solution is to trigger asrc before dma on i.MX952, and add delay to
> wait output data is generated then start the EDMA for output, otherwise
> the m2m function has noise issues.
>
> So add an option to start ASRC first for M2M before ASRC is enabled on
> i.MX952.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>


Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

