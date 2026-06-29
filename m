Return-Path: <linuxppc-dev+bounces-23073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897BAC43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:48:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphKW26Wtz2yd7;
	Mon, 29 Jun 2026 19:47:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726479;
	cv=none; b=dksq71W2f/nExjbzQvsmIYJx7lPY88imtIgQHVYXnzlxkbCTHaT955MxJ+HXiRp85zKyrRUAO6lifI8dYqrleG+OBhvYTBy5p1Yf58twFtrEbkaj/Wh15h8j/CoXPwdTUHDZGRRMmQObExoJ3H2pLNGEM4Y8TwwhHxHeZD40JMD+RR9yJTtV7/3aJ3LsmkcUUSIJ124W1fpsjkcvW3uKeK+Wzad9qUrjNAcezoevDe+19CM6SZFLvHW+uu7KL8/tfLsyeCKheh5dowC/Iggo6J/eP8eZI8LjdZmJAJs63IoDv19BxRRIn8OWOGitGD4XyD5C/pnV49Ng0PLwdpKqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726479; c=relaxed/relaxed;
	bh=C74c9Z44560ys3MOV7OLJFItsKEUasdgoX3/ADH6C1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0QW4S/SKgPPDYhgN5BJCQnuoOXaLsVKBSW476vwMJgn6uGLsiXq7kI4cuzcgSfE16YGmIDO+iRpN8c2G68Qj6JUCzlzlBFYh2KfufbXc3rxiarwRO4fY/3JRzBkccmuyZjkyqntwvtuOn2kTHpRy6ZnFP8NT73g3scVmmDg9KXHLOk5iBNl/yTwEhDyni1LcGgFCDlxHmpPNn47U9YdkwUmKxstQteP03zQgcbn7vgEqi0leQTrMiNnXWDi9CTppExCQblPZvJcGI/NsdmTGVrFDSPj5NqI3qoYpBPPgaKayJRIrvrHIG4SonbOuzI7qumoNxQr+u7fjXb53ijezA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oswYlem6; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oswYlem6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphKS3yg6z2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:47:54 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C74c9Z44560ys3MOV7OLJFItsKEUasdgoX3/ADH6C1M=;
	b=oswYlem6v3r3Ko5sz4ygnrhrcGv4rCmSO/slY64Ol9eGunwl5MFURTJD8Fhbl8htysa0K1AkM
	Y3/Aj0SATnHpScWUj3BK+r31zk2yWjT2fm5xmOiOYkmc3uCBa3aCcIQ4uBLpfrfa+pT/nB1s2Nh
	KoQnk1SKJV023ca3eyxegoY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gph794dvdz12LF6;
	Mon, 29 Jun 2026 17:39:01 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E12E74057D;
	Mon, 29 Jun 2026 17:47:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 17:47:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<elver@google.com>, <enelsonmoore@gmail.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <leitao@debian.org>,
	<kees@kernel.org>, <coxu@redhat.com>, <cfsworks@gmail.com>, <jbohac@suse.cz>,
	<osandov@fb.com>, <ryan.roberts@arm.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>, <gaohan@iscas.ac.cn>,
	<david@kernel.org>, <wangruikang@iscas.ac.cn>, <muchun.song@linux.dev>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <guoren@kernel.org>,
	<namcao@linutronix.de>, <rick.p.edgecombe@intel.com>, <djbw@kernel.org>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<vishal.l.verma@intel.com>, <chenjiahao16@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v17 00/10] arm64/riscv: Add support for crashkernel CMA reservation
Date: Mon, 29 Jun 2026 17:47:36 +0800
Message-ID: <20260629094746.191843-1-ruanjinjie@huawei.com>
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

The crash memory allocation, and the exclude of crashk_res, crashk_low_res
and crashk_cma memory are almost identical across different architectures,
This patch set handle them in crash core in a general way, which eliminate
a lot of duplication code.

And add support for crashkernel CMA reservation for arm64 and riscv.

This patch set is now rebased on v7.2-rc1. Basic second kernel boot test
were performed on QEMU platforms for x86, ARM64 and RISC-V architectures
with the following parameters:

        "cma=256M crashkernel=4G crashkernel=64M,cma"

For first kernel, there will be such log:

        # dmesg | grep crash
        [    0.000000] crashkernel low memory reserved: 0xe8000000 - 0xf0000000 (128 MB)
        [    0.000000] crashkernel reserved: 0x000000023e600000 - 0x000000033e600000 (4096 MB)
        [    0.000000] crashkernel CMA reserved: 64 MB in 1 ranges

        # dmesg | grep cma
        [    0.000000] cma: Reserved 256 MiB at 0x00000000f0000000
        [    0.000000] cma: Reserved 64 MiB at 0x0000000100000000

For second kernel, there will be such log:

        [    0.000000] OF: fdt: Looking for usable-memory-range property...
        [    0.000000] OF: fdt: cap_mem_regions[0]: base=0x000000023e600000, size=0x0000000100000000
        [    0.000000] OF: fdt: cap_mem_regions[1]: base=0x00000000e8000000, size=0x0000000008000000
        [    0.000000] OF: fdt: cap_mem_regions[2]: base=0x0000000100000000, size=0x0000000004000000

Changes in v17:
- Rebased on v7.2-rc1.
- Update the x86 commit subject and "s/By the way/While at it/"
  as Borislav suggested.
- Add Acked-by.
- Link to v16: https://lore.kernel.org/all/20260608073459.3119290-1-ruanjinjie@huawei.com/

Changes in v16:
- Split out the unrelated bugfixes as Baoquan suggested, which will
  be a separate patch set later.
- Link to v15: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/

Changes in v15:
- Unify the subject prefix formats as Huacai suggested.
- Fix powerpc pre-existing NULL pointer dereference [Sashiko [1]]
- Fix powerpc pre-existing __merge_memory_ranges() memory range
  truncation [Sashiko [1]].
- Fix pre-existing arm64 CMA page leaks [Sashiko[2]].
- Fix pre-existing crash_load_dm_crypt_keys() Use-After-Free and
  Double Free issue [Sashiko[3]].
- Fix vfree(headers) and uninitialized variables issue
  and simplify the fix [Sashiko[2]].
- As walk_system_ram_res() and for_each_mem_range() use different
  lock, unify and simplify the fix of TOCTOU buffer overflow via memory
  region padding [Sashiko[4]].
- Fix the arm64 crash dump issues in Sashiko[5].
- Link to v14: https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com/

[1]: https://lore.kernel.org/all/20260525092207.96B9D1F000E9@smtp.kernel.org/
[2]: https://lore.kernel.org/all/20260525091149.1A1E01F00A3D@smtp.kernel.org/
[3]: https://lore.kernel.org/all/20260525105227.3C2421F000E9@smtp.kernel.org/
[4]: https://lore.kernel.org/all/20260525095447.944E11F000E9@smtp.kernel.org/
[5]: https://lore.kernel.org/all/20260525101746.9959D1F000E9@smtp.kernel.org/

Changes in v14:
- Fix image->elf_headers memory leak during retry loop for arm64 as Sashiko
  AI code review pointed out.
- Solve the hotplug notifier arch_crash_handle_hotplug_event() AA
  self-deadlock problem as Sashiko AI code review pointed out.
- Fix the TOCTOU issue in prepare_elf_headers() by get_online_mems().
- -ENOMEM -> -EAGAIN as Breno suggested.
- Add support for arm64 crash hotplug.
- Link to v13: https://lore.kernel.org/all/20260511030454.1730881-1-ruanjinjie@huawei.com/

Changes in v13:
- Rebased on v7.1-rc1.
- Update the commit message.
- Add Reviewed-by.
- Link to v12: https://lore.kernel.org/all/20260402072701.628293-1-ruanjinjie@huawei.com/

Changes in v12:
- Remove the unused "nr_mem_ranges" for x86.
- Add "Fix crashk_low_res not exclude bug" test log.
- Provide a separate patch for each architecture for using
  crash_prepare_headers(), which will make the review more convenient.
- Add Reviewed-by and Tested-by.
- Link to v11: https://lore.kernel.org/all/20260328074013.3589544-1-ruanjinjie@huawei.com/

Changes in v11:
- Avoid silently drop crash memory if the crash kernel is built without
  CONFIG_CMA.
- Remove unnecessary "cmem->nr_ranges = 0" for arch_crash_populate_cmem()
  as we use kvzalloc().
- Provide a separate patch for each architecture to fix the existing
  buffer overflow issue.
- Add Acked-bys for arm64.

Changes in v10:
- Fix crashk_low_res not excluded bug in the existing
  RISC-V code.
- Fix an existing memory leak issue in the existing PowerPC code.
- Fix the ordering issue of adding CMA ranges to
  "linux,usable-memory-range".
- Fix an existing concurrency issue. A Concurrent memory hotplug may occur
  between reading memblock and attempting to fill cmem during kexec_load()
  for almost all existing architectures.
- Link to v9: https://lore.kernel.org/all/20260323072745.2481719-1-ruanjinjie@huawei.com/

Changes in v9:
- Collect Reviewed-by and Acked-by, and prepare for Sashiko AI review.
- Link to v8: https://lore.kernel.org/all/20260302035315.3892241-1-ruanjinjie@huawei.com/

Changes in v8:
- Fix the build issues reported by kernel test robot and Sourabh.
- Link to v7: https://lore.kernel.org/all/20260226130437.1867658-1-ruanjinjie@huawei.com/

Changes in v7:
- Correct the inclusion of CMA-reserved ranges for kdump kernel in of/kexec
  for arm64 and riscv.
- Add Acked-by.
- Link to v6: https://lore.kernel.org/all/20260224085342.387996-1-ruanjinjie@huawei.com/

Changes in v6:
- Update the crash core exclude code as Mike suggested.
- Rebased on v7.0-rc1.
- Add acked-by.
- Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/

Jinjie Ruan (9):
  riscv: kexec_file: Fix crashk_low_res not exclude bug
  crash: Add crash_prepare_headers() to exclude crash kernel memory
  arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
  x86/crash: Use crash_prepare_headers() helper to simplify code
  riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
  LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify
    code
  powerpc/kexec_file: Use crash_exclude_core_ranges() helper
  arm64: kexec_file: Add support for crashkernel CMA reservation
  riscv: kexec_file: Add support for crashkernel CMA reservation

Sourabh Jain (1):
  powerpc/crash: sort crash memory ranges before preparing elfcorehdr

 .../admin-guide/kernel-parameters.txt         |  16 +--
 arch/arm64/kernel/machine_kexec_file.c        |  40 +++----
 arch/arm64/mm/init.c                          |   5 +-
 arch/loongarch/kernel/machine_kexec_file.c    |  40 +++----
 arch/powerpc/include/asm/kexec_ranges.h       |   1 -
 arch/powerpc/kexec/crash.c                    |   5 +-
 arch/powerpc/kexec/ranges.c                   | 101 +-----------------
 arch/riscv/kernel/machine_kexec_file.c        |  39 +++----
 arch/riscv/mm/init.c                          |   5 +-
 arch/x86/kernel/crash.c                       |  89 ++-------------
 drivers/of/fdt.c                              |   9 +-
 drivers/of/kexec.c                            |   9 ++
 include/linux/crash_core.h                    |   9 ++
 include/linux/crash_reserve.h                 |   4 +-
 kernel/crash_core.c                           |  89 ++++++++++++++-
 15 files changed, 180 insertions(+), 281 deletions(-)

-- 
2.34.1


