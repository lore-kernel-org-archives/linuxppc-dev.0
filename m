Message-ID: <3961CEE4.1FC16625@lightning.ch>
Date: Tue, 04 Jul 2000 13:47:48 +0200
From: Giovanna Ambrosini <ambrosini@lightning.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, cort@fsmlabs.com, paulus@linuxcare.com,
        dmalek@jlc.net
Subject: patch: Checkstop reset for MPPC8xx platforms
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


diff -urN linux-2.4.0-test2/arch/ppc/kernel/head_8xx.S linux-2.4.0-test2-ga/arch/ppc/kernel/head_8xx.S
--- linux-2.4.0-test2/arch/ppc/kernel/head_8xx.S Tue Jun 20 02:59:36 2000
+++ linux-2.4.0-test2-ga/arch/ppc/kernel/head_8xx.S Tue Jul  4 13:29:54 2000
@@ -947,26 +947,6 @@
  SYNC
  blr

-/* Jump into the system reset for the rom.
- * We first disable the MMU, and then jump to the ROM reset address.
- *
- * r3 is the board info structure, r4 is the location for starting.
- * I use this for building a small kernel that can load other kernels,
- * rather than trying to write or rely on a rom monitor that can tftp load.
- */
-       .globl  m8xx_gorom
-m8xx_gorom:
-       li      r5,MSR_KERNEL & ~(MSR_IR|MSR_DR)
-       lis     r6,2f@h
-       addis   r6,r6,-KERNELBASE@h
-       ori     r6,r6,2f@l
-       mtspr   SRR0,r6
-       mtspr   SRR1,r5
-       rfi
-2:
-       mtlr    r4
-       blr
-
 /*
  * We put a few things here that have to be page-aligned.
  * This stuff goes at the beginning of the data segment,
diff -urN linux-2.4.0-test2/arch/ppc/kernel/m8xx_setup.c linux-2.4.0-test2-ga/arch/ppc/kernel/m8xx_setup.c
--- linux-2.4.0-test2/arch/ppc/kernel/m8xx_setup.c Tue May  2 22:05:39 2000
+++ linux-2.4.0-test2-ga/arch/ppc/kernel/m8xx_setup.c Tue Jul  4 13:29:23 2000
@@ -14,6 +14,11 @@
  * bootup setup stuff..
  */

+/*
+ * ambrosini@lightning.ch
+ * Modified to reboot on machine checkstop.
+ */
+
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -230,9 +235,20 @@
 void
 m8xx_restart(char *cmd)
 {
- extern void m8xx_gorom(void);
+ int msr;
+ /* Make sure PLPRCR[CSR] is set to reboot on checkstop state
+  */
+ ((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x80;

- m8xx_gorom();
+ /* Clear the ME bit in MSR to cause checkstop on machine check
+  */
+ __asm__("mfmsr %0" : "=r" (msr) );
+ msr &= ~0x1000;
+ __asm__("mtmsr %0" : : "r" (msr) );
+
+ /* Cause a Machine Check (by accessing reserved space)
+  */
+ for (;;) ((volatile immap_t *)IMAP_ADDR)->im_clkrst.res[0] = 0;
 }

 void


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
