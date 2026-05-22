Return-Path: <linuxppc-dev+bounces-21377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E45CCD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLK94NxHz2xc2;
	Fri, 22 May 2026 19:56:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443805;
	cv=none; b=CWdlpLyMBIgn874kzTuNVW7WY15iZqV4qO97xLGMNaGdEDs4NA5F9BOloysw5yoLagw7NW9ff/lG1aCuFjxuaQJ+eUOISwFU1C17mrGDN7BSO1UWQ2x/bImCYXTu0iq6DbKjT7zIzl1cxqYE9zUEz/wFG8BHMgmoIkIB5oAh1EaXKi+Lgnrwrf1X6takBWEodcpZjlKyFSvSudPCtb65MhJjbNMEUj3uIXvVGl3a/oUnLC4KZRMm70kLqKjIHFfRnmfN9wtp6Umq76D/TbDHx2pZd00VJk+AyXZuCayJEjK1YqGCd5twHhWaE24c2bYsFR89eSijdDb4eFG2pXZgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443805; c=relaxed/relaxed;
	bh=fzwgZUQEacu3K8PcuQ/7zhHyuadt9SEQ2ccJ0dnfKhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldOMludN+3YTkBgUZ19QnpKy1jvKCzlgb4kEeqy/u1f2zhPFxP91Voiz4cxsv2gjLQ3FYKikWiFcyOsoq42Jo7M9/GRMPeIMD786hPrWTFU76Ee7muE+RqhmHfHaENxTsK/EBTKJxS5dC/S2t2Bxlo6WWNxllrLXaqzlbLjOl+Stm42eugi7/8rEdWjamkm7UEDnglzFLmeCpc9Urs454FkTqe/3+qzfpauynY6wSTju3ZQCnTbEGuOWsnztDpISnx+UAwAQ7WqvJqdIQNN/0CjdnTBSCQYkPDmcE6wyNaxhxm+/AbgBw2oP7qO/tSpGEh34p5CNN9X1ByXnt4JCwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKcve0Qt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKcve0Qt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLK732GVz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BC86160136;
	Fri, 22 May 2026 09:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B3E1F000E9;
	Fri, 22 May 2026 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443800;
	bh=fzwgZUQEacu3K8PcuQ/7zhHyuadt9SEQ2ccJ0dnfKhw=;
	h=From:To:Cc:Subject:Date;
	b=aKcve0QtayrCzcg0SnSnj+rVB3nViL1XW98creJ9xjT10+oP+wutVD8TnpWfxuP4k
	 rpOR1wey77iYeo/a/fMmJf6SZqguqa48cBkDEMSkTzNr8xM+7+iHO9Q5yLrCDn0RQ4
	 FxoEDXvnRVo+5fRMjEfIDbKRCjvV8qQyFnfZIveuL5xZXcWc6Gxbt3lZsK5AmXYBj/
	 R9mfAuRAuA2cx/Lrq5rYRqf4CvKj+NACvJD2EjpAMgZdjjm2K1YpHdLXKSdvWzi9F2
	 0xse62NVfYF4QELm6Zms//E30pYTftLBmmLeSskjODZsMqpK6e6/SpGQhdJEHiwR7P
	 QzzusGkpu/Gbg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/8] powerpc/signal: Convert to scoped user access
Date: Fri, 22 May 2026 11:56:00 +0200
Message-ID: <cover.1779441786.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=chleroy@kernel.org; h=from:subject:message-id; bh=gT4/7lN4HmOIFqSwIFAmkc8jTKq7PVEB70sBkJ3jm+E=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaJi9/e37UOr/9J1vol/drg9sWeicvVDCR8J5dV+Oi ensbVGcHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiEcsZ/pdtnaA++VTBxS+a em8DbFU+9G7W/xnjtSNx3h6/yZ4nzWwY/lk6rXnUGHCVw85u3benk7u8LsloBk88uO1s0oJ/i9d /XcECAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

This series converts powerpc architecture signal handling to scoped
user access and enlarges some of the block accesses to minimise the
number of times user access has to be opened and closed.

As mentioned in individual patches, some bring real performance
improvement.

This series is built from previous series [1] which predates
implementation of scoped user access.

[1] https://lore.kernel.org/all/1718f38859d5366f82d5bef531f255cedf537b5d.1631861883.git.christophe.leroy@csgroup.eu/T/#t

Christophe Leroy (CS GROUP) (8):
  powerpc/signal32: Convert to scoped user access
  powerpc/signal64: Untangle setup_tm_sigcontexts() and
    user_access_begin()
  powerpc/signal64: Convert to scoped user access
  powerpc/signal64: Access function descriptor with scoped user access
  powerpc/signal: Include the new stack frame inside the user access
    block
  signal: Add unsafe_copy_siginfo_to_user()
  powerpc/uaccess: Add unsafe_clear_user()
  powerpc/signal: Use unsafe_copy_siginfo_to_user()

 arch/powerpc/include/asm/uaccess.h |  20 ++
 arch/powerpc/kernel/signal_32.c    | 498 ++++++++++++++---------------
 arch/powerpc/kernel/signal_64.c    | 120 +++----
 include/linux/signal.h             |  15 +
 include/linux/uaccess.h            |   1 +
 kernel/signal.c                    |   5 -
 6 files changed, 323 insertions(+), 336 deletions(-)

-- 
2.54.0


