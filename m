Return-Path: <linuxppc-dev+bounces-26096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72949C61DCD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:25:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK4m0tDwz2yh4;
	Wed, 26 Aug 2026 19:25:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736328;
	cv=none; b=hjQq0X25ng1ZsfuzUPMEzWReNrQG3j5zmvY9vgFGEIio7pq685YxZWHewGsMf3EQn+HV5A+Uu+ODio2dKbZnML8ykZ6tL1FnHMcHJ3Y1IQXfsHmyLcASAuN90XJlVtvf9v60EIR0tevFzAV9omTqqo815AiIo1oButNm9Lyl9uq/LgcMCnriU0fv9WnMhkTgMvfJslDq51+sK3xS77XS4UQ3MCsTflEqz45xRgi6Cnuo1j+MC+rC4Z594qygUW5NxgUMONLDvqwW1nG5Gp3xlk1ct/7iDJNwrBAsSv1J0yf2SD/W4nJDXDnd7XptteZXTU2YcYFlZbitad7dJw8VrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736328; c=relaxed/relaxed;
	bh=9edbR+c1lIWwnMXcuZ4KLnLfBU2ND4Eytl1ZUtAADc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQpiH28gE9xHPiTXevLJCVghGPEhDGlNw1dPJJGMY34frAAIiD/db6tfjIY15wwcWlsjNjg64WDNkLgsqVk4ixs5pgml0Eb7hrlnSkhUb1gsvsV+pfx9d0hfEVPBnHcgPtG746mqVp7G32irUf9L4XX6hGbWJnpow0Hf+NGe/8wOybGUIWEtWlP4rgi5raBmkzlK3cTaWRPJUJObqL44J1S7J1xvX2x1sqVSUDcG8PBoXxSXF/2ZstbNjGHJp6eWCIgaSrZw23+yS1nC+kUQJEYCbJPyvK8X3iALmqzZzgVhMYXX77WY+C2KPzJPfKeXNeE+qc4n9EMyC2FQC1U4bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KBVStN8d; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KBVStN8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK4h3Rc0z2y32
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:23 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9edbR+c1lIWwnMXcuZ4KLnLfBU2ND4Eytl1ZUtAADc8=;
	b=KBVStN8dWPuI9yiBGp/Kx3AtHQXr/JcHChmjwO+KMIF1cJvdn8dAp/8Bewckmuy7wkYaOMIR4
	ij3HNnpyCUcZ9hM3ZViAfMc6YQ+wna5UnBvYWUkemqrG8cx+eM57NwbIFrlq/YG3TQAKabbsqZR
	iOqhygocFvk052U3Kzzseq0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hVJr151wrzRhWY;
	Wed, 26 Aug 2026 17:14:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 61173202E6;
	Wed, 26 Aug 2026 17:25:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 00/17] crash: Rework and add arm64 crash hotplug support
Date: Wed, 26 Aug 2026 17:25:24 +0800
Message-ID: <20260826092541.3905933-1-ruanjinjie@huawei.com>
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
 dggpemf500011.china.huawei.com (7.185.36.131)

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
- Simplify x86 related code.
- Simplify arm64 load_other_segments().
- Implement infrastructure for arm64 crash memory hotplug support.

This patch set is rebased on x86 fix [3].

TESTING
=======

Only kexec_file_load path has been tested; kexec_load is expected to
work via KEXEC_CRASH_HOTPLUG_SUPPORT flag but not yet verified.

Tested on an arm64 guest using KVM-QEMU[4] with the following
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
[3]: https://lore.kernel.org/all/20260826073527.21487-2-ionut.nechita@windriver.com/
[4]: https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

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
  kexec: Record allocated CMA pages to fix release size mismatch
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec: Fix CMA page leaks in segment placement retry loops
  LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
  crash_dump: Fix potential double-free of keys_header
  crash: Extract crash_get_memory_ranges() helper
  crash: Fix TOCTOU race in crash memory range collection
  elf: Introduce elf64_phdr_size() helper
  crash: Introduce crash_extra_elfcorehdr_size() helper
  x86/crash: Use num_possible_cpus() for elfcorehdr size
  crash: Improve elfcorehdr segment identification
  x86/crash: Simplify crash_load_segments() using
    crash_extra_elfcorehdr_size()
  crash: Simplify CRASH_MAX_MEMORY_RANGES handling
  arm64: kexec_file: Simplify load_other_segments()
  arm64: crash: Add crash hotplug support

 arch/arm64/Kconfig                         |   3 +
 arch/arm64/include/asm/kexec.h             |  11 ++
 arch/arm64/kernel/Makefile                 |   2 +-
 arch/arm64/kernel/crash.c                  | 165 +++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c            |   1 +
 arch/arm64/kernel/machine_kexec_file.c     |  57 ++-----
 arch/loongarch/kernel/kexec_efi.c          |   1 +
 arch/loongarch/kernel/machine_kexec_file.c |  10 +-
 arch/powerpc/kexec/crash.c                 |   6 +-
 arch/powerpc/kexec/file_load_64.c          |  19 +--
 arch/powerpc/platforms/powernv/opal-core.c |   3 +-
 arch/x86/kernel/crash.c                    |  46 ++----
 fs/proc/vmcore.c                           |   6 +-
 include/linux/crash_core.h                 |  27 ++++
 include/linux/elf.h                        |   4 +
 include/linux/kexec.h                      |   3 +
 kernel/Kconfig.kexec                       |   3 +-
 kernel/crash_core.c                        |  57 ++++++-
 kernel/crash_dump_dm_crypt.c               |  15 +-
 kernel/kexec_core.c                        |  26 ++--
 kernel/kexec_file.c                        |  16 +-
 21 files changed, 352 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

-- 
2.34.1


