Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0BDB1A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 17:00:00 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au
Subject: [PATCH 1/3] powerpc: Simplify do_sigbus
Date: Wed, 24 Sep 2014 16:59:56 +1000
Message-Id: <1411541999-21457-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Exit out early for a kernel fault, avoiding indenting of
most of the function.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/fault.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7..abc8c81 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -120,16 +120,16 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address)
 
 	up_read(&current->mm->mmap_sem);
 
-	if (user_mode(regs)) {
-		current->thread.trap_nr = BUS_ADRERR;
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
-		return MM_FAULT_RETURN;
-	}
-	return MM_FAULT_ERR(SIGBUS);
+	if (!user_mode(regs))
+		return MM_FAULT_ERR(SIGBUS);
+
+	current->thread.trap_nr = BUS_ADRERR;
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = BUS_ADRERR;
+	info.si_addr = (void __user *)address;
+	force_sig_info(SIGBUS, &info, current);
+	return MM_FAULT_RETURN;
 }
 
 static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
-- 
1.9.1
