Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0ED62C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:07 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Jan 2013 23:13:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 92C6C3578023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:02 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0UD6wmo9634244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:06:58 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0UDJ10V029255
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:02 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 1/3] powerpc: Don't hard code the size of pte page
Date: Wed, 30 Jan 2013 18:48:34 +0530
Message-Id: <1359551916-10321-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

USE PTRS_PER_PTE to indicate the size of pte page.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h |    6 ++++++
 arch/powerpc/mm/hash_low_64.S      |    4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index a9cbd3b..fc57855 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -17,6 +17,12 @@ struct mm_struct;
 #  include <asm/pgtable-ppc32.h>
 #endif
 
+/*
+ * hidx is in the second half of the page table. We use the
+ * 8 bytes per each pte entry.
+ */
+#define PTE_PAGE_HIDX_OFFSET (PTRS_PER_PTE * 8)
+
 #ifndef __ASSEMBLY__
 
 #include <asm/tlbflush.h>
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 5658508..94fd37b 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -484,7 +484,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	beq	htab_inval_old_hpte
 
 	ld	r6,STK_PARAM(R6)(r1)
-	ori	r26,r6,0x8000		/* Load the hidx mask */
+	ori	r26,r6,PTE_PAGE_HIDX_OFFSET /* Load the hidx mask. */
 	ld	r26,0(r26)
 	addi	r5,r25,36		/* Check actual HPTE_SUB bit, this */
 	rldcr.	r0,r31,r5,0		/* must match pgtable.h definition */
@@ -601,7 +601,7 @@ htab_pte_insert_ok:
 	sld	r4,r4,r5
 	andc	r26,r26,r4
 	or	r26,r26,r3
-	ori	r5,r6,0x8000
+	ori	r5,r6,PTE_PAGE_HIDX_OFFSET
 	std	r26,0(r5)
 	lwsync
 	std	r30,0(r6)
-- 
1.7.10
