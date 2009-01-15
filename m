Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] powerpc: Remove unused ppc64_terminate_msg()
Date: Thu, 15 Jan 2009 17:43:15 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h |    2 --
 arch/powerpc/kernel/setup_64.c     |    7 -------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2740c44..6c34a0d 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -327,8 +327,6 @@ extern void __devinit smp_generic_take_timebase(void);
  */
 /* Print a boot progress message. */
 void ppc64_boot_msg(unsigned int src, const char *msg);
-/* Print a termination message (print only -- does not stop the kernel) */
-void ppc64_terminate_msg(unsigned int src, const char *msg);
 
 static inline void log_error(char *buf, unsigned int err_type, int fatal)
 {
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2d34196..73e16e2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -578,13 +578,6 @@ void ppc64_boot_msg(unsigned int src, const char *msg)
 	printk("[boot]%04x %s\n", src, msg);
 }
 
-/* Print a termination message (print only -- does not stop the kernel) */
-void ppc64_terminate_msg(unsigned int src, const char *msg)
-{
-	ppc64_do_msg(PPC64_LINUX_FUNCTION|PPC64_TERM_MESSAGE|src, msg);
-	printk("[terminate]%04x %s\n", src, msg);
-}
-
 void cpu_die(void)
 {
 	if (ppc_md.cpu_die)
-- 
1.5.5
