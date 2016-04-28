Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwRTV5hWPzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:18:06 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p185so8870129pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 23:18:06 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH] powerpc: Add out of bounds check to
 crash_shutdown_unregister()
Date: Thu, 28 Apr 2016 16:17:45 +1000
Message-Id: <1461824265-30592-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When unregistering a crash_shutdown_handle in the function
crash_shutdown_unregister() the other handles are shifted down in the
array to replace the unregistered handle. The for loop assumes that the
last element in the array is null and uses this as the stop condition,
however in the case that the last element is not null there is no check
to ensure that an out of bounds access is not performed.

Add a check to terminate the shift operation when CRASH_HANDLER_MAX is
reached in order to protect against out of bounds accesses.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 2bb252c..6b267af 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -288,7 +288,7 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
 		rc = 1;
 	} else {
 		/* Shift handles down */
-		for (; crash_shutdown_handles[i]; i++)
+		for (; crash_shutdown_handles[i] && i < CRASH_HANDLER_MAX; i++)
 			crash_shutdown_handles[i] =
 				crash_shutdown_handles[i+1];
 		rc = 0;
-- 
2.5.0
