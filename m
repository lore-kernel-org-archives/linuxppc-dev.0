Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E4BC2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 21:01:02 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 29 Mar 2013 15:26:57 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5A67C3940058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:30:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2TA0qB756295652
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:30:52 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2TA0rOd007766
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 21:00:54 +1100
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/6] powerpc: Exit user context on notify resume
Date: Fri, 29 Mar 2013 18:00:18 +0800
Message-Id: <1364551221-23177-4-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
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
