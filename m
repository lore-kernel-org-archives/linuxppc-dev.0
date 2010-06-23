Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25101B73F4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:12 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4Gkh006285
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:16 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4BBn1314942
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:11 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA491U027486
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:11 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 06/40] x86: add arch_compat_syscall_addr()
Date: Wed, 23 Jun 2010 20:02:47 +1000
Message-Id: <1277287401-28571-7-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: x86@kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Baron <jbaron@redhat.com>

Add arch_compat_syscall_addr(int nr) for x86_64. This is in preparation for adding
compat syscall support to the event tracer.

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/x86/include/asm/syscall.h |    5 +++++
 arch/x86/kernel/ftrace.c       |    8 ++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index c4a348f..4e462cc 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,7 +16,12 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 
+#if defined(CONFIG_COMPAT) && defined(CONFIG_FTRACE_SYSCALLS)
+ #define __HAVE_ARCH_FTRACE_COMPAT_SYSCALLS
+#endif
+
 extern const unsigned long sys_call_table[];
+extern const unsigned long *ia32_sys_call_table;
 
 /*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index cd37469..4b36a0b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -26,6 +26,7 @@
 #include <asm/ftrace.h>
 #include <asm/nops.h>
 #include <asm/nmi.h>
+#include <asm/syscall.h>
 
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -510,3 +511,10 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef __HAVE_ARCH_FTRACE_COMPAT_SYSCALLS
+unsigned long __init arch_compat_syscall_addr(int nr)
+{
+	return (unsigned long)(&ia32_sys_call_table)[nr];
+}
+#endif
-- 
1.7.1
