Return-Path: <linuxppc-dev+bounces-18052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA604104C007
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW7791mJXz3cHx;
	Wed, 11 Mar 2026 21:59:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773226789;
	cv=none; b=SjJQRpTnHg3Z6XEqq69670JpxE/KMocjIEmVgGlbLJ9hBFrWm80GShW/a7wV4kqPCiHDWCUV72jV0oZ/0ekMxW6qlSGuTGsnWY0QchxpLB5EoaJqbIcb8uluIIpBx9Btk4ZB36cUdUxN6iSSja7FJK/9SrYBiy3ATlMmq5AwCDyzjErDsrbPwX31one7unvMQJb0Gt59gNu2ZP8izOLQjU8RfXSUjIYN3M1HNPSGpIezTW/6642Bx2YmN9JcDzc3a6wfcsZ/TjRnQAfiHdHAOKXkmW1fFKA8tS95/T33ACHn6m57U37IAUwXWgZ0mQZ8yU5QJfNGXlIrhpWFlD4aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773226789; c=relaxed/relaxed;
	bh=zcH6Lc40kzSRAoAYXb6qtKvvgyxtQF34YwNbavKNGPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JonyqVIS/NnAzh7LGIt7xpqXVRzWoHAUenRr8ie2iuMLkfDINLkKBUE3MC3PUiNU6RpNOW905ty7Xi/+hSFNcftg5EpsmsnI633Kb7vMmAtTvwg6WcsRSSadXD/0939243XkZ798R6yD/YA+okqD0aY0zg2ZmUUvRFy2yCIM4yLKah/TX8njIRHujMFKE0aUIDLIaZ6d6noar3Pwdo1GDFm6uRgxPMgJjz/E9tnkg3G9SN9IaHvWOp0YeBbU1lcnnMKCohiYLYH9KjxzAjXkZ6nej7rnQmqVcPJG3+Kjog11kvH+ngZJExqiYLvGXyWXxpthaBeI5Q2y/HukmFpnYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NbuVPsol; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NbuVPsol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW77843F3z3cHf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 21:59:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5145143392;
	Wed, 11 Mar 2026 10:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC28C4CEF7;
	Wed, 11 Mar 2026 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226785;
	bh=NWbVZd2f0Apk9phlC10/UOc9VRa5mnywdugFB8KMC/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbuVPsolvA1iCHiziVg/YQZCU8nhtZ7WoL4OFlP5RwLzgJ8ArrunKkEZlqWrbRaYJ
	 VBk5Qtaoeroo4VTY/puOUUpEjex4/xAumktU9Ae+/edkR6rDma9z09ZqbhCgTo31EQ
	 JEIqOehOcaZ9n1lsgkD1NfopjyxKU5sCeljbyZDIQLdA20XdghhTsG33WMey843qNw
	 XFit0QD5CNRi0jSpy/KZS+o5+dHVLz7VUn3xoVdN/fB6UYfebbTRY40RPHjVab1VcV
	 Nx0myWJYpWKDdu9F9IEEE3t2zkSfCp/e7g2nXtc74xksA0IXjdRxu7ZQ5ncFzui+VT
	 ncZE8tHF0hEwQ==
Date: Wed, 11 Mar 2026 11:59:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <abFLGRn9TYrsycRs@fedora>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
 <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
 <aJ743hJw-T9y3waX@ryzen>
 <lakgphb7ym3cybwmpdqyipzi4tlkwbfijzhd4r6hvhho3pc7iu@6ludgw6wqkjh>
 <aLmcO8ukT-CDZMuT@ryzen>
 <mevtdhght66tds7yhmr5a6xg5a75fb667b6lyvguoxqexmc74p@mroqidhzptxk>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mevtdhght66tds7yhmr5a6xg5a75fb667b6lyvguoxqexmc74p@mroqidhzptxk>

On Tue, Mar 10, 2026 at 07:07:39PM +0530, Manivannan Sadhasivam wrote:
> > 
> > I tested your patch series + your suggested change above, and after a:
> > 
> > ## On EP side:
> > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > 
> > Instead of:
> > 
> > # FAILED: 1 / 16 tests passed.
> > 
> > I now get:
> > # FAILED: 7 / 16 tests passed.
> > 
> > Test cases 1-7 now passes (the test cases related to BARs),
> > all other test cases still fail:

(snip)

> I guess what is going wrong here is that you might be rebooting the device
> *after* restoring the config space in 'slot_reset()' callback. So all the
> previous config space contents would be lost and the device would've started
> afresh.

I'm confused.

# echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
  sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start

Will not reboot the device.


> 
> I don't think we can restore the config space after rebooting the EP device,
> because host has no idea about it. It can only restore the content after
> recovering the device through platform specific means.

Am I missing something, or why are we talking about rebooting the device?



Kind regards,
Niklas

