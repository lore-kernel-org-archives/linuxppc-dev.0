Return-Path: <linuxppc-dev+bounces-24578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEACC44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 07:58:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h48rX4DCFz2xqJ;
	Tue, 21 Jul 2026 17:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784620684;
	cv=none; b=inAfKZ5cA2FPbtEOkP/ZCIar4YrUTOK28ziLq0Z9/8L6U6z+GRhKb0DcYdAzeex34MJNE9FtF9Cv3JnfDYe1pYm2eIJEs0CJ/vXFMDPj1OvPweHpF3j5H50B1cExJ5xYwXRt0GxA8rVCbRHlxmQ+5g7mQBtEXSbEvnVoEmTxVfgRguUw4ULcQVlRIK0Q9Jqc2MIvKyPZmhWO6VUcm/T4LCn2a/dslgK3KdTEOWrBl0ea6GDMYTmT+8yOOKDVGMESMjjLCQGQKHH4+FKrxHKF0tzWcyCJTqjAANGV8AkOGIjGorCX5/48rOH4NSItJqWU1TNabteIerdtQ4I+jEBQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784620684; c=relaxed/relaxed;
	bh=y8ZQiTN586DKOzGjE0xQTVjSc0oG6CWcbCqpe2Jy2M4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azjOnLEp5Yg7OM+F7MQgZThpO0Dn+y5JBCBAgt2O+yg+k622bM/m8DKCHm4fwrIgb7jNmCPWMHWfeS/3cLvO5IAJyRGj59CUg+IZKjr8TiVJqWHCCkq43a1w5WwtOQhwdsaL0VnqtCeD2l7sVE/K13K80EIZye8eaqlN+7/zhFH/Mh92NirzVBZhK6yuRlAjeivt7KaBPVHgVWr8zBHQAbte3cBGAkNlTVb7t7e2VlNy1LvadbFDl6fiFW5B5GnucnDtYOJpoCbZgtwdkKWOd9wjwbMrHWclyKKHE/88D1F29VSOq+etjk5YqkRzWPA6m4nRntQl6F+W2ViKoLXvCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVmvwJVT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVmvwJVT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h48rW3SNFz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 17:58:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DC1560AA4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82721F00A3F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620679;
	bh=y8ZQiTN586DKOzGjE0xQTVjSc0oG6CWcbCqpe2Jy2M4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=YVmvwJVT9Qyay4HbMhb49B9CjDlZz7ft+lQj9lbS0gACumnC1Iv2/dsdm1MV9mu4c
	 zAFU0hI7Xau7B4/YM37CP9pXGedF5Cl9Ux1RfADSqooiQWl5++I9UPNLx9bYcxW1m8
	 dWwOXXbyLjJgKyY5IIabDL3n7y2Qbv9FbuP/aoVu6GwF4dZ4uDwHKNeaHY0jS2eqLz
	 RXoTf9r6Ejv9blA7uC5ei4TYzAeV966wu8kwI6AZd0WBupxsdSKzxFL2wT4iB1WSxL
	 qBk3K/JlKeou8FmssItan6rHnzpwi6jaVlRe/TmBqMy6lmtyvBR91Q78CeI2qT2hly
	 ZQt1jND0CNHjw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b01146b205so8109915e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:57:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoBddwknWnYWOFubLe/t5wamBW16p1Nkzv/o4OSiCIEVa1WNEa7ufgEkMp9Q1vqWe0zTT1a4mvn+EbgDgA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbYq28VIK3qIOSlM6Vg1E9ui8EX1MyOcuBKlAm09st+SvBgvTq
	iWhKVOT2fil+gCgi78DkuFikMKZnRZS1m3OV1f/30nmlTzO8ZsVwgblcGE/M/8hbmiWrd105RPY
	UC8kjl6XV8pstuVX6icnAXqzlpKO6mQRtpp/ub6LZJA==
X-Received: by 2002:ac2:554c:0:b0:5ae:bcf8:e7d0 with SMTP id
 2adb3069b0e04-5b28f9bd551mr2209166e87.55.1784620678478; Tue, 21 Jul 2026
 00:57:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 00:57:57 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 00:57:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <3e14e41f-ecd5-432b-9f52-690a05b38a8a@lunn.ch>
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
 <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch> <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
 <3e14e41f-ecd5-432b-9f52-690a05b38a8a@lunn.ch>
Date: Tue, 21 Jul 2026 00:57:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md_zUwYW5KL+p=BRixSaf3Rrc5jnBA3x8Ze+fK+fAOctQ@mail.gmail.com>
X-Gm-Features: AUfX_mxrzWF5f1w8uOBbvKVmYCYI9DGFBZVEBrX2uI1sc7agH6iCfKo0CQST8Mw
Message-ID: <CAMRc=Md_zUwYW5KL+p=BRixSaf3Rrc5jnBA3x8Ze+fK+fAOctQ@mail.gmail.com>
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
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 20:28:39 +0200, Andrew Lunn <andrew@lunn.ch> said:
> On Mon, Jul 20, 2026 at 06:01:37PM +0200, Bartosz Golaszewski wrote:
>> On Mon, 20 Jul 2026 16:43:40 +0200, Andrew Lunn <andrew@lunn.ch> said:
>> > On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
>> >> Prefer the higher-level platform_device_set_fwnode() over the
>> >> OF-specific platform_device_set_of_node() for dynamically allocated
>> >> platform devices.
>> >>
>> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> >> ---
>> >>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
>> >> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>> >>  		goto put_err;
>> >>  	}
>> >>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> >> -	platform_device_set_of_node(ppdev, pnp);
>> >> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
>> >
>> > This is definitely an OF only driver. There are no other calls to
>> > fwnode functions in this driver, so this is the wrong thing to do.
>> >
>> > Sorry, NACK.
>> >
>>
>> I'm not going to die on this hill but drivers are OF-only until they're not.
>> For example, Qualcomm is now working on a hybrid ACPI-OF approach for
>> laptops[1] and we may end up needing to start converting drivers to fwnode
>> after all.
>>
>> There's no real benefit to sticking to OF-specific APIs unless you need to
>> iterate over all properties of a node or use some other functionality not
>> available in fwnode. The overhead is minimal and it's never a hot path.
>
> There is a lot of benefit to sticking to OF specific APIs, because
> within the kernel OF is well maintained, has active maintainers, there
> are tools to validate bindings, etc. ACPI is a Wild West, each driver
> is a snow flake, there is no review, no binding documentation, no
> validation tools etc.
>
> I hope you allow plenty of time to convert any networking drivers,
> where Linux is driving the hardware, to ACPI. Your first stop will be
> the UEFI forum making a proposal for MDIO busses, because that
> currently is not part of ACPI. You will then need to spend time
> understanding the DT bindings, and figuring out which properties are
> deprecated so need to stay OF only, and which can be converted to dual
> OF/ACPI. I've seen too many naive attempts which blindly convert
> everything, copying all the past errors in the DT binding into the
> brand new ACPI binding. That will get NACKed.
>
> OF != ACPI
>

I've never said that and ACPI is actually irrelevant to this discussion. Fwnode
is the abstraction layer and OF happens to implement it. Unless you need
fine-grained control (only exposed by the lower-level abstraction) or
performance - neither of which is the case here - you should use the top-level
API. As I said: there's no good reason to stick to OF-specific interfaces for
drivers that don't really require it - and even then, we should strive to fill
the gaps in the fwnode API instead.

Bart

