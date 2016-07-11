Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnsJj6hDPzDqwn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 14:17:57 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hh10so2540365pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jul 2016 21:17:57 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au,
	sjitindarsingh@gmail.com
Subject: [PATCH] powerpc/crash: Rearrange loop condition to avoid out of
 bounds array access
Date: Mon, 11 Jul 2016 14:17:31 +1000
Message-Id: <1468210651-4199-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The array crash_shutdown_handles[] has size CRASH_HANDLER_MAX, thus when
we loop over the elements of the list we check crash_shutdown_handles[i]
&& i < CRASH_HANDLER_MAX. However this means that when we increment i to
CRASH_HANDLER_MAX we will perform an out of bound array access checking
the first condition before exiting on the second condition.

To avoid the out of bounds access, simply reorder the loop conditions.

Fixes Coverity bug #128232

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 888bdf1..47b63de 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -351,7 +351,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	old_handler = __debugger_fault_handler;
 	__debugger_fault_handler = handle_fault;
 	crash_shutdown_cpu = smp_processor_id();
-	for (i = 0; crash_shutdown_handles[i] && i < CRASH_HANDLER_MAX; i++) {
+	for (i = 0; i < CRASH_HANDLER_MAX && crash_shutdown_handles[i]; i++) {
 		if (setjmp(crash_shutdown_buf) == 0) {
 			/*
 			 * Insert syncs and delay to ensure
-- 
2.5.5
