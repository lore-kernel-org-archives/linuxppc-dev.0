Message-ID: <3C59FDD1.2F290996@mvista.com>
Date: Thu, 31 Jan 2002 18:30:41 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: trini@mvista.com, linuxppc-dev@lists.linuxppc.org
Cc: frowand@mvista.com
Subject: linuxppc_2_4_devel patch for enable_irq()
Content-Type: multipart/mixed;
 boundary="------------94AFE5FFF82CCB2C18CB5FF0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------94AFE5FFF82CCB2C18CB5FF0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tom,

I'm attaching a patch for a problem with enable_irq().

Comments and feedback from those intimately familiar with the
PPC interrupt handling infrastructure are encouraged...


The problem:

  The irq handling code disables external interrupts, but doesn't
  increment the desc[irq]->depth.

  Code path is:

  do_IRQ()
    ppc_irq_dispatch_handler()
      ack_irq()
        irq_desc[irq].handler->ack(irq)
        which is ppc405_uic_disable_and_ack()

  disable_irq() and enable_irq() do use the depth field to determine when
  to actually re-enable the irq.  If enable_irq() is called from within
  the irq handling path then interrupts for that irq may be enabled even
  though the irq handling path thinks that it has disabled them.

  I encountered the problem while stress testing an ethernet driver
  error path.


"The solution" (what the attached patch does):

  Add a check for (IRQ_DISABLED|IRQ_INPROGRESS) to ppc405_uic_enable(),
  like the check in ppc405_uic_end().


This solution works because the 4xx is not MP capable (at least not yet).
I don't think this solution would work for MP systems (<---- note to the
other PPC processor families, I think the same problem that I fixed for
405 needs to be fixed for all the other processors) because
ppc_irq_dispatch_handler() doesn't set IRQ_INPROGRESS if IRQ_PER_CPU.

If anyone cares about the 403 code, it also needs to be fixed to check
for (IRQ_DISABLED|IRQ_INPROGRESS).  I didn't include that fix in my
previous 405 irq patch because I don't have a 403 to test with (I meant
to mention that when I submitted the previous patch, sorry for forgetting).

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
--------------94AFE5FFF82CCB2C18CB5FF0
Content-Type: text/plain; charset=us-ascii;
 name="patch_ppc4xx_pic"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_ppc4xx_pic"

--- old_linux/arch/ppc/kernel/ppc4xx_pic.c	Thu Jan 31 15:05:03 2002
+++ linux/arch/ppc/kernel/ppc4xx_pic.c	Thu Jan 31 14:58:11 2002
@@ -135,11 +135,14 @@
 {
 	int bit, word;

-	bit = irq & 0x1f;
-	word = irq >> 5;
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {

-	ppc_cached_irq_mask[word] |= 1 << (31 - bit);
-	mtdcr(DCRN_UIC0_ER, ppc_cached_irq_mask[word]);
+		bit = irq & 0x1f;
+		word = irq >> 5;
+
+		ppc_cached_irq_mask[word] |= 1 << (31 - bit);
+		mtdcr(DCRN_UIC0_ER, ppc_cached_irq_mask[word]);
+	}
 }

 static void

--------------94AFE5FFF82CCB2C18CB5FF0--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
