Return-Path: <linuxppc-dev+bounces-18063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC9FD0651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 14:40:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWD1T1WZ6z3bf8;
	Thu, 12 Mar 2026 01:40:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773240013;
	cv=none; b=BX2TVx8rwzet0TZrMI9ehfaJgFYECMoMGAEkT633m1x7x1iXtkBJTGqUXnxKScvlhYwPWZup9Z1L6gkwaqqFOQxyZTsvIUUBhH7R8ST8tzQVe5PwYbrDg/e5b0T1azkCXzG/uYFNGKo5DboKSIn8AxHYp9T0Hkqdnkq53oTHt0P/il7sHQThrdWBRbeJeRcKZxvaOQfw8aT2TPAtXa2bOGt7n8FeJ661PD6v1Bo7fI0DdDML4K9Q7/S3/GNtnUlXaV3A5Bz1AGtoN+vOnWTvpPR5mqFUBsrXJdAuj8pt+PaNVfa7mUbGZvNnGaV+bVCjYkZaq3fsnDbTqQ1abkxn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773240013; c=relaxed/relaxed;
	bh=Fqi7yB+UTgYOJUUaPcHDCmNygswwW4ZYGrGDcvSqdMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeOf2nA5LTsGfEFxIWTCm0p2r2yxYQjlxgLAiq5vhMvQTmEDSXomF7aH4kHlFqqDBcyV1Wk4ns63ninCl3Lp+8yvAf+i1CffQHcDul+a/Xc6nsidM0lxFI+8unaXJAJBRw99D+kk+wtfSpxr4dvXvFM2QA/stYObjZ1nnud2tchSxfgoEW8Q8CgxhOxKUIzr1QONZICoxixxaXK7VhK2YwiOIOzuvrKv667esw1Qomu2UP1D1iUsrKbTvcG3Injj6PNYdB2Vy76tjjSD62zTwAhfsNhrTD/znGzWmeqmf2u+C8LI5TtJJfL7vOgNoYorOiciNUwfMwzNX+weaJCzqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h/ZF8l4o; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h/ZF8l4o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWD1S2ts3z30hP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 01:40:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3933C40B2D;
	Wed, 11 Mar 2026 14:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D62C4CEF7;
	Wed, 11 Mar 2026 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773240010;
	bh=0zJ0HQFf1lzSS5LA2IFPSO9AkXjfgAxBGWOu+Mzp1PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/ZF8l4o6TNAy+i+OxrOe0OLGywhNzKtVbVYp74L2z2TydeYuY3+X/g9L5dEUiYOT
	 yZUoISYDYPAj2StS7DHyURGWki4VbXGthWmYFwecKer1qiK+Ol0DMmRDBsZxDR/G/n
	 Qu14UDrbgrCgI523wcTEndr+Q5bpnKpKxh83hpon0c0fVoqpCfdvwQoWDxe7FDyVwY
	 zTjltTOCK6vw6u6YWicQm9DQ5nd6MOURmGxWLJoswyjTm2KD2SwG896Z8CXS8OWjMj
	 NtsZcxyNo1miOWcKlLG3k8k6jY06SDcow2r5lU+ZxY/1ym2GjQOsIIoxT/DfsFU3b1
	 DPpiGOOUXlNrw==
Date: Wed, 11 Mar 2026 20:09:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abFMa6DCGGLUHddA@fedora>

On Wed, Mar 11, 2026 at 12:05:15PM +0100, Niklas Cassel wrote:
> On Tue, Mar 10, 2026 at 07:31:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Changes in v7:
> > - Dropped Rockchip Root port reset patch due to reported issues. But the series
> >   works on other platforms as tested by others.
> 
> Are you referring to
> 
> ## On EP side:
> # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
>   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> 
> Then running pcitest only having 7 / 16 tests passed ?
> 
> If so, isn't that a problem also for qcom?
> 

No, tests are passing on my setup after link up.

> 
> There is no chance that the patch:
> "misc: pci_endpoint_test: Add AER error handlers"
> improves things in this regard?
> 
> Or will it simply avoid the "AER: device recovery failed" print?
> 

Yes, as mentioned in the commit message, it just avoids the AER recovery failure
message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

