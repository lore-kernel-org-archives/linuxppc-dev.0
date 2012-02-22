Return-Path: <xenidis@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFDF3B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 08:51:58 +1100 (EST)
Received: by pbbrp2 with SMTP id rp2so681043pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 13:51:55 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: icswx: fix race condition where threads do not get
 their ACOP register updated in time.
Date: Wed, 22 Feb 2012 16:07:46 -0600
Message-Id: <1329948466-325-1-git-send-email-jimix@pobox.com>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a race where a thread causes a coprocessor type to be valid
in its own ACOP _and_ in the current context, but it does not
propagate to the ACOP register of other threads in time for them to
use it.  The original code tries to solve this by sending an IPI to
all threads on the system, which is heavy handed, but unfortunately
still provides a window where the icswx is issued by other threads and
the ACOP is not up to date.

This patch detects that the ACOP DSI fault was a "false positive" and
syncs the ACOP and causes the icswx to be replayed.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/icswx.c |   29 +++++++++++++++++++++++++++--
 arch/powerpc/mm/icswx.h |    6 ++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/icswx.c b/arch/powerpc/mm/icswx.c
index 5d9a59e..4db5b36 100644
--- a/arch/powerpc/mm/icswx.c
+++ b/arch/powerpc/mm/icswx.c
@@ -163,7 +163,7 @@ EXPORT_SYMBOL_GPL(drop_cop);
 
 static int acop_use_cop(int ct)
 {
-	/* todo */
+	/* There is no alternate policy, yet */
 	return -1;
 }
 
@@ -227,11 +227,36 @@ int acop_handle_fault(struct pt_regs *regs, unsigned long address,
 		ct = (ccw >> 16) & 0x3f;
 	}
 
+	/*
+	 * We could be here because another thread has enabled acop
+	 * but the ACOP register has yet to be updated.
+	 *
+	 * This should have been taken care of by the IPI to sync all
+	 * the threads (see smp_call_function(sync_cop, mm, 1)), but
+	 * that could take forever if there are a significant amount
+	 * of threads.
+	 *
+	 * Given the number of threads on some of these systems,
+	 * perhaps this is the best way to sync ACOP rather than whack
+	 * every thread with an IPI.
+	 */
+	if (acop_copro_type_bit(ct) && current->active_mm->context.acop) {
+		pr_debug("%s[%d]: Spurrious ACOP Fault, CT: %d, bit: 0x%llx "
+			"SPR: 0x%lx, mm->acop: 0x%lx\n",
+			current->comm, current->pid,
+			ct, acop_copro_type_bit(ct), mfspr(SPRN_ACOP),
+			current->active_mm->context.acop);
+
+		sync_cop(current->active_mm);
+		return 0;
+	}
+
+	/* check for alternate policy */
 	if (!acop_use_cop(ct))
 		return 0;
 
 	/* at this point the CT is unknown to the system */
-	pr_warn("%s[%d]: Coprocessor %d is unavailable",
+	pr_warn("%s[%d]: Coprocessor %d is unavailable\n",
 		current->comm, current->pid, ct);
 
 	/* get inst if we don't already have it */
diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
index 42176bd..6dedc08 100644
--- a/arch/powerpc/mm/icswx.h
+++ b/arch/powerpc/mm/icswx.h
@@ -59,4 +59,10 @@ extern void free_cop_pid(int free_pid);
 
 extern int acop_handle_fault(struct pt_regs *regs, unsigned long address,
 			     unsigned long error_code);
+
+static inline u64 acop_copro_type_bit(unsigned int type)
+{
+	return 1ULL << (63 - type);
+}
+
 #endif /* !_ARCH_POWERPC_MM_ICSWX_H_ */
-- 
1.7.0.4
