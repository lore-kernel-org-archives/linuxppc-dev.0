Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C1DFC2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 23:22:55 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 17:52:52 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7C173394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:52:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SCMi7w48234574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:52:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SCMm30031429
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:52:49 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, stable@vger.kernel.org
Subject: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
Date: Tue, 28 Jan 2014 17:52:42 +0530
Message-Id: <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Zhong <zhong@linux.vnet.ibm.com>

It seems that forward declaration couldn't work well with typedef, use
struct spinlock directly to avoiding following build errors:

In file included from include/linux/spinlock.h:81,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/uapi/linux/timex.h:56,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
/root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here

build fix for upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
for 3.13 stable series

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index d27960c89a71..bc141c950b1e 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
-typedef struct spinlock spinlock_t;
-static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
-					 spinlock_t *old_pmd_ptl)
+struct spinlock;
+static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+					 struct spinlock *old_pmd_ptl)
 {
 	/*
 	 * Archs like ppc64 use pgtable to store per pmd
-- 
1.8.5.3
