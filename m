Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 87089679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 07:09:01 +1000 (EST)
Message-ID: <42963C54.2090300@mvista.com>
Date: Thu, 26 May 2005 14:15:00 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="------------090006070708060208070602"
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Add Soft-Reset to MPC834x.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090006070708060208070602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
   The attached patch adds soft reset to the MPC834x platform. With this 
patch the "reboot" command will cause a shutdown and restart sequence.


		Randy Vinson

--------------090006070708060208070602
Content-Type: text/plain;
 name="reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reset.patch"

Add soft reset to MPC834x

This change allows mpc83xx_restart to issue a software reset.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

---
commit 6d63102a8653755f40a5714020f375e297c0bfae
tree 8471abaacd09aaa62ea479c926f13cbbf8906e49
parent 269bcdbf0a9f000400052b2da38348733dbfe88f
author Randy Vinson <rvinson@linuxbox.(none)> Wed, 25 May 2005 17:37:16 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Wed, 25 May 2005 17:37:16 -0700

 arch/ppc/platforms/83xx/mpc834x_sys.h |    6 ++++++
 arch/ppc/syslib/ppc83xx_setup.c       |   28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- d10f5c31c29228a00a1a7551e3e825b439bfc741/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ 8471abaacd09aaa62ea479c926f13cbbf8906e49/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -28,6 +28,12 @@
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
+#define BCSR_MISC_REG2_OFF	0x07
+#define BCSR_MISC_REG2_PORESET	0x01
+
+#define BCSR_MISC_REG3_OFF	0x08
+#define BCSR_MISC_REG3_CNFLOCK	0x80
+
 #ifdef CONFIG_PCI
 /* PCI interrupt controller */
 #define PIRQA        MPC83xx_IRQ_IRQ4
Index: arch/ppc/syslib/ppc83xx_setup.c
===================================================================
--- d10f5c31c29228a00a1a7551e3e825b439bfc741/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
+++ 8471abaacd09aaa62ea479c926f13cbbf8906e49/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
@@ -29,6 +29,7 @@
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
+#include <asm/delay.h>
 
 #include <syslib/ppc83xx_setup.h>
 
@@ -117,7 +118,34 @@
 void
 mpc83xx_restart(char *cmd)
 {
+	volatile unsigned char __iomem *reg;
+	unsigned char tmp;
+
+	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+
 	local_irq_disable();
+
+	/*
+	 * Unlock the BCSR bits so a PRST will update the contents.
+	 * Otherwise the reset asserts but doesn't clear.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG3_OFF);
+	tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
+	out_8(reg + BCSR_MISC_REG3_OFF, tmp);
+
+	/*
+	 * Trigger a reset via a low->high transition of the
+	 * PORESET bit.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG2_OFF);
+	tmp &= ~BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
+	udelay(1);
+
+	tmp |= BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
 	for(;;);
 }
 

--------------090006070708060208070602--
