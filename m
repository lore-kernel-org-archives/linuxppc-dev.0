Return-Path: <linuxppc-dev+bounces-18585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E41FC72A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:02:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffPHk1vyRz2ySb;
	Mon, 23 Mar 2026 18:02:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774249346;
	cv=none; b=dPq69adI9xl0flVYYAyF48gcPCOK4BEIaITbH3n/kqorJh2xjbKy7wKrlLqg7hqQ/O2tJ1giGxvw/cIa8ebXx0tlSzEDrIj1cA2qcOh8bNo5/RJat+7KzJdraUeF/JhGZdOUT6+JYpltEQaG6x4HXoyxSBMvQjaATvkqPYx2nKcShP6s46g0njiSomGiaRAVhAhMzIKPMRBm72hkY6kuafISr4eWFaH8T1eihpyc1/ppcKEycNTwxOZvnPIVjBdTI1RIObc6Sq40Y9ytONKnqBGgg5LQDVYsRKvj+Bu3YZ8kO5m13c9SOorjGfiPPiim1fr/eLbbA74zAgVg8/1uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774249346; c=relaxed/relaxed;
	bh=ymKLyHDUS1Lu6tStQ0lnD46LWrM7guBhCULfBOM2RqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gM/5YSzwtez9FiyUA3rxEUto8a3GSHRLmD7Vd54yd9v0tpINTfBtsO9ckFFqpkj1ouT3bM38CaIg2MM+p9r/IDTTPQjFB8ynljxDvY5glaJroBF7n8bp2h0fsAw6B8lWB8/wEU1wvsHou1XwOXFuWEs8IIga+NPhTawMSuzXioJ2SuIFNnL6JCvuEnUaU8PHbsiTdclD5vqPLzoc1B42ZlytBThbcdaAafHgYt5HL7qc07DBtDPu7o8SVjX7xXMVjhty8/nPx+Ba2V7iscIxYlwNPDAsWLlmtp79E+IF8G0GisG8mvSghqcHoWR8ozgo1Zid/MjSzDJRuAX7f6kY2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d7rz3TJI; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d7rz3TJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffPHb5kg7z2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:02:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ymKLyHDUS1Lu6tStQ0lnD46LWrM7guBhCULfBOM2RqI=; b=d7rz3TJIO5VfLVTCv6nD8Xnzpy
	b30BT6XjmyaGSr0JxhLjSl7zn3uR/MAH6ReoCZRgIETHDH9xETuWjVl1uRgMTja5hExmiG/huXj/+
	I2j7olvaQhY8aeJoqZzCnwYVJC9uyiWYzhx7I3ddO77ONjJOXQbA2QyA/wh4b6nqNHihx0/fRnHR4
	U/oe1EA/ztH2sNKmPNvEi78LRUy02mkByquMVrtYjUTjQO7csjDuoBO4q0uMiw9T+C2Qbwwp+ioUD
	V9zGUDjjZp9w/vA6QMzaWpGFhnDn2zPvL6tx7CuC5bT3HTvyqKTRjd/H+KwKSftEdoFUHhJqPNQYx
	SsVwiEzA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIi-0000000G9ib-15sM;
	Mon, 23 Mar 2026 07:02:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: fix architecture-specific compat_ftruncate64 implementations
Date: Mon, 23 Mar 2026 08:01:43 +0100
Message-ID: <20260323070205.2939118-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes a really old bug found by code inspection, where the
architecture-specific 32-bit compat ftruncate64 implementations enforce
the non-LFS file size limit unless opened with O_LARGEFILE.

Diffstat:
 arch/arm64/kernel/sys32.c       |    2 +-
 arch/mips/kernel/linux32.c      |    2 +-
 arch/parisc/kernel/sys_parisc.c |    4 ++--
 arch/powerpc/kernel/sys_ppc32.c |    2 +-
 arch/sparc/kernel/sys_sparc32.c |    2 +-
 arch/x86/kernel/sys_ia32.c      |    3 ++-
 fs/internal.h                   |    3 +--
 fs/open.c                       |   40 +++++++++++++++++++---------------------
 include/linux/syscalls.h        |   16 +++-------------
 io_uring/truncate.c             |    2 +-
 10 files changed, 32 insertions(+), 44 deletions(-)

