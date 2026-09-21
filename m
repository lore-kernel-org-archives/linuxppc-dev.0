Return-Path: <linuxppc-dev+bounces-27829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66953C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:05:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNX0Ct0z3bmC;
	Mon, 21 Sep 2026 19:04:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981467;
	cv=none; b=MjS2FtUTTeNMQl8rXOLfqb5lOiNJJDJn7AS/o+L4L1NJKryjaY9+GNWej8FpUi78qxsh2/guYS1iQcaCuUk/BK62MqHbJi3+7p54yJArvZSO0I2GiPMoHYJSGPBVJ5Ysqygud6PjArtOrQhBzoHowWDMLP7tbsqZN1RVWf52rvVm+XQwL5IpUFxSDUHHWgIfYylst8mIJLzvDdvxsY2QAby/gpQffQXBHtRIleeBDejz20sIwM93YjUy/LaCiXwFk5WU5VQpL7hH38N/Pa2jRAZTuBH8n5a7EgRQpArMt7COW6Uab6g5SQzYt8IVrVPIICaXMDVcqBzF90CYoaggag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981467; c=relaxed/relaxed;
	bh=oJTPjIaIqy30CyW5gdpqj1ltYgKaERSOMcSOuwRttqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN8AoZoUJWavwlq6kmJNWttkdQqZEZdaKqExoPiKSJJPJjbIOQXCJF8KwJUFaZU6HQ0sy/+Zse8pMn6fCVHNEUHR6K6UB+OgkmJ5MdWFCHouOILKi+g4j/Kw6d0DutWJ2JCnJHtXtQ8fbc77Spduy70uBS6DckplcAhB2dkQM6nydPxQPXpuyeSoCN0+oL4vtepXCvW9dhhHjVHDdlDK0oMHT1GjhKP3poiBPGOLg8LF1b6LFo4GysGtHHrIXW9EVhifvjKeP1BrNRHOYITN6KYN3eqSc5/ohbxetpr4Xjzu76BqipZQQ+QAD/F7+HmVdmFci7Py49U+XVZVTjgljQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xk3K1Lag; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xk3K1Lag;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHNV5jnGz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oJTPjIaIqy30CyW5gdpqj1ltYgKaERSOMcSOuwRttqY=;
	b=Xk3K1Lag16/7PUJwSJwRKAWcXn51YKwa9K4bTVig/jzNn34hk7LewtIKmtx+01VSKzFVqRzzQ
	wGiFlBwGpaMhKzr9S/eyYz1vcdeUtXIbZr9e9FiAHiBznYDu4EF1evoWFkMInlmtdm/yuNtiMKX
	/P1HTZPUO81RTQgB5/AToOM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7b1rDqz1K9D2;
	Mon, 21 Sep 2026 16:53:15 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2860E40586;
	Mon, 21 Sep 2026 17:04:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:15 +0800
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
Subject: [PATCH v6 11/14] crash: Factor out crash_find_elfcorehdr() helper
Date: Mon, 21 Sep 2026 17:04:47 +0800
Message-ID: <20260921090450.807575-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
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

The elfcorehdr segment is located by scanning the segments for
the ELF magic. Factor that scan out into a new helper function,
crash_find_elfcorehdr(), to clean up crash_handle_hotplug_event()
and prepare for its reuse in crash hotplug code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 406b68d2adfd..4a990b17b66c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -647,6 +647,28 @@ int crash_check_hotplug_support(void)
 	return rc;
 }
 
+static void crash_find_elfcorehdr(struct kimage *image)
+{
+	unsigned char *ptr;
+	unsigned long mem;
+	unsigned int n;
+
+	if (image->elfcorehdr_index >= 0)
+		return;
+
+	for (n = 0; n < image->nr_segments; n++) {
+		mem = image->segment[n].mem;
+		ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+		if (!ptr)
+			continue;
+
+		/* The segment containing elfcorehdr */
+		if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+			image->elfcorehdr_index = (int)n;
+		kunmap_local(ptr);
+	}
+}
+
 /*
  * To accurately reflect hot un/plug changes of CPU and Memory resources
  * (including onling and offlining of those resources), the relevant
@@ -702,22 +724,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	 * is allocated. Find the segment containing the elfcorehdr,
 	 * if not already found.
 	 */
-	if (image->elfcorehdr_index < 0) {
-		unsigned long mem;
-		unsigned char *ptr;
-		unsigned int n;
-
-		for (n = 0; n < image->nr_segments; n++) {
-			mem = image->segment[n].mem;
-			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-			if (ptr) {
-				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
-					image->elfcorehdr_index = (int)n;
-				kunmap_local(ptr);
-			}
-		}
-	}
+	crash_find_elfcorehdr(image);
 
 	if (image->elfcorehdr_index < 0) {
 		pr_err("unable to locate elfcorehdr segment");
-- 
2.34.1


