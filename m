Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6KXz5XfTzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 21:26:43 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm/hash: Remove stale comment.
Date: Tue, 11 Jul 2017 13:26:26 +0200
Message-Id: <20170711112626.17094-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit e6f81a92015b ("powerpc/mm/hash: Support 68 bit VA") the
masking is folded into ASM_VSID_SCRAMBLE but the comment about masking
is removed only from the firt use of ASM_VSID_SCRAMBLE.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/mm/slb_low.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index bde378559d01..8e95e01b9e8e 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -296,10 +296,6 @@ slb_compare_rr_to_size:
 	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
 	rldimi  r10,r9,ESID_BITS_1T,0
 	ASM_VSID_SCRAMBLE(r10,r9,r11,1T)
-	/*
-	 * bits above VSID_BITS_1T need to be ignored from r10
-	 * also combine VSID and flags
-	 */
 
 	li	r10,MMU_SEGSIZE_1T
 	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
-- 
2.10.2
