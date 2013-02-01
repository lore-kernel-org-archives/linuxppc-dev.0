Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F6E32C0332
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 21:28:08 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 1 Feb 2013 15:55:30 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 46989E0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 15:58:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r11AS15U21102662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Feb 2013 15:58:01 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r11AS1e8022782
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Feb 2013 21:28:02 +1100
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] powerpc: Use the new schedule_user API on userspace
 preemption
Date: Fri,  1 Feb 2013 18:27:44 +0800
Message-Id: <1359714465-6297-5-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, fweisbec@gmail.com, paulus@samba.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch corresponds to
[PATCH] x86: Use the new schedule_user API on userspace preemption
  commit 0430499ce9d78691f3985962021b16bf8f8a8048

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/context_tracking.h |   11 +++++++++++
 arch/powerpc/kernel/entry_64.S              |    3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/context_tracking.h b/arch/powerpc/include/asm/context_tracking.h
index 3adccd8..2e042ba 100644
--- a/arch/powerpc/include/asm/context_tracking.h
+++ b/arch/powerpc/include/asm/context_tracking.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_CONTEXT_TRACKING_H
 #define _ASM_POWERPC_CONTEXT_TRACKING_H
 
+#ifndef __ASSEMBLY__
 #include <linux/context_tracking.h>
 #include <asm/ptrace.h>
 
@@ -17,4 +18,14 @@ static inline void exception_exit(struct pt_regs *regs)
 #endif
 }
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CONTEXT_TRACKING
+#define SCHEDULE_USER bl	.schedule_user
+#else
+#define SCHEDULE_USER bl	.schedule
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
 #endif
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 3d990d3..91f09ec 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -33,6 +33,7 @@
 #include <asm/irqflags.h>
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
+#include <asm/context_tracking.h>
 
 /*
  * System calls.
@@ -595,7 +596,7 @@ _GLOBAL(ret_from_except_lite)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
 	bl	.restore_interrupts
-	bl	.schedule
+	SCHEDULE_USER
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
-- 
1.7.9.5
