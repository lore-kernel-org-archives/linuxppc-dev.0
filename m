Return-Path: <srs0=xgkb=4e=linux.vnet.ibm.com=khandual@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDx1l14s0zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 00:25:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDx1l0W33z8sg1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 00:25:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDx1k3ssFz9s8G
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2017 00:25:46 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3SEKepl128420
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 10:25:44 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a416kajkf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 10:25:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 29 Apr 2017 00:25:37 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3SEPRKs61079666
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2017 00:25:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3SEOwGb025269
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2017 00:24:58 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm: Fix mapped range information print during boot
Date: Fri, 28 Apr 2017 19:54:45 +0530
Message-Id: <20170428142445.17615-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a trivial fix patch regarding mapped ranges in radix MMU
environment during boot. No functional change.

Before the patch:

$dmesg | grep Mapped
[    0.000000] Mapped range 0x0 - 0x2000000000 with 0x40000000
[    0.000000] Mapped range 0x200000000000 - 0x202000000000 with 0x40000000

After the patch:

$dmesg | grep Mapped
[    0.000000] Mapped range 0x0000000000000000 - 0x0000002000000000 with 1024 MB
[    0.000000] Mapped range 0x0000200000000000 - 0x0000202000000000 with 1024 MB

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d..802ead4 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -115,7 +115,8 @@ static inline void __meminit print_mapping(unsigned long start,
 	if (end <= start)
 		return;
 
-	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
+	pr_info("Mapped range 0x%016lx - 0x%016lx with %lu MB\n",
+			start, end, (unsigned long) (size >> 20));
 }
 
 static int __meminit create_physical_mapping(unsigned long start,
-- 
2.9.3
