Return-Path: <linuxppc-dev+bounces-23005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8339CCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmpYc1Cbpz2yZ6;
	Fri, 26 Jun 2026 18:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782462116;
	cv=none; b=dHKE7dCkLybZCYrZcX8lYCa79cbMpMZU4pswewshrBk94kqleKwxc4+4FSL0a+cFedq7Ag9+azeJ6UQnTpGilyWMtkBvRmWz+Gzr3hkSfNVv5S5LwULs3d5ctpI2xgAdyRzlyljZS7jnqXkEgv4wEEe8YWt1Ji4upttuY0D9A/m6wYtsespVKjjytKt5SqUSXks2GcV5q4LM5f1mQA1IFYisN0hkV83CQKlcbwDTRNt0XGtH9Z7eRvke6EM2nUfjKB887sy32RpGuB+s3Fp/oSaSiMg2w+1dMHAUZYnLJ1PEO+Zx+a9K0jA+aPxYszKbBHNTefHEIxDKHRbGfT3Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782462116; c=relaxed/relaxed;
	bh=7N6xFs6HldNaJtHXB+1so7kMQ4CsatgFOfKvzUpfQ6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NpcYOQ62I51kSYhBMNUv1dH1LNtcpR0mAujGWBt9Cie1sHZR1xf8UOQAuRPPgTQz47SpzgcUfAveTarZ5FOf5JMnDmqChDlvyYShJRlodIp+tHvojH5qf9djts/Ei0zC+ESRHUcK1cdULPvkPRDlsh0r6jhaGmvWdttOmiao32UO1En+gG/4fCDrGiuAwu3xWlZCxb1yqM9QTFWKByiIhJBX42tTLP+T6t8P8pK08YokhCHN5SRMiAlG4n3bDuJKb+XdKnJQq/6xiGQk4lEaYd3aNE1DhI0YqqhFp37Dt1S06or72Ewei4EcVF0pe7x4w0OXVLOI0AjblgQ3E5LG0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLkaMOoe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLkaMOoe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmpYb0QhTz2yVv;
	Fri, 26 Jun 2026 18:21:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 085944430E;
	Fri, 26 Jun 2026 08:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDAC1F00A3A;
	Fri, 26 Jun 2026 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462112;
	bh=7N6xFs6HldNaJtHXB+1so7kMQ4CsatgFOfKvzUpfQ6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DLkaMOoe7jjLq0zrWVM7g5T3weWBVn0GKvdUrsWL1NS6Qs/YGb/jSI/OCz0xvfzqS
	 Qaym8bn+YQ7Yv3mFvqa3JZPMQyeTT1JkI61/DRV2mqoJOQ6RCZahCcrN/sZ0P41GxN
	 lQMkVEyzffwbljfjI4cRAmJFH6TA/MXXocYqdJ0r2fyaFbY7MUFYbzOT2mQ1bO9ESQ
	 aXENlZ4+KidZLyWpFEQCN/4TQ2SdvjPzYQw0gZqKyFHWnTN9MR5o7FqI9NLTieKhiJ
	 eEE7hw/g70YQVjdOMlBaDUGyYwudw/LY4An0H/3ioGWkJoeS59H947CE7rYTKgUHWr
	 baMoIKRFCt04w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D639389E8;
	Fri, 26 Jun 2026 08:21:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/9] driver core: Fix some race conditions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246209959.3816447.5329631417058038374.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:39 +0000
References: <20260406232444.3117516-1-dianders@chromium.org>
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, stern@rowland.harvard.edu, aik@ozlabs.ru,
 johan@kernel.org, edumazet@google.com, leon@kernel.org, hch@lst.de,
 robin.murphy@arm.com, maz@kernel.org, aleksander.lobakin@intel.com,
 saravanak@kernel.org, akpm@linux-foundation.org, Frank.Li@kernel.org,
 jgg@ziepe.ca, alex@ghiti.fr, alexander.stein@ew.tq-group.com,
 andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch,
 andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 astewart@tektelic.com, bhelgaas@google.com, brgl@kernel.org,
 broonie@kernel.org, catalin.marinas@arm.com, chleroy@kernel.org,
 davem@davemloft.net, david@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, driver-core@lists.linux.dev, gbatra@linux.ibm.com,
 gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev,
 jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org,
 kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com, maddy@linux.ibm.com, mani@kernel.org,
 miko.lenczewski@arm.com, mpe@ellerman.id.au, netdev@vger.kernel.org,
 npiggin@gmail.com, osalvador@suse.de, oupton@kernel.org, pabeni@redhat.com,
 palmer@dabbelt.com, peter.ujfalusi@gmail.com, peterz@infradead.org,
 pjw@kernel.org, robh@kernel.org, sebastian.hesselbarth@gmail.com,
 tglx@kernel.org, tsbogend@alpha.franken.de, vgupta@kernel.org,
 vkoul@kernel.org, will@kernel.org, willy@infradead.org,
 yangyicong@hisilicon.com, yeoreum.yun@arm.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Danilo Krummrich <dakr@kernel.org>:

On Mon,  6 Apr 2026 16:22:53 -0700 you wrote:
> The main goal of this series is to fix the observed bug talked about
> in the first patch ("driver core: Don't let a device probe until it's
> ready"). That patch fixes a problem that has been observed in the real
> world and could land even if the rest of the patches are found
> unacceptable or need to be spun.
> 
> That said, during patch review Danilo correctly pointed out that many
> of the bitfield accesses in "struct device" are unsafe. I added a
> bunch of patches in the series to address each one.
> 
> [...]

Here is the summary with links:
  - [v5,7/9] driver core: Replace dev->dma_coherent with dev_dma_coherent()
    https://git.kernel.org/riscv/c/3e2c1e213ac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



