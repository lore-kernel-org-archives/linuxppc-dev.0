Return-Path: <linuxppc-dev+bounces-16577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DBEE95363
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 09:37:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Zxg739Rz30T8;
	Wed, 04 Feb 2026 20:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770197815;
	cv=none; b=eCJcZBLeskQ08spUGE709+UhlBUB7K7/CXKrzC+CbiQ/0jobP1D7sNy9GESYr0mOP1o9v9rVdaTkaAD5ezTPY9Ld8E7JdFBtzySsc5Tn0I6hwuOtqURxzREB8AHJAgbIGFNISGGme4T5GgGL78wL7Nnx5h8pQMEa2oLJZ+Ko+ekqBMUypRjdvJjt3syN4GHp3iyOrGbc4ct0WBVMlSw3V2bq7gO8xWG9cxtZaOetue2ejRankCNdktSBMlwFDTlzK9+5qc/HdZdXez2HcUKDioFfN9YPwPZrzXyrgScMUsEJinuKmfQOkO7UfS60209j47EXiXKq+9PB/YzDBGO7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770197815; c=relaxed/relaxed;
	bh=mFBJiqIwT9NZGyk5qGLbY1mlcpA6eQGqiHTQkqvDMKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/K4MGQhBboTILLFD3VacKV3mLolSvaWzLpG4DFq8Z5/hYTkosJ/tZojipolVdTUAPyYJ6cZStEN85UIA4pYfF/xV4fAt/PrggcbIYiOkO2CaXSR2HFOqbCP59T6cdrpQgLOOWlfba1U6QZ27A2qvV5t90ObC5Khlz9DNunNDX+qbPnmX61sM6sLeQzQi79S3MnANZ6hOWKksyM58rE3AEHkHlaPlwyIb45bylokuFr/8vri2Bo4Ywdm3/heA17lO4sZ1v74obpjektbCsKTmT7MT3Hw7k3It5Zj4hvK14smLhHPpo7bR25foMBMHAXLjsTVWJ/j01ZVhD/E+eKrIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1xqbDBGH; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1xqbDBGH; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1xqbDBGH;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1xqbDBGH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Zxc38Gjz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 20:36:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mFBJiqIwT9NZGyk5qGLbY1mlcpA6eQGqiHTQkqvDMKc=;
	b=1xqbDBGHV2dYoy3vGnjXu2TA/WZN09CbjC82e2+V5v8DPKKxKAbS/fgjLipQORmfwaL0pUvBs
	FJBu5fvw0+v0LExpIvXW2pSMR2LIhb6URUTKmgEUAj0nd3KCKgtMg/zlMOEspDjG9HYmU/vfTMe
	grDxiK3ovrSLsg2wWnF2HVU=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f5Zwh0Zcnz1BGCw
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2026 17:36:04 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mFBJiqIwT9NZGyk5qGLbY1mlcpA6eQGqiHTQkqvDMKc=;
	b=1xqbDBGHV2dYoy3vGnjXu2TA/WZN09CbjC82e2+V5v8DPKKxKAbS/fgjLipQORmfwaL0pUvBs
	FJBu5fvw0+v0LExpIvXW2pSMR2LIhb6URUTKmgEUAj0nd3KCKgtMg/zlMOEspDjG9HYmU/vfTMe
	grDxiK3ovrSLsg2wWnF2HVU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f5Zr04p4mz1prLg;
	Wed,  4 Feb 2026 17:32:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 54A75404AD;
	Wed,  4 Feb 2026 17:36:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 17:36:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<kees@kernel.org>, <elver@google.com>, <arnd@arndb.de>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <leitao@debian.org>,
	<rppt@kernel.org>, <cfsworks@gmail.com>, <osandov@fb.com>,
	<sourabhjain@linux.ibm.com>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <samuel.holland@sifive.com>,
	<kevin.brodsky@arm.com>, <junhui.liu@pigmoral.tech>,
	<vishal.moola@gmail.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<liaoyuanhong@vivo.com>, <brgerst@gmail.com>, <fuqiang.wang@easystack.cn>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Date: Wed, 4 Feb 2026 17:37:25 +0800
Message-ID: <20260204093728.1447527-1-ruanjinjie@huawei.com>
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

Add support for crashkernel CMA reservation for arm64 and riscv.

By the way, exclude crash kernel memory in crash core to
avoid duplication.

Changs in v3:
- Exclude crash kernel memory in crash core as Mike suggested.
- Add acked-by.

Jinjie Ruan (3):
  crash: Exclude crash kernel memory in crash core
  arm64: kexec: Add support for crashkernel CMA reservation
  riscv: kexec: Add support for crashkernel CMA reservation

 .../admin-guide/kernel-parameters.txt         | 16 ++++----
 arch/arm64/kernel/machine_kexec_file.c        | 16 +++-----
 arch/arm64/mm/init.c                          |  5 ++-
 arch/loongarch/kernel/machine_kexec_file.c    | 12 ------
 arch/powerpc/kexec/ranges.c                   | 16 ++------
 arch/riscv/kernel/machine_kexec_file.c        | 15 ++++---
 arch/riscv/mm/init.c                          |  5 ++-
 arch/x86/kernel/crash.c                       | 39 +------------------
 kernel/crash_core.c                           | 28 +++++++++++++
 9 files changed, 61 insertions(+), 91 deletions(-)

-- 
2.34.1


