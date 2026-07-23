Return-Path: <linuxppc-dev+bounces-24737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAF3C531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkt6Q3zz2ygm;
	Thu, 23 Jul 2026 23:12:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812374;
	cv=none; b=mMvyD8jvOmi9s74s0/ZatKwzNOEWoxfJuiN6k4EjyI82ETNECWFBloQibTbYqQqSVO1AbhT1sFcZJ26uQYpjwCgk4Pqp+h+RqzNwMHXZUl6jyrb53HyfdpiTPnb/nnrGbs7oOwgOMClt28gPoQYWRDjSWcaQvpw0Ackr8m+6D+mKOHHRbOFl4Hco0FD+Rt6CzK9W2IDqPy978MBrQhTeWGA3vL+LJN3RmUqOkYSN8gy1ui6uNLJNt9p7PWCPKj7s6G/FhPDDipC9aE8SOgmovjrNbGpElSDucW/NGQUkZ7KnZgMgvIBW+zmA2GDyVP7oTDwFlPKbz2BnwVf5OAvJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812374; c=relaxed/relaxed;
	bh=hK7jXFCfDWQmfE1lAfmJ1Za3SQzmPkoVKzIw7WDhIQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHW2XBEIoOgrAcbWa/p62nc2b7DRUI6AjejeMmN/vz5prKmu3wfryoHMVrjfjxLvjJygkVNpHmlAKcRoF8swjilEmoVctLj4CzKclSFNreL7MVuaV+rNM8uGlgtLgfbW4pwiAzTrffFqDRkd4WmwbOqkuFIn5qbpso7gyT4PDsOuMWMXKtrer8lEQxK52i2cLQDjpCCW2iQ1TCd8csl86d67uOV/Lhdr9tvs9gnwwGK9QirUrs7XAs63ZTHwETso7LtOxOz0qSW6K1bYK6MVsu2AM+ozkr3F8xikWlxEc+lp0AeKISh5JYWMqjudt3cfzFwpa0oz3DU1UywAdh5pdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=31XQs43c; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=31XQs43c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkr6PL6z2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:52 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hK7jXFCfDWQmfE1lAfmJ1Za3SQzmPkoVKzIw7WDhIQs=;
	b=31XQs43cCV6qUL/z+fW/NkDN9h0WcjRSf5EWA/7dfyMRXUhd6y5jYVs6/QTD42C/zM30SYR4/
	whaZW45IuDMQuymkmF6F3ZYU9f982Zg01l9E4Ur45WddBKSTgZvoDc1roJNPeL/7kVU6AVyLSxB
	1XgVvw5QyX+I6ClfZxod72E=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWx0T82z1cyQd;
	Thu, 23 Jul 2026 21:03:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 05479402AB;
	Thu, 23 Jul 2026 21:12:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:45 +0800
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
Subject: [PATCH 6/8] arm64: kexec_file: Fix image->elf_headers memory leak during retry loop
Date: Thu, 23 Jul 2026 21:12:40 +0800
Message-ID: <20260723131242.1537633-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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

Sashiko AI code review pointed out a potential memory leak of
image->elf_headers when load_other_segments() fails on error paths.

When load_other_segments() fails during the arm64 kexec_file file-load
path, execution jumps to the out_err label. While this path restores
`image->nr_segments`, it returns an error back to the caller without
freeing the allocated `image->elf_headers` vmalloc buffer.

Consequently, the retry loop in image_load() will allocate new ELF
headers on the next iteration and overwrite `image->elf_headers`,
permanently leaking the memory blocks allocated in previous iterations.

Fix this by explicitly freeing the stale `image->elf_headers` buffer
once the new headers buffer is allocated.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Benjamin Gwin <bgwin@google.com>
Cc: stable@vger.kernel.org
Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e48f29167b38..2f750e5f4fcc 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -112,6 +112,10 @@ int load_other_segments(struct kimage *image,
 			vfree(headers);
 			goto out_err;
 		}
+
+		if (unlikely(image->elf_headers))
+			vfree(image->elf_headers);
+
 		image->elf_headers = headers;
 		image->elf_load_addr = kbuf.mem;
 		image->elf_headers_sz = headers_sz;
-- 
2.34.1


