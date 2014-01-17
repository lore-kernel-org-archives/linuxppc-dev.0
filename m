Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 745DD2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 17:10:44 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 17 Jan 2014 16:10:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F05563578050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 17:10:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0H6ARFN11993592
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 17:10:28 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0H6AdYR031079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 17:10:40 +1100
Message-ID: <1389939036.3000.7.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH powerpc] Fix compile error of pgtable-ppc64.h
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 17 Jan 2014 14:10:36 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index d27960c..bc141c9 100644
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
