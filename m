Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23BD6B76C5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:29 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4RxA001364
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4Ruq1835070
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4PDS017537
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:27 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 21/40] trace syscalls,
	PPC: Add ftrace compat syscall support for PPC64
Date: Wed, 23 Jun 2010 20:03:02 +1000
Message-Id: <1277287401-28571-22-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch adds the necessary infrastructure to trace 32bit compat
syscalls on PowerPC64.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/Kconfig              |    1 +
 arch/powerpc/include/asm/unistd.h |    4 ++++
 arch/powerpc/kernel/ftrace.c      |    7 +++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0d5c28d..a724c93 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,6 +142,7 @@ config PPC
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_COMPAT_FTRACE_SYSCALLS if PPC64
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index f0a1026..f584b71 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -353,6 +353,10 @@
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
 
+#ifdef CONFIG_PPC64
+#define NR_syscalls_compat NR_syscalls
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f5fadbb..dddbc33 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -619,3 +619,10 @@ inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 	return (!strcmp(sym + 4, name + 3));
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
+
+#ifdef CONFIG_COMPAT_FTRACE_SYSCALLS
+unsigned long __init arch_compat_syscall_addr(int nr)
+{
+	return sys_call_table[nr*2+1];
+}
+#endif
-- 
1.7.1
