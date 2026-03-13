Return-Path: <linuxppc-dev+bounces-18180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4DC107BCD5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 18:19:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXXn32Rnrz3cKj;
	Sat, 14 Mar 2026 05:19:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773425943;
	cv=none; b=U8vo8pL+WsFymubhWsnb5kXYmY6D+Aiu9gfu2zdkqX/eWc6zi7tL5DNX8nRqQe5nwJXfzZtNH0EHLyYV3Lg5I753LLGe4aLDZBUMoo4SrGOiyDqUKhPsUOGQqqH0OXifgT3A5HAnI1dl1AZy+MPg0UYnZ/XFIhcex6AOHHYfA9nAj2tLmDCkAHCQqnRFt6ozc2JhFwErdrcXDow1UmBMSXrqV1M8Jm9QfFrL/c1YWnuLEiJLrst20yFpu4sruTJiQwuVcCIh6KvAqHpRVlVvUPFuqRnsM5HClKqV+36RX/d+U/579ZLb45Xj2sgSo4SWwghOJ0UXoe6gQeu41wjISw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773425943; c=relaxed/relaxed;
	bh=CUSRPf6wNhl2pkl3Aegsu7BSX3meXuDNoqe4H8TJPg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n0Po83+ajdP+4Ys/9qMxFY58sO4GgzBSPN02qqKEIt3+thed6fv8q19U3STd00U+5COdUbofOPzZPAY6gPk7AmnYehAVVxEeKGMwP24uTKqh01ep3d75l3pfl/kUFiAJfHLNqaNqAtYexOaxlLGsiXWZxRC7EXD9Uca4dAc5uIjTC7476PvgwokghSM3mUiPeuoT1p4eyJD4PSNNikMv9GMqxejJCbn6uwrlf+kjrw6snVhuysBXm7ucpBRBV/d/8eTMLdi5mX7UuM5DJTAyPc08vsiwuavHSDB+G6rLrYL5Rbs4ly7zbVGmqNIvIBmYwk/w+eNfRAijz78zwul5Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WkuBmUY5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WkuBmUY5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXXn220W6z3cKT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 05:19:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CA7F46012B;
	Fri, 13 Mar 2026 18:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49944C19421;
	Fri, 13 Mar 2026 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773425939;
	bh=2NXO+yF+55T7F+hpfAb0nuG4E5nybIth2x/Lfeit0v0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WkuBmUY5zECY4w8HigOp4c5Dc0Y7y2nfHD6yuEYwFaBxRHSoHOnEVTjF7hkT0eQkA
	 AFvQ0/U9ShmNbMyzF+0wQhrhDsQwyNxKjC32q2tl+0EsRInNZqjgNxUjA0SajeBrn6
	 kHFj31oHvk4O5GY8i8NmF5RD6dgQrjiCuW1ZNS0TlFAoxlpUagAwvkYpFuqyVtZphY
	 QVlHtHnRkgjRr9/4FntuZCDQbU9JYgsYDVeDARhaRlMuvQRsZqk8X1fkK1i1jrac4k
	 8sYPWv4uyylodoV2LcLxP/nDTVvuq2bcgK0cxCWY0hcOSstFpl3VMDzH3SGAkgADCP
	 f+nDIUI0cgl7Q==
Date: Fri, 13 Mar 2026 13:18:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	kishon@kernel.org, jirislaby@kernel.org, rongqianfeng@vivo.com,
	18255117159@163.com, shawn.lin@rock-chips.com,
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com,
	vidyas@nvidia.com, shuah@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 3/8] PCI: dwc: Advertise dynamic inbound mapping
 support
Message-ID: <20260313181858.GA1427542@bhelgaas>
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
In-Reply-To: <b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com>

On Fri, Mar 13, 2026 at 04:59:26PM +0100, Christian Bruel wrote:
> Hello,
> 
> While testing after this series, I encountered regressions on the STM32MP2,
> which I am unsure how to fix. The failures depend on the order in which the
> tests are run.

c0f1506f6354 ("PCI: dwc: Advertise dynamic inbound mapping support")
appeared in v7.0-rc1, so apparently we added a regression in v7.0?  Do
we need to revert this?

> The STM32 ATU has 4 inbound entries. After enumeration, the first 4 ATU
> entries are allocated within ib_window_map.
> 
> On the first run of ./pci_endpoint_test -v BAR3(for example),
> SUBRRANGE_SETUP calls dw_pcie_ep_ib_atu_addr(), which frees only one ATU
> entry (BAR3), because we were in the bar_to_atu case, for the first submap
> but fails to allocate the second submap. So the test FAILs.
> 
> On the second run with a different BAR, SUBRRANGE_SETUP test calls
> dw_pcie_ep_ib_atu_addr() again, freeing the required ATU entry (BAR1) and
> successfully using the second ATU entry (3), which was left unallocated by
> the first test. then now the test PASSes
> 
> Therefore, the first invocation of ./pci_endpoint_test on any BAR always
> fails. Other invocations are fine because the first one has left the missing
> necessary ATU entry free. Whatever initial BAR number is used
> 
> I am unsure how to fix this. Always freeing all BARs before calling
> set_bar() in the epf-test seems overkill, but safe.
> I am also considering modifying dw_pcie_ep_clear_ib_maps() to clear N
> num_submap entries even if ib_atu_indexes was not used yet, since only the
> full BAR is used during the first invocation from bar_to_atu. But the
> question is which ATU entry to select ? BAR+1 ?. This seems empirical.
> 
> I am not bothered by test failures due to an insufficient number of BARs
> (this is already the case for BAR5,6), but the fact that the failures depend
> on the test order is frustrating and show a regression.
> 
> But I'm not satisfied with either of the 2 possible fixes mentioned above.
> 
> Do you have any other thought ?
> 
> thank you
> 
> Christian

