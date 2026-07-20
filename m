Return-Path: <linuxppc-dev+bounces-24523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B6C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 16:01:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ld5320Fz2ySN;
	Tue, 21 Jul 2026 02:01:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784563305;
	cv=none; b=DK2YkbgukcJq7/w/6atfrrENV87cZ1pMt17AKGcFhKAHsDFV1Z4OEPWJIH4jpYbimkhf5Zk/lM4AmYZZWEqbJKsNrpqgFOcTQL0LFlxC26Glp/80ZREOGIDNJW9bxkqo/nRvhRpYOD0SiPOfB/1+pfKHQMm5ldbDXRFGxykJv1hfqnKWvUfU33xTr2hyCZ05Swg4vpZ/woInwwmAYiZpEcSgCMJZ5XhBGvTkBglzv2oNG+pSx3c0wosm91JIz1lfFBCgtwbzYUvJVFpAqPBs+7UVs66AOSmQizJOzCVs77gRBUOzBwA0bdweltiSqrMFWQL8RnQWxis4y6mw1n0n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784563305; c=relaxed/relaxed;
	bh=cy2ZkxCpNVSDLVTKtd8tQZtQMok6N80r7SDOQ9XS6Ps=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUbPfdVLroBpJCzfZo5tE1kL9IcWvKy62svQ6qwLG73OoAGmVUGWb4SAxP1VK0pYuhHixfPy0IjVjTO3ntO5GrOOd+p4rx27faCTCsjjPugKOxPz899ZWhuid72/ntE/Q2o5tvsl5VLq8ZfakT4UA2w2JM6WmLXaqPMti0FfbudrRwtNCGWaZpzSgYbfFPE7Cyp4VyUE6KgvYbzBWdbFBgq1fMud0qRmnzFgK0FpgKVqSJ8dxn3P3QkAZWHu2poHkihYlL3zDlZc55QVHER/0MUkBXdaF6NGhZz6MksSGZctfZXcfepY9g5rrKC7MjuHEwPiacAAsr9j4nk5WmDEiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmI9exjG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmI9exjG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ld42QxTz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 02:01:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CC7C44006
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AA81F00ADE
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563301;
	bh=cy2ZkxCpNVSDLVTKtd8tQZtQMok6N80r7SDOQ9XS6Ps=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CmI9exjGe/Q9lpN/jDKjGYcZAhE82h4JhNs/XWbdbT2QKOv9Vt/lJRkWSNzc2sTDK
	 bT7H2HlxBn7PRd35GrUlcJXAkBZ/htEGpxajzqT8x+LQ9JKk55GrVmyrUIS+VwrASy
	 ex7zrBxyL4kKER0PbZqRA66QIdxuVaYzzXmIP4+VcaHIcdtYLEOA+9DLMG2S+JTXPB
	 7Dja9EFj7xhGycntJmC877y3Ph7X6yhMSvvn0ClkvGzRg4VXz75VMJGEj8vEBkESvB
	 HWh8zfEm7bAVxCLzbZXYqaMpxHTM9TEEaYT8KSHa+fLKy+x1CPl/UGD5zTR0ZeiVqX
	 P9CvaeVK0zUyg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aec201b582so10280739e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqxt8LneB1lzZpoThLNiqlDpGJzFV1r4xVBOCq+aC9vyu4nbGXZZIU23BPiatMtA+p5rsW94NOsLUSOwnM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypmOBPdqtgLm4RRBDei2/tbaTV/iyoAdGVDXRJtiSZeF2mnIiS
	j665/1IpdR5O8Ir5SnkvkwOU3vbl+j3PVSnJwj+ti8W86FKt9fC87ozsisRVvLMoXoTWW6fh6rQ
	KM8UzbeVEgc9gLJirhFqiHFaJpUdIUcGSOBIT2CT9Yw==
X-Received: by 2002:a05:6512:23a5:b0:5b0:1ab1:2640 with SMTP id
 2adb3069b0e04-5b28f9a56f2mr2858457e87.41.1784563299555; Mon, 20 Jul 2026
 09:01:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 18:01:37 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 18:01:37 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
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
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
 <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
Date: Mon, 20 Jul 2026 18:01:37 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
X-Gm-Features: AUfX_mzoRVqC1tUK_OfVS-B_bFewvPArrOEoPGLWKm-p7iGJrfuSSI_-EnPQPN4
Message-ID: <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 16:43:40 +0200, Andrew Lunn <andrew@lunn.ch> said:
> On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
>> Prefer the higher-level platform_device_set_fwnode() over the
>> OF-specific platform_device_set_of_node() for dynamically allocated
>> platform devices.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
>> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>>  		goto put_err;
>>  	}
>>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> -	platform_device_set_of_node(ppdev, pnp);
>> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
>
> This is definitely an OF only driver. There are no other calls to
> fwnode functions in this driver, so this is the wrong thing to do.
>
> Sorry, NACK.
>

I'm not going to die on this hill but drivers are OF-only until they're not.
For example, Qualcomm is now working on a hybrid ACPI-OF approach for
laptops[1] and we may end up needing to start converting drivers to fwnode
after all.

There's no real benefit to sticking to OF-specific APIs unless you need to
iterate over all properties of a node or use some other functionality not
available in fwnode. The overhead is minimal and it's never a hot path.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20260623145225.143218-1-johannes.goede@oss.qualcomm.com/

