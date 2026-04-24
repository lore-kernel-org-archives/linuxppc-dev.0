Return-Path: <linuxppc-dev+bounces-20086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CAFED3EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:03:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Hnm2HXbz2ymg;
	Sat, 25 Apr 2026 02:03:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777046636;
	cv=none; b=HzW4tSDf3EbIrWTwJza7B3B0rWIPv1DcbvZs2t4GSye3E08HLjLcKhM6m1BHVkKcPDLqCfk5jGT33/q8p5gYH7/bVLWVt7bDbs9Cn2wCCOlb21ko5/dYC1r1Se/kfcdTRszUuriNQdarunyfUA3bfo+TvOoewggYF4UgC4yYyTviU416NaPjBUecBI1635f4kuJ+qxNWoG7YO/RGpYgQPFSesW0s0OtJoU3XmelQOPTx4F7SDVs79jSXMKzndF0V4qI3LMiC5KYD7fEXpvzRT1wyLtT4Vwl/dY+gi2wpEmr3SpUo6NtpdF7HrQXDwDx9MbAXx0W+n4Qp8raSzIsYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777046636; c=relaxed/relaxed;
	bh=ygwE4NIp6Mh+rB4JSyL9R6Clad9kO1w9zf/3FTlQF7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nm4Tg4vDeQbqcTtqZNjyxZ2JgkFXYUND4nxAIRnqcOB+rxl+oEAvphLOHloQdQJIyZ/9FoqKvoBebwtcjzfNKAd5EXiejKizT9gHeDvhw67d8VBWN1Yvw6JN5TN1muOcfw6Cd+//X7DATMUZTL/X+nUWrUbHNMGwhtrKlW732QueDgOVPgn2G++cBml3QKUEKvUIoVL2Wi3W/b5pROhFrE6ewzl0BA3bGeV3FLCmABQiAdCNO/Y/LqURs/UWChjbPnUfaHbLyBwWow7HHCvr12AlUfT8Iww9/J9G0dYLdG+5/JtMq0puQKFnIQnnMeD9f8PeO0vwQXRuMXys6ji+AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sQYNy55l; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sQYNy55l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2Hnl3Zq6z2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:03:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A529600CB;
	Fri, 24 Apr 2026 16:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE26AC2BCB5;
	Fri, 24 Apr 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046632;
	bh=F48DLVFetU+KBmzBu5hKSjNo/XPgAf0yJreDNgMNOEk=;
	h=From:To:Cc:Subject:Date:From;
	b=sQYNy55lvNJFuXFwyIMxlbs6emCkZwubiHhsINj7cIOdNV0g5ywg/7p+n5CAFR/lN
	 rF/6V1QX7U2Wuvwt461afb8oobQlaDUhQLQDIMrII3p21qarEzvLWSrJEf76WmRNlE
	 FguhcsV22FRhDkl3eVD+KevZjXQq4RyY3VjZFZGY58Rd/D9Jjla0KBnOrGi3GWO52S
	 nezcYRwImXS3uOu1LGLb7XyYQ/dh57MOusr0K6ctq0hTyuVh7TMjA1z4sEGw+Uf+X4
	 WhROd/Z7fi8Ll/2iS70l7pnLdyHud5fO2gQfWeZZnh4NQwLkCodY2vhEZZBbpHmoR8
	 AresVS4gF1L8g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGJ0P-0000000BDJb-3CC4;
	Fri, 24 Apr 2026 18:03:49 +0200
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
Subject: [PATCH v2 0/3] powerpc: switch to dynamic root devices
Date: Fri, 24 Apr 2026 18:02:56 +0200
Message-ID: <20260424160259.2672722-1-johan@kernel.org>
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


Changes in v2:
 - only set ibmebus root pointer on successful registration
 - add sanity check when registering ibmebus devices to avoid
   use-after-free if ibmebus_register_driver() is called after the bus
   failed to register (Sashiko flagged this path which I had missed)


Johan Hovold (3):
  powerpc/ps3: switch to dynamic system bus root device
  powerpc/pseries: switch to dynamic ibmebus root device
  powerpc/pseries: clean up ibmebus printks

 arch/powerpc/platforms/ps3/system-bus.c  | 10 ++---
 arch/powerpc/platforms/pseries/ibmebus.c | 57 ++++++++++++------------
 2 files changed, 33 insertions(+), 34 deletions(-)

-- 
2.53.0


