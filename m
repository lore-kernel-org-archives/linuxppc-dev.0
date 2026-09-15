Return-Path: <linuxppc-dev+bounces-27439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DEFC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:36:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq2L40yFz2y8m;
	Wed, 16 Sep 2026 03:36:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493802;
	cv=none; b=St95JOEUPK/Tsp7ZIOD8y0u0S742zM0dYzZE3kybN/eMgJKRKpC5mZPNOBnuxJO6hS7lEPG4fEFbt4LjXCprOawtvbTclRqTIzTXY9q4vjMYbYgg1MeyjYjaKBS49AfScr9DSfuFTZoN2hxUqLsP26rHU7X8KS2DPZ5lzFKDneEj2OEuz3RxW0ovzR7B4nTNp3gpiiGd1+OKj5YlJfQWZMtENJGKtPaUhN/DCDMqh4bgMh8pilozhUpKZ+uB15y5eKsr9DFhbLb60G7zAAool/u4yHdkxVoCVWYqwS5lzctz5tnJZkvkwVmsfZMrO4fMkv+UfuhqTRj4wAn4UmoXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493802; c=relaxed/relaxed;
	bh=eU+QyDuRh8rn3c7grMKH5arPf7g3bSGEarn06XP+mVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ndL3QkoL/2lTrbgDEJ6LIODSnsIo6yCeJCyHbQuY3gQVzqWfMIh9NM9euIB+3U34Nr2YDOTr7Wjn0jEtqZ/4iAcWbPjY2KlwMHVAU26t/Q0admAv/GyKJZoLmaJAoKmlEQ6/rPLZGxHf8Mvqdk8rTe+kuR7eSH8ep7Y3JcuNQ03wGFlpYVk1AbA1SCkv8V21B94Mf/o9F+8m0gCQ1aOHz4fFoZuabdVwLKHd/uajssuLtRXg6UYLKdUIMQlRotKIKprA9Jl0VVXPuHCcPXJoNcCDI+WQVo4APuRSr9/pWu0H6/QwLWjKAScsv2q0riT0yDcy8YHwBWWUvRmedKdZIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3aNArZz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3aNArZz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq2L0g1dz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:36:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2FBFB602BE;
	Tue, 15 Sep 2026 17:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4DC1F000FF;
	Tue, 15 Sep 2026 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493799;
	bh=eU+QyDuRh8rn3c7grMKH5arPf7g3bSGEarn06XP+mVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z3aNArZzqdTtvCK/RTJ427HuAB1eIEq2M1RjXoTT0sMvZhoeGiFGAcm1YLR6h4lUG
	 W/sIXfqynspCqzH1sQ9JtVcPK4OgxHQUBWdwfKFKh5OWTNu6d3Ao87IjkzY8q9b/YN
	 nU7HgD4lcQfe6MAqLLXsBIgCb48N8nzcYFS3c8d82oTko9pFHsjsnAv70ESvCVckgQ
	 77nRRT/3iZJQUZKSSV70MfEg7OOLgS+k8t92G5jvsy748MK0QjbsbbpHWEGO0InYnA
	 A8x0kFW04Wa5HVbFbC0GgVNff0l9AKl9W1oGThDiPemx9xVd4GWd/8YzKkeZKleVMk
	 OL3Lx+4Qvzz4g==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260913194804.39939-1-rosenp@gmail.com>
References: <20260913194804.39939-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] dmaengine: bestcomm: make gen_bd init helpers static
Message-Id: <178949379734.248239.352418063118190567.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:37 +0530
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


On Sun, 13 Sep 2026 12:48:04 -0700, Rosen Penev wrote:
> bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
> the PSC wrapper functions in gen_bd.c, so make them static, drop
> their now-unneeded exports, and remove the corresponding header
> declarations.
> 
> These had use before commit 7d3ee229ea51
> ("powerpc: Drop MPC5200 LocalPlus bus FIFO driver")
> 
> [...]

Applied, thanks!

[1/1] dmaengine: bestcomm: make gen_bd init helpers static
      commit: 1ff9bed1b5547259f67e58b03a83eda934d78735

Best regards,
-- 
~Vinod



