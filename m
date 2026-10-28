Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489D606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pmoe/AMv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDvzW5jXXz2xwL;
	Wed, 28 Oct 2026 15:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793162983;
	cv=none; b=FoDIvT8YqoRLLj9L+oMgHG4p1cMDlaCgwb0AA9R2DPvnmFevpjtPAlfMTtKlMmpudN6dy6KNJRjquwAFLrmAozakxC35bOpxKJoVONmWTo07eT8rbUhZr/kiaMX534cn3hLLOfCmoaeDtIha8vKeU/+/SWxvNP6YpB+vV7n3mstkcE5d3rmFTVnUSP84vB9ZOeCyYemfBvFNgyAqPQcjR7p8SMO6aXGEvAiRJalANzCLn6J4BIJ+EVCqni6RM5j2RpMOfkdofuY3+6M09/GxRcdPp/xmegg11wm43Jr0u9+GI0r2kIN1g+4/JjRefbAHMo8VGqxkgrSDwmAndyoFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793162983; c=relaxed/relaxed;
	bh=5eX6ZERtxMma6IIiwk4zjHSJGCnTW5TdkQ89tZL/8dM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YGxaXmST9qUM+L57HDYmvjiFC9wNA3gelymCNIErw27SkVLuh0GMx+hqdQD1CwCYWHKdE6EskY7AQz00IcodpyUyA5OprPyMh3lpButA6LIxfBEeHFNb08hXqWLbabdXuMBH8Sk3JTJxAcOk4nPbPe8bm95hegfoeQXqM5g5OQwWp+xeCZkxWfSXJkaBeJdMVdJGys2G/N+AiU08wu/pcTvURLd3lNvwSxKoGi99HrjiRomot5FWG625CRCaDQOrcIjhWTj3fTuA9HQJwJDLsENYfuWZcVrhx/QvlE2uex/pta9uUxNvD5IrKQRGUEKDwhloKtU79o46dSpOMJT2lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pmoe/AMv; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pmoe/AMv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDvzV1trtz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 15:49:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5e
	X6ZERtxMma6IIiwk4zjHSJGCnTW5TdkQ89tZL/8dM=; b=Pmoe/AMv61DOoUS7hw
	fJtrZ1OMVnBesqPe6v4a8+oGDtdeJ3Kmtf4tf4a4NHv6eHPXLarg1WgKZ5yBzh2D
	sCKfYqy6c0tdGZ0XZrY36teHjocwbfTitnmOp/cu5Kq9/4MNwk/sKJvQ7YHsj4rp
	O2kCYpKzGX/5HwlY9DZzq6lCs=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S2;
	Wed, 28 Oct 2026 12:48:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Steven Royer <seroyer@linux.vnet.ibm.com>,
	Adam Reznechek <adreznec@linux.vnet.ibm.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/6] Initialize device state before userspace registration
Date: Wed, 28 Oct 2026 12:48:20 +0800
Message-Id: <20261028044828.96177-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWfGw4fZr1kWFy5Xry5Jwb_yoW8Jry3pa
	1Sg3sYy392krW7Xr43Zay7Ga4Fga48uayUCF90kw1FgFs5CFyvqFW0qay8tFWDJFWxA3W0
	qF10vrWxGFWUCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpE_NUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x7ZFGrhfp6IQwAA3c
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several drivers register character devices or sysfs attributes before
initializing synchronization objects and related state used by their
userspace entry points. Registration makes those entry points immediately
available, so a concurrent access can reach partially initialized state.

Move each initialization ahead of the corresponding registration. The
patches are independent and cover AoE, fsl-mc, MSHV, IBM VMC, DCSSBLK,
and the RDC321x watchdog.

Jiale Yao (6):
  aoe: initialize error message synchronization before registration
  bus: fsl-mc: initialize UAPI state before device registration
  Drivers: hv: initialize partition table before device registration
  misc: ibmvmc: initialize HMC state before device registration
  s390/dcssblk: initialize device semaphore before sysfs registration
  watchdog: rdc321x: initialize device state before registration

 drivers/block/aoe/aoechr.c       |  6 +++---
 drivers/bus/fsl-mc/fsl-mc-uapi.c |  6 ++----
 drivers/hv/mshv_root_main.c      |  6 +++---
 drivers/misc/ibmvmc.c            | 16 ++++++++--------
 drivers/s390/block/dcssblk.c     |  3 ++-
 drivers/watchdog/rdc321x_wdt.c   | 12 ++++++------
 6 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.34.1


