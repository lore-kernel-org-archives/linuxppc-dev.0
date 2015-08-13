Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E99B81A0779
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 17:11:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: khandual@linux.vnet.ibm.com
Subject: [PATCH] powerpc/slb: Use a local to avoid multiple calls to
 get_slb_shadow()
Date: Thu, 13 Aug 2015 17:11:18 +1000
Message-Id: <1439449878-1168-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For no reason other than it looks ugly.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 0c7115fd314b..515730e499fe 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -62,16 +62,16 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
 				     enum slb_index index)
 {
+	struct slb_shadow *p = get_slb_shadow();
+
 	/*
 	 * Clear the ESID first so the entry is not valid while we are
 	 * updating it.  No write barriers are needed here, provided
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
-	get_slb_shadow()->save_area[index].esid = 0;
-	get_slb_shadow()->save_area[index].vsid =
-				cpu_to_be64(mk_vsid_data(ea, ssize, flags));
-	get_slb_shadow()->save_area[index].esid =
-				cpu_to_be64(mk_esid_data(ea, ssize, index));
+	p->save_area[index].esid = 0;
+	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
+	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
 }
 
 static inline void slb_shadow_clear(enum slb_index index)
-- 
2.1.4
