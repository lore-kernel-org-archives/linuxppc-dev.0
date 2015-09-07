Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05961A2A91
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 02:16:35 +1000 (AEST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-api@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/9] [picked] powerpc: allocate sys_membarrier system call
 number
Date: Mon,  7 Sep 2015 12:15:48 -0400
Message-Id: <1441642556-30972-2-git-send-email-mathieu.desnoyers@efficios.com>
In-Reply-To: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow it to be used from SPU, since it should not have unwanted
side-effects.

[ Picked-by: Michael Ellerman <mpe@ellerman.id.au> ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-api@vger.kernel.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 4d65499..126d0c4 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -369,3 +369,4 @@ SYSCALL_SPU(bpf)
 COMPAT_SYS(execveat)
 PPC64ONLY(switch_endian)
 SYSCALL_SPU(userfaultfd)
+SYSCALL_SPU(membarrier)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 4a055b6..13411be 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		365
+#define __NR_syscalls		366
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 6ad58d4..6337738 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -387,5 +387,6 @@
 #define __NR_execveat		362
 #define __NR_switch_endian	363
 #define __NR_userfaultfd	364
+#define __NR_membarrier		365
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1
