Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1CD72C010D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 12:17:01 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 14 May 2013 07:42:58 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DE43F125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 07:48:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4E2Gp7p6554064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 07:46:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4E2Gt92022751
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 02:16:56 GMT
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/5] powerpc: Exit user context on notify resume
Date: Tue, 14 May 2013 10:16:42 +0800
Message-Id: <1368497804-21706-4-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1368497804-21706-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1368497804-21706-1-git-send-email-zhong@linux.vnet.ibm.com>
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

This patch allows RCU usage in do_notify_resume, e.g. signal handling.
It corresponds to
[PATCH] x86: Exit RCU extended QS on notify resume
  commit edf55fda35c7dc7f2d9241c3abaddaf759b457c6

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/signal.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index cf12eae..d63b502 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/signal.h>
 #include <linux/uprobes.h>
 #include <linux/key.h>
+#include <linux/context_tracking.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -159,6 +160,8 @@ static int do_signal(struct pt_regs *regs)
 
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 {
+	user_exit();
+
 	if (thread_info_flags & _TIF_UPROBE)
 		uprobe_notify_resume(regs);
 
@@ -169,4 +172,6 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
+
+	user_enter();
 }
-- 
1.7.9.5
