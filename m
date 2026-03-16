Return-Path: <linuxppc-dev+bounces-18241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CB8F506C7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 12:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFVs27Zvz2xpn;
	Mon, 16 Mar 2026 23:57:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773665861;
	cv=none; b=O7lEzxdj5k10yI4Q7WmdTxGz/Bpp/EkegpNyuoOpomkpKvF+ePnlWXtsB1FaETCPCD9nGlCoCVVossRB91FLHTtauHHNpNxUhlomY2TDQfZsoTHvI7v0D8hwLL5g5BfIvBmmzFsOdIm6oHbicQCRIVKFurzEn0ilP4MWP4kbu6vUaIH3Gz+TC+8WIOwQ7eMTOFwBembzYOrZfcrDUiHqnHNbhrd61Z+IBRuvD1/2xQxgGjf+XT0I/xIWLCeblDBTikpuHMnZP2G/WbFzj297X4zLy9yTHCBUQ9W8SusWhM/BqYxVrkUpWxAk/0iLHBkWpzPMfEB+aUO/PqFcRss5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773665861; c=relaxed/relaxed;
	bh=PxS4Apc6Dos6VxLVgltvDbWqTgEwO0QasQNmcGO0JaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDa968M+yxatVAOOz5It+QUVrfRPtM6E3QebMlkKG7u++mhteHC+a6sV0knm2gNJfphM1sdQbqe1EgKXLKDky6jNLBztNlt/YhaApOj8ac/CVaaAF5TctP/n7UHHkkpsg2xzvYh4CghV//g6cFHsdB3qoS+v8rL/nhRH4S5RcyTAbZzS7llF7/nyHwLNdfxQUdVBv8owYbU1/9hzlEfT1Snx69uN4DVdoQw/TKTH5fD/Tx3k8VNiZWFXU23FGDo5nG0EQrxcMN8fuhfKwgdFS0gCxjDshMdRZyP4xp8XQP3CjSK9psIWWBlG0IPBZSAFz9Dm/NbXk2WuRNYj9gA7cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uQlhNjPn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uQlhNjPn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFVr1nrnz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 23:57:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03C9440433;
	Mon, 16 Mar 2026 12:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D31AC19421;
	Mon, 16 Mar 2026 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773665857;
	bh=tzu+r2qc7wCfm8REikgVroUxtUjdMAAfjpIXLK3YodM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQlhNjPnw/+sGK8GvTKCPoZUhDhYl44fzqlqWrftUDqeMtbvxoKYn2T6C/RVS+Ust
	 HK4Sw1FIffQBntafCLNjcpjmc2NeKQo5v8vL38/ERGybt1eC0kCQY6Zo/Qt5nU/QqU
	 15917IM/CEEWtpSG2iaw10u6phrNYX+YompvRt4EH7CrUaSEunPRgLzlaoy4kvXgf3
	 /cwtGWUo2f1P4U0AwsmUGEWOrOvjjNdkKWFvwebPQDGNC0mCP9S2MBe/YWLl/VM69B
	 269nAYZTQ3aThTX02S784XZH1qs1uKwt64gHF//3klHmNmcuFfYE/EhQXfpfyTqCbH
	 +KDvqMSWxjcvA==
Date: Mon, 16 Mar 2026 13:57:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, vigneshr@ti.com,
	s-vadapalli@ti.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	roy.zang@nxp.com, jesper.nilsson@axis.com, heiko@sntech.de,
	srikanth.thokala@intel.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
	magnus.damm@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, shuah@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 3/8] PCI: dwc: Advertise dynamic inbound mapping
 support
Message-ID: <abf-LKj8V2MpJFEE@ryzen>
References: <20260124145012.2794108-1-den@valinux.co.jp>
 <20260124145012.2794108-4-den@valinux.co.jp>
 <b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com>
 <tkfhaovpmaoodo35attvmbnpukcqgmwyrxmfgiwjy2dga65cgl@hmj4mx2n44ki>
 <5e485218-becf-499b-8a07-d25358504807@foss.st.com>
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
In-Reply-To: <5e485218-becf-499b-8a07-d25358504807@foss.st.com>

On Mon, Mar 16, 2026 at 01:41:03PM +0100, Christian Bruel wrote:
> Hi Koichiro,
> 
> > 
> > If I understood the problem correctly, would something like the patch below
> > address it? My expectation is that the subrange mapping test would then fail
> > consistently on platforms that do not have enough free IB iATU regions.
> > 
> 
> Thank you for your patch. Yes, now the bar subrange tests fail consistently,
> so that is enough to say this is not a regression.
> 
> However, I think there was a clear BAR missing somewhere before running the
> tests in the EPF driver, as the BARs could be reallocated during the other
> tests. This is not due to the subrange tests, but the EPF test driver
> supposes a 1:1 BAR/ATU mapping. Now this assumption is broken. I'm wondering
> if this could be improved to make the subrange tests pass on all platforms

Normally, you want one inbound iATU per enabled BAR, since you want the host
to be able to access all the enabled BARs at any time.

If you are thinking that we should somehow temporarily disable inbound
address translation for one of the enabled BARs, such that we can do "steal"
that iATU to test inbound subrange mapping, then I think that is a bad idea.

I think we should just let the test fail. Possibly we could call some API that
tells us that all inbound iATUs are occupied, and then SKIP instead of FAIL
the inbound subrange test case.

If you really want to test/use inbound subrange mapping, even if your SoC has
a very limited number of inbound iATUs, then I think a better solution is to
mark one or multiple of your BARs as disabled:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9

Then you should have at least one more inbound iATU available, and should be
able to run the inbound subrange test case.


Kind regards,
Niklas

