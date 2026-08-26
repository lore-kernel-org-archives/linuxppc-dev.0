Return-Path: <linuxppc-dev+bounces-26107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE3C61DC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK563pxSz3c53;
	Wed, 26 Aug 2026 19:25:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736346;
	cv=none; b=e0wZo8ZGcVWUSWNf0sJ/DTeR2ud/q8bGJm0vtCBIOEoWlSCQ5iixY7Kza0am0aPj4b9H2yvTm5EUH01zALqnstHedEtC1hn7Wq6ccNmqWxPB34aVXHTsO0I68XEkmOOP+LLWSV0zfYjpyzr9wirj1wW0IWm6LUaiBFEeAyhNq874YVSFilwTa0Maz8uOHId9/wDW8tFu0o2AEWYdyWGAtWr2ynxtjEyZe7Lsg3n6JXqm0q3q3MWzetKfhRgZ7kmpBJz0r3Lb3fORtQmd5GDfZMPXWAKjJskQw8O5sxsGtAHgd4e74q5p4S7h4uz9OdyOWAnhVIcnP8ig8epvSP4x7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736346; c=relaxed/relaxed;
	bh=OsSkMIhsameVeQcyubflsAKjqyDPzlK/Dltq516R/Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQf7ZggAzmdjQjF69bDY8O5W9224+0Uwd/E3MU85Km4Cu16ghTpLXND3zAmZOiEJC1Tj0OZPRbNBnsmJDZbcPWO8E/kztUqNEIyPFbghF0oCtUxybpPPgNqp/OqIIX5SX59KF0QgM/DwsIiwQOJM+eKVIUBXQw5lNm9FPh6+X34MHRS7gNPqOsScgmfjl+gq8DSqDh5Q3KoxJ/UoOZyRXVxGFNPHRu6LE/zvzu4TpPhPpM/Br0P2FPQYKzTihDtKrvl0sEI1d71by+gC+wr6B0dp+WVEziijtfIHH4s5sfOVwHDLCNfwC0621frj1V0iLTcdx2BGizxonoqNz/JoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4/tAT6Kh; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4/tAT6Kh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK544cVLz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OsSkMIhsameVeQcyubflsAKjqyDPzlK/Dltq516R/Cc=;
	b=4/tAT6KhStANNCVtYQC+DB5wYYXDiC3tT34fBpKlCqPTh2I1YSkgN/f/nRnKQCczgulZrLa5x
	SMtVukw+4IMcbUBzz4us12yj4rcnLybfHqc3ah2t+jgK2r5itK8c4c82rj9Gk9VcSKgK+3/ji5n
	r0Yl4uQkkWaI+TBCQprUFWY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrX05jqz1prQB;
	Wed, 26 Aug 2026 17:14:52 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8733E4056D;
	Wed, 26 Aug 2026 17:25:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:37 +0800
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
Subject: [PATCH v3 13/17] crash: Improve elfcorehdr segment identification
Date: Wed, 26 Aug 2026 17:25:37 +0800
Message-ID: <20260826092541.3905933-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
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

Only checking ELFMAG is insufficient, as other segments like the
kernel image or an ELF initrd may also start with \x7fELF, leading
to misidentification. This is especially problematic when elfcorehdr
is not the last segment, such as:

	kexec -d --t bzImage -p bzImage --initrd=/bin/true

Add an "e_type == ET_CORE" check to ensure the correct segment is
identified, and break early after finding it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bd3f82b62751..0730c4ea8054 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -737,9 +737,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 			mem = image->segment[n].mem;
 			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
 			if (ptr) {
+				Elf64_Ehdr *ehdr = (Elf64_Ehdr *)ptr;
+
 				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0 && ehdr->e_type == ET_CORE) {
 					image->elfcorehdr_index = (int)n;
+					kunmap_local(ptr);
+					break;
+				}
 				kunmap_local(ptr);
 			}
 		}
-- 
2.34.1


