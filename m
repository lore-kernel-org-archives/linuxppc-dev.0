Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F772606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WXo9wn0N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLwc2pTrz3bYf;
	Fri, 13 Nov 2026 00:34:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794490496;
	cv=none; b=nsJjNWEdPWlw0JwJk9WHyJM0rrGrFJZ6gUj5f5I5IdNIz4WpWYXiDr9+0KY5uhiQE0k+GtMmZ9yTlpzZED4U1cQyZCknxsT9bNSY4jE+kxszCXm3+RjnquqtQctP/eu6UpQYWGF3mJp0J4xI25/7nlFCTSc79ZQ08szoqUPgD85s0U7AijFqgkkXR0VKIwgRCdWU4WYiiYgcmF8i3KbplUIuiAi3UE/3zLdPJeOrhYLZ1SfkIwhskx8ec7hDjKDz/WMxc0fCDTCx7YTKS8pWAoy0Sg9nENyzd9XYfO7iQ9Almx6Z8YsvWKfmHNDW4u8XukL8VyglVUcrIX+WUkZCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794490496; c=relaxed/relaxed;
	bh=ZBHTfkePstkdhYPStihPwpZhe6evYsJ4HxGFWI7xQIQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBtSPXX0eLzLye+aXaU0WgQlbybyqCqzAB9zOQfQLdXjpeWWZaMIoheAa6GyatV5C94vRta28lBNuLiM+lom1psICfG+vH6JyZRoClMniqsmdouxFdKoFbn3DmLjruphPP1p/qbjClmDfBRJaNc3QIbg7pbJd6UHNHfPobNtyc/1eIY1fRip0+fI41vhHsdoz2FKRlbwmW6TaxviQiBOMYMQo3SlefdRqWXSi+hXcw8mjQMKg8bhCJn48kD4TCzNRONp4B9biT8UweYHMziyQeRN7ijnn1MP2SpuoY9zXWsA2Uc4lHjKSI3lZQlEFLBm83BEGxSv64MXpZSnrlCfzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WXo9wn0N; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WXo9wn0N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLwV3L2Wz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:34:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZBHTfkePstkdhYPStihPwpZhe6evYsJ4HxGFWI7xQIQ=;
	b=WXo9wn0NXhZX7pp7ZUMh/iOPIRLVlUIH2p8LTgXE7ANDOBqTMLMcJn+ioAx56LEYcQClNy3LR
	fhpJPlEmx97/Kbdl53DCIYli9z7cMxKnOY197T93hS34sNl3vH29acpUDwGroc1TguVRSPeD6C6
	amzAd2VIz8neRJeZS5pH9T0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jQLvT1RGbzpSt9;
	Thu, 12 Nov 2026 21:33:57 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B50E040579;
	Thu, 12 Nov 2026 21:34:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 21:34:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruanjinjie@huawei.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <mpilaniy@redhat.com>, <robh@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@Red54.com>, <prudo@redhat.com>,
	<brads@mainlining.org>, <sourabhjain@linux.ibm.com>, <mkchauras@gmail.com>,
	<blum@kernel.org>, <adityag@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<richard.lyu@suse.com>, <arnd@arndb.de>, <tzimmermann@suse.de>,
	<rick.p.edgecombe@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<piliu@redhat.com>, <thuth@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <tangyouling@kylinos.cn>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v8 00/11] kexec: Rework segment loading and fix CMA retries
Date: Thu, 12 Nov 2026 21:34:07 +0800
Message-ID: <20261112133418.4044428-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ARM64, LoongArch, RISC-V, x86 and powerpc build the elf core header
and place it together with the initrd and the DTB with almost identical
code.

This series reworks that path into common helpers that the architectures
reuse, and fixes the CMA page and elf core header leaks in the arm64
and LoongArch placement retry loops.

The patch organization is as follows:

- Patch 1 moves the release of the elf core header into the generic
  post-load cleanup, so that the architectures no longer free it
  themselves.

- Patch 2 adds the common helpers

- Patches 3-7 convert arm64, LoongArch, RISC-V, X86 and Powerpc to
  reuse the common helpers

- Patches 8-11 fix the CMA pages leaked by the retry loops and
  the loop that makes no progress

Tested with kexec_file_load() on arm64, LoongArch, RISC-V, X86 and
Powerpc under QEMU, including the CMA retry paths, loading a crash
kernel and booting the second kernel, with the agent help.

This series is also available at:
	https://github.com/ruanjinjie-eng/linux/tree/kexec_rework_cma_bugfx_v9

Changes in v8:
- Rework the common code as Mike suggested: the core provides building
  blocks and the architectures uses them (Mike)
- Build the elf core header once and only place it on the retries (Mike)
- Keep the segment order and the arch placement policy unchanged (Mike)
- Convert x86 and powerpc as well
- Move the CMA fixes to the end of the series (Mike)
- Link to v7: https://lore.kernel.org/all/20261026075201.699550-1-ruanjinjie@huawei.com/

Previous Versions are as below:
- v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/
- v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
- v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
- v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
- v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
- v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t

Jinjie Ruan (11):
  kexec: Free the elf core header in kimage_file_post_load_cleanup()
  kexec: Add helpers to load the elf core header, initrd and FDT
  arm64: kexec_file: Load the other segments with common helpers
  LoongArch: kexec_file: Load the other segments with common helpers
  riscv: kexec_file: Load the extra segments with common helpers
  x86: kexec_file: Use the common segment helpers
  powerpc: kexec_file: Use the common segment helpers
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  kexec: Add kexec_rollback_segments() helper
  arm64: kexec_file: Fix CMA segment placement retries
  LoongArch: kexec_file: Fix CMA segment placement retries

 arch/arm64/include/asm/kexec.h             |   4 +-
 arch/arm64/kernel/kexec_image.c            |  15 ++-
 arch/arm64/kernel/machine_kexec_file.c     |  87 ++++----------
 arch/loongarch/include/asm/kexec.h         |   3 +-
 arch/loongarch/kernel/kexec_efi.c          |  15 ++-
 arch/loongarch/kernel/kexec_elf.c          |   3 +-
 arch/loongarch/kernel/machine_kexec_file.c |  80 +++++--------
 arch/powerpc/kexec/elf_64.c                |   9 +-
 arch/powerpc/kexec/file_load_64.c          |  18 +--
 arch/riscv/include/asm/kexec.h             |   4 +-
 arch/riscv/kernel/kexec_elf.c              |   3 +-
 arch/riscv/kernel/kexec_image.c            |   3 +-
 arch/riscv/kernel/machine_kexec_file.c     |  83 ++++----------
 arch/x86/kernel/crash.c                    |  25 +----
 arch/x86/kernel/kexec-bzimage64.c          |   8 +-
 arch/x86/kernel/machine_kexec_64.c         |   4 -
 include/linux/kexec.h                      |  14 +++
 kernel/kexec_core.c                        |  25 +++--
 kernel/kexec_file.c                        | 125 +++++++++++++++++++++
 19 files changed, 254 insertions(+), 274 deletions(-)

-- 
2.34.1


