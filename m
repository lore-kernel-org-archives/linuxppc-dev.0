Return-Path: <roland@redhat.com>
Received: from QMTA05.emeryville.ca.mail.comcast.net
	(qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
	by ozlabs.org (Postfix) with ESMTP id EABBFDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:08:27 +1100 (EST)
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc32: asm-offsets ptrace cruft
Message-Id: <20080319210751.C95B126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:07:51 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These items in asm-offsets.c are not used anywhere.  Remove them.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/asm-offsets.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4b749c4..e932b43 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -26,8 +26,6 @@
 #ifdef CONFIG_PPC64
 #include <linux/time.h>
 #include <linux/hardirq.h>
-#else
-#include <linux/ptrace.h>
 #endif
 
 #include <asm/io.h>
@@ -60,7 +58,6 @@ int main(void)
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
-	DEFINE(PTRACE, offsetof(struct task_struct, ptrace));
 #endif /* CONFIG_PPC64 */
 
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
@@ -80,7 +77,6 @@ int main(void)
 	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
-	DEFINE(PT_PTRACED, PT_PTRACED);
 #endif
 #ifdef CONFIG_SPE
 	DEFINE(THREAD_EVR0, offsetof(struct thread_struct, evr[0]));
