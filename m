Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id 84F65DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 16:01:25 +1100 (EST)
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc exec PT_DTRACE
Message-Id: <20080317050120.8C9DC26F995@magilla.localdomain>
Date: Sun, 16 Mar 2008 22:01:20 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The PT_DTRACE flag is meaningless and obsolete.
Don't touch it.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/process.c   |    5 -----
 arch/powerpc/kernel/sys_ppc32.c |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 4846bf5..7c8e3da 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -862,11 +862,6 @@ int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
 	flush_spe_to_thread(current);
 	error = do_execve(filename, (char __user * __user *) a1,
 			  (char __user * __user *) a2, regs);
-	if (error == 0) {
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
-	}
 	putname(filename);
 out:
 	return error;
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 4a4f5c6..9c3371e 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -368,11 +368,6 @@ long compat_sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
 
 	error = compat_do_execve(filename, compat_ptr(a1), compat_ptr(a2), regs);
 
-	if (error == 0) {
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
-	}
 	putname(filename);
 
 out:
