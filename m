Date: Sun, 4 Jun 2000 13:03:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh in 2.4.0-test1
In-Reply-To: <Pine.LNX.4.05.10005312242300.2148-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10006041259560.514-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 May 2000, Geert Uytterhoeven wrote:
> Is there anyone who is succesfully using SCSI devices connected to MESH SCSI
> with 2.4.0-test1 (or late 2.3.99-preX, e.g. pre9)?

After 3 days of hacking, I found it. The new Core99 interrupt tree code doesn't
take into account that on CHRP boxes with both ISA and OpenPIC, the interrupt
numbers have to be fixed up. Below is the patch that made it work for me.

Before I check it in into bitkeeper: should I replace the test

    _machine == _MACH_chrp

by

    !strncmp(model, "IBM,LongTrail", 13)

or are there other CHRP models bitten by this as well?

===== arch/ppc/kernel/prom.c 1.18 vs edited =====
--- 1.18/arch/ppc/kernel/prom.c	Fri May  5 00:15:36 2000
+++ edited/arch/ppc/kernel/prom.c	Sun Jun  4 12:59:07 2000
@@ -1125,17 +1125,36 @@
 	     */
 	    if (get_property(node, "interrupt-controller", &l)) {
 	    	int i,j;
 	    	np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = ipsize / isize;
 		mem_start += np->n_intrs * sizeof(struct interrupt_info);
 		for (i = 0; i < np->n_intrs; ++i) {
 		    np->intrs[i].line = *interrupts++;
 		    np->intrs[i].sense = 0;
 		    if (isize > 1)
 		        np->intrs[i].sense = *interrupts++;
 		    for (j=2; j<isize; j++)
 		    	interrupts++;
 		}
+		/*
+		 *  On the CHRP LongTrail, ISA interrupts are cascaded through
+		 *  the OpenPIC. For compatibility reasons, ISA interrupts are
+		 *  numbered 0-15 and OpenPIC interrupts start at 16.
+		 *  Hence we have to fixup the interrupt numbers for sources
+		 *  that are attached to the OpenPIC and thus have an
+		 *  interrupt-controller named `open-pic'.
+		 *
+		 *  FIXME: The name of the interrupt-controller node for the
+		 *         `ide' node has no name, although its parent is
+		 *         correctly specified in interrupt-map, so we check
+		 *         for a NULL name as well.
+		 */
+		if (_machine == _MACH_chrp &&
+		    ((node->name && !strcmp(node->name, "open-pic")) ||
+		     !node->name)) {
+		    for (i = 0; i < np->n_intrs; ++i)
+			np->intrs[i].line = openpic_to_irq(np->intrs[i].line);
+		}
 		return mem_start;
 	    }
 	    /* We lookup for an interrupt-map. This code can only handle one interrupt

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
