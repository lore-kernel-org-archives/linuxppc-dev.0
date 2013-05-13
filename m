Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D7F62C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:08 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 May 2013 15:19:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6DEEA3578018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D57uXQ22675670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:07:56 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D5M1DP014038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:02 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/5] powerpc: Use the new schedule_user API on
 userspace preemption
Date: Mon, 13 May 2013 13:21:32 +0800
Message-Id: <1368422493-9831-5-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/context_tracking.h |   10 ++++++++++
 arch/powerpc/kernel/entry_64.S              |    3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/context_tracking.h

diff --git a/arch/powerpc/include/asm/context_tracking.h b/arch/powerpc/include/asm/context_tracking.h
new file mode 100644
index 0000000..b6f5a33
--- /dev/null
+++ b/arch/powerpc/include/asm/context_tracking.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_POWERPC_CONTEXT_TRACKING_H
+#define _ASM_POWERPC_CONTEXT_TRACKING_H
+
+#ifdef CONFIG_CONTEXT_TRACKING
+#define SCHEDULE_USER bl	.schedule_user
+#else
+#define SCHEDULE_USER bl	.schedule
+#endif
+
+#endif
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 915fbb4..d418977 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -33,6 +33,7 @@
 #include <asm/irqflags.h>
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
+#include <asm/context_tracking.h>
 
 /*
  * System calls.
@@ -634,7 +635,7 @@ _GLOBAL(ret_from_except_lite)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
 	bl	.restore_interrupts
-	bl	.schedule
+	SCHEDULE_USER
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
-- 
1.7.9.5
