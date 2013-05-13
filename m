Return-Path: <anton@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 609812C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 11:05:02 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Mon, 13 May 2013 10:58:43 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 728652BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 11:04:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D0p0u720906122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 10:51:00 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D14v0K020855
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 11:04:57 +1000
Date: Mon, 13 May 2013 11:04:53 +1000
From: Anton Blanchard <anton@au1.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/kexec: Fix kexec when using VMX optimised memcpy
Message-ID: <20130513110453.02a2d748@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit b3f271e86e5a (powerpc: POWER7 optimised memcpy using VMX and
enhanced prefetch) uses VMX when it is safe to do so (ie not in
interrupt). It also looks at the task struct to decide if we have to
save the current tasks' VMX state.

kexec calls memcpy() at a point where the task struct may have been
overwritten by the new kexec segments. If it has been overwritten
then when memcpy -> enable_altivec looks up current->thread.regs->msr
we get a cryptic oops or lockup.

I also notice we aren't initialising thread_info->cpu, which means
smp_processor_id is broken. Fix that too.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@vger.kernel.org> # 3.6+
---

Index: b/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/hardirq.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -335,10 +338,13 @@ void default_machine_kexec(struct kimage
 	pr_debug("kexec: Starting switchover sequence.\n");
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
+	 * We setup preempt_count to avoid using VMX in memcpy.
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
 	kexec_stack.thread_info.task = current_thread_info()->task;
 	kexec_stack.thread_info.flags = 0;
+	kexec_stack.thread_info.preempt_count = HARDIRQ_OFFSET;
+	kexec_stack.thread_info.cpu = current_thread_info()->cpu;
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
 	 * it.  Also poison per_cpu_offset to catch anyone using non-static
