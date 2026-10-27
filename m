Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A65606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcY10bMX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVVx4Kldz2ySC;
	Tue, 27 Oct 2026 23:42:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=154.81.10.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104921;
	cv=none; b=U7FlrrfIaq5K+yvfTUDIHgL4k4zXPbWlqp/GnbZa2h3pTVxO4k+IVJA7U330hzX4AS6CClAeZwDVQbHjwEORdY1pLW//FBUHVrZewXpkPWMbJHqn9KFDwiHPwoS0kCYnt6Sp35L2SCmoYIizzrJCrk8vvGVryrvFrjaHi5s7EHWWgsx7+ABcf3foDlm6814ZteEugSfvWwswAve0qIXp70n7JXLs0jSZ859nvJs/S/JmqIj6/WHDV+Y8kRVB/U5OttjOCqsP0rJHF+Au9WzaJoqaAvA6hwWbjgFRlQ42vH3sMk/L5Vj1UB3h2a3MHZCgYXE/mWP8Bf9jhYhXQ6sAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104921; c=relaxed/relaxed;
	bh=CiGmRdlkoViId5TfscHFKflRSN2mgmPjTQiT6qBmjg0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YcuHJdqCsZO2viLtqxzrFy3RfmnJTZGAy6TNYqmK+eoIqVReygtuhZn9y8NdrPDzpRKaGbAAbwq0WJnkxGNCiDga7ETnq6dMQ+WtlzZbOFsEVP28RvLCeDyHgUdsXDBXnvISu78OYGYPVSzMIlJc7+eVxjuZjEyHfWK1hVGJ3REDd5An/b2nC0c3iLX9xMEtwp3yr1wRtlWIi5CK7NGIeuNrvLBSk1A1OsgRtL8PmcAHfjeIMGsdEv9WLaH7ymtKe2S//M46woxKfYR7CNYjofXUBhHMNU3Yh6yk04To2+0Fgra7cKeB8E/G3fnDgPG+rLSzbdxcWl+hph2UZbT8dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcY10bMX; dkim-atps=neutral; spf=pass (client-ip=154.81.10.223; helo=mail-m10223.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcY10bMX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=154.81.10.223; helo=mail-m10223.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 305 seconds by postgrey-1.37 at boromir; Tue, 27 Oct 2026 23:41:58 AEDT
Received: from mail-m10223.netease.com (mail-m10223.netease.com [154.81.10.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVVt237Bz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:41:57 +1100 (AEDT)
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 528682039;
	Tue, 27 Oct 2026 20:36:42 +0800 (GMT+08:00)
Message-ID: <311338f7-ae03-47b9-96fe-1ec2b2851c7b@rock-chips.com>
Date: Tue, 27 Oct 2026 20:36:41 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 jingoohan1@gmail.com
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-7-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261027122827.2725643-7-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17d5ce66c03a4kunm8cbf4897570f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGktJVk9ISU0eTR5CHUIeHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JcY10bMX5VWFSTKD/G7A+Y8NZJqvgD8AMt+1D9jMkiqr+9Jj2ehRz18pkYtHT8ZunL5eUiWUhHwAdDix7KG3Iz5rowwLyFwISqEK7Ufpz8TkQo2jzcOTYLFdc41EbsaxeluNB0tsf/s/ByM6UAVG153ph24+T3bO3XlJYxZOroY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=CiGmRdlkoViId5TfscHFKflRSN2mgmPjTQiT6qBmjg0=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

在 2026/10/27 星期二 20:28, Hans Zhang 写道:
> rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
> i.e. from the .init callback, which runs after the controller clocks and
> resets have been enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
> point.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e..753606193855 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -373,7 +373,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>   	u32 cap, lnkcap;
>   
>   	/* Enable L0S capability for all SoCs */
> -	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap = dw_pcie_get_pcie_cap(pci);
>   	if (cap) {
>   		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>   		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;


