Return-Path: <linuxppc-dev+bounces-25127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F3BC55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 16:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9w685SVkz2y8c;
	Fri, 31 Jul 2026 02:44:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785429888;
	cv=none; b=kvPdgiBnQF85cDhugl8DIIuiq/+Hcwxwxn/wW0vLXPYgiuSJ5mJ4seBLdZPHzZ8BY5I98V850czvHb26J4YnoeBONg1wjgye8EU0yXkuuO6w1G9xXUWA+IqsGjWuzIY3mqT7Ia0wsWcabjm6aKPaYK+fWwh1uIfxOhKJlB+1eLe3a3hZnG809LjR/e9j7FohJSFlAwgtiS4K+RON2E3CjFYGFwCFqrBmQdc3vJ+15TIRVqUMEnTdJtpcUuaf93550kNLcaI/xyDUJMdVLa3EuxbmJxdm+I6qMdRpQWtzfg9XOjPSPB4jI7nJJu/jopcbI9N8Ax8xhjzDMSorcwsSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785429888; c=relaxed/relaxed;
	bh=UBnrFFhJXHxkqZUiOlk8YO8RU5J3O80m+AewPDl6eTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n6Ucp+JT72JsTe5cOwa8Ypwy8FLDhDYvgOP3o8k9Y9Few1f5bRZU8X/A3EaesMQ7NibnXkD1Rp0PMc9vL/gNuxF+DYj8tFNFQxJXurRvoBN3R4k6zAVyojUaxv3p8SbooX/K16OprX3nlCRdIUIxHgmdlSYVw7QC888SsPYUB6voJTJxH3weMoJhcNvMGw3XKsedE6TwuaihBO5/Ze2Pk+TU7FneQErskg7bau1TNpmdR97Z/vgIXlyHY2227H4DszULFllEVTwjpPChTlsYjBKd1UGihWZGe7CbtF2+DNa6X6/FRej+ejk9GzOdGJiqYDGIe+WJKQBxITqLAc064Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=unvo=fy=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=unvo=fy=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9w676L4Jz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 02:44:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DEBEC600AD;
	Thu, 30 Jul 2026 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820931F000E9;
	Thu, 30 Jul 2026 16:44:37 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Brian Norris <briannorris@chromium.org>, 
 Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] PCI: Add support for resetting the Root Ports
 in a platform specific way
Message-Id: <178542987704.1025433.15649163299546579647.b4-ty@b4>
Date: Thu, 30 Jul 2026 18:44:37 +0200
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 29 Jul 2026 10:22:26 +0530, Manivannan Sadhasivam wrote:
> Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> Port) and its subordinate devices by invoking bridge control reset and FLR. But
> in some cases like AER Fatal error, it might be necessary to reset the Root
> Ports using the PCI host bridge drivers in a platform specific way (as indicated
> by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> Otherwise, the PCI link won't be recovered successfully.
> 
> [...]

Applied, thanks!

[1/5] PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()
      commit: 36637958726a4bbc630c0848eb3eb07cbfae89c2
[2/5] PCI/ERR: Add support for resetting the Root Ports in a platform specific way
      commit: e3e7dabe25e7be701c2a27a425ea71b17e238394
[3/5] PCI: host-common: Add link down handling for Root Ports
      commit: a36da2a2940a5c23a0a2e0c24966da637ca513fa
[4/5] PCI: qcom: Add support for resetting the Root Port due to link down event
      commit: 6b14d8bdba854e0031b4dbadf2d9cf5b98f95601
[5/5] misc: pci_endpoint_test: Add AER error handlers
      commit: 2e7d10af1cd05b26056a09032770db5c47bd54cd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



