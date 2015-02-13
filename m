Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0108.outbound.protection.outlook.com [65.55.169.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CEA21A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 19:56:47 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
Subject: [PATCH v3 2/3] powerpc: Relax secure computing on syscall entry trace
Date: Fri, 13 Feb 2015 08:22:31 +0000
Message-ID: <1423815752-3013-3-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1423815752-3013-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1423815752-3013-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The secure_computing_strict will just force the kernel to panic on
secure_computing failure. Once SECCOMP_FILTER support is enabled in the kernel,
syscalls can be denied without system failure.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2edae06..285e056 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1772,7 +1772,9 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	user_exit();
 
-	secure_computing_strict(regs->gpr[0]);
+	/* Do the secure computing check first; failures should be fast. */
+	if (secure_computing(regs->gpr[0]) == -1)
+		return -1L;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
-- 
2.1.4
