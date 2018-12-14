Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F5C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCE720892
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GT1y0mkBzDrTM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:33:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GSXx1MD9zDrHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 22:11:29 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E53487643;
 Fri, 14 Dec 2018 11:11:27 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-139.ams2.redhat.com [10.36.117.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49F465DA2A;
 Fri, 14 Dec 2018 11:11:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 9/9] mm: better document PG_reserved
Date: Fri, 14 Dec 2018 12:10:14 +0100
Message-Id: <20181214111014.15672-10-david@redhat.com>
In-Reply-To: <20181214111014.15672-1-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 14 Dec 2018 11:11:27 +0000 (UTC)
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
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Miles Chen <miles.chen@mediatek.com>, David Hildenbrand <david@redhat.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The usage of PG_reserved and how PG_reserved pages are to be treated is
buried deep down in different parts of the kernel. Let's shine some light
onto these details by documenting current users and expected
behavior.

Especially, clarify on the "Some of them might not even exist" case.
These are physical memory gaps that will never be dumped as they
are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
hinder anybody from dumping or swapping. In some cases, these pages
will not be stored in the hibernation image.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: yi.z.zhang@linux.intel.com
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 808b4183e30d..9de2e941cbd5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,37 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages. The "struct page" of such a page
+ * should in general not be touched (e.g. set dirty) except by their owner.
+ * Pages marked as PG_reserved include:
+ * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
+ *   initrd, HW tables)
+ * - Pages reserved or allocated early during boot (before the page allocator
+ *   was initialized). This includes (depending on the architecture) the
+ *   initial vmmap, initial page tables, crashkernel, elfcorehdr, and much
+ *   much more. Once (if ever) freed, PG_reserved is cleared and they will
+ *   be given to the page allocator.
+ * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
+ *   to read/write these pages might end badly. Don't touch!
+ * - The zero page(s)
+ * - Pages not added to the page allocator when onlining a section because
+ *   they were excluded via the online_page_callback() or because they are
+ *   PG_hwpoison.
+ * - Pages allocated in the context of kexec/kdump (loaded kernel image,
+ *   control pages, vmcoreinfo)
+ * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
+ *   not marked PG_reserved (as they might be in use by somebody else who does
+ *   not respect the caching strategy).
+ * - Pages part of an offline section (struct pages of offline sections should
+ *   not be trusted as they will be initialized when first onlined).
+ * - MCA pages on ia64
+ * - Pages holding CPU notes for POWER Firmware Assisted Dump
+ * - Device memory (e.g. PMEM, DAX, HMM)
+ * Some PG_reserved pages will be excluded from the hibernation image.
+ * PG_reserved does in general not hinder anybody from dumping or swapping
+ * and is no longer required for remap_pfn_range(). ioremap might require it.
+ * Consequently, PG_reserved for a page mapped into user space can indicate
+ * the zero page, the vDSO, MMIO pages or device memory.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.2

