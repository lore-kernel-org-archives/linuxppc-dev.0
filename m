Return-Path: <linuxppc-dev+bounces-16728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822C8E78D6A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 09:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8f3S0csgz2yFm;
	Mon, 09 Feb 2026 20:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770628052;
	cv=none; b=MvsatnF1o9JThhDu4ev9QK0hKjC7CNgRH7LhMfM/9pGvf11HusmJ6Q/fpzBG4XLh5tsc5EGB65sKUAFDCeQm+aB0N1AZO2DHsrDPRP/MSFlAxhWFUSXU5xFrEEWVNhTxiZuDW9wZCuzERcT0yZTukAX9V+Pt4Fs3zl2zgUtCP8fZMCPlAJRzQG7IYtJ6FlmNIWwLr+MOywGX+7DHZu74tWzTCYK93nomCX7pdVeq9OpvoJ+6/0IXPx7HyMjn3VMiGh+eNYTanex4ynlAjdnVlmv04hOcGtoe0D9wK230uhxblHrBbQVPVxurlzlFn6VJDeeWk8fIbe3N25oSRN+1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770628052; c=relaxed/relaxed;
	bh=ldPhGDz6odKYJJYfPklkHhLA78TDu86SzZgRiyZHvn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC4tenDhXArmNSkvIDhVVSdX7OhyWaQeaHwaE8FyfkiCuMD25960WSvn99YHH5iTCIcgm1/ndOjexWuyYf8/HhIjGss/ugfDNbYI0s9CtmMuK6vz88DhIUXDsNDQXAlArMpI2S4C5v9YvTcTBAF7lVggnvzUd84vrTnQBBkOAleordGi5kLSVu7GgFb2qw5YypMyGTw/HbKbY2Pdk0XF76BeQxozLZOUGu1rdB4NymVoPfp2TJcc0f++T/zGP3bMMCtLZETCyOT7qLqOEH4Li04zxrEJaOXSLr7ZxSoWaqb7FrHSR78JPWaYwALnpRNKQw298FX8nK1LoZzKjpTCrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rXCpMKG9; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rXCpMKG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8f3R2mf4z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 20:07:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 11CC160008;
	Mon,  9 Feb 2026 09:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7710C116C6;
	Mon,  9 Feb 2026 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770628048;
	bh=YX2dlUnFy6z+33Wd41/5d2pf3kMRqAOW/vZQUL0L6XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXCpMKG9ftgohCo6zJAAk3a/cq4h/5ZHTZVK2z4PAmybiAC2eNvbFObbxDAOhlJ+N
	 0nLJp3IDDsr2cGyBI8lXgm6aCKUlm+bhT1q63wCU5+xzq4qppYaofzz3sJpBpj5DvX
	 hvTL7mBngd2IQ9boz8RraLah0nSZJ7scLg4EXd0Z0REwj+4OYd3z6KH0YT+z75W7uu
	 6SCFkkOcWZFT2rEJX0MNkv2uY/8MF1Z8q17D2Tv7qW2Iq1R6c9uGDUNwYSoxRURF2w
	 0w2qJL/FMVVac1XZbnxXYECymvBmzNXd0RG2lYiSzZ+FkWH/n2nGxdu4wvFrPcUQrm
	 XfW7Ux4E15JDA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: herve.codina@bootlin.com,
	qiang.zhao@nxp.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()
Date: Mon,  9 Feb 2026 10:04:53 +0100
Message-ID: <177062782918.3769661.1539202055286384529.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260209015904.871269-1-nichen@iscas.ac.cn>
References: <20260209015904.871269-1-nichen@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=500; i=chleroy@kernel.org; h=from:subject:message-id; bh=p8lgMolzAatri58HbwQzvJCCPq3xAD8+zmQmEpG7lXE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR2LjZ3EjSQv9Tbe0Re86g09/2GLIfmeTKyh3drsXF41 XSve7ayo5SFQYyLQVZMkeX4f+5dM7q+pOZP3aUPM4eVCWQIAxenAEzkiyDDX9EVu7UiWYXOb1K7 VTH75AMGzRtpX3w/bTaZ84br34OWldcY/udUesxnOPI6O678Jg/PrHbmHSI5EbvVlIIquqUCzGf 4MAIA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 09 Feb 2026 09:59:04 +0800, Chen Ni wrote:
> Fix wrong variable used for error checking after devm_ioremap_resource()
> call. The function checks qmc->scc_pram instead of qmc->dpram, which
> could lead to incorrect error handling.
> 
> 

Applied, thanks!

[1/1] soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()
      commit: 39676244858f24089f83134bbf975dd31abe7544

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

