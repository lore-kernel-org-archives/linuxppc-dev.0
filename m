Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zqgmF0X6YzF1HR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:16:27 +1100 (AEDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: [RESEND][PATCH 2/2] powerpc/watchdog: include linux/processor.h for
 spin_until_cond
Date: Mon, 26 Feb 2018 12:16:16 +0000
Message-Id: <1519647376-3352-2-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1519647376-3352-1-git-send-email-sudeep.holla@arm.com>
References: <1519647376-3352-1-git-send-email-sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implementation uses spin_until_cond in wd_smp_lock including
neither linux/processor.h nor asm/processor.h

This patch includes linux/processor.h here for spin_until_cond usage.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/kernel/watchdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 6256dc3b0087..f4359fde99f3 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -24,6 +24,7 @@
 #include <linux/kdebug.h>
 #include <linux/sched/debug.h>
 #include <linux/delay.h>
+#include <linux/processor.h>
 #include <linux/smp.h>
 
 #include <asm/paca.h>
-- 
2.7.4
