Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CBFA2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:46:51 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 13:46:48 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E67BC6E804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:46:42 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QHki9v21757994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:46:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QHkfpw011802
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 14:46:43 -0300
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 1/3] page_alloc: make setup_nr_node_ids() usable for arch init
 code
Date: Tue, 26 Mar 2013 10:46:00 -0700
Message-Id: <1364319962-30967-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc and x86 were opencoding copies of setup_nr_node_ids(), which
page_alloc provides but makes static. Make it avaliable to the archs in
linux/mm.h.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/mm.h | 6 ++++++
 mm/page_alloc.c    | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7acc9dc..3405405 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1755,5 +1755,11 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool page_is_guard(struct page *page) { return false; }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
+#if MAX_NUMNODES > 1
+void __init setup_nr_node_ids(void);
+#else
+static inline void setup_nr_node_ids(void) {}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fcced7..96909bb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4710,7 +4710,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 /*
  * Figure out the number of possible node ids.
  */
-static void __init setup_nr_node_ids(void)
+void __init setup_nr_node_ids(void)
 {
 	unsigned int node;
 	unsigned int highest = 0;
@@ -4719,10 +4719,6 @@ static void __init setup_nr_node_ids(void)
 		highest = node;
 	nr_node_ids = highest + 1;
 }
-#else
-static inline void setup_nr_node_ids(void)
-{
-}
 #endif
 
 /**
-- 
1.8.2
