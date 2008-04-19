Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E1E2DE3F4
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 02:25:22 +1000 (EST)
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3324944FF0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 18:25:17 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Add compat handler for PTRACE_GETSIGINFO
Date: Sat, 19 Apr 2008 18:25:13 +0200
Message-ID: <je1w51ak2e.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current versions of gdb require a working implementation of
PTRACE_GETSIGINFO for proper watchpoint support.  Since struct siginfo
contains pointers it must be converted when passed to a 32-bit debugger.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/powerpc/kernel/ppc32.h    |    2 ++
 arch/powerpc/kernel/ptrace32.c |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

--- linux-2.6.25.orig/arch/powerpc/kernel/ppc32.h	2006-01-03 17:04:01.000000000 +0100
+++ linux-2.6.25/arch/powerpc/kernel/ppc32.h	2008-04-18 19:28:55.000000000 +0200
@@ -135,4 +135,6 @@ struct ucontext32 { 
 	struct mcontext32	uc_mcontext;
 };
 
+extern int copy_siginfo_to_user32(struct compat_siginfo __user *d, siginfo_t *s);
+
 #endif  /* _PPC64_PPC32_H */
--- linux-2.6.25.orig/arch/powerpc/kernel/ptrace32.c	2008-02-11 19:12:25.000000000 +0100
+++ linux-2.6.25/arch/powerpc/kernel/ptrace32.c	2008-04-18 19:31:20.000000000 +0200
@@ -29,12 +29,15 @@
 #include <linux/security.h>
 #include <linux/signal.h>
 #include <linux/compat.h>
+#include <linux/elf.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
+#include "ppc32.h"
+
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
@@ -64,6 +67,27 @@ static long compat_ptrace_old(struct tas
 	return -EPERM;
 }
 
+static int compat_ptrace_getsiginfo(struct task_struct *child, compat_siginfo_t __user *data)
+{
+	siginfo_t lastinfo;
+	int error = -ESRCH;
+
+	read_lock(&tasklist_lock);
+	if (likely(child->sighand != NULL)) {
+		error = -EINVAL;
+		spin_lock_irq(&child->sighand->siglock);
+		if (likely(child->last_siginfo != NULL)) {
+			lastinfo = *child->last_siginfo;
+			error = 0;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
+	if (!error)
+		return copy_siginfo_to_user32(data, &lastinfo);
+	return error;
+}
+
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
@@ -282,6 +306,9 @@ long compat_arch_ptrace(struct task_stru
 			0, PT_REGS_COUNT * sizeof(compat_long_t),
 			compat_ptr(data));
 
+	case PTRACE_GETSIGINFO:
+		return compat_ptrace_getsiginfo(child, compat_ptr(data));
+
 	case PTRACE_GETFPREGS:
 	case PTRACE_SETFPREGS:
 	case PTRACE_GETVRREGS:


-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
