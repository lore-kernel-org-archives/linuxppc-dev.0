Subject: ppc_irq_dispatch_handler and unhandled interrupts
From: Hollis Blanchard <hollis@austin.ibm.com>
To: devel list <linuxppc-dev@lists.linuxppc.org>
Date: 21 Nov 2002 10:58:55 -0600
Message-Id: <1037897936.10521.89.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TBSwqz8ZMqhAJXfL84YF"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-TBSwqz8ZMqhAJXfL84YF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here's the failure mode:
On a 405LP (using ppc405_pic), an irq is becoming unmasked[1] (in
UIC0_ER). ppc_irq_dispatch_handler sees irq_desc[0].action =3D=3D NULL, and
correctly complains of an unhandled interrupt and masks it off. However
at the end of the same function (label "out"), the irq is unmasked again
because irq_desc[0].handler =3D=3D ppc405_pic (irq_desc[0..NR_IRQS] =3D
ppc405_pic; see ppc4xx_init_IRQ() ). So the irq is unmasked, occurs
again, is masked, is unmasked, occurs again...

The attached patch fixes the problem by checking desc->action as well as
desc->handler - there is no sense unmasking an interrupt if we already
know there are no drivers ready to handle it.

[1] In my particular case, UIC0_ER is being modified by BIOS when waking
from sleep (the BIOS later returns control to Linux), which could be
worked around in wakeup code. However in the interest of handling as
many unexpected hardware and software errors as possible, I believe this
patch should be applied.

-Hollis
--=20
PowerPC Linux
IBM Linux Technology Center

--=-TBSwqz8ZMqhAJXfL84YF
Content-Disposition: attachment; filename=unhandled-irq.diff
Content-Type: text/plain; name=unhandled-irq.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- arch/ppc/kernel/irq.c	2001/12/18 00:18:00	1.1.1.2
+++ arch/ppc/kernel/irq.c	2002/11/21 16:13:22
@@ -513,7 +513,7 @@
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
 	 */
-	if (irq_desc[irq].handler) {
+	if (desc->handler && desc->action) {
 		if (irq_desc[irq].handler->end)
 			irq_desc[irq].handler->end(irq);
 		else if (irq_desc[irq].handler->enable)

--=-TBSwqz8ZMqhAJXfL84YF--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
