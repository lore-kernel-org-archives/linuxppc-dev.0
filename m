Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5440C2C0313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:47:03 +1100 (EST)
Received: by mail-ob0-f172.google.com with SMTP id gq1so6618514obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:47:00 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 1/4] mm: export numa_migrate_prep()
Date: Wed, 11 Dec 2013 16:47:51 +0800
Message-Id: <1386751674-14136-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc will use it in fast path.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5ab0e22..420fb77 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1092,6 +1092,8 @@ extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long
 extern int mprotect_fixup(struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
+extern int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+				unsigned long addr, int page_nid);
 
 /*
  * doesn't attempt to fault and will return short.
-- 
1.8.1.4
