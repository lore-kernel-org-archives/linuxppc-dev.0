Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72171DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 19:21:45 +1000 (EST)
Subject: [PATCH] swsusp: introduce register_nosave_region_late
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 08 May 2007 11:23:49 +0200
Message-Id: <1178616229.18162.40.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces a new register_nosave_region_late function that
can be called from initcalls when register_nosave_region can no longer
be used because it uses bootmem.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

---
Paul, I see you merged the suspend to disk for G5 patches, but this one
is required for it to build. Rafael said that we should merge it with
the user, since our code is the only user right now I take it that means
it should go through the powerpc tree.

 include/linux/suspend.h |   11 ++++++++++-
 kernel/power/snapshot.c |   12 +++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

--- linux-2.6-git.orig/include/linux/suspend.h	2007-05-03 15:20:29.081123904 +0200
+++ linux-2.6-git/include/linux/suspend.h	2007-05-03 15:23:03.819123904 +0200
@@ -52,7 +52,15 @@ struct hibernation_ops {
 
 #if defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND)
 /* kernel/power/snapshot.c */
-extern void __init register_nosave_region(unsigned long, unsigned long);
+extern void __register_nosave_region(unsigned long b, unsigned long e, int km);
+static inline void register_nosave_region(unsigned long b, unsigned long e)
+{
+	__register_nosave_region(b, e, 0);
+}
+static inline void register_nosave_region_late(unsigned long b, unsigned long e)
+{
+	__register_nosave_region(b, e, 1);
+}
 extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
@@ -70,6 +78,7 @@ void hibernation_set_ops(struct hibernat
 extern int hibernate(void);
 #else
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
+static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
--- linux-2.6-git.orig/kernel/power/snapshot.c	2007-05-03 15:20:01.842123904 +0200
+++ linux-2.6-git/kernel/power/snapshot.c	2007-05-03 15:22:19.138123904 +0200
@@ -608,7 +608,8 @@ static LIST_HEAD(nosave_regions);
  */
 
 void __init
-register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
+__register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
+			 int use_kmalloc)
 {
 	struct nosave_region *region;
 
@@ -624,8 +625,13 @@ register_nosave_region(unsigned long sta
 			goto Report;
 		}
 	}
-	/* This allocation cannot fail */
-	region = alloc_bootmem_low(sizeof(struct nosave_region));
+	if (use_kmalloc) {
+		/* during init, this shouldn't fail */
+		region = kmalloc(sizeof(struct nosave_region), GFP_KERNEL);
+		BUG_ON(!region);
+	} else
+		/* This allocation cannot fail */
+		region = alloc_bootmem_low(sizeof(struct nosave_region));
 	region->start_pfn = start_pfn;
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);
