Return-Path: <linuxppc-dev+bounces-24763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E7AC531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 03:32:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5tpy4qz4z2xYh;
	Fri, 24 Jul 2026 13:32:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784859472;
	cv=none; b=jPxidUeMPJhiCSJFyJyHXUFSKakGKnMOwNP3IIY3Xs8db0p8eM5qRNsYF5n85qJN8K6/a9g9mA+LQJMwOrGfWUE7/sRbtAqNXpPqq71ddzNcztNVlsGGyrIZEjMZjV/XtFcFXPCINboD1V0vP/RqUOHsRjG/dr16Ywiv69sxyPBw+wb/YtPazpYtI48GSc0TwG29+VUvkjRYxto+/eGXM80qECRQwp1MvTE8IyLQl/aAJ2lEAF/r+ffwgBtUu2Jxo01ld98UKfAeR2RL8jG2mly7xypZYO2SgsxagGgLTg8KWcvpT7CcG1cse5BQHNqcB96YpFIB6pQUMEl0aa50KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784859472; c=relaxed/relaxed;
	bh=R0fZk7cw47NM3PZyeQotTKEsd6zLI7x4WIDlkM2CwcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q83CWkeaGDlELjncpzGTxRw2qd3ro5kaA6GdpMRDwgmxxMMgMOm9tuU08IbDK+U12MYG8IID73TMQCBZ4aT31r1YZhF8aXpJ25CYPAXcy9gICF8VqB3+wpl+3k9pSDLFlcKuWkLff8fp/ylaSN6glb+F9tM9ktuOUdQgv4T20cHMKkbIxdMb5n4GpiuWOO2iW1e4zz0X67ATJAcXgj4GZn4DeI+Unk1IUmfRvFE/cJW65qP80vt2UYguQ8GVOVDBYWXI7WdEI68ZEwEZ5+SgLFHZFxlBs6j73T4U2uV6VYqYiLqdOn1+9ZyuSaMi4k3hHwNCNLYpRSjT5ILYpD4e0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com; dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=e4V5LBZg; dkim-atps=neutral; spf=pass (client-ip=117.135.210.8; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org) smtp.mailfrom=126.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=e4V5LBZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=117.135.210.8; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org)
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5s8Y1Tmlz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:17:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R0
	fZk7cw47NM3PZyeQotTKEsd6zLI7x4WIDlkM2CwcM=; b=e4V5LBZgUcm5oq799U
	7a3h6abrPnRrCCVAvummdZRPY8PbC0JeoIi/jMUsu3oBmHVz0vsso+pLxULG/D1v
	xCoCVPqs72DWoIg/AsQRHgzlMviTeGpOYmqNBW1jHGynpeFYHGo6XiuVKyQ4sbm/
	oxpAlt6fWlzkbCvbLcBdYsNNA=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S4;
	Fri, 24 Jul 2026 10:12:43 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 2/3] btrfs: Allow error injection on btrfs_data_csum_ok
Date: Fri, 24 Jul 2026 10:12:28 +0800
Message-ID: <20260724021229.47302-3-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724021229.47302-1-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
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
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWfZr4kWFykJw4xJFWrXwb_yoW8Xw4fpr
	WUGw1ruFWDXr97Wrs7Gay09ryFg3yDWa10gFnxZw4YywsIkw1FqrZay3WxGa48KrZrX343
	Z3Z0gw17ZF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USeH9UUUUU=
X-Originating-IP: [221.238.56.48]
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRvra2piyhtNggAA3o

btrfs_data_csum_ok validates the checksum of a data block
after a read I/O completes. A mismatch between the on-disk
checksum and the one computed from the read data indicates
silent data corruption, which can be caused by bit flips due
to DRAM errors, storage media degradation, or bus transmission
faults.

Testing the error handling path that responds to such
corruption, including any warning output and uspace
notification, normally requires reproducing the hardware
fault, which is not always feasible.

Mark btrfs_data_csum_ok with ALLOW_ERROR_INJECTION so that
the fail_function infrastructure can override its return value
to false, simulating a checksum mismatch without requiring
actual data corruption. This enables validation of the full
error detection and reporting path in a controlled environment.

Usage:
        cd /sys/kernel/debug/fail_function
        echo btrfs_data_csum_ok > inject
        echo 0 > btrfs_data_csum_ok/retval
        echo 100 > probability
        echo N > times

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 906d5c21ebc4..6be3e920b954 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3574,6 +3574,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
 	return false;
 }
+ALLOW_ERROR_INJECTION(btrfs_data_csum_ok, FALSE);
 
 /*
  * Perform a delayed iput on @inode.
-- 
2.43.0


