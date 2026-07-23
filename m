Return-Path: <linuxppc-dev+bounces-24732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2698FC531CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkm3mzZz2ygm;
	Thu, 23 Jul 2026 23:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812368;
	cv=none; b=iQ6IZeEIukw7nCHMc0rFqj0ffN4r8TqZhQR9uNFFSyL++W1iXyzqr3wuBK/By1PVOQ9t7DfF1ScPoOhQC6qWhB8uZtDzsCj9c1vaNP5wVLkr0Xwm5cflzmmiNOlezEtUxrJNzHlAu7SOyzyz3Tn7DHOKjaDBySmhQXxt7gC9GsSCbwscc+n5AtxpvCPs+O36a1yHLwfzwMkpW1rb/KsNidJmcEEzjStbUgw7ypPKxxu6+LTB7yfBv0jqDtz5FABc2ygBWZKrC/1yV+Nicpxzi4iH5U/sz5geHBPqRK6EtR1zi5OmORixTuPaACig+8PZhWcGk0wSD/fIRBNCI5ORFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812368; c=relaxed/relaxed;
	bh=nSc6H1n8CfUvbxJc0ENwagioj/mFRPueC/MDVwFsPJ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LE66GonDWUv5zfon2eKPGdiQ8hGTGci29JgMnWtkIFCLO584VdKmX0JqJJAqrvWga1TBqMeiScWrxb4mwsIBncAG9obQCtajVGRmUH8O1ji4/ZcXcnPOvMzgEYvZ8idytomsQrvwJ0m2wIUOkPVcoDPOfDJL5p/9/WNrUV4vS8eCXyYdQY+PXKHy6Bx+Wpg2UFsFt2yAObCkNqNLPJl+DwW/cQGZzifmKcCY6VQOI8AneQ8US05LoB9pYxcYGOofUFOZ3yOrGWaCGi9I/hcIo4HK996b1K+XOyEjG1gMXOaDAnR24WGR55OIZjMDwPKUl+MwTBVAUKHD+0DLb6PWFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LZrc17Nj; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LZrc17Nj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkk1BMsz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:43 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nSc6H1n8CfUvbxJc0ENwagioj/mFRPueC/MDVwFsPJ0=;
	b=LZrc17NjvFuqc0ZNMkyYqGJLxhfCEHwM6Ms7VhwB4lOZhWJBOzAe0Ye+sIM3YgqNFnOnNAqj2
	vbCWf1cS2hlJ4LgzWQGI8VnjMtIUf6PP9YLAIcOJ4rviEC2IzBoNRx/iogz3rARiSK64MjrQ8Cq
	Escl3Ykk99yeG1PQAvVzi7Q=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWk57tnzRhV9;
	Thu, 23 Jul 2026 21:03:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DC4684057D;
	Thu, 23 Jul 2026 21:12:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 0/8] arm64: crash: Add crash hotplug support
Date: Thu, 23 Jul 2026 21:12:34 +0800
Message-ID: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
 dggpemf500011.china.huawei.com (7.185.36.131)

When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch set implements crash hotplug support for arm64.

It also addresses and fixes several critical pre-existing code issues
and Sashiko AI review findings extracted from the previous patch set,
following Baoquan's suggestions.

The major improvements and fixes included in this series are:

- Fix powerpc memory leak, null-ptr-def and overlapping memory
  range truncation bug.

- Fix several memory leaks for arm64.

- Simplify arm64 load_other_segments().

- Implement infrastructure for arm64 crash memory hotplug support.

This patch set is rebased on liveupdate/crashkernel-cma.

Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/

Jinjie Ruan (8):
  powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
  powerpc/kexec_file: Fix null-ptr-def in extra size calculation
  powerpc/kexec_file: Prevent kexec range truncation
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix image->elf_headers memory leak during retry
    loop
  arm64: kexec_file: Simplify load_other_segments()
  arm64: crash: Add crash hotplug support

 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  13 +++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c        |   1 +
 arch/arm64/kernel/machine_kexec_file.c |  76 ++++++-------
 arch/powerpc/kexec/crash.c             |   2 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/powerpc/kexec/ranges.c            |  12 +-
 include/linux/kexec.h                  |   2 +
 kernel/kexec_core.c                    |  25 +++--
 11 files changed, 223 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

-- 
2.34.1


