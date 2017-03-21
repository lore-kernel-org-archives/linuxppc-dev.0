Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnFnW6f7wzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 12:38:07 +1100 (AEDT)
Date: Tue, 21 Mar 2017 12:38:02 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Revert "powerpc/64: Disable use of radix under a hypervisor"
Message-ID: <20170321013802.GA21037@fergus.ozlabs.ibm.com>
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

This reverts commit 3f91a89d424a79f8082525db5a375e438887bb3e.

Now that we do have the machinery for using the radix MMU under a
hypervisor, the extra check and comment introduced in 3f91a89d424a are
no longer correct.  The result is that when booted under a hypervisor
that only allows use of radix, we clear the MMU_FTR_TYPE_RADIX and
then set it again, and print a warning about ignoring the
disable_radix command line option, even though the command line does
not include "disable_radix".

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
This should go into 4.11.

 arch/powerpc/mm/init_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9be9920..c22f207 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -397,8 +397,7 @@ static void early_check_vec5(void)
 void __init mmu_early_init_devtree(void)
 {
 	/* Disable radix mode based on kernel command line. */
-	/* We don't yet have the machinery to do radix as a guest. */
-	if (disable_radix || !(mfmsr() & MSR_HV))
+	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	/*
-- 
2.7.4
