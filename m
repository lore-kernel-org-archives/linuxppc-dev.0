Return-Path: <linuxppc-dev+bounces-18053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C862105D29D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW7Fg3NSBz3cJF;
	Wed, 11 Mar 2026 22:05:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773227127;
	cv=none; b=A57/20xBDm4oQmC7xZJTgvRKxT0qutToB2soxYDQ8NaFD7Fv/BqLaR6re7QtYWUnCFScdvdeK7JOlpGwNKUJ07YZO+2VKg32j8n9TmiAg1L+u/7MvgZNGQMTOWDOY89ArlX2QIESuq8dzSvNUtPIWbJAAcKSfa/vafYasjxbzcg/Tw5daiRI7qQDGZoJb/c7op+r9WOgJeFRtSTH7KTnnZD6nTWfI12TbRcZ/IUzRQzmf4wisLF3nTZe0Qowo2e3q1BDkSBTkb1mknODt6qwkj+BgKhsKKXx60OieRoHRgYRkgRCUtKSaNs4SfYuMqpkPPxItSBiJROQNMYaDb3hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773227127; c=relaxed/relaxed;
	bh=aqeXgG0YlkIhVkSKx1066/go5LgrSNrZPxNBAAiS4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHNGWGGRb2pwp0iXfz7fnbkaR6PLRJEx3lT2N4AwFwju5AKf8YRAMKjmbAFhcVhUFsxaLZQOxuXTAYR4oYttUc293TT4Y5NmweMnrkNdtCzSLlcxlndFt9kVI63IFJn5fV7kRRi1NVQ1MWmwKkk4brHlDj1RM2rcIevQwzOqt9/9Xns5djarty1w/1XzI8TJC5yxV6zy2yJstgZ1Ymvrxh+a4TYelkI+b1mf41zO6y31cQftAFrUsp2lzwj6ZlSeDs2y3u+eSTSsbvEz26OnGUIB5DxkPXaLcNEUEbBYM+ak0C9ufVxqXC3YgS0WDjAV1gVXNHNnUyl6ViUFRAUrBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eq24ij66; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eq24ij66;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW7Ff4VYyz3cHf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 22:05:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E84CA6013E;
	Wed, 11 Mar 2026 11:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6B7C4CEF7;
	Wed, 11 Mar 2026 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773227124;
	bh=BgLuLCpNt8YikxfkQc3yHUtyj3A7U731tcqZVJqZcPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq24ij66oMbyTp1yMVUcNGzHc65udFXi7P4njEUQUTlsmxGbZAXKzJnJ9FlGX4OH5
	 8EJdF+H5q/pNCEc9m2zibOEiho3mYxp4rAL9uS9PPqOtvTL8xHBpnRMGEbfimxABGW
	 iwMIRCPAVGeGn0VdA1SK0UaD2BwdtnTi6a4F0LutKSrnZ0AUkgwHiWqYHeq2Yo+hQB
	 BX77RFSPRFEXfbCIFMcHngXlOR7zC1ZXJuzsO2W8TO5YKYMAyOP3XiWDOWdC2AEfyb
	 Py7eKU8OcsajO4JUfyO2uBjjwKK/FMz5jqIaK34DcCF4ou2NdzrBnCexEbFUbfSP1d
	 bXzS+9ypNh3XA==
Date: Wed, 11 Mar 2026 12:05:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <abFMa6DCGGLUHddA@fedora>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
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
In-Reply-To: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>

On Tue, Mar 10, 2026 at 07:31:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Changes in v7:
> - Dropped Rockchip Root port reset patch due to reported issues. But the series
>   works on other platforms as tested by others.

Are you referring to

## On EP side:
# echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
  sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start

Then running pcitest only having 7 / 16 tests passed ?

If so, isn't that a problem also for qcom?


There is no chance that the patch:
"misc: pci_endpoint_test: Add AER error handlers"
improves things in this regard?

Or will it simply avoid the "AER: device recovery failed" print?


Kind regards,
Niklas

