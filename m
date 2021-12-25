Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AFDC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Dec 2021 11:57:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JLj9B5WHkz3c8j
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Dec 2021 22:57:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JLj8k4gTZz2xYQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Dec 2021 22:57:08 +1100 (AEDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JLj4t03dTz1DK73;
 Sat, 25 Dec 2021 19:53:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:02 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, <linux-mm@kvack.org>, Andrew Morton
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Paul Mackerras" <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/2] mm: usercopy: Warn vmalloc/module address in
 check_heap_object()
Date: Sat, 25 Dec 2021 20:06:21 +0800
Message-ID: <20211225120621.13908-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
References: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

virt_addr_valid() could be insufficient to validate the virt addr
on some architecture, which could lead to potential BUG which has
been found on arm64/powerpc64.

Let's add WARN_ON to check if the virt addr is passed virt_addr_valid()
but is a vmalloc/module address.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/usercopy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..ce83e0b137dd 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -228,6 +228,8 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
+	WARN_ON_ONCE(is_vmalloc_or_module_addr(ptr));
+
 	/*
 	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
 	 * highmem page or fallback to virt_to_page(). The following
-- 
2.26.2

