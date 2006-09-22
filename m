Return-Path: <SRS0+e8fc20ab33191259865d+1125+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD4C267B66
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 18:24:00 +1000 (EST)
Subject: [PATCH] Fix audit syscall success/failure reporting on PowerPC
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Fri, 22 Sep 2006 09:23:53 +0100
Message-Id: <1158913433.24527.650.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to my stupidity, we were checking for the wrong bit in CCR when
attempting to determine whether a syscall succeeded or not. Remedy the
symptom, if not the cause.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index dea75d7..cf1d1bc 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -553,7 +553,7 @@ #ifdef CONFIG_PPC32
 #endif
 
 	if (unlikely(current->audit_context))
-		audit_syscall_exit((regs->ccr&0x1000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
+		audit_syscall_exit((regs->ccr&0x10000000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
 				   regs->result);
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)

-- 
dwmw2
