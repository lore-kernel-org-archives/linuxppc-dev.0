Message-ID: <3F656CFC.1050706@imc-berlin.de>
Date: Mon, 15 Sep 2003 09:40:44 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems w/  CONFIG_BLK_DEV_MPC8xx_IDE
Content-Type: multipart/mixed;
 boundary="------------040607080006040705040000"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040607080006040705040000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

I just noticed that the vanilla 2.4.22 does not compile with
CONFIG_BLK_DEV_MPC8xx_IDE:

drivers/ide/idedriver.o: In function `ide_timer_expiry':
drivers/ide/idedriver.o(.text+0xaa30): undefined reference to `ide_ack_intr'
drivers/ide/idedriver.o(.text+0xaa30): relocation truncated to fit: R_PPC_REL24

It's the same for the BK trees.

The attached patch fixes that.

Please apply and forward it.

Thanks a million,

Steven

--------------040607080006040705040000
Content-Type: text/plain;
 name="MPC8xx_IDE.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MPC8xx_IDE.fix"

--- include/asm-ppc/ide.h.FIX	Mon Sep 15 09:35:25 2003
+++ include/asm-ppc/ide.h	Mon Sep 15 09:36:17 2003
@@ -110,6 +110,7 @@
  */
 #if (defined CONFIG_APUS || defined CONFIG_BLK_DEV_MPC8xx_IDE)
 #define IDE_ARCH_ACK_INTR 1
+#define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
 #endif

 #endif /* __KERNEL__ */

--------------040607080006040705040000--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
