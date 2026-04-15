Return-Path: <linuxppc-dev+bounces-19762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1892AF4198C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 10:39:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwd1L1bN2z2yvL;
	Wed, 15 Apr 2026 20:39:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776249558;
	cv=pass; b=C2fSaWqslr1wlfNUMz21WUPevXqFqnMFt/c3tuRb962Ngs7kG7XI4qE9Y5hCmkD0ZnXGkROnmPXu1+eLiG2nKgBP4WN877oflZsQ26J3Dln1Hy0VyP8Drik+uRT6w0PKL9EJK2ETiyggR67NI3b7OjlKD3Z48XRx+TuaYiClw14wnAs3M77zcRSjWNilxWScRCfhpga1n7J6G6qRrqew9T7LJXXkP91U/8697CC8TWxwHNF2pRoiPnsdHwKzHzv9w/pyO7euBcEvDnxiAFpS8QNGpH/hfYH+Aae1wrTc2I370raHVAHNS2dnD2+cl0lpFka2IVYDWJXhujgC+M19Cw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776249558; c=relaxed/relaxed;
	bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTUrHXq1own8MidrSf+MdNNmSeBLOOhw+45q0qDi4F/qoVik3e/mEl1wEj1kP7SF8hFeO1xzdCN7LTjx4tqqXWpsSX0MWW97SpTqP4Kzb6BI8g0kSBIGnCtyliqRaaT3OKW8y5oLakuIMBfQ7mMBFhjcGc72N6Yh9bOBIpmj+YCZ/SMWV7f1hlxZb/1dWbth3Lt50cULgFCLnmS0q1VhuJP4GtwlToUXv8TKv4nofgnNng5+gnot88hFiha6wN6HbnS9UEUE7QY46J4xUgPUTT18WlmAmYKITgFhEMD2E1n7K31vH4AeJR105TNJ+jpt4cimzTBFm8AcqtvxLxS9KQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstkquvC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstkquvC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com [IPv6:2607:f8b0:4864:20::b133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwd1K0nBcz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 20:39:16 +1000 (AEST)
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-65006c99d38so6781929d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 03:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776249554; cv=none;
        d=google.com; s=arc-20240605;
        b=Lg0Zt6R9tlyQiw0n3WGDF6IKAioSZiXuMwYE1+2LKn0SWbX2QqRPTu5aNpu3Q/rKCq
         ztUmM7qBwTMHryxgF6jG3bKatk/eYvUM8h0n/10zfpFDiLzVUJL/UaNEYK2qAu4cO2+j
         UCBuJW8douMs6wZXs1p9KuN0RArqO7X6kJJ02g+bA+6syyjsqWKpczMrEEVUd3F8UHOo
         uWNgOh1ioYsX+fuuhi4K1wSlWgnsuVj6TaOOqQZwC/XrqUIn29zq+TUmFApQyURR/FxJ
         st1Zwpm/HdKSkOihZCZRONVV5SOcjvc9/MhCjtpcsfpk6YXMOBgEPNEPCIqfPZO5PbvV
         9NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        fh=PC+rGgqj3dAu6BMShtr7yx27lRaP0ya52hWZy+pMCJ4=;
        b=Np878qRDNhmsu3EIzw52Xxgs+xMeH/aQj2iy/Q1FV7ilGDIrpyUYHrexg02uHiplaU
         QA0PMPxp4zGntFoBnOHWyAK1JofLIUrhF8plvEQF9rutBuDa1Tfqz8VPNVLnBfjp027Z
         cLl7scd3urrh42wxNmhsSsS7dB7yXBGNmPjr4QVhvIyMQ48U+79LdidZ+pD+75C6CD6M
         kUEft2fr8xRc9WFO8OIAoBCYyQrZAETPC6iPoXbtLGtC/mjepHzWIDEl7lk9O8Z+mawc
         oK4I5cOV9uUi+JjEryk0v9EWJYl28hZ/SGwUxPpskexnZPvLBzEVvIbYj1e58loDC91P
         fdgg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249554; x=1776854354; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        b=bstkquvCT9gf97G0C8lio92Yd/Nl372n/gr+0clEA0YJHosZdO+NbLyM1I02MeUhC6
         8oncpsgqvCNQauq4x4nSJKH9mVMebwIFX/OSnwQSXmnny7RIs1ZylUGmUkDIt+ySyG+O
         ZdDDJ75n1wRbybnT3976TgGr5W2QIAhVk8ALFLIvaQtcwK+lypfilDxHci7m8aHFFrqP
         yG/9amTMrAMrH4CN16PRzNrqnlGBJ4KzXVMhDaMMbRusUPtjYCvhVCB2tmPO8kktbXzH
         yNPjEj09Ot6TlHPkDN3H8gxdOLJOpsSpcGCn4dxT6UqUrQwDOLPrifuB+h+/d0dQR7+A
         PCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249554; x=1776854354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        b=EIMTNm7h27thzNHxxtVUWmpy4oyy1ETQkX8aYMZuISnCH2vxgLKP358K00PfEoz3HI
         TfczjU/or8O0b1GvZCOJafrpAVjL+tvh3yQuxBS/6iDuHG89PAnb8lmQMT8HSE/vmHLn
         dKukszAPLCO0m/PEWda2C9/hzTHycrS9tWgVzUcdist98Bh/abASpqyUXqSeoaz8sgd3
         6d4xF1B8Vnga1OjFDxxmKqzjLA3Cv/nAyeLpco5uDdZIkIhP+0XCM39neRHRZgkkPcs/
         NfAwI7EyNcpjh+x23qk1NlW0+AcCdAvp2zU7/xHF17P+NEkEzpHxh1BlPzb7ZuORNboi
         uc1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9H2BzT6PWtAbVIBMW812mo09epBU9xD4VC7qQL/pMt9X30gwKV53tlB72FSiJy+X2oLB8Ba20NWLSD5G4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw29497EMxiKjs77xnLtuB5F4N1sxED6Gmko+zFgnK1i499Rbeu
	95ZN7Uc5/BxVbEmb2Iw0vlYrhuPvISpKyWdF82JrlCvf4O+oxJ3brCSykbtZDL/z2Efx20ETJ78
	GlJt5BlTgXyRJB3jKq+7baZfdb7w9f1c=
X-Gm-Gg: AeBDiesYn/ht/DG7QgQRqzl2v9exEw1FcMN4wMnDsgvtbee4H98OmnFRpTroCGWfArn
	UyFO0kysOshe5DPBlb/endGbyfIaweSDZRohDjYGAc49Bg7ALSR/KnikPcI2BNnic6NvmdqTixq
	ot2LqafkQM4eiJXcddrv9nT5sW9gh0iKIOftda2TiOviGKvfcn9NDnirQWn9x/I9bVeXyiMIPMH
	wOQeFYMEt9Qq0tww7bjubxKt5hquOkt7G5ur2b/0fBrYlqz/8itQWwgsCv2SrWVnXolwGy0OgtQ
	u+NN6+k4UaWhRbC7NaScYow/QKa88A4=
X-Received: by 2002:a05:690e:1404:b0:651:d2ff:dc6c with SMTP id
 956f58d0204a3-651d2ffef9amr9116210d50.68.1776249554088; Wed, 15 Apr 2026
 03:39:14 -0700 (PDT)
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
References: <20260413134345.2855417-1-lgs201920130244@gmail.com> <4yzeebhaojygexo2ori5xpwyjpldag66vkoywnnrcs2ncjoght@bjiaqfz6koeo>
In-Reply-To: <4yzeebhaojygexo2ori5xpwyjpldag66vkoywnnrcs2ncjoght@bjiaqfz6koeo>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 18:39:00 +0800
X-Gm-Features: AQROBzCMM7yF1lbVtFjb7fumcuxkzR_jd819BKirInIUv9EulL0NA_j9prMl11s
Message-ID: <CANUHTR9HNmNTnxKtWLQZV9rF4w=po4Uy_=iRxwEWuHq+JgGETw@mail.gmail.com>
Subject: Re: [PATCH v2] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add()
 error path
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Graf <agraf@suse.de>, 
	"J. German Rivera" <German.Rivera@freescale.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ioana,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 17:38, Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> What tree are you using?
>
> Ioana

I was using v6.19-rc8-214-ge7aa57247700 when I found this issue.

From the commit you pointed out, it seems the problem has already been
fixed upstream. Sorry for the duplicate report, and thanks again for
catching this.

Best regards,
Guangshuo

