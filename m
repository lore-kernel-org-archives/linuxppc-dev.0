Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D7EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:24:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4224218AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4224218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Fwj6VsLzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:24:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440FVc2pQxzDqVP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:05:28 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2019 15:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; d="scan'208";a="138415618"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga001.jf.intel.com with ESMTP; 13 Feb 2019 15:05:24 -0800
From: ira.weiny@intel.com
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, kvm@vger.kernel.org,
 linux-fpga@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
 devel@lists.orangefs.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: [PATCH V2 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Date: Wed, 13 Feb 2019 15:04:52 -0800
Message-Id: <20190213230455.5605-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213230455.5605-1-ira.weiny@intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190213230455.5605-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Feb 2019 10:16:37 +1100
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
Cc: Martin Brandenburg <martin@omnibond.com>, Rich Felker <dalias@libc.org>,
 David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>,
 Ben Chan <benchan@chromium.org>, Rob Springer <rspringer@google.com>,
 Todd Poynor <toddpoynor@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Joerg Roedel <joro@8bytes.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ingo Molnar <mingo@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Alan Tull <atull@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Alexandre Bounine <alex.bou9@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Vetter <daniel@ffwll.ch>, Moritz Fischer <mdf@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Christian Benvenuti <benve@cisco.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Ira Weiny <ira.weiny@intel.com>

DAX pages were previously unprotected from longterm pins when users
called get_user_pages_fast().

Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
back to regular GUP processing if a DEVMAP page is encountered.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6f32d36b3c5b..f7e759c523bb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1439,6 +1439,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
+			if (unlikely(flags & FOLL_LONGTERM))
+				goto pte_unmap;
+
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
 				undo_dev_pagemap(nr, nr_start, pages);
@@ -1578,8 +1581,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pmd_devmap(orig))
+	if (pmd_devmap(orig)) {
+		if (unlikely(flags & FOLL_LONGTERM))
+			return 0;
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+	}
 
 	refs = 0;
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -1904,8 +1910,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		start += nr << PAGE_SHIFT;
 		pages += nr;
 
-		ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
-					      gup_flags);
+		if (gup_flags & FOLL_LONGTERM) {
+			down_read(&current->mm->mmap_sem);
+			ret = __gup_longterm_locked(current, current->mm,
+						    start, nr_pages - nr,
+						    pages, NULL, gup_flags);
+			up_read(&current->mm->mmap_sem);
+		} else {
+			/*
+			 * retain FAULT_FOLL_ALLOW_RETRY optimization if
+			 * possible
+			 */
+			ret = get_user_pages_unlocked(start, nr_pages - nr,
+						      pages, gup_flags);
+		}
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
-- 
2.20.1

