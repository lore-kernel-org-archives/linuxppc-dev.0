Return-Path: <linuxppc-dev+bounces-25263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EE7C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:05:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDH3F6Pkzz3brv;
	Mon, 03 Aug 2026 23:05:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785762329;
	cv=none; b=nnHuDxrvKQki60uSaa6grCVh5lbAj4Psr4GbmLqvn51KhCil/BHP42CY+A6vKhBlWfwdoXapxp1oJqcANsG5ieKV/hpR2IK8D2uAjz+4/fMcQ/5cUVQjiKg4xGFvP1/+8gdz64xrCyUZAn1qOPhe8bbIWGyZMlZ/gZ3ziAosYx1AzDJXJ3PS4DSsg0ViHeOI2kzLOjYevRVVIjknFnVe76wAKwC3ny7VQQqFvnryBqRqVBbntzTkXs3I8k87BX+FQcFc4YkXOh2KxWDpj+i7sPbJTNFWItA9waMmjsrA0VA03wgSi4Qx9M8p9YA1HcpTQC0Ai4+CYInp25NBFFTTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785762329; c=relaxed/relaxed;
	bh=vnvfQXUPkCwHc3R1RNufoZv6AlvmQpMN5ddzTcHtCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHdG6k5G2MSw9+ZA/P3bfVyz5bHDHsghyZZ5iCclPOl3DokZo7J8GDhp/76EEyNj738ZKpdXcYgTy3h6zPBTapuKAjwklqxhS3d8/SBrfT8Lx7JthqqQuJnkAl6Yja6I9DNnNu6w/tR87Vla1IjFd7f2SLDpTr9qa2hLYULOSGhw253PpSPT8rQyphHi5M1eJ23saI+x36P9bkmNU1J7CGZYi8reIEQBZXngr+puFvFGew+gbAWzRr3BIdTdGW+b1p9/XO3bxOrnLY+eDYDFhIYaR5YFeC2Uyj/mzG6QLsH4UQtbCROryI6h/HwUq53m/zegFpaiLv+fAV4ytq6e9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkx4MKxH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkx4MKxH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDH3F1NrHz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:05:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0377143E52;
	Mon,  3 Aug 2026 13:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A541F000E9;
	Mon,  3 Aug 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762325;
	bh=vnvfQXUPkCwHc3R1RNufoZv6AlvmQpMN5ddzTcHtCcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkx4MKxHx4RRU8jMkJyTzd7B1CWphPwdvmzZlp8h4m36f5TX98ES906be0OTgXhFu
	 vybCQwI6iyxhWdtG8NC30s5kH+6cECzhb7+TkaW1Cm9IXmWH+3nPeQGTbMSf+ijpTB
	 0DM8X4+Vhv88tvPdqiLXVnH6RVwz0XvpR6eQXOUPVHPVgEzX5txpvtcI3asCX5h4eG
	 0E1LlyENt9emBKlVqnZlFOa8rphMOgGacsI4vn/mq3ZqtKOZj/1bx5K7WFIG4l62iU
	 QL1apds50y7j61BWMLRXFl3e2GQdQAEg6HlfyLtbStKe98IzZ/z4eFlVm0u4v77DyO
	 XbHx2c6QZXFXw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Linkai Gong <gonglinkai@kylinos.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Maxim Kochetkov <fido_max@inbox.ru>,
	Saravana Kannan <saravanak@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()
Date: Mon,  3 Aug 2026 15:05:03 +0200
Message-ID: <178576221777.155079.6723403896365207978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731094608.1883391-1-gonglinkai@kylinos.cn>
References: <20260731094608.1883391-1-gonglinkai@kylinos.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=430; i=chleroy@kernel.org; h=from:subject:message-id; bh=g32TLNYO1Snhhf+BMD5yHtq8V00IAMVJ4U1EuJ7sUBw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQVTGI7vkWOedJ8xrPLMopCY3rbvNnOx3DF/rnutn5b5 5XH+by/O0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBECpQZGa6ybjjQESP46WGK /PMFC87yrW/rXhNy8e2CG8ySKf83VMcy/LO+cy/7oeSGm++eHWabeDRKcN47P+PO0/+dq2SyZyR rdfMAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 31 Jul 2026 17:46:08 +0800, Linkai Gong wrote:
> qe_ic_of_init() ignored the return value of platform_driver_register()
> and always returned success. Propagate the error to the initcall.
> 
> 

Applied, thanks!

[1/1] soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()
      commit: 060325071fab5d889740f6393e4e8ecd990e6cd1

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

