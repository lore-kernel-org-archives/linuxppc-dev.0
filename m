Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 979D32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:13 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Jan 2013 23:13:44 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1A06E2CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:05 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0UD70oF8192426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:07:00 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0UDJ3tB029325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:04 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 2/3] arch/powerpc: Reduce the PTE_INDEX_SIZE
Date: Wed, 30 Jan 2013 18:48:35 +0530
Message-Id: <1359551916-10321-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1359551916-10321-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1359551916-10321-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This make one PMD cover 16MB range. That helps in easier implementation of THP
on power. THP core code make use of one pmd entry to track the huge page and
the range mapped by a single pmd entry should be equal to the huge page size
supported by the hardware.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64-64k.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index be4e287..3c529b4 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -4,10 +4,10 @@
 #include <asm-generic/pgtable-nopud.h>
 
 
-#define PTE_INDEX_SIZE  12
+#define PTE_INDEX_SIZE  8
 #define PMD_INDEX_SIZE  12
 #define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  6
+#define PGD_INDEX_SIZE  10
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
-- 
1.7.10
