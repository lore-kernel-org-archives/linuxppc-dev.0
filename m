Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2Nw2nhjzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so14494040pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/9] powerpc/64s: slb_allocate_realmode() preserve r3
Date: Sun, 21 May 2017 23:15:42 +1000
Message-Id: <20170521131550.25813-2-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One fewer registers clobbered by this function means the SLB miss
handler can save one fewer.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb_low.S | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 1519617aab36..9869b44a04dc 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -70,6 +70,7 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
  * Create an SLB entry for the given EA (user or kernel).
  * 	r3 = faulting address, r13 = PACA
  *	r9, r10, r11 are clobbered by this function
+ *	r3 is preserved.
  * No other registers are examined or changed.
  */
 _GLOBAL(slb_allocate_realmode)
@@ -235,6 +236,9 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
  	 * dont have any LRU information to help us choose a slot.
  	 */
 
+	mr	r9,r3
+
+	/* slb_finish_load_1T continues here. r9=EA with non-ESID bits clear */
 7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
 	/* This gets soft patched on boot. */
@@ -249,10 +253,10 @@ slb_compare_rr_to_size:
 	std	r10,PACASTABRR(r13)
 
 3:
-	rldimi	r3,r10,0,36		/* r3= EA[0:35] | entry */
-	oris	r10,r3,SLB_ESID_V@h	/* r3 |= SLB_ESID_V */
+	rldimi	r9,r10,0,36		/* r9  = EA[0:35] | entry */
+	oris	r10,r9,SLB_ESID_V@h	/* r10 = r9 | SLB_ESID_V */
 
-	/* r3 = ESID data, r11 = VSID data */
+	/* r9 = ESID data, r11 = VSID data */
 
 	/*
 	 * No need for an isync before or after this slbmte. The exception
@@ -265,21 +269,21 @@ slb_compare_rr_to_size:
 	bgelr	cr7
 
 	/* Update the slb cache */
-	lhz	r3,PACASLBCACHEPTR(r13)	/* offset = paca->slb_cache_ptr */
-	cmpldi	r3,SLB_CACHE_ENTRIES
+	lhz	r9,PACASLBCACHEPTR(r13)	/* offset = paca->slb_cache_ptr */
+	cmpldi	r9,SLB_CACHE_ENTRIES
 	bge	1f
 
 	/* still room in the slb cache */
-	sldi	r11,r3,2		/* r11 = offset * sizeof(u32) */
+	sldi	r11,r9,2		/* r11 = offset * sizeof(u32) */
 	srdi    r10,r10,28		/* get the 36 bits of the ESID */
 	add	r11,r11,r13		/* r11 = (u32 *)paca + offset */
 	stw	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
-	addi	r3,r3,1			/* offset++ */
+	addi	r9,r9,1			/* offset++ */
 	b	2f
 1:					/* offset >= SLB_CACHE_ENTRIES */
-	li	r3,SLB_CACHE_ENTRIES+1
+	li	r9,SLB_CACHE_ENTRIES+1
 2:
-	sth	r3,PACASLBCACHEPTR(r13)	/* paca->slb_cache_ptr = offset */
+	sth	r9,PACASLBCACHEPTR(r13)	/* paca->slb_cache_ptr = offset */
 	crclr	4*cr0+eq		/* set result to "success" */
 	blr
 
@@ -301,7 +305,7 @@ slb_compare_rr_to_size:
 	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
 
 	/* r3 = EA, r11 = VSID data */
-	clrrdi	r3,r3,SID_SHIFT_1T	/* clear out non-ESID bits */
+	clrrdi	r9,r3,SID_SHIFT_1T	/* clear out non-ESID bits */
 	b	7b
 
 
-- 
2.11.0
