Return-Path: <linuxppc-dev+bounces-25074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D77C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fw926mLz2xwH;
	Thu, 30 Jul 2026 16:50:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785394217;
	cv=none; b=oqQrLuFMmQnw1Q/F7/FWtJMWgFtZW+w3b8/ZRpeS44jkd9b4+YP8ym9kxcagIYhNjwkG0S6n4ZawTe9s4n96K//SbPbratLjuQ6LHPnkrbTiQ0KyuRtdk3+jSmYw7IU9+oAq2zIteUne4VTsfx2VaoFHMEYIu0wfimQc3C3COAwDZDauTN0VXJcjAVPx6/j7CB3gG7Ch2w8f/9PVOx3KlbGgAnnORwpvOwxRtFphvgwL8FYzl+5l1Fe846QgPi0QcvKZZozkbxjONyWfwJGGuB9zsn+5AorxfA16CQiytIP+nawHZz6+xhSQTN14H8OFkdoJF6f/cbUm6JEWYK/tBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785394217; c=relaxed/relaxed;
	bh=YAQbWgLO85+KQC5FuwIpEK/nBhYQ4P4I2Jls6/J5o4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l43Lh5NjATG4YBGvF5JOMLu/n3Ah+3S4sHzAZidiT1wECj71fr4yHnViZmjiL76o5T+btv1UT1m6s18RuALZiHg+sMcX58JGcjzSOX/n9mZD2O3k6KQtDG00ByHbc9EuwlfYmJpT6rTSxJCN6iqeJcs9CrAl8NC4ckOoRZ/4cX+ObJrkJ5SX6o4x20cv12AowtTa8BU2iMG5OnFiX2vKuqhHOjyoZibk+v8ZQT3yqJk6IDlsJeCbd6FjrLLDtbGhDo0sYRhNh/vZcYTLXt5sGKVjQM/g/nCVTuAGGscxCsVQlxlL45eI12vO0UqAkaHEg+53XhG7bsRmiHxz2ofoCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fw82K9Mz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:50:16 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 053FD7099366; Thu, 30 Jul 2026 08:50:13 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Christophe Leroy <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
Date: Thu, 30 Jul 2026 08:50:04 +0200
Message-ID: <20260730065007.964703-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two local variables were only set but never read on 32-bit PowerPC,
which causes an error during compilation with W=1.

This series first makes the 64-bit guards consistent by converting all
uses of __powerpc64__ to use CONFIG_PPC64 instead, and then guard the
two variables rc and suffix behind CONFIG_PPC64 checks.

Link Mauve (2):
  powerpc/sstep: Consistently use one define to check arch bit width
  powerpc/sstep: Don’t define variables we won’t be using

 arch/powerpc/lib/sstep.c | 111 ++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 53 deletions(-)

Changes since v1:
- Link to v1:
  https://lore.kernel.org/linuxppc-dev/amrpdv0g__ELifId@desktop/T/
- Switch from __powerpc64__ to CONFIG_PPC64, as it is the preferred
  check.
- Document that the build error was only occurring with W=1.
- Declare both variables on the same line.

base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
-- 
2.55.0


