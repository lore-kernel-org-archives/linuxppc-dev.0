Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zq2MX9zF0C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:39 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 62so11289797pld.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/9] powerpc/64: rtas avoid accessing paca in 32-bit mode
Date: Fri, 22 Dec 2017 21:17:10 +1000
Message-Id: <20171222111716.13101-4-npiggin@gmail.com>
In-Reply-To: <20171222111716.13101-1-npiggin@gmail.com>
References: <20171222111716.13101-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 177ba7c647f3 ("powerpc/mm/radix: Limit paca allocation in radix")
limited the paca allocation address to 1G on pSeries because RTAS return
accesses the paca in 32-bit mode:

    On return from RTAS we access the paca variables and we have 64 bit
    disabled. This requires us to limit paca in 32 bit range.

    Fix this by setting ppc64_rma_size to first_memblock_size/1G range.

Avoid this limit by switching to 64-bit mode before accessing any memory.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 36878b6ee8b8..371c05fe250a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1083,6 +1083,17 @@ __enter_rtas:
 rtas_return_loc:
 	FIXUP_ENDIAN
 
+	/*
+	 * Clear RI and set SF before anything.
+	 */
+	mfmsr   r6
+	li	r0,MSR_RI
+	andc	r6,r6,r0
+	sldi	r0,r0,(MSR_SF_LG - MSR_RI_LG)
+	or	r6,r6,r0
+	sync
+	mtmsrd  r6
+
 	/* relocation is off at this point */
 	GET_PACA(r4)
 	clrldi	r4,r4,2			/* convert to realmode address */
@@ -1091,12 +1102,6 @@ rtas_return_loc:
 0:	mflr	r3
 	ld	r3,(1f-0b)(r3)		/* get &rtas_restore_regs */
 
-	mfmsr   r6
-	li	r0,MSR_RI
-	andc	r6,r6,r0
-	sync	
-	mtmsrd  r6
-        
         ld	r1,PACAR1(r4)           /* Restore our SP */
         ld	r4,PACASAVEDMSR(r4)     /* Restore our MSR */
 
-- 
2.15.0
