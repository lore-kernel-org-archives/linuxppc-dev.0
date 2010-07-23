Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6678B6EEA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N0c0MT001033
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:38:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N0fxxj1789962
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N0fwOI011728
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/mm: Handle hypervisor pte insert failure in
	__hash_page_huge
Date: Fri, 23 Jul 2010 10:41:40 +1000
Message-Id: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

If the hypervisor gives us an error on a hugepage insert we panic. The
normal page code already handles this by returning an error instead and we end
calling low_hash_fault which will just kill the task if possible.

The patch below does a similar thing for the hugepage case.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hugetlbpage-hash64.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 1995398..c9acd79 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -121,8 +121,15 @@ repeat:
                         }
 		}
 
-		if (unlikely(slot == -2))
-			panic("hash_huge_page: pte_insert failed\n");
+		/*
+		 * Hypervisor failure. Restore old pte and return -1
+		 * similar to __hash_page_*
+		 */
+		if (unlikely(slot == -2)) {
+			*ptep = __pte(old_pte);
+			err = -1;
+			goto out;
+		}
 
 		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
-- 
1.6.3.3
