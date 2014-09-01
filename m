Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com
 [IPv6:2607:f8b0:4002:c07::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BF351A0027
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 04:23:17 +1000 (EST)
Received: by mail-yk0-f171.google.com with SMTP id 9so3459529ykp.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Sep 2014 11:23:13 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fabian Frederick <fabf@skynet.be>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Wire up three sys calls
Date: Mon,  1 Sep 2014 14:23:07 -0400
Message-Id: <1409595790-17437-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch wires up three new syscalls for powerpc. The three
new syscalls are seccomp, getrandom and memfd_create.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
---
 arch/powerpc/include/asm/systbl.h      | 3 +++
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 542bc0f..7d8a600 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -362,3 +362,6 @@ SYSCALL(ni_syscall) /* sys_kcmp */
 SYSCALL_SPU(sched_setattr)
 SYSCALL_SPU(sched_getattr)
 SYSCALL_SPU(renameat2)
+SYSCALL_SPU(seccomp)
+SYSCALL_SPU(getrandom)
+SYSCALL_SPU(memfd_create)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 5ce5552..4e9af3f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		358
+#define __NR_syscalls		361
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 2d526f7..0688fc0 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -380,5 +380,8 @@
 #define __NR_sched_setattr	355
 #define __NR_sched_getattr	356
 #define __NR_renameat2		357
+#define __NR_seccomp		358
+#define __NR_getrandom		359
+#define __NR_memfd_create	360
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.1.0
