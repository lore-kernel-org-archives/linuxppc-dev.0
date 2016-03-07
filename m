Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC8131A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 01:10:16 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:39:57 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E926F1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:28:03 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27Ddsic31981570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:39:54 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27DZTG3012761
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 08:35:30 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 03/14] powerpc/mm/subpage: Clear RWX bit to indicate no access
Date: Mon,  7 Mar 2016 19:09:23 +0530
Message-Id: <1457357974-20839-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subpage protection used to depend on _PAGE_USER bit to implement no
access mode. This patch switch that to use _PAGE_RWX. We clear READ
and Write access from pte instead of clearing _PAGE_USER now. This was
done to enable us to switch to _PAGE_PRIVILGED. subpage_protection()
returns the pte bits that need to be cleared. Instead of updating the
interface to handle no-access in a separate way, it appears simple to
clear RWX acecss to indicate no access.

We still don't insert hash pte for these ptes, hence we should not
get PROT_FAULT with change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ea23403b3fc0..ec37f4b0a8ff 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -917,7 +917,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  * Userspace sets the subpage permissions using the subpage_prot system call.
  *
  * Result is 0: full permissions, _PAGE_RW: read-only,
- * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
+ * _PAGE_RWX: no access.
  */
 static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
@@ -943,8 +943,13 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 	/* extract 2-bit bitfield for this 4k subpage */
 	spp >>= 30 - 2 * ((ea >> 12) & 0xf);
 
-	/* turn 0,1,2,3 into combination of _PAGE_USER and _PAGE_RW */
-	spp = ((spp & 2) ? _PAGE_USER : 0) | ((spp & 1) ? _PAGE_RW : 0);
+	/*
+	 * 0 -> full premission
+	 * 1 -> Read only
+	 * 2 -> no access.
+	 * We return the flag that need to be cleared.
+	 */
+	spp = ((spp & 2) ? _PAGE_RWX : 0) | ((spp & 1) ? _PAGE_WRITE : 0);
 	return spp;
 }
 
-- 
2.5.0
