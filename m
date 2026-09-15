Return-Path: <linuxppc-dev+bounces-27437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9497FC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:36:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq2C2t0sz2yqw;
	Wed, 16 Sep 2026 03:36:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493795;
	cv=none; b=h8dh8JV7aVyJRU5Hjqgvg4vHnTTWZ4+MLJAYqI8Z0pTQy2WuBSnubaaRP3sh4wyW/1M7K8ARJF052g2yvZR1zP7v9Jvk5H+vNQhe6UfmHBtLgOu3bABRe2EYHH26r5f2QAd/1oHYXhajfM/Y05uFxKy+9UvEeEorWbJPsVOio0ro7b5OmcpGTdozRY8Kb5MY1Adl8UlR12v/cl3TEWBvYQhSO02JFiS6EIP52NyFULwTxSkPgJOE+TSi0cILSnfdyHVo8Qh03MEdhqWFrNQfwNrn18ZOQCFFbue+oQRIrjLPeo4Ow+a0IF70KMF9ujbnySLuBDvlrih/lumVRs7oEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493795; c=relaxed/relaxed;
	bh=FnLmeYIQPAAgZAXOCOf2VNKKiWote+e9JLjawzWka4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mSEzhgtTVO3sriZX0knnlEBssE9C6CweWnaDHqvQhSDSU1QGiXfdk/gv8pdgDzmV45zLean+RljRY83fVW2rFHFQbWkYjCNFAUX5qEfhggBVYu+XtEOhPXtyOxQm06pdWm/UxOWYXVx8sw+QU+Jc16BoAZnLbbrobn5mmYAl3sO9eQZTOJspGO2bPHmyg3+Bszr2uBb1HENoo29I08fsA7A2Y4tyePhZ7JGsitw2QyWzewOOKprZZDJHkfGzR41nKZuPicXpmNwgHOwcRnJGQ0n/162ZGHIBbyBC7jcQCcNx/C5ZbSMbuvPP/QKb+S2cMgvcGiI/WuOzUCFfObz8tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYCjdh1e; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYCjdh1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq2B5SLhz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:36:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81C1E4403B;
	Tue, 15 Sep 2026 17:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAF01F00898;
	Tue, 15 Sep 2026 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493792;
	bh=FnLmeYIQPAAgZAXOCOf2VNKKiWote+e9JLjawzWka4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hYCjdh1eHRYYE/giaeiVwVAAN7Grmep6NWmTu/EfTZ1VRqjb8MNwkBoahrZdrkqGE
	 vdWJ1VmACNvzykGU2kRHMkCZBPsJL0OwZAoXieuoQawaoE08VgFF6Yof3mj1Ryo/i4
	 aPer0R1/wEwhya2O5zy7O9OUhitpFfs/rJ5083su9dwmSX1cZmJQXBJTkFDS0sGPSh
	 qAUJpB2b2g8NYlyn2FnTB0g6n0aNeByQlNsBc5jQuHi2HE3mOnBZvbGZNST2JElCLS
	 PHmxL+Kafqg5HfWILWizuW9IKIHOqNuoPa+Hvhxj+GaCXcPavQZKl4TsLx3FpqWGLe
	 gRjj5EFMbDc2Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Zhang Wei <zw@zh-kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260910202846.48941-1-rosenp@gmail.com>
References: <20260910202846.48941-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] dmaengine: fsldma: kill tasklet before removing
 channel
Message-Id: <178949379014.248239.9161202230659885240.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:30 +0530
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 10 Sep 2026 13:28:46 -0700, Rosen Penev wrote:
> Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
> tasklet is scheduled by the IRQ handler and runs after the channel has been
> freed.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsldma: kill tasklet before removing channel
      commit: 32ac4723e5526c44e5a1f3b1586578c17647f2ef

Best regards,
-- 
~Vinod



