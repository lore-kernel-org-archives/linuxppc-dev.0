Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9669E1A0823
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 17:00:03 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au
Subject: [PATCH 3/3] powerpc: Fill in si_addr_lsb siginfo field
Date: Wed, 24 Sep 2014 16:59:58 +1000
Message-Id: <1411541999-21457-3-git-send-email-anton@samba.org>
In-Reply-To: <1411541999-21457-1-git-send-email-anton@samba.org>
References: <1411541999-21457-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fill in the si_addr_lsb siginfo field so the hwpoison code can
pass to userspace the length of memory that has been corrupted.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 588b6cc..24b3f49 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -33,6 +33,7 @@
 #include <linux/magic.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
+#include <linux/hugetlb.h>
 
 #include <asm/firmware.h>
 #include <asm/page.h>
@@ -118,6 +119,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     unsigned int fault)
 {
 	siginfo_t info;
+	unsigned int lsb = 0;
 
 	up_read(&current->mm->mmap_sem);
 
@@ -135,7 +137,13 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 			current->comm, current->pid, address);
 		info.si_code = BUS_MCEERR_AR;
 	}
+
+	if (fault & VM_FAULT_HWPOISON_LARGE)
+		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+	if (fault & VM_FAULT_HWPOISON)
+		lsb = PAGE_SHIFT;
 #endif
+	info.si_addr_lsb = lsb;
 	force_sig_info(SIGBUS, &info, current);
 	return MM_FAULT_RETURN;
 }
-- 
1.9.1
