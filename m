Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Wireup the kcmp syscall to sys_ni
Date: Tue,  5 Mar 2013 11:39:54 +1100
Message-Id: <1362443994-26580-1-git-send-email-tony@bakeyournoodle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since kmp takes 2 unsigned long args there should be a compat wrapper.
Since one isn't provided I think it's safer just to hook this up to not
implemented.  If we need it later we can do it properly then.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 535b6d8..289bb52 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -358,3 +358,4 @@ SYSCALL_SPU(setns)
 COMPAT_SYS(process_vm_readv)
 COMPAT_SYS(process_vm_writev)
 SYSCALL(finit_module)
+SYSCALL(ni_syscall)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index f25b5c4..1487f0f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		354
+#define __NR_syscalls		355
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 8c478c6..74cb4d7 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -376,6 +376,7 @@
 #define __NR_process_vm_readv	351
 #define __NR_process_vm_writev	352
 #define __NR_finit_module	353
+#define __NR_kcmp		354
 
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.8.1.4
