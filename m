Return-Path: <linuxppc-dev+bounces-16361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F7D25B52
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:43:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1MQk2wmpz2xlK;
	Wed, 28 Jan 2026 23:43:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769604238;
	cv=none; b=Yrdrn8ivQakjUjX5+fNGMagH490IA1fZfnC5ww4MQI14XX2Z7aTcFoHkX3Vnh0kgEgPVktD3i/wnCYN5/BrgXgsJlOtQuQjPU6ir+NEr7VuPzlzWJbljr3J16rI52P2Hb3XSwJMsHUCKO50gjzkFqDyp5p4oU2OQswkiL3KYjr0LLZ2OZlMcCB/pqSwp70uQVuioF6spHqRpaRxa0ITQ9eg6hGoF7nCOnIID1mS3j6V/+aZmnuMh/vKVRmIxeSuU00NJu9iOsuJiaqJAK+6Y0tkfd8XnVFmCQkJruLFClaPEXHGfFjrntM/TEgxMwCbcWWL5Q7H+S/fR3Db+imZg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769604238; c=relaxed/relaxed;
	bh=uEnG5+Ir7fYb0GjdKzcWFsnATObsGHVdLfNfxjqN8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJzOfOYi2pqFs8ubsOdqQOZemVJXLv1yPwFoh29C6LZIV1AlLMA8+OfB5k/qjwD4wRPvO4zZNBCZaZdSP+NRhg73lUc87yv8s4Y3rnS6lDRIv/RglzAMDFiQ5q6JldV+D02zmOkcc6jhongmQIDCNhLgrR69jXDfOnUe2EukmqbJXp7ObacxjVn3MCYmaXqtwwc2uZ9YB6li9SGFe7Q3oci4/5RmrKdVA0o7uMsZhQfw7cvWI3bD8AFvsBCos7+MihTbM9M3uiQkcmlV7Zw+GyslhBbmO2ROvPhaq7zmbqTXFfFhhsq673dcZWa0jXIcytQ2q0qkJjxvZo7rpU7qWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YczMVpYw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YczMVpYw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1MQj3jcRz2xjK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 23:43:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E5D11440CA;
	Wed, 28 Jan 2026 12:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78FDC4CEF1;
	Wed, 28 Jan 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769604234;
	bh=oMHuOisfzFZa/SspMgzHSAJ7KCfQNx6FWbCb53V78Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YczMVpYwGeQR/JzANd0TTmXgJOgr2gVaF/lmwtcANf+m2u8mZcQUL+SRNgcTWC3xu
	 sJdf1nvdsAlouwdM861jTs9hkHdDoI9kAEi35kTHN8yfhZY4ltzT5lOKvrN90UPOBW
	 JlJbsi0un1KaFOczXEmFQFWXYd2/HuThck/kV91xcHw2ULUnrjUMYPS0vjad29vUor
	 uzVwA04GqRfCTna0yHdLTWzBFCdec+pArFM8mRqjmnjd8w4qmcxK36x6Piyi3hd9Vv
	 BebmzG/Bzel3keuqlAkOxwgzxqLPHASewoFUoHnGMMK2gJNnjVJPvEeE/e/fsyoYUM
	 B7INYod04iPjQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: ioana.ciornei@nxp.com,
	stuart.yoder@freescale.com,
	agraf@suse.de,
	German.Rivera@freescale.com,
	gregkh@linuxfoundation.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH v3] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
Date: Wed, 28 Jan 2026 13:43:32 +0100
Message-ID: <176960420088.2084129.13365764643328327479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=564; i=chleroy@kernel.org; h=from:subject:message-id; bh=lWZnn2tJcaNFkDUvVsOHuReTjNx23lTBLXZ5Xxh0drE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRWsZTxpuy6qqC+ZUGFmPFpb9W/kYlW+c8P+djzmb+6P e/R9kkvO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEOmQY/gdaMj0LCS/9kTGf UfXDEwUfhQNrf71vqtjYp7bdy3dq3C5GhoN2BTr9i19rTZi30rl5knjk4jsvUuZwnrgapvOUVXn 1Hg4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Sat, 24 Jan 2026 18:20:54 +0800, Haoxiang Li wrote:
> In fsl_mc_device_add(), device_initialize() is called first.
> put_device() should be called to drop the reference if error
> occurs. And other resources would be released via put_device
> -> fsl_mc_device_release. So remove redundant kfree() in
> error handling path.
> 
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
      commit: 52f527d0916bcdd7621a0c9e7e599b133294d495

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

