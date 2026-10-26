Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4260A2627
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ApEa5JUG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCm886jgCz2yh4;
	Mon, 26 Oct 2026 18:53:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001192;
	cv=none; b=iEDo+d2l4NcBweA6O44a1KbaL2wifd7J6QSHBs+rP2+qa/PYv7aGJsGQs2sOJoBIxEc7JEtSveVDbqnD0rOB072hzAWV+M8CbRdHezZcPNmRdhoy5e2P89BYYsdHqyzK2usPJNLulOSK4lIjKI65dlxSbs1tzQRGc260lxZvmaT9g7ZIMyQ+ffBBDXfeVojTj5r8/04iudhuXzqaWy/EIcEMjxCrA7Vd0a/JHdDRxDSMu6LFswaXBjcdJEccp2VmhUA/MrhqO1XSTw4HthILtN04JKZD/diWc2B1nhUN36k6ByuCkHNwYDCFAa5wsMHEjRFk+sitWRAKCqsD7ar4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001192; c=relaxed/relaxed;
	bh=qw2K6Vzt5YqE23MaU4ygfGnUQ1iM0Wvvk6X29IlIT0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfHbpdJk8Etkl6dGHDJq6tMb6Sfkz7r0hlsrBsRW8LiylhxumTAuwfwNJKHfQ+bQAuxjXHYXpAQyXdzbbpn/t4kuGfRfO+veWUBqldqRDwxkoeVpaoKTvBHCeaGOTjGofhDxsuCuTOZL4dlHHuRISNuGay1GHvRV6bVlu1ddEpyFsVHSU1r9rWMpOslxQvIcfLooZvK8leTYQBKPIZRcVNqfFR2joYhviqbjruMEaWKZn5bVrPapFUO8M9w5KG8tg0A2jmXkA3gK+hRt1NYjVXe9JGiixczI+7TbyaEpPYMB3y9741DklScMdTu5tMqrdrezka4YTpm6S9o61EZ8cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ApEa5JUG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ApEa5JUG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCm821lBrz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 18:53:05 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qw2K6Vzt5YqE23MaU4ygfGnUQ1iM0Wvvk6X29IlIT0Y=;
	b=ApEa5JUGfhrr9q3nuEX3q9iTC5ZnvPjVIXhddgt/jD+41CHgtx4NdPjHinbA46Dv0aklobgDf
	hrwpQ/Iic60NRfmL4h2otrzfIQEMF2kilmAEUUVk2XA1Z/65K8WhZF3qB20JtrdvwaLdLki1RFW
	Tkiy/mbe5UnSSq78RrBy5bM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jCm7l4MMFzcb08;
	Mon, 26 Oct 2026 15:52:51 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 986354056E;
	Mon, 26 Oct 2026 15:53:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:53:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <ruanjinjie@huawei.com>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <robh@kernel.org>,
	<sourabhjain@linux.ibm.com>, <kees@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
Subject: [PATCH v7 07/15] LoongArch: kexec_file: Fix a modified_cmdline leak
Date: Mon, 26 Oct 2026 15:51:53 +0800
Message-ID: <20261026075201.699550-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

machine_kexec_prepare() copies it to KEXEC_CMDLINE_ADDR and overwrites
the pointer, so free the heap buffer after the copy.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Kexin Liu <liukexin@kylinos.cn>
Cc: Youling Tang <tangyouling@kylinos.cn>
Cc: Qiang Ma <maqianga@uniontech.com>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: George Guo <guodongtai@kylinos.cn>
Cc: stable@vger.kernel.org
Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec_file")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/kernel/machine_kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 1883cae93bc3..19ccc91b6f2a 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/of_fdt.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
@@ -56,6 +57,7 @@ int machine_kexec_prepare(struct kimage *kimage)
 		 */
 		memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.cmdline_ptr,
 					strlen((char *)kimage->arch.cmdline_ptr) + 1);
+		kfree((void *)kimage->arch.cmdline_ptr);
 		kimage->arch.cmdline_ptr = (unsigned long)KEXEC_CMDLINE_ADDR;
 	} else {
 		/* Find the command line */
-- 
2.34.1


