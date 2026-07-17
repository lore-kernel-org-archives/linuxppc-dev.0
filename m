Return-Path: <linuxppc-dev+bounces-24329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C368C4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:38:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Xbq59RBz2yVd;
	Fri, 17 Jul 2026 11:37:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784252279;
	cv=none; b=WKwGW8Go5OQujo4mYpHPTAEr5TeWGZcWMfPwJCZsnCZxDSfORUnT1w22XmEPx0TaXtT7kNmF9sVnZvvcxolVHWB/rEleC5xNv3PRwQv8QmKuxPCIL1lBAxfsDJabFopIQwU9rg3AqRd7MuCRqgtv1PfeAiBtNWqY8xycrrOKw3DVS2Ul3ZqTxwXvE0CDSQCuhTZZRTpT3yFu0Aez67kTCsqJxD8pbhsnwS3nOSHp/atBlYl0l5Lgq8zEcApXkvHMid3B2cr1PGkFVlG4Oz4hS3auWXKShE0wF2Ims7hVzD6IEKWcnG5O6ZEKdIG/+UbuaAzWjCszG9q1stU9KWiygw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784252279; c=relaxed/relaxed;
	bh=HQWHI05VLoFmTDGLD/8BrEB9TvW9zVg8VbA2I33LjSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhj89pXUUzvO2F1qqg4OKJIrKWxEEl8oSdacMafZnHTpMrQHfqpIrn4UCMa1Ry/sjznumaHsPWUbdkaBU9Yc5NHesT+112OC7Q0flEJJNjKpLXn2VAYhEjCxC/GZdBXwRMFkCQBDl1aD3lLbjWx1mN4OCKv1QI2Cilo2mkCfJ0cdlvuVNh6sPHcQdfT20EmDMH66+IVwmfhzUuLqdc8ADOhX+MEr6wy5gJJ00l5K9EKcD+Z//68nq0z64kZGMPNtHPDZWnGDDVQ7N7XtPyRfBToPlPSMMapiNc8JwjNLpqYTIuZs66HvpMFBTFMH1y4a4FYnOGmVM8CT5gXH8BWcHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIjUb8Ae; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIjUb8Ae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Xbp6sWZz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 11:37:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8313A60A6C;
	Fri, 17 Jul 2026 01:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CDB1F00A3E;
	Fri, 17 Jul 2026 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252276;
	bh=HQWHI05VLoFmTDGLD/8BrEB9TvW9zVg8VbA2I33LjSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIjUb8AeamEEXIjQWPL5g2nKM1WJlVr1ofaI2WGxaJ2yDbrytsFrAgMPqwGwBmtN3
	 7NYI8KEj2LUXkZvvOcs+bda2TUbTbPvjTA7U1Y/MJWyTSy0xhHYiM6XypYjqBoEgSv
	 SoQy6esckD/8rVLNhc+/4l4BIaFbBXn2ntmmt+8PIZ5PL7qeD/6FzvfVqrC9fz07Iy
	 9Kq1WenZdQeSgIToBYH4qXZFlG+/zUqILKX9TbDrN2bbIbHrebV464VadK2s1PDePJ
	 TKQF3Ppf4apxHj75gEcdvUJfgJxACGi8UvkwbliDGtzXVH5rf/40F/QNKhMPldv+Xg
	 J4GYyJpJDbt9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.12.y 0/6] cBPF JIT spray hardening
Date: Thu, 16 Jul 2026 21:37:34 -0400
Message-ID: <20260716232340.0007-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 02:27:39PM -0700, Pawan Gupta wrote:
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

