Return-Path: <linuxppc-dev+bounces-18077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9927F1125857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:48:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWJC25K5Yz3c97;
	Thu, 12 Mar 2026 04:48:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.224.81.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773251326;
	cv=none; b=m5x31y+TH8HX5CUXahnWnSybwaLZF8hCe9tx0C+mEgF2l5qyyPhBd+FMOcctNMN7VBVkCZ4KK8+RTA6h+DGWYujagrIZRBapi085N99oY1k0edHb+ATmCWs60xRx3rrMVd5rXBXftSVGJFZEYOlhlbzNv3suZNFVXTalUM9xpG0NDN6R8cZikitPAEbF9Rmam9sKmnczO3QR81RmMaGcPybUKBQJd8z0Yvr+7TU4eHBDIvSpPrFUypb74mjuYJe7TTuv9SOXj0/7tijy5GdUgRcInTMrDs3dVAAVCHq7rgZixmbSB5tL8uYRBckqRJfx48UyB1N3yzm4d1SqwtQfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773251326; c=relaxed/relaxed;
	bh=9yG8NQ0gHRExp7u3DqeTqLY+f4Q07ToFiRLsE78NeCU=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NDtqafBJpgdnFvYw9JfLlXsgyYAMXUgbfBbAv2mmNiSZ2pBpeOhQEhh04ZLpJmsTtijrW6Dfrc/P09nSZGh4dXllI2VP6+g8XSyGk1JSmFpOAgQfyOj0qnMU5MNpMdbgfcXeRks76pDy1KUVEfWxeRmlaE8C9b6eckSvErAScyLfJnsybzxrU1my10XAk73ILF4k4IOYOdktp69Qir3Reu4yVj/XeEYTYDkJtM0KC+JNHsZXnyPWkxymFU6MNmQQ3pb409jy9NKXzieDQiLtv74HHEoJEzy93kaO8V0XzZLtqPB3eyddTyNbyS/yQc97o7UQolFUq+jd/jYWS65XuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=K7wZRUJk; dkim-atps=neutral; spf=pass (client-ip=156.224.81.54; helo=mail-m8154.xmail.ntesmail.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=K7wZRUJk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=156.224.81.54; helo=mail-m8154.xmail.ntesmail.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4007 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 04:48:43 AEDT
Received: from mail-m8154.xmail.ntesmail.com (mail-m8154.xmail.ntesmail.com [156.224.81.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWJBz3n7Qz3bnJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:48:40 +1100 (AEDT)
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36820e818;
	Wed, 11 Mar 2026 13:26:29 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
 Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 1/4] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
To: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <20260310-pci-port-reset-v7-1-9dd00ccc25ab@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e951b005-d9c9-224b-ed52-23abbccf7212@rock-chips.com>
Date: Wed, 11 Mar 2026 13:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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
In-Reply-To: <20260310-pci-port-reset-v7-1-9dd00ccc25ab@oss.qualcomm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cdb5c5d4d09cckunma929f57d18cd2d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlDTlZPHxlISE4ZSx8aHUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K7wZRUJk1emUgxCcHil5+9JB/ANF+IxeKRXJYfvQNEB51UFMvURGvaB1+hEuaGfLw6gNqqGdYK7+AzOAJqC3QeulrOvdMdg98utMWmVdILteJwz08dWusEIiUceoqY1rrzpiBbUcuejudxcc0a8Y5GCv3zU3YmURNiNhYMC2e6Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9yG8NQ0gHRExp7u3DqeTqLY+f4Q07ToFiRLsE78NeCU=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/10 星期二 22:01, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Some host bridge devices require resetting the Root Ports in a platform
> specific way to recover them from error conditions such as Fatal AER
> errors, Link Down etc... So introduce pci_host_bridge::reset_root_port()
> callback and call it from pcibios_reset_secondary_bus() if available. Also,
> save the Root Port config space before reset and restore it afterwards.
> 
> The 'reset_root_port' callback is responsible for resetting the given Root
> Port referenced by the 'pci_dev' pointer in a platform specific way and
> bring it back to the working state if possible. If any error occurs during
> the reset operation, relevant errno should be returned.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/pci/pci.c      | 20 ++++++++++++++++++++
>   drivers/pci/pcie/err.c |  5 -----
>   include/linux/pci.h    |  1 +
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f..6f09057d83e0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4812,6 +4812,26 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>   
>   void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>   {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int ret;
> +
> +	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
> +		/*
> +		 * Save the config space of the Root Port before doing the
> +		 * reset, since the state could be lost. The Endpoint state
> +		 * should've been saved by the caller.
> +		 */
> +		pci_save_state(dev);
> +		ret = host->reset_root_port(host, dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> +		else
> +			/* Now restore it on success */
> +			pci_restore_state(dev);
> +
> +		return;
> +	}
> +
>   	pci_reset_secondary_bus(dev);
>   }
>   

LGTM,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index bebe4bc111d7..13b9d9eb714f 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -256,11 +256,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	}
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(bridge, "broadcast slot_reset message\n");
>   		pci_walk_bridge(bridge, report_slot_reset, &status);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..34c434b79abb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -644,6 +644,7 @@ struct pci_host_bridge {
>   	void (*release_fn)(struct pci_host_bridge *);
>   	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>   	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	int (*reset_root_port)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>   	void		*release_data;
>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 

