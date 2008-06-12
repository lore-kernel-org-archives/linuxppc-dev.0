Return-Path: <arnd@arndb.de>
Message-Id: <20080612092511.307094929@arndb.de>
References: <20080612091433.851620325@arndb.de>
Date: Thu, 12 Jun 2008 11:14:34 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/3] powerpc: provide dummy crash_shutdown_register
Cc: Michael Neuling <mikey@neuling.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When kexec is disabled, the crash_shutdown_{un,}register
functions are not available in the kernel.
This provides dummy inline functions for those so that
the callers don't have to worry about it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-powerpc/kexec.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/kexec.h b/include/asm-powerpc/kexec.h
index 701857b..acdcdc6 100644
--- a/include/asm-powerpc/kexec.h
+++ b/include/asm-powerpc/kexec.h
@@ -34,6 +34,8 @@
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
 
+typedef void (*crash_shutdown_t)(void);
+
 #ifdef CONFIG_KEXEC
 
 #ifdef __powerpc64__
@@ -123,7 +125,6 @@ struct pt_regs;
 extern void default_machine_kexec(struct kimage *image);
 extern int default_machine_kexec_prepare(struct kimage *image);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
-typedef void (*crash_shutdown_t)(void);
 extern int crash_shutdown_register(crash_shutdown_t handler);
 extern int crash_shutdown_unregister(crash_shutdown_t handler);
 
@@ -143,6 +144,16 @@ static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
 
 static inline void reserve_crashkernel(void) { ; }
 
+static inline int crash_shutdown_register(crash_shutdown_t handler)
+{
+	return 0;
+}
+
+static inline int crash_shutdown_unregister(crash_shutdown_t handler)
+{
+	return 0;
+}
+
 #endif /* CONFIG_KEXEC */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
1.5.4.3

-- 
