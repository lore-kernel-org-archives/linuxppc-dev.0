Return-Path: <tglx@linutronix.de>
Received: from tglx.tec.linutronix.de (pD953A911.dip.t-dialin.net
	[217.83.169.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B48BC2BF0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 21:25:26 +1100 (EST)
Date: Thu, 16 Dec 2004 11:25:13 +0100
From: tglx@linutronix.de
Message-ID: <20041216112511.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Make OpenPIC serial clock configurable
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Make OpenPIC serial clock configurable

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/ppc/syslib/open_pic.c |    6 +++++-
 include/asm-ppc/open_pic.h |    3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)
---
Index: 2.6.10-rc3/include/asm-ppc/open_pic.h
===================================================================
--- 2.6.10-rc3/include/asm-ppc/open_pic.h	(revision 11)
+++ 2.6.10-rc3/include/asm-ppc/open_pic.h	(working copy)
@@ -35,6 +35,9 @@
 
 extern u_int OpenPIC_NumInitSenses;
 extern u_char *OpenPIC_InitSenses;
+#ifdef CONFIG_EPIC_SERIAL_MODE
+extern u_int OpenPIC_ClockRatioSerial;
+#endif
 extern void* OpenPIC_Addr;
 extern int epic_serial_mode;
 
Index: 2.6.10-rc3/arch/ppc/syslib/open_pic.c
===================================================================
--- 2.6.10-rc3/arch/ppc/syslib/open_pic.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/syslib/open_pic.c	(working copy)
@@ -42,6 +42,10 @@
  */
 u_int OpenPIC_NumInitSenses __initdata = 0;
 u_char *OpenPIC_InitSenses __initdata = NULL;
+#ifdef CONFIG_EPIC_SERIAL_MODE
+/* Slowest value until we know better */
+u_int OpenPIC_ClockRatioSerial __initdata = 7;
+#endif
 extern int use_of_interrupt_tree;
 
 static u_int NumProcessors;
@@ -418,7 +422,7 @@
 	openpic_disable_8259_pass_through();
 #ifdef CONFIG_EPIC_SERIAL_MODE
 	if (epic_serial_mode) {
-		openpic_eicr_set_clk(7);	/* Slowest value until we know better */
+		openpic_eicr_set_clk(OpenPIC_ClockRatioSerial);
 		openpic_enable_sie();
 	}
 #endif
