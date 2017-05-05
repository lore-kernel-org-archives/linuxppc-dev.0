Return-Path: <srs0=3xnc=4l=buserror.net=oss@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK38m6qgwzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 17:16:08 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wK38m6F4fz8tc2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 17:16:08 +1000 (AEST)
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wK38m3p2Dz9s9c
 for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2017 17:16:08 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 01:31:45 -0500
Message-Id: <20170505063145.21631-1-oss@buserror.net>
Subject: [PATCH] powerpc/64e: Don't place the stack beyond TASK_SIZE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit f4ea6dcb08ea ("powerpc/mm: Enable mappings above 128TB") increased
the task size on book3s, and introduced a mechanism to dynamically
control whether a task uses these larger addresses.  While the change to
the task size itself was ifdef-protected to only apply on book3s, the
change to STACK_TOP_USER64 was not.  On book3e, this had the effect of
trying to use addresses up to 128TiB for the stack despite a 64TiB task
size limit -- which broke 64-bit userspace producing the following errors:

Starting init: /sbin/init exists but couldn't execute it (error -14)
Starting init: /bin/sh exists but couldn't execute it (error -14)
Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.

Fixes: f4ea6dcb08ea ("powerpc/mm: Enable mappings above 128TB")
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/include/asm/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index a4b1d8d6b793..a2123f291ab0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -151,8 +151,13 @@ void release_thread(struct task_struct *);
 
 #ifdef __powerpc64__
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /* Limit stack to 128TB */
 #define STACK_TOP_USER64 TASK_SIZE_128TB
+#else
+#define STACK_TOP_USER64 TASK_SIZE_USER64
+#endif
+
 #define STACK_TOP_USER32 TASK_SIZE_USER32
 
 #define STACK_TOP (is_32bit_task() ? \
-- 
2.11.0
