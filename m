Return-Path: <linuxppc-dev+bounces-20067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84784FE5204
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wn2wh8z2ypV;
	Fri, 24 Apr 2026 20:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026981;
	cv=none; b=g4Tif5lx1hx6xHQukUYlGFOI3GpI8Mz5fYbN2in6uDtRHUk4vKzzghMVmSD7vJrhYCvu62NbBxks6yWs+fmMH3qoNZiwXXE5HDEOO8iPiQEs8pPhXbiFrYl9OAlh3KANtUgk4WXdADTPdQwgaHwOYGQAp2OwYHvmRtVzgzx0TN1xEmeuQI599buq1BcKJuDg9Sn6GQ2Yb4ae28xUnViQhibAzUbWgTgDXbT+4fmDNDinWI3gsrX7oX4dYtwhjX3sm9xjeFQvdgdECGELudAGVcdKqTxjPNNQ40e1EFDyOgr7D9MXWMBPbHxRwQ8Dt1ksDPIqYKNwKKPqW1HxrWDwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026981; c=relaxed/relaxed;
	bh=swanGyyHRnhkz3mBV65rrTG3fNZhjUZNTL4EhPwa10A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB4GAzvc/E1hUk0YgM0R1zWmpuU67tSlMBf3vptdWrB2/EzHCyjdqS/N21xfWbdgmBYfTmH0DSXTF0S40PdJXMsmdKkeOvGg6FEe7lQVkFpL1ZZl/Lmo/PF7ZSp947QWeaPcN2aaqCjT4EMPXdTT5/Xa8AmTuA8mAZnjQqkox1hRuYqK3LpnP17iQ11f7DZqG142wHMQ0O71yoYjm1IrNSPQrnLXjcA4i301yYpRFExqknEnLj7divnnyzbgTKTBJK3HkMdN5MqhNdrHf4J55fI4Xxzn6z8NQiv2BNuv7HqyUtQqadnjX138RaPKYj/HxkU2y4kN5jogYqcm5Yrv4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ig1zxbmG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ig1zxbmG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wm1s8Jz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A7B4060121;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59704C2BCB6;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026977;
	bh=J5JHKULmi+OYKTLmnufD8fAye9o4hGx73PlE0mD4LOo=;
	h=From:To:Cc:Subject:Date:From;
	b=ig1zxbmG10kjNRfMlYUJ7X6aMVc9cZVmWUC4cWXsrH6c/dPAVRUYK5K7JYLyf6bh6
	 eSZCtvGCWPqSp3CcUhIyuAokyP+bT55jnx5zNl/N0ksFw6uyv43clZgO3eA02B34Lu
	 Fhv2TmR3RErIoazhwa+9fKB1HApVAAagPSkQpdTY/6bbFEHb608CQ3yo6BxzhGDuWm
	 U08cRxlGecQtEduFwu72Gy0XEMJqLSvigYbdqaz5iQ//B4ha4dLKJFTMrpv2al787B
	 5rxJF3pY0CPJRNnTq1rddgEPQG7qh8KO31l0hjIZIyfQZRIqk16odTR04e+p+vva6d
	 +k262blxWnuDQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDtP-0000000AyiX-0jVD;
	Fri, 24 Apr 2026 12:36:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] powerpc: switch to dynamic root devices
Date: Fri, 24 Apr 2026 12:36:01 +0200
Message-ID: <20260424103604.2616657-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
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

This series replaces static root devices with dynamically allocated
ones. Included is also a related printk cleanup.

Johan


Johan Hovold (3):
  powerpc/ps3: switch to dynamic system bus root device
  powerpc/pseries: switch to dynamic ibmebus root device
  powerpc/pseries: clean up ibmebus printks

 arch/powerpc/platforms/ps3/system-bus.c  | 10 +++----
 arch/powerpc/platforms/pseries/ibmebus.c | 34 +++++++++---------------
 2 files changed, 17 insertions(+), 27 deletions(-)

-- 
2.53.0


