Return-Path: <linuxppc-dev+bounces-27693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E3EC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSs60cPSz2xYg;
	Fri, 18 Sep 2026 20:04:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725866;
	cv=none; b=klu6xnbjIdab3B45FPhOrdZbSqGuQww3Z+vLpKRwCx9o1i6/RV8qZAQK6CJbpfsD29VKRzMENAhBYzktZWxEGTOs4Zk5RckHTRn/mPw+hQzziIiKZMQHpvUUAACSA14FxJlsmJoGJAXxjCTjbzlIo4UCpVSSyNfopuouU1+vZIIZuXMNOY5Ww1jnfhG3eLwhiavcVZIft7c9WNejiVBTVhFDTaaKB9vQ1GE34mopQG1ad0ofarl5dgoev1L3JcKmbQAgnRJRJiBmjjqviGNIYDGiNo0y/KjvMq67gUm9eZi9+cDs9kUfHMaTpHSSfnQsg+Eu4J4r/AGPmGvsQtLbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725866; c=relaxed/relaxed;
	bh=EOHA0/QYz5xuB3tvJyr3yacJBYiZYap2Q9rrEaqTc0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFk8JLveNUpzljGgDBHwnBSgt2gGbPAIt8HN3ckcncnItMSFoODou0hW2FZIrps4c0ejyy7UYEJTUQ8kXvViNNyFdeMzMdfzyLJrggGVWYNmP47giZ/EFwbXPWKNhBcYeoRWZwOvRTrV7j41se2ybCwf1gVtoR+oD82n2nllTlJdVEt3wQf0jr04OYe97ClznYq1k/ZQbUZ9uKw+s1WzcyGGsLl9y9Hm9hNed36P+crUqsHAdCX8z2H/7klRuTLQgdadd6fzdSXTpRw+XpshIDA5EsRCd2oqdXzRoxfUwZLG17OepzU1UoU9xQJT9pUsNujd2+HrLwYRF7FcY+JbCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qk1PVVbt; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qk1PVVbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSs055gGz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:19 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EOHA0/QYz5xuB3tvJyr3yacJBYiZYap2Q9rrEaqTc0c=;
	b=qk1PVVbtJxXdKcs9wpTlzPoFToj5fhJMqZXlKRUbGqvztUzDiFmXx13jYea2QU56vbEQg6D2C
	eV1GOMr3NYNQwfkv/JjGEqLjMUkL4BPXCI42trcrh9qwTFWSefYzUaLRrZed3BOpq8NJrKi5BeS
	kyXWpicfA8rwz/bHdl6VRMI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbp3RV0zcb3G;
	Fri, 18 Sep 2026 17:52:54 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D11E40561;
	Fri, 18 Sep 2026 18:04:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug support
Date: Fri, 18 Sep 2026 18:04:25 +0800
Message-ID: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)

When CPU or memory hotplug events occur, the elfcorehdr in the kdump
image becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch set implements crash hotplug support for arm64.

As Baoquan and Catalin suggested, it also addresses and fixes several
pre-existing code issues found by Sashiko AI [1][2].

The major improvements and fixes included in this series are:
- Fix several memory leaks for arm64, and similar issues on LoongArch.
- Fix TOCTOU race in crash memory range collection
- Simplify arm64 load_other_segments().
- Implement infrastructure for arm64 crash memory hotplug support.

This patch set is rebased on v7.3-rc3.

TESTING
=======

Only kexec_file_load path has been tested; kexec_load is expected to
work via KEXEC_CRASH_HOTPLUG_SUPPORT flag but not yet verified.

Tested on an arm64 guest using KVM-QEMU[3] with the following
configuration:
        -M virt,acpi=on,highmem=on
        -m 4G,slots=256,maxmem=16G
        -smp cpus=4,maxcpus=8,cores=4,threads=2,sockets=1

1. Memory Hot-Add Test

[Step 1] Load kexec first:
        ./kexec --kexec-file-syscall ...

[Step 2] Hotplug and online 128M memory and trigger crash:
        (qemu) object_add memory-backend-ram,id=mem1,size=128M
        (qemu) device_add pc-dimm,id=dimm3,memdev=mem1,addr=0x160000000
        echo 1 > /sys/devices/system/memory/memory44/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify vmcore layout in the secondary kernel:
        readelf -l /proc/vmcore

The newly added 128M memory segment (0x160000000) is successfully
recognized and populated as a LOAD segment:

        LOAD 0x... 0x0000000160000000 0x08000000 0x08000000 RWE 0x0

2. Memory Hot-Remove Test

[Step 1] Add memory device and online 128M memory first:
        (qemu) device_add pc-dimm,id=dimm3,memdev=mem1,addr=0x160000000
        echo 1 > /sys/devices/system/memory/memory44/online

[Step 2] Load kexec, offline memory, and crash:
        ./kexec --kexec-file-syscall ...
        echo 0 > /sys/devices/system/memory/memory44/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify vmcore layout:
        readelf -l /proc/vmcore

Result: The 0x160000000 segment is cleanly excluded from the vmcore
        program headers, and the dump completes without any hang.

3. CPU Hot-Add Test

[Step 1] Load kexec first:
        ./kexec --kexec-file-syscall ...

[Step 2] hotplug and online one CPU, then crash:
        (qemu) device_add driver=host-arm-cpu,core-id=2,thread-id=0,id=cpu4
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify notes count:
        readelf -n /proc/vmcore | grep -w CORE | wc -l
        5

Result: Crash hotplug responds correctly; the newly plugged CPU4 is
        tracked, and 5 NT_PRSTATUS notes are generated.

4. CPU Hot-Remove Test

[Step 1] Add CPU device and online it first:
        (qemu) device_add driver=host-arm-cpu,core-id=2,thread-id=0,id=cpu4
        echo 1 > /sys/devices/system/cpu/cpu4/online

[Step 2] Load kexec, remove CPU, and crash:
        ./kexec --kexec-file-syscall ...
        (qemu) device_del cpu4
        echo c > /proc/sysrq-trigger

[Step 3] Verify notes count:
        readelf -n /proc/vmcore | grep -w CORE | wc -l
        4

Result: Crash hotplug automatically updates the headers upon CPU
        eviction; only 4 online CPUs are registered in the vmcore.

[1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
[2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
[3]: https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Changs in v5:
- Rebased on v7.3-rc3.
- Fix several pre-existing code issues reported by Sashiko AI review. [5]
- Add an extra slot for memory hot-unplug.
- Add device_hotplug_lock_assert_held() helper.
- Rework to let the hotplug paths to skip CPU events entirely, which avoid
  the TOCTOU race of memory hotplug events and internal CPU offline path
  without holding device_hotplug_lock.
- Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/

[5]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com

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

Jinjie Ruan (17):
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
  crash: Normalize the kexec_load elfcorehdr at load time
  crash: Fix TOCTOU race in crash memory range collection
  crash: Assert device_hotplug_lock in crash_get_memory_ranges_nolock()
  elf: Introduce elf64_phdr_size() helper
  crash: Introduce crash_extra_elfcorehdr_size() helper
  arm64: kexec_file: Simplify load_other_segments()
  arm64: crash: Add crash hotplug support

 arch/arm64/Kconfig                         |   3 +
 arch/arm64/include/asm/kexec.h             |  11 ++
 arch/arm64/kernel/Makefile                 |   2 +-
 arch/arm64/kernel/crash.c                  | 171 +++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c            |   1 +
 arch/arm64/kernel/machine_kexec_file.c     |  63 +++-----
 arch/loongarch/kernel/kexec_efi.c          |   1 +
 arch/loongarch/kernel/machine_kexec.c      |   2 +
 arch/loongarch/kernel/machine_kexec_file.c |  10 +-
 arch/powerpc/kexec/crash.c                 |   3 +-
 arch/powerpc/kexec/file_load_64.c          |  15 +-
 arch/powerpc/platforms/powernv/opal-core.c |   3 +-
 arch/x86/kernel/crash.c                    |  43 +++---
 drivers/base/core.c                        |   5 +
 fs/proc/vmcore.c                           |   6 +-
 include/linux/crash_core.h                 |  22 +++
 include/linux/device.h                     |   1 +
 include/linux/elf.h                        |   4 +
 include/linux/kexec.h                      |   3 +
 kernel/crash_core.c                        | 115 +++++++++++---
 kernel/kexec.c                             |   4 +
 kernel/kexec_core.c                        |  42 +++--
 kernel/kexec_file.c                        |  13 +-
 23 files changed, 422 insertions(+), 121 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

-- 
2.34.1


