Return-Path: <jdl@jdl.com>
From: jdl@freescale.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Wed, 07 Sep 2005 15:56:20 -0500
Message-Id: <E1ED6xw-00080Q-NA@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH ppc: Make check_bugs() static inline
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make check_bugs() static inline and remove it from syscalls.c.

 arch/ppc/kernel/syscalls.c   |    4 ----
 arch/ppc64/kernel/syscalls.c |    4 ----
 include/asm-powerpc/bugs.h   |    2 +-
 3 files changed, 1 insertions(+), 9 deletions(-)

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


 diff --git a/arch/ppc/kernel/syscalls.c b/arch/ppc/kernel/syscalls.c
--- a/arch/ppc/kernel/syscalls.c
+++ b/arch/ppc/kernel/syscalls.c
@@ -41,10 +41,6 @@
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
 
-void
-check_bugs(void)
-{
-}
 
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
diff --git a/arch/ppc64/kernel/syscalls.c b/arch/ppc64/kernel/syscalls.c
--- a/arch/ppc64/kernel/syscalls.c
+++ b/arch/ppc64/kernel/syscalls.c
@@ -46,10 +46,6 @@
 
 extern unsigned long wall_jiffies;
 
-void
-check_bugs(void)
-{
-}
 
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
diff --git a/include/asm-powerpc/bugs.h b/include/asm-powerpc/bugs.h
--- a/include/asm-powerpc/bugs.h
+++ b/include/asm-powerpc/bugs.h
@@ -13,6 +13,6 @@
  * architecture-dependent bugs.
  */
 
-extern void check_bugs(void);
+static inline void check_bugs(void) { }
 
 #endif	/* _ASM_POWERPC_BUGS_H */
