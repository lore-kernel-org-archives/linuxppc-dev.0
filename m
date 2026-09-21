Return-Path: <linuxppc-dev+bounces-27818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08989C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:04:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNB3qcGz2yVd;
	Mon, 21 Sep 2026 19:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981450;
	cv=none; b=m3Usp4CwyzlB+93iTA2bVUPu/LT/h8m4/IoNAnTWl2y8RcY/YSajtJq+P3GvS9Pejy1K6V44T1/jF89VUOB4HUjuM5uRvuZ6Ik7SQlY090RV5NyUNDG4twFgsTHvw2YBpzexOGF6MAJW/3zRYDSJs2Cr94jz+MrGWPWESJakGMdtucLwS4zxGRTu+0ZvBQTzaEbYCcjRfKo5LNfPIRXdkUOe45A7qQ0yWqX4e3jUs/Hpz1nfgCxA8Q3I+r1PgnkEB8QvDW33/VLAFSN1qs8WyFKQ/2H0pAzZgy8KUYfi4r79xpt8siCfmASOFQxDtSMhg98FFnQSvOFnnTjna3ukKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981450; c=relaxed/relaxed;
	bh=sTno8QnJjZ/NQezWYbQKFncttJxmDy0EzI/+jGwfMVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0htC0WqrkdwjNacvZ7wnVelHTtROLVE8WFExBB1rTyFGJP6ZVFKpJoMiqEN0TY4oBis6ADGm/rXRKzv0Uw7YA4pE4prnTPl5h9cZ2lmQiyt8MMOdvZhA3I5RLyYm1ZDb1CdVm7YLVIy77StIjDctW07C9RKUxvyG2cNFmQccjwVprcUwHlQOO4jCIEMWIGZjJn2pknLIn5w64lpXwcxpElPOPRLbnQPV9W6EKxlfvjA6ftWf2KrYqVjFr5NDNm3J+8NdT1kqce7iuqP0Dj2mJLl2BuB4+BOP8/eqvi9jCJBf3CFwKOllf4Vo08batirwdgETlsW5uS+0WcmtTxRQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RG3+rh09; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RG3+rh09;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHN73w2Zz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:05 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sTno8QnJjZ/NQezWYbQKFncttJxmDy0EzI/+jGwfMVY=;
	b=RG3+rh09RlR70S2nXv0n410ZV6z6gI6QSZ0h754wyzJZrJY5a85/5/WZxRMszjBbYOjDUawqp
	Uwo6gmlt4LyCUwzjnXlm82CY0CiMdWGRqmhAv0bErvQ/oL2hc2YS/J7wRPgJlGgaxmOuYKBHtAY
	bEALB8nx4uDcbCbpYDe2Rpw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7B3PYdz1prN6;
	Mon, 21 Sep 2026 16:52:54 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CE7A4058E;
	Mon, 21 Sep 2026 17:03:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:03:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 00/14] crash: Fix several bugs
Date: Mon, 21 Sep 2026 17:04:36 +0800
Message-ID: <20260921090450.807575-1-ruanjinjie@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

As Baoquan and Catalin suggested, this patch set fixes
several pre-existing code issues found by Sashiko AI [1][2][3].

The major improvements and fixes included in this series are:
- Fix several memory leaks for arm64, and similar issues on LoongArch.
- Fix out-of-bounds write on 32-bit Highmem for x86.
- Fix TOCTOU race in crash memory range collection.

This patch set is rebased on v7.3-rc3. Compared to the previous version,
split out arm64 crash hotplug patches as Breno suggested, which are based
on these bugfix patches and will be resubmitted after this patch series
is merged.

Slightly tested on x86_64 and arm64 qemu with:
- kexec_load (--kexec-syscall --hotplug)
- kexec_load (--kexec-file-syscall)

All boot successfully into the second kernel.

[1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
[2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
[3]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com

Changes in v6:
- Split out arm64 crash hotplug patches as Breno suggested.
- Remove unused elfcorehdr_updated [4].
- Make the patch split more clear.
- Link to v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/

[4]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com

Changs in v5:
- Rebased on v7.3-rc3.
- Fix several pre-existing code issues reported by Sashiko AI review. [3]
- Add an extra slot for memory hot-unplug.
- Add device_hotplug_lock_assert_held() helper.
- Rework to let the hotplug paths to skip CPU events entirely, which avoid
  the TOCTOU race of memory hotplug events and internal CPU offline path
  without holding device_hotplug_lock.
- Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/

Changes in v4:
- Rebased on v7.3-rc1.
- Update the kexec_core code as Mike suggested.
- Update the LoongArch subject as Huacai suggested.
- Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
  Sourabh suggested.
- Drop x86 related patches because of branch conflict, which will
  be done later.
- Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
- Handle elfcorehdr_index in arm64 arch code.
- Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/

[4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/

Changes in v3:
- Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
- Fix several pre-existing code issues reported by Sashiko AI review [3].
- Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
- Rework related crash and arch code.
- Add test method.
- v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/

Changes in v2:
- Split out Powerpc bugfix patch as Mike suggested.
- Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
- Convert pnum_hdr_sz() to a function.
- Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
  crash_handle_hotplug_event() already performs validity check on
  elfcorehdr_index:
  - We can safely remove the check for CPU hotplug
    in arch_crash_handle_hotplug_event().
  - The elfcorehdr_index's segment mem will be valid in
    update_crash_elfcorehdr(), so we can safely remove the NULL check.
- Simplify the commit message.
- v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t

Jinjie Ruan (14):
  kexec: Fix CMA segment address translation with non-zero text_offset
  kexec: Record allocated CMA pages to fix release size mismatch
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
    loops
  LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix a modified_cmdline leak
  x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
  crash: Extract crash_get_memory_ranges() helper
  crash: Factor out crash_find_elfcorehdr() helper
  crash: Normalize the kexec_load elfcorehdr at load time
  driver core: Add device_hotplug_lock_assert_held() helper
  crash: Fix TOCTOU race in crash memory range collection

 arch/arm64/kernel/kexec_image.c            |   1 +
 arch/arm64/kernel/machine_kexec_file.c     |   9 +-
 arch/loongarch/kernel/kexec_efi.c          |   1 +
 arch/loongarch/kernel/machine_kexec.c      |   2 +
 arch/loongarch/kernel/machine_kexec_file.c |  10 +-
 arch/powerpc/kexec/crash.c                 |   1 +
 arch/x86/kernel/crash.c                    |  40 +++++---
 drivers/base/core.c                        |   5 +
 include/linux/crash_core.h                 |   2 +
 include/linux/device.h                     |   1 +
 include/linux/kexec.h                      |   4 +-
 kernel/crash_core.c                        | 114 +++++++++++++++++----
 kernel/kexec.c                             |   4 +
 kernel/kexec_core.c                        |  43 +++++---
 kernel/kexec_file.c                        |  13 ++-
 15 files changed, 192 insertions(+), 58 deletions(-)

-- 
2.34.1


