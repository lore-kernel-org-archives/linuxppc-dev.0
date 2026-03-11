Return-Path: <linuxppc-dev+bounces-18065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC94A1125842
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:14:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWDn70R9dz3bf8;
	Thu, 12 Mar 2026 02:14:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773242074;
	cv=none; b=fUdTZ1mcko+D0I3l3DWv1XjpQ/VY1zHVGzlDrjhD9rIopruBgpShnhPlF04Ac1kh+c6nu2tCqQpp9V81+gdLfkgEHDK48MTJpti4DHER6D8W0X9APM44MDoh5aflVOey57L3zTl6P1MHfO3DZcwRPdRZQJECH8l96FabcmGCb1jm9oTrs6xFl2vzV2bjVH4YEF6GaYxKdvmoBPKPYZ6OGfBTgso6d2vhCmoSmVYA4I6SC4dLHtpZNZSd8qF2e3K14D7TfhsQX54GNVIqZtguGu3jkaZD286Z6WgHd4/KZHvhLBYXOElQp92gA9pFjhjf9g3IGYAD8P++MhG7UY5NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773242074; c=relaxed/relaxed;
	bh=M5HW8gZn9DLJaXwfIzx6dQqzrvbrYl5qq5NFuE4o/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU+Wq3xwjEIjwKH6VdHpF02fgLdoI94clHHK5D0v8NNx7BjbBY2gCif1/Ylca+vLDxbOjkOjHHjhqvUlac4P4Zu/oQx3TvRuQGNdaowVdzR+J5AGoe/rLNzay/ne17bp/pWImUbaLorJdmX7eSfqa+LZqmLwDFBS690Rs87WFT3gCV5NNGQSZeXSvfAkJgPGz3rZAS3y85hTEOD5RUTBFth3J3er3s17WRLlorh0og1xBzkYknihPqHeiHauT9EDpd/R5eu5tBaLgnsXWDSpSjjnU542OL+8pxonDw0dr2JQASFuh1g7vWvJgVNK1Slebpjfo2O8ZWxGygfUmo/D8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NzduROdM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NzduROdM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWDn62Bhmz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 02:14:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1833F40631;
	Wed, 11 Mar 2026 15:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545D8C4CEF7;
	Wed, 11 Mar 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773242072;
	bh=6G03Vmq9qwAjWyaMz8DPlElYYLptRloaQTWWkg09UaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzduROdM4NtDkaC97uFQCxBxcQk2+/sdIAEDxDo46Sa1HI+QkJr/W69c2Ir2IcqT8
	 yDFVqxVG6Uoy2C1u7z8hbctT5e6H4204OSpR7P4iULIE+LNSCndBNOIlZ0dDXL8MlQ
	 l4WIr8beXU+M/Luz551S9xo13BT7i3wJ96J0SEPoSvzwaHCkwyUbIDiq2XIy4jfYuz
	 6lmGZwceMWkMXv51jWNVTUZo9r1cbbfyd0lp6Nu0cpBU+Bp0/EqnBMeyriu5GpJ1GK
	 ZQDhBsPe9f31JSjasOZkllQzRP2VjuZ7cfXP+Wwfto/f9PR5NPTFQ2Q6BSl5Ll9Fqa
	 0LqOaXelYUCfA==
Date: Wed, 11 Mar 2026 20:44:15 +0530
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
Message-ID: <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
 <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
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
In-Reply-To: <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>

On Wed, Mar 11, 2026 at 08:09:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 11, 2026 at 12:05:15PM +0100, Niklas Cassel wrote:
> > On Tue, Mar 10, 2026 at 07:31:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Changes in v7:
> > > - Dropped Rockchip Root port reset patch due to reported issues. But the series
> > >   works on other platforms as tested by others.
> > 
> > Are you referring to
> > 
> > ## On EP side:
> > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > 
> > Then running pcitest only having 7 / 16 tests passed ?
> > 
> > If so, isn't that a problem also for qcom?
> > 
> 
> No, tests are passing on my setup after link up.
> 
> > 
> > There is no chance that the patch:
> > "misc: pci_endpoint_test: Add AER error handlers"
> > improves things in this regard?
> > 
> > Or will it simply avoid the "AER: device recovery failed" print?
> > 
> 
> Yes, as mentioned in the commit message, it just avoids the AER recovery failure
> message.
> 

I also realized that Endpoint state is not saved in all the code paths. So the
pci_endpoint_test driver has to save/restore the state also. But it is still not
clear why that didn't help you.

Can you share the snapshot of the entire config space before and after reset
using 'lspci -xxxx -s "0000:01:00"'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

