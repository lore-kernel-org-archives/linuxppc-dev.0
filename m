Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 0E5A167B7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 02:47:56 +1000 (EST)
Message-ID: <42C2D2E1.8060004@ru.mvista.com>
Date: Wed, 29 Jun 2005 20:57:05 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------070804030909050308010308"
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: minor arch/ppc/syslib/xilinx_pic.c cleanups
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
--------------070804030909050308010308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

For level sensitive interrupts the patch moves unmasking the interrupt behind
acknowledging it. It seems not to change anything in practice (experimented with
the ethernet a little bit), but looks more logical IMHO.

The second hunk removes two lines that do nothing.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>


--------------070804030909050308010308
Content-Type: text/plain;
 name="xilinx_pic_cleanup.20050629.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xilinx_pic_cleanup.20050629.diff"

diff -Nupr a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
--- a/arch/ppc/syslib/xilinx_pic.c	2005-06-23 15:32:18.000000000 +0400
+++ b/arch/ppc/syslib/xilinx_pic.c	2005-06-29 18:28:44.000000000 +0400
@@ -71,10 +71,11 @@ xilinx_intc_end(unsigned int irq)
 
 	pr_debug("end: %d\n", irq);
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		intc_out_be32(intc + SIE, mask);
 		/* ack level sensitive intr */
 		if (irq_desc[irq].status & IRQ_LEVEL)
 			intc_out_be32(intc + IAR, mask);
+		/* unmask the interrupt */
+		intc_out_be32(intc + SIE, mask);
 	}
 }
 
@@ -101,8 +102,6 @@ xilinx_pic_get_irq(struct pt_regs *regs)
 	 */
 
 	irq = intc_in_be32(intc + IVR);
-	if (irq != -1)
-		irq = irq;
 
 	pr_debug("get_irq: %d\n", irq);
 

--------------070804030909050308010308--
