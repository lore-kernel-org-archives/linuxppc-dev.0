Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCF606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=if1OE+s+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDWJk3R8Bz2x99;
	Wed, 28 Oct 2026 00:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.224.81.136
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793107094;
	cv=none; b=jPb/wzcEfIFZ/6gWsr/tJTDOOMwS7qkVZ7Hw9IryeGIe06m3dYz2mwbzSqYK/BAvV1ubetdwSMDbve5jbW2vuj7JnpPNwmusdgXhAEZy/NDvHQmtlNCbnWz4fA3M4rz6qwKaeoRxMHG6+d+Muu2HAy2eLc8ha54KaGkR0jixYQpikXs9D2ksBblrshO4mGzaVvGqlEZdX1nrs5ho5X7ialHaxfMFzf0ifC6zXlbVlPQ4KvQ5xOcMWTRoDjs4LdvtcjfcvBYYScuK+om3EByVcKuWzXf8lzlt9SJT5nGD3j8WjxyR+WoEqxUYg4oucVeV22sa51APkvzP+B5ERoUmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793107094; c=relaxed/relaxed;
	bh=g7rGr35rsfUat/aHvoe/Mi5rDCRRMxT0NcwnokuEoLQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HTUVYrpSx8IU75xNCVd41jHxEtpmM7UNmhapM4kCOvT/EWNNqLsZPySbZ+EROIrS77wcfTmSH0nAHWaSMkSxD2GPhgBXosBMis29QJGRQeIJZIPXEV96Zpd5GcmYxACH8nGroTEIWFDmzTNFeT1c6SZ3W38TsAf/BQJYKtEDti0KSKmDSQhIAeLNFLYbbcwWg+Pxghk+OPI7n3zYG2L09QTDmqPYnlSPEKhhgbYypPmhKW2D2XJ9IYJl+qUndBAjrFGwneXfEgSfRe7O5kfp+/W19ziBGNKpCmaHv1hh8GV7lbAKBUUpKnBjj4/TVbwHkH97+uWVra9UqUGZB7h2Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=if1OE+s+; dkim-atps=neutral; spf=pass (client-ip=156.224.81.136; helo=mail-m81136.xmail.ntesmail.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=if1OE+s+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=156.224.81.136; helo=mail-m81136.xmail.ntesmail.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 304 seconds by postgrey-1.37 at boromir; Wed, 28 Oct 2026 00:18:11 AEDT
Received: from mail-m81136.xmail.ntesmail.com (mail-m81136.xmail.ntesmail.com [156.224.81.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDWJg09blz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 00:18:10 +1100 (AEDT)
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 528713ae7;
	Tue, 27 Oct 2026 21:12:59 +0800 (GMT+08:00)
Message-ID: <80f85ae9-7162-4940-8dec-690bc00098b4@rock-chips.com>
Date: Tue, 27 Oct 2026 21:12:57 +0800
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
Subject: Re: [PATCH v4 01/16] PCI: dwc: Add pcie_cap field and caching helper
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 jingoohan1@gmail.com
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-2-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261027122827.2725643-2-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17d7e1c8c03a4kunmbc22d35997dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkxPVksdSUpMGR9OGhlMTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=if1OE+s+0vJEWd3Li6qhSK+6BnN+GRMpiXbxk3rZd8OP+gZRRJTgOPkxvlHVvkfTSHfgfCHrlQaCwDegrXIGqsg5RiwE8+kwUi0A9fecpSt8Hux3Z2shlMceNBl4RxxWxv/AwzexIk4Q9bjOpYyaV2XS7lJ5MiQP1V21+XMyr64=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=g7rGr35rsfUat/aHvoe/Mi5rDCRRMxT0NcwnokuEoLQ=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hans,

在 2026/10/27 星期二 20:28, Hans Zhang 写道:
> The DWC PCIe core and its platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure. Besides being verbose, that performs a
> DBI read every time, including in paths that run repeatedly such as link
> up polling, suspend/resume and interrupt handlers.
> 
> Add a pcie_cap field to struct dw_pcie and a helper
> dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
> the result for the subsequent calls.
> 
> The lookup is deliberately done lazily, at the first place that needs the
> offset, instead of at a fixed point during controller initialization.
> This guarantees that the DBI read happens exactly when the open coded
> dw_pcie_find_capability() call it replaces used to happen, so no DBI
> access can be made before the controller clocks, resets and power are


With the controller inaccessible (clocks/power gated), what a DBI
read returns is platform dependent, most integrations just hang the
accessing CPU, like Rockchip's SoCs, others might return zero or
garbage. Zero self-heals as the commit message describes, but a garbage 
non-zero lookup would now be cached indefinitely, so every later caller
would use a bogus offset?

Perhaps the "TX Interface Progression Detection Features" of dwc IP
could help return a dedicated value? I don't know, so I need to check
it internally. I will get back to you later.


> enabled. This matters for endpoint controllers such as qcom-ep and
> tegra194, where DBI is only accessible after PERST# is deasserted, and it
> also means platform drivers do not have to call the helper from a
> specific callback at the right time.
> 
> The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
> first lookup may be triggered from different contexts, for example the
> qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
> the same value, so this race is benign.
> 
> A return value of 0 means that the capability is not present. This
> cannot happen on real DWC hardware, where the PCI Express Capability is
> mandatory, so a negative result is not cached separately: it only causes
> the search to be repeated, which does not affect correctness.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae940924..fa31e8b763bc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -592,6 +592,8 @@ struct dw_pcie {
>   	 * use_parent_dt_ranges to true to avoid this warning.
>   	 */
>   	bool			use_parent_dt_ranges;
> +
> +	u8			pcie_cap;	/* Offset of PCI_CAP_ID_EXP */
>   };
>   
>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> @@ -830,6 +832,38 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>   	dw_pcie_writel_dbi(pci, reg, val);
>   }
>   
> +/**
> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
> + * @pci: DWC instance
> + *
> + * The offset of the PCI Express Capability structure is read once from
> + * the DBI configuration space on the first call and cached in
> + * @pci->pcie_cap for the subsequent ones.
> + *
> + * The lookup is done lazily at the first place that actually needs the
> + * offset, so the DBI read happens exactly when it used to happen before
> + * caching was introduced, i.e. never before the controller's clocks,
> + * resets and power are enabled.
> + *
> + * DWC PCIe controllers always implement the PCI Express Capability, so a
> + * return value of 0 means that the hardware is not usable. Callers that
> + * check the returned offset keep working, and the (never expected)
> + * lookup is simply repeated on the next call.
> + *
> + * Return: the cached offset, or 0 if the capability is not present.
> + */
> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
> +{
> +	u8 cap = READ_ONCE(pci->pcie_cap);
> +
> +	if (!cap) {
> +		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		WRITE_ONCE(pci->pcie_cap, cap);
> +	}
> +
> +	return cap;
> +}
> +
>   static inline int dw_pcie_start_link(struct dw_pcie *pci)
>   {
>   	if (pci->ops && pci->ops->start_link)


