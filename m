Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D7AE1A0375
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:38 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 00:52:38 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 685102CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6FEZocm65667128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:35:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6FEqaHX028170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: subpage_protect: Increase the array size to take
 care of 64TB
Date: Tue, 15 Jul 2014 20:22:30 +0530
Message-Id: <1405435950-24187-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now support TASK_SIZE of 16TB, hence the array should be 8.

Fixes the below crash:

Unable to handle kernel paging request for data at address 0x000100bd
Faulting instruction address: 0xc00000000004f914
cpu 0x13: Vector: 300 (Data Access) at [c000000fea75fa90]
    pc: c00000000004f914: .sys_subpage_prot+0x2d4/0x5c0
    lr: c00000000004fb5c: .sys_subpage_prot+0x51c/0x5c0
    sp: c000000fea75fd10
   msr: 9000000000009032
   dar: 100bd
 dsisr: 40000000
  current = 0xc000000fea6ae490
  paca    = 0xc00000000fb8ab00   softe: 0        irq_happened: 0x00
    pid   = 8237, comm = a.out
enter ? for help
[c000000fea75fe30] c00000000000a164 syscall_exit+0x0/0x98
--- Exception: c00 (System Call) at 00003fff89737004

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 807014dde821..c2b4dcf23d03 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -22,6 +22,7 @@
  */
 #include <asm/pgtable-ppc64.h>
 #include <asm/bug.h>
+#include <asm/processor.h>
 
 /*
  * Segment table
@@ -496,7 +497,7 @@ extern void slb_set_size(u16 size);
  */
 struct subpage_prot_table {
 	unsigned long maxaddr;	/* only addresses < this are protected */
-	unsigned int **protptrs[2];
+	unsigned int **protptrs[(TASK_SIZE_USER64 >> 43)];
 	unsigned int *low_prot[4];
 };
 
-- 
1.9.1
