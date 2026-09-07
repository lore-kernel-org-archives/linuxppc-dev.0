Return-Path: <linuxppc-dev+bounces-26697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1944DC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 20:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdzpq493Jz2yql;
	Tue, 08 Sep 2026 06:54:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788814499;
	cv=none; b=HHjcJ10pPwdkVVzlXSNOCtOQZnuLMJrYAw5Ev85/wsLCrHeVi09FmSMv/YnObybLGr798/NiEbFOGxITgLd6P2bQjUkazTgpPeEx05bilABWXagtSQKa91YoTox1tBzalUeavZo1ky7g6SXoA2cZhbvEAdppmCohQnV/FKZDc8UTzHW7XI4LYU65hv4vpRvTNwtAH30k80afrbRBFlaP09DaGRKDjrac3VJ9auLqw+CmPcHjNgZ8Q9YgDGjmnr52f7UfODqUDUtMstE1u11ThTPxTW8lCneQEhJjUoYgVuZhmbP1IDrIsr9njaXnfvO+kb8dZWHY6ARq0f95GmrIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788814499; c=relaxed/relaxed;
	bh=DszcB6B2Baeds68gqqmdhNYLmUsAE/lCLovJMtCHvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ+RncB9LBSN8ZhzH2srJmEwNMxW7ObXYF0tHnBl3gv+HcgjhmAppV0SgROwyx8WhTI6ksgYuUKYr9RnLqVZJDjL7cstZHy+cgYsV/nuuR/Le0FcW21dzRnGG0R/WZjqJc7PDkTJuPs9gkmTN079oKebzSQINtIUz9EUW6n4BxUzwGN+bOdmPW9mYRadA1C0/YyEZeNj7wUDM5TsjYcLtGdxoaUePeouVsZPMrQMrIz1ODq8prm9+W5O0WaKdTiYuhaumrHztA2rlmtxsLZ7x+Oh2/V8K9LYtDzi0pdg6ih6nOvkEcTD9hUtjUnvRx6JTsv8/BM0DfEnaNWqfg1YpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ny1MpYS7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ny1MpYS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdzpq0mpBz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 06:54:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D23C601DB;
	Mon,  7 Sep 2026 20:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF971F00A3A;
	Mon,  7 Sep 2026 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814497;
	bh=DszcB6B2Baeds68gqqmdhNYLmUsAE/lCLovJMtCHvsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ny1MpYS7/xWLiXnWpMkW6Ga0kN0e25oxyFxaYR4yOIaJZYBE0FLmRpJ+YrZUEFPPu
	 keSFF6Lp6rXH5mjypNursTBCQfZL5SdNy5oHcY/SZK00Rl3TcENgaDJlAt0Oaa/V47
	 Ysw+QOy1Fp1hYlt7rTIySPjhxQP5cbpJ0hUgDx4G17EWdYd3YoeoIrApEkcPt2YIIM
	 dItz4WlBeldhaZBTyhDy2DCwrs122/4BJNuI7u1XG2rfNclatEfpLCSWcY4WfGq1aJ
	 92fXl0WzUMM3PI1fXEcvbxtiQLT1reFAUQyujn1HIGKOSDoERmTF3jFQEPcoG4Ja8k
	 ksNfjD8YJkNsA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bogdan Purcareata <bogdan.purcareata@nxp.com>,
	Stuart Yoder <stuyoder@gmail.com>,
	Vincent Jardin <vjardin@free.fr>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: set dma_mask for the DPRC devices
Date: Mon,  7 Sep 2026 22:54:37 +0200
Message-ID: <178881446329.32908.11212951412522310651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731-for-upstream-fsl-mc-dprc-dma-mask-v2-1-ea7058b90f06@free.fr>
References: <20260731-for-upstream-fsl-mc-dprc-dma-mask-v2-1-ea7058b90f06@free.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=560; i=chleroy@kernel.org; h=from:subject:message-id; bh=M9/sCvI6UDN5RnwxgdqjKii4Rlg+88q5sddKIwzSa/Q=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTNV5nKllvA/PYFtzJHopqMcpTBzkRhkVlv1u6tbeGbc 3HaipK9HaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiJ+Yy/OFcdfr0ii0/nVIY xM+Vd9vGqxxsO7NMJm27jPSacwe7me0Y/in6LPn49XLYu7Rs53rzZd5r+Pw99fN4lm9Y7pC140h BOy8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 31 Jul 2026 22:13:49 +0200, Vincent Jardin wrote:
> On Layerscape platforms when SMMU is disabled by ATF, the root DPRC probes
> with its dma_mask pointer unset which leads to a notification:
>   "DMA mask not set"
> so the device is left with a zero DMA mask instead of a sane default.
> 
> Let's seed the masks for all cases.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: set dma_mask for the DPRC devices
      commit: f85e5ec18eb104574433caec67f452dd6e02d5de

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

