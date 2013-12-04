Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6ED362C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 17:58:24 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id at1so25775271iec.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 22:58:21 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] mm: export numa_migrate_prep()
Date: Wed,  4 Dec 2013 14:59:07 +0800
Message-Id: <1386140348-7854-3-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
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
