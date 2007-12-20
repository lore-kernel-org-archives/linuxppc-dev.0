Return-Path: <roland@redhat.com>
Received: from QMTA05.emeryville.ca.mail.comcast.net
	(qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
	by ozlabs.org (Postfix) with ESMTP id 9DBE5DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 24/43] powerpc compat_sys_ptrace
Message-Id: <20071220115855.D937126F98D@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:55 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This replaces powerpc's compat_sys_ptrace with a compat_arch_ptrace and
enables the new generic definition of compat_sys_ptrace instead.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace32.c |   33 +++++----------------------------
 include/asm-powerpc/ptrace.h   |    2 ++
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 6612304..0f6eea0 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -85,33 +85,13 @@ static long compat_ptrace_old(struct task_struct *child, long request,
 	return ret;
 }
 
-long compat_sys_ptrace(int request, int pid, unsigned long addr,
-		       unsigned long data)
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	struct task_struct *child;
+	unsigned long addr = caddr;
+	unsigned long data = cdata;
 	int ret;
 
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		ret = ptrace_traceme();
-		goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/*
 	 * Read 4 bytes of the other process' storage
@@ -375,9 +355,6 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		ret = compat_ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 }
diff --git a/include/asm-powerpc/ptrace.h b/include/asm-powerpc/ptrace.h
index 3063363..a8cb00c 100644
--- a/include/asm-powerpc/ptrace.h
+++ b/include/asm-powerpc/ptrace.h
@@ -55,6 +55,8 @@ struct pt_regs {
 
 #ifdef __powerpc64__
 
+#define __ARCH_WANT_COMPAT_SYS_PTRACE
+
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
 
 /* Size of dummy stack frame allocated when calling signal handler. */
-- 
1.5.3.6
