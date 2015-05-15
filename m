Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 383EC1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:29:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 3/3] powerpc: Enable seccomp-filter for 64-bit
Date: Fri, 15 May 2015 18:29:40 +1000
Message-Id: <1431678580-11160-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1431678580-11160-1-git-send-email-mpe@ellerman.id.au>
References: <1431678580-11160-1-git-send-email-mpe@ellerman.id.au>
Cc: strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now have the right pieces in place to enable seccomp-filter on
64-bit. We select HAVE_ARCH_SECCOMP_FILTER to enable the code, and we
also need to switch to using secure_computing() rather than the strict
variant.

Enabling support on 32-bit should just be a matter of fixing the
assembler in entry_32.S in a similar fashion to the 64-bit code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig         | 1 +
 arch/powerpc/kernel/ptrace.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 190cc48abc0c..a90bbd2c3f3b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -104,6 +104,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_LITTLE_ENDIAN
 	select HAVE_KPROBES
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_SECCOMP_FILTER if PPC64
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_MEMBLOCK
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f21897b42057..473d555ce60c 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1772,7 +1772,13 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	user_exit();
 
+#ifdef CONFIG_PPC64
+	/* Do the secure computing check first */
+	if (secure_computing() == -1)
+		return -1L;
+#else
 	secure_computing_strict(regs->gpr[0]);
+#endif
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
-- 
2.1.0
