Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Hlr5G7WzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 10:57:44 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g132so2416774pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 17:57:44 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH] powerpc: Add array bounds checking to crash_shutdown_handlers
Date: Wed, 11 May 2016 10:57:32 +1000
Message-Id: <1462928252-11195-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The array crash_shutdown_handles is an array of size CRASH_HANDLER_MAX+1
containing up to CRASH_HANDLER_MAX shutdown_handlers. It is assumed to
be NULL terminated, which it is under normal circumstances. Array
accesses in the functions crash_shutdown_unregister() and
default_machine_crash_shutdown() rely on this NULL termination property
when traversing this list and don't protect again out of bounds accesses.
If the NULL terminator were somehow overwritten these functions could
potentially access out of the bounds of the array.

Shrink the array to size CRASH_HANDLER_MAX and implement explicit array
bounds checking when accessing the elements of the
crash_shutdown_handles[] array in crash_shutdown_unregister() and
default_machine_crash_shutdown().

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/crash.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 2bb252c..3dc1fad 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -48,8 +48,8 @@ int crashing_cpu = -1;
 static int time_to_dump;
 
 #define CRASH_HANDLER_MAX 3
-/* NULL terminated list of shutdown handles */
-static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
+/* List of shutdown handles */
+static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX];
 static DEFINE_SPINLOCK(crash_handlers_lock);
 
 static unsigned long crash_shutdown_buf[JMP_BUF_LEN];
@@ -288,9 +288,14 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
 		rc = 1;
 	} else {
 		/* Shift handles down */
-		for (; crash_shutdown_handles[i]; i++)
+		for (; i < (CRASH_HANDLER_MAX - 1); i++)
 			crash_shutdown_handles[i] =
 				crash_shutdown_handles[i+1];
+		/*
+		 * Reset last entry to NULL now that it has been shifted down,
+		 * this will allow new handles to be added here.
+		 */
+		crash_shutdown_handles[i] = NULL;
 		rc = 0;
 	}
 
@@ -346,7 +351,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	old_handler = __debugger_fault_handler;
 	__debugger_fault_handler = handle_fault;
 	crash_shutdown_cpu = smp_processor_id();
-	for (i = 0; crash_shutdown_handles[i]; i++) {
+	for (i = 0; crash_shutdown_handles[i] && i < CRASH_HANDLER_MAX; i++) {
 		if (setjmp(crash_shutdown_buf) == 0) {
 			/*
 			 * Insert syncs and delay to ensure
-- 
2.5.0
