Return-Path: <linuxppc-dev+bounces-27436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D70C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:36:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq291G7mz2y8F;
	Wed, 16 Sep 2026 03:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493793;
	cv=none; b=jzOu+zGzBushs+uN4zrtKQ4+tCVSgUHz8NUfK5tJAZgX6RdTeGyAik3E7mMRjZoZ/xlwsuwBEcXfiaX0VOdvxPlU473IKoFKhNx8LhZ9uZ0RrdzM8tpkZgnNwl+K25zJQr1jB6Eh8sCSK5N/cNl1lbCYhxTmbESZ4Kf/HXkBSY6Mu8rxKzv4oLTX7dPPFj0pw8S0FTk8JPCyIlJczVHW7C+ThZzBITyDr3Jlj/LhHsBh+1cUDo7Ptcf9VGdtcYaEyEo6l07rNm8JNTUESuWHsSkZjPrXm8T6jlTjIpeCg6IkyGLpb/T/IA/nw6ti9EHtr1OK4i7NQHmHuqhCfOqymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493793; c=relaxed/relaxed;
	bh=pcdBqCyKpSLusVdM7IagHkaMfvPdLXkzn1gyiEf9p5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XL6oEwEJ/DAMedxtVdOhin2F9SwFxOidZAeqmNSjtdQUEPuTF/5IAl+GSpwMKlE6xvCHOrkuvRnOUbIJXJ8l1VjHCnyf5w0nFQ+1ALVekkVhGCicxiTxID+a5RclXSI5J3epDTZFxc5bD0uGaSb5hXDjk1jNFTEViODCwhKIAtqHv739k4AvZx816Zn8rsEN2+vCfjiftFlelwJkj5p0NTtzYfBKPLrVhDcTD9WJiDdIHNyB7Y5rgj2fy4IiBRuBtX091p6VD3vjFXgqw4rmkl9txc7cA0cEHCEoblox0gg/vhRp0rXjGcPzGZs1iFpJPy0WNfMc54PIzZ69LpzC+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afiCR1v5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afiCR1v5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq283KK0z2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:36:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39CA3602C4;
	Tue, 15 Sep 2026 17:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143081F000FF;
	Tue, 15 Sep 2026 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493789;
	bh=pcdBqCyKpSLusVdM7IagHkaMfvPdLXkzn1gyiEf9p5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=afiCR1v5pPGV5NTrucW0pjnEfc4qUNDSGMNp2wAaPeaYEqs2S+SYg52i0g2nq9f+0
	 AOfxT/yaKHH8iL1OHgLebrSmNygAIvW98AxjPxudlpjFNl/ZK4xZFYPULrYmOPjmr8
	 DUqu48xDHlQrtMTrcnfyRp8PauB4jWdWA0CmDjKQayLffasXFUfAYQPGerRkwIGvaK
	 wZ1kdkF4S5fDZlmKyJqkA6Ef3L7gXw7wE0OLTdyAeO3+yei8HoUj99ALf17yeEuoL/
	 Cs0OCKCzcSJdbQpzEYxjLtScvn+HJqg/mNsqiPIoksgJMxbUZ5pazL5AWjdvFttAy1
	 QAypmoS+5yftA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Zhang Wei <zw@zh-kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260910202453.47887-1-rosenp@gmail.com>
References: <20260910202453.47887-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] dmaengine: fsldma: fix kernel-doc param names to
 match function signatures
Message-Id: <178949378765.248239.7839228857014022727.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:27 +0530
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


On Thu, 10 Sep 2026 13:24:53 -0700, Rosen Penev wrote:
> Fix kernel-doc warnings where the documented parameter names
> (@chan) no longer match the actual function signatures (@dchan),
> and add the missing @cookie and @txstate parameters to
> fsl_tx_status.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsldma: fix kernel-doc param names to match function signatures
      commit: eb18901d481971c4ee938f59b0256ee8f02e0ce7

Best regards,
-- 
~Vinod



