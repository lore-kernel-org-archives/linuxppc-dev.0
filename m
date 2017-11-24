Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjj0f5bxlzDrb2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 14:51:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: david@gibson.dropbear.id.au,
	bsingharora@gmail.com,
	yilzhang@redhat.com
Subject: [PATCH] powerpc/kexec: Fix kexec/kdump in P9 guest kernels
Date: Fri, 24 Nov 2017 14:51:02 +1100
Message-Id: <20171124035102.28051-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code that cleans up the IAMR/AMOR before kexec'ing failed to
remember that when we're running as a guest AMOR is not writable, it's
hypervisor privileged.

They symptom is that the kexec stops before entering purgatory and
nothing else is seen on the console. If you examine the state of the
system all threads will be in the 0x700 program check handler.

Fix it by making the write to AMOR dependent on HV mode.

Fixes: 1e2a516e89fc ("powerpc/kexec: Fix radix to hash kexec due to IAMR/AMOR")
Cc: stable@vger.kernel.org # v4.10+
Reported-by: Yilin Zhang <yilzhang@redhat.com>
Debugged-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/misc_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 8ac0bd2bddb0..3280953a82cf 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -623,7 +623,9 @@ BEGIN_FTR_SECTION
 	 * NOTE, we rely on r0 being 0 from above.
 	 */
 	mtspr	SPRN_IAMR,r0
+BEGIN_FTR_SECTION_NESTED(42)
 	mtspr	SPRN_AMOR,r0
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	/* save regs for local vars on new stack.
-- 
2.14.3
