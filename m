Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
Date: Fri, 3 Aug 2007 18:58:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix special PTE code for secondary hash bucket
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code for mapping special 4k pages on kernels using a 64kB base
page size was missing the code for doing the RPN (real page number)
manipulation when inserting the hardware PTE in the secondary hash
bucket.  It needs the same code as has already been added to the
code that inserts the HPTE in the primary hash bucket.  This adds it.

Spotted by Ben Herrenschmidt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 4762ff7..35eabfb 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -472,10 +472,12 @@ _GLOBAL(htab_call_hpte_insert1)
 	/* Now try secondary slot */
 
 	/* real page number in r5, PTE RPN value + index */
-	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
+	andis.	r0,r31,_PAGE_4K_PFN@h
+	srdi	r5,r31,PTE_RPN_SHIFT
+	bne-	3f
 	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
 	add	r5,r5,r25
-	sldi	r5,r5,HW_PAGE_SHIFT
+3:	sldi	r5,r5,HW_PAGE_SHIFT
 
 	/* Calculate secondary group hash */
 	andc	r0,r27,r28
