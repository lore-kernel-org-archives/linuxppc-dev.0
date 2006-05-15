Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 09B8B679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 02:54:54 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Export PowerPC atomic operations to userspace
Date: Mon, 15 May 2006 11:54:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605151154.52599.bcook@bpointsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The atomic operations in asm/atomic.h are really useful from userspace too. 
Other architectures (i386, x86_64, mips) export these to userspace, but the 
powerpc versions are guarded by __KERNEL__ for some reason. Can we remove 
these if there is no good reason to guard them?

Signed-off-by: Brent Cook <bcook@bpointsys.com>

Index: linux-2.6-bps/include/asm-powerpc/atomic.h
===================================================================
--- linux-2.6-bps/include/asm-powerpc/atomic.h  (revision 77)
+++ linux-2.6-bps/include/asm-powerpc/atomic.h  (working copy)
@@ -7,7 +7,6 @@

 typedef struct { volatile int counter; } atomic_t;

-#ifdef __KERNEL__
 #include <linux/compiler.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
@@ -414,5 +413,4 @@
 #endif /* __powerpc64__ */

 #include <asm-generic/atomic.h>
-#endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ATOMIC_H_ */
