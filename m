Return-Path: <SRS0=ZMG4=T3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155BC04AB3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 11:18:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA7820883
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 11:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA7820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CDwk5lPLzDqNF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 21:17:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CDpQ11CnzDqDB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 21:12:30 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AADC387621;
 Mon, 27 May 2019 11:12:27 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-89.ams2.redhat.com [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B59CC2AA83;
 Mon, 27 May 2019 11:12:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 04/11] arm64/mm: Add temporary arch_remove_memory()
 implementation
Date: Mon, 27 May 2019 13:11:45 +0200
Message-Id: <20190527111152.16324-5-david@redhat.com>
In-Reply-To: <20190527111152.16324-1-david@redhat.com>
References: <20190527111152.16324-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 27 May 2019 11:12:27 +0000 (UTC)
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-ia64@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, Chintan Pandya <cpandya@codeaurora.org>,
 Igor Mammedov <imammedo@redhat.com>, akpm@linux-foundation.org,
 Mike Rapoport <rppt@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A proper arch_remove_memory() implementation is on its way, which also
cleanly removes page tables in arch_add_memory() in case something goes
wrong.

As we want to use arch_remove_memory() in case something goes wrong
during memory hotplug after arch_add_memory() finished, let's add
a temporary hack that is sufficient enough until we get a proper
implementation that cleans up page table entries.

We will remove CONFIG_MEMORY_HOTREMOVE around this code in follow up
patches.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jun Yao <yaojun8558363@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/mm/mmu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a1bfc4413982..e569a543c384 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1084,4 +1084,23 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   restrictions);
 }
+#ifdef CONFIG_MEMORY_HOTREMOVE
+void arch_remove_memory(int nid, u64 start, u64 size,
+			struct vmem_altmap *altmap)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone;
+
+	/*
+	 * FIXME: Cleanup page tables (also in arch_add_memory() in case
+	 * adding fails). Until then, this function should only be used
+	 * during memory hotplug (adding memory), not for memory
+	 * unplug. ARCH_ENABLE_MEMORY_HOTREMOVE must not be
+	 * unlocked yet.
+	 */
+	zone = page_zone(pfn_to_page(start_pfn));
+	__remove_pages(zone, start_pfn, nr_pages, altmap);
+}
+#endif
 #endif
-- 
2.20.1

