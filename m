Return-Path: <linuxppc-dev+bounces-16836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A99EB48EB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 10:09:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBWHM4TyRz2ydj;
	Thu, 12 Feb 2026 21:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770890959;
	cv=none; b=bUZk8dxYcXLebd9r6PttjRgTfPqlhnRsF+XVOKYbdXFYkGT7W0fs5lCt1+WcuYu8tLvtl9K6TmmDFkS7ezBjsSr5OFRPadHAq1MWfzutZBF+Shj+fCAtTXol/KlNw577xGtH1xSirD/Q/jWT+VBIr1I9EEXs8JGAW9qQ4WlCBr9YR88RxwnQTUG+t4dL8ImIKeHkS+sR4DU+kXqJbsjux0BS8nYcWUwO2XFq6oF8t1YdxCe2lzmAjJsXcx8PYOo+Ln6CNCBXuy4PFd+lb1iU/ms9yDmzRx5HehJQkKW+f0IoTFT42NA9Ax4R4dmHUTfbHGADVduEs7yEnNJFmE6E6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770890959; c=relaxed/relaxed;
	bh=DJBahsVO2buYBRo6uanQ4akOube4lASCcn5Wc5JuHA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jV2k8Ms+kzyYhLpm+m71N7lb8fMT1OQD5XKicqYGFrn4yS3BflxzoyAUOl3JdY13oYZWCwc73wwkX6PglUokLE4PUsSPGIFQTql8x029KAC5+07ZaecBmEzMm5F/FaFOx4jC/JRrHfdtLfx9dZnLjqKAmaXPqmRooJJvqJC7U3pfK8pi72fUpgg/c90O7h5TFxUlmcEAhEJylmP4DCpAj2oJPKofg7XcOTA19M4dtrCd4jV2JyuEke4nym1iv4XbS+UbH8ABHfiEVnjFEhZxCK87zuqYkZE0ACf59yWLD+juqtTkp6nTTh0xpLQLWg0F/KnbASrmXk6EKZ5H7uGiHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N1Lb/dyT; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N1Lb/dyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBWHJ5TsZz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 21:09:14 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DJBahsVO2buYBRo6uanQ4akOube4lASCcn5Wc5JuHA0=;
	b=N1Lb/dyTE2h5HOJHrh+NRJNvn9yj1KvCbqkIn6VqWUGF70dIauXoQMrrYoYNwdNWlg3+8a/E2
	vGe1QBnODc9pH2mKsoaHcQbTyBL1aa76SvP3u+XYQm95+qiCFBlYzCsJrRLeFozkScfrLE4vows
	heKtPwy0ISFWrMHfm+RuWZA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBW9p5KLtzRhTq;
	Thu, 12 Feb 2026 18:04:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C35A4201EB;
	Thu, 12 Feb 2026 18:09:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Feb
 2026 18:09:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<kees@kernel.org>, <elver@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<ruanjinjie@huawei.com>, <fvdl@google.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <rppt@kernel.org>, <osandov@fb.com>,
	<cfsworks@gmail.com>, <sourabhjain@linux.ibm.com>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <eajames@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>, <bjorn@rivosinc.com>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <dwmw@amazon.co.uk>,
	<pbonzini@redhat.com>, <kai.huang@intel.com>, <ubizjak@gmail.com>,
	<coxu@redhat.com>, <fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<brgerst@gmail.com>, <jbohac@suse.cz>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v5 0/4] arm64/riscv: Add support for crashkernel CMA reservation
Date: Thu, 12 Feb 2026 18:09:57 +0800
Message-ID: <20260212101001.343158-1-ruanjinjie@huawei.com>
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

Changes in v5:
- Fix the kernel test robot build warnings.
- Sort crash memory ranges before preparing elfcorehdr for powerpc
- Link to v4: https://lore.kernel.org/all/20260209095931.2813152-1-ruanjinjie@huawei.com/

Changes in v4:
- Move the size calculation (and the realloc if needed) into the
  generic crash.
- Link to v3: https://lore.kernel.org/all/20260204093728.1447527-1-ruanjinjie@huawei.com/

Changs in v3:
- Exclude crash kernel memory in crash core as Mike suggested.
- Add acked-by.

Jinjie Ruan (3):
  crash: Exclude crash kernel memory in crash core
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

Sourabh Jain (1):
  powerpc/crash: sort crash memory ranges before preparing elfcorehdr

 .../admin-guide/kernel-parameters.txt         |  16 +--
 arch/arm64/include/asm/kexec.h                |   9 +-
 arch/arm64/kernel/machine_kexec_file.c        |  43 +++-----
 arch/arm64/mm/init.c                          |   5 +-
 arch/loongarch/include/asm/kexec.h            |   9 +-
 arch/loongarch/kernel/machine_kexec_file.c    |  41 +++----
 arch/powerpc/include/asm/kexec.h              |  13 +++
 arch/powerpc/include/asm/kexec_ranges.h       |   1 -
 arch/powerpc/kexec/crash.c                    |  67 ++++++-----
 arch/powerpc/kexec/file_load_64.c             |  17 +--
 arch/powerpc/kexec/ranges.c                   | 103 +----------------
 arch/riscv/include/asm/kexec.h                |   9 +-
 arch/riscv/kernel/machine_kexec_file.c        |  39 +++----
 arch/riscv/mm/init.c                          |   5 +-
 arch/x86/include/asm/kexec.h                  |   9 ++
 arch/x86/kernel/crash.c                       | 104 ++----------------
 include/linux/crash_core.h                    |  75 ++++++++++++-
 kernel/crash_core.c                           |  85 ++++++++++++--
 18 files changed, 314 insertions(+), 336 deletions(-)

-- 
2.34.1


