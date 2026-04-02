Return-Path: <linuxppc-dev+bounces-19192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D746CC6B0E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmYL82qkXz2yYy;
	Thu, 02 Apr 2026 18:25:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775114752;
	cv=none; b=TXtUohDbdz5YKIurSj4PxA4wdOUHltsrGrmzPqT9buLFznAUpcx9EVdZzodX6P3zGS/wgHZJbSfwmKe3Jf1H2YrxNSxh4+B5V6Ln4+UvEmGmt3zSkljFElxO2me6YhI9fVw/coM+mxRypeUq8C/dCseudfg3h6AKvFLjfq6ljyUo3wUA4RiuB7fLElT80cHPAyfFQ/WQ4H+Gye4AoF1rkIG5lohoRxwS794R1hlT+it3H5GaP05RfrbYLJPSH1K8CqJ+EMJ1AzJFneY7+fZdiZ/8w/u53R3pI7Wjy4s6ENptIeuGeAWlvumTKjeckq9M+pmMuU/wYw347OX0ZneefA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775114752; c=relaxed/relaxed;
	bh=bYL91xN0k8SZnYn2ZHMX4edxJPIDmixyuT6I/2tV1KM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+zw/6tM1F7DhCPdIR+BrWhqPACp1ozV0C8zH3WCTLWamotx2ceUQREXQ4vUkDt361v7voVTxjn9d/naz2IjhPmSap1tGRuBkLDWbIsgKN4bCtHp7GDE2HNpETm5gF8KaPyc87ylO4/VtPJlcnKOL6WSyQjIKu3Aggx3bMQ/fk55E961F5FlCD1CAdvh6bFBnSNON8gbhAjNTzR1GXR+ANMQgFO2wrh3kK2MPJ4cR15xEwOiIhLI0WF/8X7HXihG4gDyHTWDfFv/FRY+VP/ZjypV/ElullGVzgx5ob91KzGqkFkAfajYX8JjXESJ7Xo2hz9rPz0WGnTaqIIXaAkqiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XFyO3HZg; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XFyO3HZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmYL54DMxz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:25:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bYL91xN0k8SZnYn2ZHMX4edxJPIDmixyuT6I/2tV1KM=;
	b=XFyO3HZgPGaDclg6e0kCRls2FHdfMYpdC5yms5BvvsRgBGd2Mu9MZgAQiTWuWzi6LVfzcOwAC
	w0CWALY8ELZuLBpl3hpqaDyz/yC9GzujhZhy2cZMcSjsxlrSaYXfKMw3v6LZsF9y3wsPlsfcowX
	MKlW+josArpEIRhERDnXVeU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fmYBp74XLzmVWV;
	Thu,  2 Apr 2026 15:19:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C81BC402AB;
	Thu,  2 Apr 2026 15:25:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 15:25:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA reservation
Date: Thu, 2 Apr 2026 15:26:46 +0800
Message-ID: <20260402072701.628293-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The crash memory allocation, and the exclude of crashk_res, crashk_low_res
and crashk_cma memory are almost identical across different architectures,
This patch set handle them in crash core in a general way, which eliminate
a lot of duplication code.

And add support for crashkernel CMA reservation for arm64 and riscv.

Rebased on v7.0-rc1.

Basic second kernel boot test were performed on QEMU platforms for x86,
ARM64, and RISC-V architectures with the following parameters:

	"cma=256M crashkernel=256M crashkernel=64M,cma"

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

Jinjie Ruan (14):
  riscv: kexec_file: Fix crashk_low_res not exclude bug
  powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
  x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
  arm64: kexec_file: Fix potential buffer overflow in
    prepare_elf_headers()
  riscv: kexec_file: Fix potential buffer overflow in
    prepare_elf_headers()
  LoongArch: kexec: Fix potential buffer overflow in
    prepare_elf_headers()
  crash: Add crash_prepare_headers() to exclude crash kernel memory
  arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
  x86/kexec: Use crash_prepare_headers() helper to simplify code
  riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
  LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
  crash: Use crash_exclude_core_ranges() on powerpc
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

Sourabh Jain (1):
  powerpc/crash: sort crash memory ranges before preparing elfcorehdr

 .../admin-guide/kernel-parameters.txt         |  16 +--
 arch/arm64/kernel/machine_kexec_file.c        |  43 +++-----
 arch/arm64/mm/init.c                          |   5 +-
 arch/loongarch/kernel/machine_kexec_file.c    |  43 +++-----
 arch/powerpc/include/asm/kexec_ranges.h       |   1 -
 arch/powerpc/kexec/crash.c                    |   7 +-
 arch/powerpc/kexec/ranges.c                   | 101 +-----------------
 arch/riscv/kernel/machine_kexec_file.c        |  42 +++-----
 arch/riscv/mm/init.c                          |   5 +-
 arch/x86/kernel/crash.c                       |  92 +++-------------
 drivers/of/fdt.c                              |   9 +-
 drivers/of/kexec.c                            |   9 ++
 include/linux/crash_core.h                    |   9 ++
 include/linux/crash_reserve.h                 |   4 +-
 kernel/crash_core.c                           |  89 ++++++++++++++-
 15 files changed, 193 insertions(+), 282 deletions(-)

-- 
2.34.1


