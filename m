Return-Path: <linuxppc-dev+bounces-26380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CA3C624DD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rm6Y6Yz2y2h;
	Tue, 01 Sep 2026 23:13:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268392;
	cv=none; b=ldEMCDkwpE4udQOguatUbXBw4qNq5ZE60DEixZuZYJSbSD9apPNNv+9Qbep9dZS8sc6kCrsfc2xAUp6AYCMQ0/jk2BT6i5/KICaZsLyquDaFP69cm9JPwNcjEN1JkM+YJMukcMP8pEhWviRgpzbipGfQGwCWNDRrc6//Lo+MrXmT8ePCnDlkZum+zMI6U2YiswjsigP8fvE9zxQs7tWz1NEyrcMUwJw9MVZAwbeomUtczPdYsy8j00TxjXz3e9HhsHNrAMY7YHR0Tlkw3y+aFQsiArJY+fxSq0kH5XPR0gUsNfWKZD8Uwifyf+ZTyeJoXj9k844dJpQXsnK2xCKIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268392; c=relaxed/relaxed;
	bh=nsDA+LJTa+8iJxzcAgvgwajibeJnEaZQX0TzVUG51qE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qr7KF5K0BfEZ84iYtoqxel8FGuqiNsfoDCUbOxkVUfiBcElcKC8yfjYa6cMVuU85PIHXwOXYXS6ZnWTw+6htLrnRPgWAYImJuTs+qwxGOVLweoW2XxFNAZgrgSo2TwBnVUiJx6mGAvwNezahqTmvYSZokdXgoCM4JR2NficAB6uiEDpLyyiLFT8XKxYxapQNsNw8hG+W7i8ItAisqT7/C41QYga3tDsBfFK+y3hSaTSJ4TIU21Zt3D7U9H7oLDdiZI2inSiAcXvoRSpBHz+UHmgMeEb9+WEi95dr1z2fNxujRVHz7tJ96fPn7UuyjqWBZhRMISJC6JQ9g9khQYH1sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FGaTAERY; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FGaTAERY; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FGaTAERY;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FGaTAERY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rk4ytJz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:10 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nsDA+LJTa+8iJxzcAgvgwajibeJnEaZQX0TzVUG51qE=;
	b=FGaTAERYcpC87ItXdrTqGuODCClix2oEWW9MjTK2x1194qw4uZwKwiTybEnmXdNSCVxYf/WI9
	Pv60W/lnQEMQmj3o2O/Zwn44MBVuzHagc7hUkhXJVW5y6EzbEwQ2y0nzBZlgLJnvai3vMWQY7eK
	VYaR4XBnt0PSpVoYZj1aS7w=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qx5WYBz1BG7s
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:29 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nsDA+LJTa+8iJxzcAgvgwajibeJnEaZQX0TzVUG51qE=;
	b=FGaTAERYcpC87ItXdrTqGuODCClix2oEWW9MjTK2x1194qw4uZwKwiTybEnmXdNSCVxYf/WI9
	Pv60W/lnQEMQmj3o2O/Zwn44MBVuzHagc7hUkhXJVW5y6EzbEwQ2y0nzBZlgLJnvai3vMWQY7eK
	VYaR4XBnt0PSpVoYZj1aS7w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5bM32Tnz12LF7;
	Tue,  1 Sep 2026 21:01:35 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D15B40561;
	Tue,  1 Sep 2026 21:12:52 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:51 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 0/8] jffs2: extend write verification to all write paths
Date: Tue, 1 Sep 2026 21:05:41 +0800
Message-ID: <20260901130549.1761342-1-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain
X-Originating-IP: [10.50.85.155]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr100018.china.huawei.com (7.185.36.64)

When JFFS2 writes data to flash, corruption can occur during the
write transfer (RAM failures, bus errors) or after commit to the
medium (bit flips). To distinguish whether the corruption happened
before or after the data reached the flash, commit a6bc432e296d
("[JFFS2] Add support for write-buffer verification.") introduced
CONFIG_JFFS2_FS_WBUF_VERIFY: reading the data back immediately
after a successful write and comparing it with the in-memory
source buffer provides the missing observation point for that
diagnosis.

However, the current implementation only performs read-back
verification on write-buffer flush paths. NOR flash devices write
directly through jffs2_flash_direct_write() and
jffs2_flash_direct_writev(), with no equivalent check. Data
corruption incidents have been observed on NOR-based devices in
production environments, yet there is no quick diagnostic tool to
isolate whether the corruption occurred during the write transfer
or after commit to the medium. A significant number of deployed
devices rely on JFFS2 on NOR flash, making this gap a practical
concern.

During the investigation of the NOR flash gap, code inspection also
revealed that when the write data length exceeds wbuf_pagesize in
jffs2_flash_writev(), the excess data bypasses the write buffer and
is written directly to flash via mtd_write(), with no verification.
Additionally, jffs2_wbuf_recover() does not clear c->wbuf_len on
recovery failure, which can lead to BUG_ON in jffs2_link_node_ref()
or deadlock in jffs2_flush_wbuf_pad() on a subsequent write.

This series closes these gaps with the following changes:

- Patch 1: fix wbuf recovery failure exit paths to clear
		   c->wbuf_len, preventing BUG_ON and deadlock

- Patch 2: fix ref_totlen misuse in jffs2_wbuf_recover() failure path

- Patch 3: replace pre-allocated per-superblock wbuf_verify
		   buffer with on-demand allocation inside jffs2_verify_write()

- Patch 4: add byte-by-byte comparison after memcmp() mismatch
		   to pinpoint the exact mismatch offset

- Patch 5: add verification in jffs2_flash_writev() for the
		   mtd_write() path that bypasses the write buffer

- Patch 6: add verification calls in jffs2_flash_direct_write() and
		   jffs2_flash_direct_writev() for NOR flash devices

- Patch 7: rename CONFIG_JFFS2_FS_WBUF_VERIFY to
		   CONFIG_JFFS2_FS_WRITE_VERIFY and remove the Kconfig
		   dependency on CONFIG_JFFS2_FS_WRITEBUFFER

- Patch 8: add module parameter write_verify for runtime
		   enable/disable of write verification

This series extends the existing write verification mechanism to
cover all write paths. It remains off by default and does not
alter JFFS2's node CRC integrity checks.

Changes in v3:
- Add patch to fix incorrect ref_totlen usage in jffs2_wbuf_recover()
  secondary write failure path, which could corrupt free_size accounting
- Add __GFP_NOWARN to jffs2_verify_write() kmalloc to suppres
  high-order allocation splats on large-erasesize NAND
- Link to v2: https://lore.kernel.org/linux-mtd/20260829061658.306854-1-zhouminqiang2@huawei.com/T/#t

Changes in v2:
- Add patch to fix wbuf recovery failure exit paths not clearing
  c->wbuf_len, preventing BUG_ON and deadlock on subsequent writes
- Use kmalloc() instead of vmalloc() for verify buffer allocation
- Keep memcmp() on the hotpath and add byte-by-byte comparison
  only after a mismatch, rather than replacing memcmp() entirely
- In jffs2_flash_direct_write() and jffs2_flash_direct_writev(),
  call mtd_write() before jffs2_sum_add_kvec() to prevent
  retlen from being uninitialized if jffs2_sum_add_kvec() causes
  an early return
- Update defconfig files to rename CONFIG_JFFS2_FS_WBUF_VERIFY to
  CONFIG_JFFS2_FS_WRITE_VERIFY
- Link to v1: https://lore.kernel.org/linux-mtd/20260820105003.2525647-1-zhouminqiang2@huawei.com/T/#t

zhouminqiang (8):
  jffs2: wbuf: clear wbuf on recovery failure paths
  jffs2: wbuf: fix space accounting in recovery secondary write failure
  jffs2: replace per-superblock verify buffer with per-write buffer
  jffs2: write verify: add byte-by-byte comparison on mismatch
  jffs2: add write verification to direct page writes in flash_writev
  jffs2: add write verification to NOR direct write paths
  jffs2: rename CONFIG_JFFS2_FS_WBUF_VERIFY to
    CONFIG_JFFS2_FS_WRITE_VERIFY
  jffs2: add runtime toggle for write verification

 arch/arm/configs/keystone_defconfig     |   2 +-
 arch/arm/configs/lpc32xx_defconfig      |   2 +-
 arch/arm/configs/pxa3xx_defconfig       |   2 +-
 arch/arm/configs/pxa_defconfig          |   2 +-
 arch/powerpc/configs/44x/fsp2_defconfig |   2 +-
 fs/jffs2/Kconfig                        |  31 ++++-
 fs/jffs2/jffs2_fs_sb.h                  |   3 -
 fs/jffs2/os-linux.h                     |  11 ++
 fs/jffs2/wbuf.c                         |  93 +++------------
 fs/jffs2/writev.c                       | 144 +++++++++++++++++++++++-
 10 files changed, 199 insertions(+), 93 deletions(-)

-- 
2.52.0


