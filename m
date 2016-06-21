Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYkfZ3D1GzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 20:36:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, kda@linux-powerpc.org
Subject: [PATCH] powerpc: Fix faults caused by radix patching of SLB miss
 handler
Date: Tue, 21 Jun 2016 20:36:19 +1000
Message-Id: <1466505379-15597-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As part of the Radix MMU support we added some feature sections in the
SLB miss handler. These are intended to catch the case that we
incorrectly take an SLB miss when Radix is enabled, and instead of
crashing weirdly they bail out to a well defined exit path and trigger
an oops.

However the way they were written meant the bailout case was enabled by
default until we did CPU feature patching.

On powermacs the early debug prints in setup_system() can cause an SLB
miss, which happens before code patching, and so the SLB miss handler
would incorrectly bailout and crash during boot.

Fix it by inverting the sense of the feature section, so that the code
which is in place at boot is correct for the hash case. Once we
determine we are using Radix - which will never happen on a powermac -
only then do we patch in the bailout case which unconditionally jumps.

Fixes: caca285e5ab4 ("powerpc/mm/radix: Use STD_MMU_64 to properly isolate hash related code")
Reported-by: Denis Kirjanov <kda@linux-powerpc.org>
Tested-by: Denis Kirjanov <kda@linux-powerpc.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c9440629128..8bcc1b457115 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1399,11 +1399,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 
 	mtlr	r10
-BEGIN_MMU_FTR_SECTION
-	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+BEGIN_MMU_FTR_SECTION
 	beq-	2f
+FTR_SECTION_ELSE
+	b	2f
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 
 .machine	push
 .machine	"power4"
-- 
2.5.0
