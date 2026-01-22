Return-Path: <linuxppc-dev+bounces-16158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9789BD3EE95
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 16:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxnND3zjBz3c9l;
	Fri, 23 Jan 2026 03:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769101164;
	cv=none; b=YMFEuTfwYXP1CyifL0vR1mUJHzCjW7YG/8dNPk7Wq11ut0TcS7hTbro/sul9//rjUqQaXkIa+QPC4GLF7P8KW5LYaxNaO9WJ2XndtxjZBMQfLIi3S4vYQ5IV4SmT+Ct4Ja6fnUtJ9Q6UnBc/BluSow3K2Z7WfmN/y64KhYFe1ISGDtLlz5jx6ggjf7ccLw1gb+cwCKgviuGxe/O4LzmpUE0YJM0mo9CxSjq/VwI37cmGY+9WSTvXMXpPeJumLt8E4OQlH3VEbj9MZmQDtkw7DFUoW9mi08bTi3dX5G7Hoq+CBTEe8rQQX9+7RTbO/t2Zj7JtpWITKy8vaj53UE9fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769101164; c=relaxed/relaxed;
	bh=ctyaECZ1PTrRA7apezvO6HlUfCV+MlmRr+a4g56cUxU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eaTuZqgPadNubqjg89hnfEYEX1rDcNGRFuxphFE8Tuyn4/MmmQR3D00itljzLvwvkvTUN+/bj2lEBvadrekpm0MEMbzoJuYnwVJcTRIxeDMEK0hUYgYMMqzUAYHTjVGuywSBrRHubYMF6HQoMAsd8XaQKZJdvUt5M9dA/LLGCOQy6X+Fara3uQuXqmoZdcKT38JdMTByMr75ZolQeBvNbf3ZBc9oR5XPR9WORUa01cMc42p95Z8m8XgDSZoJw0Zs1PCyBnhYXxYoOWdpBHgPJV7GCBaUN1VFp9Co/JQY8OWyRZxZEEmfDiVMFBVGsMxKx/ve06+mcPbEBc1VUkV8lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WK8Qdiy+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WK8Qdiy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxnNC44t9z2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 03:59:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D3DFE44229;
	Thu, 22 Jan 2026 16:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E2BC116D0;
	Thu, 22 Jan 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101161;
	bh=J5VqdBfB3qJLKokwNzHgugj/xR5O2h1qw7xFVlfjZa4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WK8Qdiy+OYob7AaCGw51BnlD5QnCxxjuxB5EckU4dxg2pceWfpf2hxcKJkAGzgwFv
	 OYvOTfFdeWLftjTHM3KIMbaNG3YhhMm3cp18/6v/6az/gI/YGsh+WTX1ANIJxUNjYh
	 cl/mjuaSdgT3rWYuCgUTf6UHnlg/1tRcJrYbOBdEOp6sNTpKOEKcgzWV5UUBmJd0NX
	 F4SohSFUcSgon4U5tz/wv89xMjr8qloLQOeEn/d6QBDjT0SbWdWqo9mkOmFYG0Sf7l
	 MKr9b6ddz/dSiwuBXDx4us3AZ2sp9epXfvMoT66uX2n8zu/GB8+2jbN0aSSOs+eDIg
	 xXk9RSb1r82KA==
Date: Thu, 22 Jan 2026 17:59:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
CC: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
 vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
 l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
 mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
 heiko@sntech.de, srikanth.thokala@intel.com, marek.vasut+renesas@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
 magnus.damm@gmail.com, christian.bruel@foss.st.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thierry.reding@gmail.com, jonathanh@nvidia.com,
 hayashi.kunihiko@socionext.com, mhiramat@kernel.org, kishon@kernel.org,
 jirislaby@kernel.org, rongqianfeng@vivo.com, 18255117159@163.com,
 shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
 linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
 linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v9_4/5=5D_PCI=3A_dwc=3A_ep=3A_Support_BAR_sub?=
 =?US-ASCII?Q?range_inbound_mapping_via_Address_Match_Mode_iATU?=
User-Agent: Thunderbird for Android
In-Reply-To: <s6bnqkbuugi7oio7ybekdbk3dokpbe2bui2wjltdwajxix2app@wosgmhrfsriv>
References: <20260122084909.2390865-1-den@valinux.co.jp> <20260122084909.2390865-5-den@valinux.co.jp> <aXHsd7-WWAGyhy_w@ryzen> <s6bnqkbuugi7oio7ybekdbk3dokpbe2bui2wjltdwajxix2app@wosgmhrfsriv>
Message-ID: <19D609EC-F850-4B43-A83C-0B8C70E641B5@kernel.org>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22 January 2026 15:29:02 CET, Koichiro Den <den@valinux=2Eco=2Ejp> wrote=
:
>
>> To make sure that dw_pcie_ep_ib_atu_addr() cannot be called without alr=
eady
>> having a BAR configured, to we perhaps want something like:
>
>Thanks for the review=2E
>Isn't the existing guard in dw_pcie_ep_ib_atu_addr sufficient?
>
>        [=2E=2E=2E]
>        base =3D dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->=
flags);
>        if (!base) {
>                dev_err(dev,
>                        "BAR%u not assigned, cannot set up sub-range mapp=
ings\n",
>                        bar);
>                return -EINVAL;
>        }
>

Well, for a driver that does not call dw_pcie_ep_reset_bar() in their =2Ei=
nit() to disable all BARs that are enabled in the controller by default, th=
e host side will assign an PCI address even if no EPF has called set_bar() =
on that BAR=2E

See e=2Eg=2E
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/pci/pci=2Egit/commit/d=
rivers/pci/controller/dwc/pcie-tegra194=2Ec?h=3Dcontroller/dwc&id=3D42f9c66=
a6d0cc45758dab77233c5460e1cf003df

There might be other EPC drivers that don't disable all BARs in their =2Ei=
nit(), so I would say that simply checking if the BAR has an address is not=
 sufficient to guarantee that an EPF driver has called set_bar()=2E


I think the safest option is my second suggestion because then we know tha=
t we will only call
dw_pcie_ep_ib_atu_addr()

When:

1) If ep->epf_bar[bar] is set:
https://github=2Ecom/torvalds/linux/blob/v6=2E19-rc6/drivers/pci/controlle=
r/dwc/pcie-designware-ep=2Ec#L363


2) All the other requirements to dynamically update a BAR is also met:

https://github=2Ecom/torvalds/linux/blob/v6=2E19-rc6/drivers/pci/controlle=
r/dwc/pcie-designware-ep=2Ec#L368-L370



Kind regards,
Niklas


