Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP0x15jNkzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 13:49:25 +1100 (AEDT)
Date: Thu, 16 Feb 2017 13:49:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/64: Disable use of radix under a hypervisor
Message-ID: <20170216024921.GB19110@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if the kernel is running on a POWER9 processor under a
hypervisor, it may try to use the radix MMU even though it doesn't have
the necessary code to do so (it doesn't negotiate use of radix, and it
doesn't do the H_REGISTER_PROC_TBL hcall).  If the hypervisor supports
both radix and HPT, then it will set up the guest to use HPT (since the
guest doesn't request radix in the CAS call), but if the radix feature
bit is set in the ibm,pa-features property (which is valid, since
ibm,pa-features is defined to represent the capabilities of the
processor) the guest will try to use radix, resulting in a crash when
it turns the MMU on.

This makes the minimal fix for the current code, which is to disable
radix unless we are running in hypervisor mode.

Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 93abf8a..8e15880 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -347,7 +347,8 @@ early_param("disable_radix", parse_disable_radix);
 void __init mmu_early_init_devtree(void)
 {
 	/* Disable radix mode based on kernel command line. */
-	if (disable_radix)
+	/* We don't yet have the machinery to do radix as a guest. */
+	if (disable_radix || !(mfmsr() & MSR_HV))
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	if (early_radix_enabled())
-- 
2.10.2
