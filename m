From: Allen Curtis <acurtis@onz.com>
Reply-To: acurtis@onz.com
To: dan@embeddededge.com
Subject: 8260/8xx IRQ patch
Date: Tue, 27 Aug 2002 17:11:52 -0700
Cc: linuxppc-embedded@lists.linuxppc.org, paulus@samba.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_SV1JP7B8VQWK7EHKP4PZ"
Message-Id: <200208271711.52796.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--------------Boundary-00=_SV1JP7B8VQWK7EHKP4PZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here is a patch for request_8xxirq()

--
All things come to those who wait. Some of us just have to wait a little
longer...
--------------Boundary-00=_SV1JP7B8VQWK7EHKP4PZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="irq.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1114  -> 1.1114.1.1
#	include/asm-ppc/mpc8xx.h	1.22    -> 1.23
#	arch/ppc/kernel/irq.c	1.53    -> 1.54
#	arch/ppc/kernel/ppc_ksyms.c	1.97    -> 1.98
#	arch/ppc/kernel/m8260_setup.c	1.37    -> 1.38
#	include/asm-ppc/irq.h	1.20    -> 1.21
#	include/asm-ppc/mpc8260.h	1.14    -> 1.15
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1115
# Make update for cross development.
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1116
# Added ability to configure the 8260 clocks used by FCC ethernet.
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1114.1.1
# Removed request_irq() remapping for 8xx and 8260 architectures.
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Tue Aug 27 16:26:08 2002
+++ b/arch/ppc/kernel/irq.c	Tue Aug 27 16:26:08 2002
@@ -177,15 +177,6 @@
 	return 0;
 }

-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
-/* Name change so we can catch standard drivers that potentially mess up
- * the internal interrupt controller on 8xx and 8260.  Just bear with me,
- * I don't like this either and I am searching a better solution.  For
- * now, this is what I need. -- Dan
- */
-#define request_irq	request_8xxirq
-#endif
-
 void free_irq(unsigned int irq, void* dev_id)
 {
 	irq_desc_t *desc;
diff -Nru a/arch/ppc/kernel/m8260_setup.c b/arch/ppc/kernel/m8260_setup.c
--- a/arch/ppc/kernel/m8260_setup.c	Tue Aug 27 16:26:08 2002
+++ b/arch/ppc/kernel/m8260_setup.c	Tue Aug 27 16:26:08 2002
@@ -275,12 +275,3 @@
 	ppc_md.kbd_init_hw		= NULL;
 	ppc_md.ppc_kbd_sysrq_xlate	= NULL;
 }
-
-/* Mainly for ksyms.
-*/
-int
-request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-		       unsigned long flag, const char *naem, void *dev)
-{
-	panic("request IRQ\n");
-}
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Tue Aug 27 16:26:08 2002
+++ b/arch/ppc/kernel/ppc_ksyms.c	Tue Aug 27 16:26:08 2002
@@ -352,9 +352,6 @@
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_8260)
-EXPORT_SYMBOL(request_8xxirq);
-#endif

 EXPORT_SYMBOL(ret_to_user_hook);
 EXPORT_SYMBOL(next_mmu_context);
diff -Nru a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h	Tue Aug 27 16:26:08 2002
+++ b/include/asm-ppc/irq.h	Tue Aug 27 16:26:08 2002
@@ -12,6 +12,9 @@
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
+#if defined(CONFIG_8xx) || defined(CONFIG_8260)
+#  define request_8xxirq	request_irq
+#endif

 #if defined(CONFIG_40x)
 #include <asm/ibm4xx.h>
@@ -169,15 +172,55 @@

 /* There are many more than these, we will add them as we need them.
 */
+#define	SIU_INT_ERROR		((uint)0x00)
+#define	SIU_INT_I2C		((uint)0x01)
+#define	SIU_INT_SPI		((uint)0x02)
+#define	SIU_INT_RISC		((uint)0x03)
 #define	SIU_INT_SMC1		((uint)0x04)
 #define	SIU_INT_SMC2		((uint)0x05)
+#define	SIU_INT_IDMA1		((uint)0x06)
+#define	SIU_INT_IDMA2		((uint)0x07)
+#define	SIU_INT_IDMA3		((uint)0x08)
+#define	SIU_INT_IDMA4		((uint)0x09)
+#define	SIU_INT_SDMA		((uint)0x0a)
+#define	SIU_INT_TIMER1		((uint)0x0c)
+#define	SIU_INT_TIMER2		((uint)0x0d)
+#define	SIU_INT_TIMER3		((uint)0x0e)
+#define	SIU_INT_TIMER4		((uint)0x0f)
+#define	SIU_INT_TMCNT		((uint)0x10)
+#define	SIU_INT_PIT		((uint)0x11)
+#define	SIU_INT_IRQ1		((uint)0x13)
+#define	SIU_INT_IRQ2		((uint)0x14)
+#define	SIU_INT_IRQ3		((uint)0x15)
+#define	SIU_INT_IRQ4		((uint)0x16)
+#define	SIU_INT_IRQ5		((uint)0x17)
+#define	SIU_INT_IRQ6		((uint)0x18)
+#define	SIU_INT_IRQ7		((uint)0x19)
 #define	SIU_INT_FCC1		((uint)0x20)
 #define	SIU_INT_FCC2		((uint)0x21)
 #define	SIU_INT_FCC3		((uint)0x22)
+#define	SIU_INT_MCC1		((uint)0x24)
+#define	SIU_INT_MCC2		((uint)0x25)
 #define	SIU_INT_SCC1		((uint)0x28)
 #define	SIU_INT_SCC2		((uint)0x29)
 #define	SIU_INT_SCC3		((uint)0x2a)
 #define	SIU_INT_SCC4		((uint)0x2b)
+#define	SIU_INT_PC15		((uint)0x30)
+#define	SIU_INT_PC14		((uint)0x31)
+#define	SIU_INT_PC13		((uint)0x32)
+#define	SIU_INT_PC12		((uint)0x33)
+#define	SIU_INT_PC11		((uint)0x34)
+#define	SIU_INT_PC10		((uint)0x35)
+#define	SIU_INT_PC9		((uint)0x36)
+#define	SIU_INT_PC8		((uint)0x37)
+#define	SIU_INT_PC7		((uint)0x38)
+#define	SIU_INT_PC6		((uint)0x39)
+#define	SIU_INT_PC5		((uint)0x3a)
+#define	SIU_INT_PC4		((uint)0x3b)
+#define	SIU_INT_PC3		((uint)0x3c)
+#define	SIU_INT_PC2		((uint)0x3d)
+#define	SIU_INT_PC1		((uint)0x3e)
+#define	SIU_INT_PC0		((uint)0x3f)

 #endif /* CONFIG_8260 */

diff -Nru a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h	Tue Aug 27 16:26:08 2002
+++ b/include/asm-ppc/mpc8260.h	Tue Aug 27 16:26:08 2002
@@ -52,12 +52,6 @@
 */
 #include <asm/ptrace.h>

-extern int request_8xxirq(unsigned int irq,
-		       void (*handler)(int, void *, struct pt_regs *),
-		       unsigned long flags,
-		       const char *device,
-		       void *dev_id);
-
 #endif /* CONFIG_8260 */
 #endif /* !__CONFIG_8260_DEFS */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h	Tue Aug 27 16:26:08 2002
+++ b/include/asm-ppc/mpc8xx.h	Tue Aug 27 16:26:08 2002
@@ -99,12 +99,6 @@
  */
 extern unsigned char __res[];

-struct pt_regs;
-extern int request_8xxirq(unsigned int irq,
-		       void (*handler)(int, void *, struct pt_regs *),
-		       unsigned long flags,
-		       const char *device,
-		       void *dev_id);
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */

--------------Boundary-00=_SV1JP7B8VQWK7EHKP4PZ--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
