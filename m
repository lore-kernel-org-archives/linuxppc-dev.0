Return-Path: <linuxppc-dev+bounces-22985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E979CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmN1g12Xmz2yVd;
	Fri, 26 Jun 2026 01:26:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782401174;
	cv=none; b=hiP5/VxW4v5UYcp4LyzKgT6S4mEU7mvLBzZkxOR/Qjt/Cwe1iQL+3O3geAIQe2F5CiSLjtbTT2IXUmlKFI5zO8AG8UZQ5JAI1XEorpZHAXlOINsB8wu23NPmEBwNxVWN3A2LlhfnCOBJ3IDIHuCgtXq6h1UjdEyKmL2pqXx8R9C5R44ajZgek1NmHxqjkNThUR0WQc4zAVzgyhmRmxnLsHhhc58LJwF8tkQAzLfjmX1QYXmV+y5nTX+LDGClHTyjaiY0YoQFtrveuMES4kST1VgZC0+IwB7nsh0YvSIGnMo/iXul4lFlPTj1pj4bpicTaTX6iZctoqov49YKUPdjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782401174; c=relaxed/relaxed;
	bh=5CnqIZrXbOvj5YTogFA5mNwwB12cmB+wEc2uMYZ9VoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYDdU22zDVoP70B+CI1F1+0ASZvzYV9r+d0q1ZQy7fw0JQ8wGZSU4X90IpmJFOdVD5AOAWspsWq4G3HG64oEMsKFgBkTlH2bWGVRo6BIth/iTTxoBKlhviXGwDHDnfaMAFU3r/37s4rjZXDbz95+ll8XFboGUseQi5ZQc5baeaSyt24ldvEf0vqOksxv6i3isbTMwauGIBL475sGobCWqtwJ2hi/CYpT7Pwe4L93ddaCcLOb9EwmljSPG3wSzsmRHn/B0bJFrZba3n0bYUr3WcV+2XzwDGtO8DPjpFAT0wXB9BKbPlOUzSxFwBllI2vUhjYrcrwJ8rT9BEIadCUKzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=e07tngQX; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=e07tngQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmN1d3zymz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:26:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401169;
	bh=5CnqIZrXbOvj5YTogFA5mNwwB12cmB+wEc2uMYZ9VoI=;
	h=From:To:Cc:Subject:Date:From;
	b=e07tngQXAOEZscw7ItyoLzxMsp7Ue3bldidYfHVIzLCq6lk4TxQcueMgQ9+yxl3dz
	 3xNtlINvBBG2n81B7hmWnqomB805PfqiomxKlInI5v4VW66KJAMOqJW6Q3z4tMAQH6
	 yD4iwzTxJJ6gJBE8x4H+AFLjVPljCZbA1sYBgB6s=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1Y5KFRz10hn;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1Y0NDvz10j8;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 0/4] sys_info: prevent duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:54 +0000
Message-ID: <20260625152558.7450-1-include@grrlz.net>
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

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
When they strip that bit, an all_bt-only mask becomes zero and sys_info(0)
falls back to kernel_si_mask, potentially duplicating output.

This series adds sys_info_with_filter() to filter specific bits without
triggering the kernel_si_mask fallback.

Changes since v2:
- Use sys_info_with_filter() instead of sys_info_without_all_bt() per
  Petr's suggestion
- Filter applied at __sys_info() level to handle kernel_si_mask correctly
- Added panic.c conversion

Bradley Morgan (4):
  sys_info: add helper for callers that print some sys_info on their own
  watchdog: use sys_info_with_filter() to avoid duplicate backtraces
  powerpc/watchdog: use sys_info_with_filter() to avoid duplicate
    backtraces
  panic: use sys_info_with_filter() to avoid duplicate backtraces

 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 include/linux/sys_info.h       |  1 +
 kernel/panic.c                 |  2 +-
 kernel/watchdog.c              | 12 ++++++++----
 lib/sys_info.c                 | 20 ++++++++++++++++++--
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.53.0


