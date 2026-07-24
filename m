Return-Path: <linuxppc-dev+bounces-24764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF73EC531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 03:33:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5tqq1KCrz2yYq;
	Fri, 24 Jul 2026 13:33:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784859472;
	cv=none; b=FhiyxH6H31ECEh9Yg7LJmNUjra/wM3CO7BDWw4t9JTqhpCWxmDvSL9RwuMRz17bAcQZL0urBkAYh3Y1DrDDHSCmnO0OuToW3KidCvUrWhSy3r61vf6ZYSPstQGmd6dqtqHJQQvYxk9LP/sB4XmPRv8Vr3uWb71qNAjcf3a9/f315aOJ3hhhw62F1qtmNGsvX+FJhP+SV095Z9/njnIHoiHWxeKekteHjGYlLPdx7z38yDu+8RoB2icXST67FqBpIP2WsGhIBs9VUWD+EEIFZl1yFsYP7HYZ1mLU7OO9R3yTIhDIiutJV2RaYJUJiCYdQbb5ss2IT+F77NfXgLRdWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784859472; c=relaxed/relaxed;
	bh=77TlUQQ5Ug6Bo+r9yStAO1cYSC7lbr5tqO3K9ciX64s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVkDTc6Vfqt90D+N8Ec8kHm20+i6JDf7Pj5DrkqqVRzXGEE0gK7CgoFR04BWShgit2SgfP6AqK5kseJ/BJUg17Erqw5Qfshsnfa5CNIoo/upVZljb/6Nu2GX2GWDHdFpYNuUip5zJk1EePyb8Amd8jgsXuMQ8MuSW23V+XuOTzYyGw0jD8rMFBmdx528r2R4KnevT6OZb7aoL2eUJZE1ywGzgMCklwCuWlpXZVwQCuwLWlMTQG7QGguhUmlkhZU3MG/1Anz1ACGfdm39p85K4+4SYqoTpXLLFGRcICuRkUVNcUG9suNNCFkVHAZpsUSn8bnvOi4CjGqOGMq9LMP37g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com; dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=A58Q0hC7; dkim-atps=neutral; spf=pass (client-ip=117.135.210.7; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org) smtp.mailfrom=126.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=A58Q0hC7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=117.135.210.7; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org)
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5s8Z2Tr6z2yYf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:17:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=77
	TlUQQ5Ug6Bo+r9yStAO1cYSC7lbr5tqO3K9ciX64s=; b=A58Q0hC7pBgmyd1P0k
	hLdauK2xNyRBVzvhAisrBvhwe51IYuU3v9CdBPEmeUuNhaOUQCGDOQWF5MJocr6d
	sUDDytIRZ4RCNVAsuNo5OmI5d3/Yw40nyoy5CkXb3KuvjzGCqY5FdMsT584qwXjb
	/BY0wrzWkU1UlbE8vhPU3x/hE=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S2;
	Fri, 24 Jul 2026 10:12:35 +0800 (CST)
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
Subject: [RFC PATCH v2 0/3] btrfs: add error injection support for checksum verification
Date: Fri, 24 Jul 2026 10:12:26 +0800
Message-ID: <20260724021229.47302-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xWr1UWw47tryUKF4Durg_yoW8GF1rpr
	y3u3s3uryrC34fCrnxAay8Zw1Fkrs5W34UXFnrG348W343Za4qq3WkKa4UJ3WS9rWUGw17
	X3WUKr4UWr1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UonmiUUUUU=
X-Originating-IP: [221.238.56.48]
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxPpaWpiyhNNnAAA3g

This patchset adds fault injection support for btrfs_data_csum_ok,
enabling controlled simulation of checksum mismatches to test btrfs
silent data corruption detection and reporting paths.

The first patch extends the error injection framework with a new type,
EI_ETYPE_FALSE, which allows bool-returning functions to be overridden
with a false return value directly.

The second patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION
using this new type.

The third patch adds a parent field to fei_attr to allow fault injection
on a function only when called from a specific parent function. 

Song Chen (3):
  error-injection: Introduce EI_ETYPE_FALSE for fail_function
  btrfs: Allow error injection on btrfs_data_csum_ok
  error-injection: Introduce parent in fei_attr

 arch/arm/lib/error-inject.c           |  6 ++
 arch/arm64/lib/error-inject.c         |  6 ++
 arch/csky/lib/error-inject.c          |  6 ++
 arch/loongarch/lib/error-inject.c     |  6 ++
 arch/powerpc/lib/error-inject.c       |  6 ++
 arch/riscv/lib/error-inject.c         |  6 ++
 arch/s390/lib/error-inject.c          |  6 ++
 arch/x86/lib/error-inject.c           |  6 ++
 fs/btrfs/inode.c                      |  1 +
 include/asm-generic/error-injection.h |  6 ++
 kernel/fail_function.c                | 98 ++++++++++++++++++++++++++-
 11 files changed, 152 insertions(+), 1 deletion(-)

---
changelog:
v1 --- v2:
Add a parent field to struct fei_attr.

-- 
2.43.0


