Return-Path: <linuxppc-dev+bounces-16729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA97E7E0BA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 09:58:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8gBf69GLz2ydq;
	Mon, 09 Feb 2026 20:58:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770631130;
	cv=none; b=HUOq5j7J+Hm6jzCFdv+2chbPQ2/kWjIPtU/AyXKYvYq4Aa+9FBGzuLElAmzwBGhsz4ElmKILKt8NJ5ttSJCi5t/TuJy1bjb26aTbYZ7HVWNa6u6Ni+ext2J/fd+o6Pzyo5LDRdyqWnGGnty/oVpIgsD7oFu2hLtEiDccK1RYvWJGmlkB+WlmPB0zSsVJtD4bI+Q60fVnt6cV06TLmwPU05Z7KJ4c/Hz/ZM9G6mpSqcmia9T5KBEH55+QbKEPEvacgCZjRVaHegK+dbQuYu4jxk2ULVQlhOja5dGOh8ygI3Zqnfk8+Nraf193rSG3eqE8qiiMkLb/L2+/y4XGpp5xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770631130; c=relaxed/relaxed;
	bh=rZbn2DX+TpOyjPxTrik+wvw3h17J9tL/MLsovlvAZxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S9MNWmunZDq2ME6Ab9cafPzfugR4vd9pvDVy1WK/goSfc2/0DePlRB0Vm3oAX6RsvygD9hqa4mwKsOMjPIjRGbRqS4cYXHTt0sBPe+FtXPqytNs82CJDJoj1Buh0oLAIGqxRGZYncdYiAMP19xVdpDbrs/STRFlP1mLrVGUVfH9sSUjAt3VQ4j6KEc9l5+G5hZNqAxJVbHJTZfw1D4X5B6/ZnkfvDFbwXTzc7eq5CIr/ShYY0QHhsPp5sIclLBNTTQlAgLJ7YUL6qGCpNy++qS9w7+L3+HFSVQ/amEFxza0NW9crtE+0rAJl5QhSAcYS1ULME40Deb9RTUwivvGKug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hhs9dNsd; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hhs9dNsd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8gBb2MbRz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 20:58:44 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rZbn2DX+TpOyjPxTrik+wvw3h17J9tL/MLsovlvAZxo=;
	b=hhs9dNsdwe4qkbK7HPFjHzXVe+tEdgWvlYgxvjQ+66g+iSMAe6/pwiihzhDiak6cf8lDusHvs
	OcMhzeSKNnSvqdRfFEnMQI0HtAxRMeSjpqLj8wOnfenTD8HasNqQUnmpYZapopvoOtj8aqI1qqk
	Qk1z6f7tD12iwcZTC7CUEcw=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f8g5D4r3jz1T4K2;
	Mon,  9 Feb 2026 17:54:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E25840538;
	Mon,  9 Feb 2026 17:58:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 17:58:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<arnd@arndb.de>, <lirongqing@baidu.com>, <fvdl@google.com>,
	<leitao@debian.org>, <rppt@kernel.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<sourabhjain@linux.ibm.com>, <osandov@fb.com>, <ryan.roberts@arm.com>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<thuth@redhat.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<bjorn@rivosinc.com>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <dwmw@amazon.co.uk>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kai.huang@intel.com>, <ubizjak@gmail.com>,
	<coxu@redhat.com>, <liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Date: Mon, 9 Feb 2026 17:59:28 +0800
Message-ID: <20260209095931.2813152-1-ruanjinjie@huawei.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Exclude crash kernel memory in crash core to avoid duplication. Also move
the size calculation (and the realloc if needed) into crash core.

And add support for crashkernel CMA reservation for arm64 and riscv.

Changes in v4:
- Move the size calculation (and the realloc if needed) into the
  generic crash.

Changs in v3:
- Exclude crash kernel memory in crash core as Mike suggested.
- Add acked-by.


Jinjie Ruan (3):
  crash: Exclude crash kernel memory in crash core
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

 .../admin-guide/kernel-parameters.txt         |  16 +--
 arch/arm64/kernel/machine_kexec_file.c        |  47 +-------
 arch/arm64/mm/init.c                          |   5 +-
 arch/loongarch/kernel/machine_kexec_file.c    |  45 +------
 arch/powerpc/include/asm/kexec.h              |  13 ++
 arch/powerpc/kexec/crash.c                    |  52 ++++----
 arch/powerpc/kexec/file_load_64.c             |  17 +--
 arch/powerpc/kexec/ranges.c                   |  18 +--
 arch/riscv/include/asm/kexec.h                |  10 ++
 arch/riscv/kernel/machine_kexec_file.c        |  39 +++---
 arch/riscv/mm/init.c                          |   5 +-
 arch/x86/include/asm/kexec.h                  |  10 ++
 arch/x86/kernel/crash.c                       | 104 ++--------------
 include/linux/crash_core.h                    | 114 +++++++++++++++++-
 kernel/crash_core.c                           |  71 +++++++++--
 15 files changed, 290 insertions(+), 276 deletions(-)

-- 
2.34.1


