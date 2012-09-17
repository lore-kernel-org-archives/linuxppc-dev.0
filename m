Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 936552C0083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2012 19:54:36 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v5][PATCH 1/3] powerpc/kprobe: introduce a new thread flag
Date: Mon, 17 Sep 2012 17:54:29 +0800
Message-ID: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to add a new thread flag, TIF_EMULATE_STACK_STORE,
for emulating stack store operation while exiting exception.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/thread_info.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index e942203..8ceea14 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -104,6 +104,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
 #define TIF_UPROBE		14	/* breakpointed or single-stepping */
 #define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
+#define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
+						for stack store? */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -121,6 +123,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
 
-- 
1.7.9.5
