Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxj6GCFzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 08/70] powerpc/mm/subpage: Clear RWX bit to indicate no
 access
Date: Fri, 29 Apr 2016 23:25:31 +1000
Message-Id: <1461936393-10131-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Subpage protection used to depend on the _PAGE_USER bit to implement no
access mode. This patch switches that to use _PAGE_RWX. We clear Read,
Write and Execute access from the pte instead of clearing _PAGE_USER
now. This was done so that we can switch to _PAGE_PRIVILEGED in a later
patch.

subpage_protection() returns pte bits that need to be cleared. Instead
of updating the interface to handle no-access in a separate way, it
appears simpler to clear RWX acecss to indicate no access.

We still don't insert hash ptes for no access implied by !_PAGE_RWX.
Hence we should not get PROT_FAULT with change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ed190e42bbc5..36e00371ba5a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -921,7 +921,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  * Userspace sets the subpage permissions using the subpage_prot system call.
  *
  * Result is 0: full permissions, _PAGE_RW: read-only,
- * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
+ * _PAGE_RWX: no access.
  */
 static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
@@ -947,8 +947,13 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
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
