Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63F8DDDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 07:57:56 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH] powerpc/mm: Fix _PAGE_COHERENT support on classic ppc32 HW
Date: Tue, 10 Feb 2009 14:57:46 -0600
Message-Id: <1234299466-17300-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, martyn.welch@gefanuc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following commit:

commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Dec 18 19:13:51 2008 +0000

    powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED

broke setting of the _PAGE_COHERENT bit in the PPC HW PTE.  Since we now
actually set _PAGE_COHERENT in the Linux PTE we shouldn't be clearing it
out before we propogate it to the PPC HW PTE.

Reported-by: Martyn Welch <martyn.welch@gefanuc.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/hash_low_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 67850ec..14af8ce 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -320,7 +320,7 @@ _GLOBAL(create_hpte)
 	and	r8,r8,r0		/* writable if _RW & _DIRTY */
 	rlwimi	r5,r5,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
-	ori	r8,r8,0xe14		/* clear out reserved bits and M */
+	ori	r8,r8,0xe04		/* clear out reserved bits */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r8,r8,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
-- 
1.5.6.6
