Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA662C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 13:19:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3F220659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 13:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3F220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dYw05qfbzDqWl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:19:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dYTy086NzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 00:00:06 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBC1BC057F3B;
 Mon, 14 Jan 2019 13:00:02 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDEA5D75F;
 Mon, 14 Jan 2019 12:59:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 7/9] arm64: kdump: No need to mark crashkernel pages
 manually PG_reserved
Date: Mon, 14 Jan 2019 13:59:01 +0100
Message-Id: <20190114125903.24845-8-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 14 Jan 2019 13:00:04 +0000 (UTC)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 CHANDAN VN <chandan.vn@samsung.com>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Stefan Agner <stefan@agner.ch>, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Laura Abbott <labbott@redhat.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 Dave Kleikamp <dave.kleikamp@oracle.com>, James Morse <james.morse@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The crashkernel is reserved via memblock_reserve(). memblock_free_all()
will call free_low_memory_core_early(), which will go over all reserved
memblocks, marking the pages as PG_reserved.

So manually marking pages as PG_reserved is not necessary, they are
already in the desired state (otherwise they would have been handed over
to the buddy as free pages and bad things would happen).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec.c |  2 +-
 arch/arm64/mm/init.c              | 27 ---------------------------
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 6f0587b5e941..66b5d697d943 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -321,7 +321,7 @@ void crash_post_resume(void)
  * but does not hold any data of loaded kernel image.
  *
  * Note that all the pages in crash dump kernel memory have been initially
- * marked as Reserved in kexec_reserve_crashkres_pages().
+ * marked as Reserved as memory was allocated via memblock_reserve().
  *
  * In hibernation, the pages which are Reserved and yet "nosave" are excluded
  * from the hibernation iamge. crash_is_nosave() does thich check for crash
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..c38976b70069 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -118,35 +118,10 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-#ifdef CONFIG_HIBERNATION
-	phys_addr_t addr;
-	struct page *page;
-
-	if (!crashk_res.end)
-		return;
-
-	/*
-	 * To reduce the size of hibernation image, all the pages are
-	 * marked as Reserved initially.
-	 */
-	for (addr = crashk_res.start; addr < (crashk_res.end + 1);
-			addr += PAGE_SIZE) {
-		page = phys_to_page(addr);
-		SetPageReserved(page);
-	}
-#endif
-}
 #else
 static void __init reserve_crashkernel(void)
 {
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-}
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
@@ -586,8 +561,6 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
-	kexec_reserve_crashkres_pages();
-
 	mem_init_print_info(NULL);
 
 	/*
-- 
2.17.2

