Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17F1F2C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:03 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 May 2013 15:14:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AB0E22CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:21:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D57qji4325544
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:07:52 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D5Lvrs013881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:21:57 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/5] powerpc: Exit user context on notify resume
Date: Mon, 13 May 2013 13:21:31 +0800
Message-Id: <1368422493-9831-4-git-send-email-zhong@linux.vnet.ibm.com>
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
