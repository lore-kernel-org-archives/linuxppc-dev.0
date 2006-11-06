Return-Path: <nd@bplan-gmbh.de>
Date: Mon, 6 Nov 2006 12:03:10 +0100 (MET)
Message-Id: <200611061103.kA6B3ADJ023943@post.webmailer.de>
To: linuxppc-dev@ozlabs.org
From: "Nicolas DET"<nd@bplan-gmbh.de>
Subject: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="b_01_9f75f5759d3e0c1e1a66f10cd8bb73c4"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--b_01_9f75f5759d3e0c1e1a66f10cd8bb73c4
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//DE"><HTML><HEAD><=
META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">=
<TITLE>Message</TITLE></HEAD><BODY>
          <pre>This patch add MPC52xx Interrupt controller for ARCH=3Dpower=
pc.<br><br>It includes the main code in arch/powerpc/sysdev/ ad well as an =
header file in<br>include/asm-powerpc.<br><br>Signed-off-by: Nicolas DET &l=
t;nd@bplan-gmbh.de&gt;<br>---<br>--- a/arch/powerpc/sysdev/mpc52xx_pic.c=09=
1970-01-01 01:00:00.000000000 +0100<br>+++ b/arch/powerpc/sysdev/mpc52xx_pi=
c.c=092006-11-06 11:10:29.000000000 +0100<br>@@ -0,0 +1,527 @@<br>+/*<br>+ =
*<br>+ * Programmable Interrupt Controller functions for the Freescale MPC5=
2xx.<br>+ *<br>+ * Copyright (C) 2006 bplan GmbH<br>+ *<br>+ * Based on (we=
ll, mostly copied from) the code from the 2.4 kernel by<br>+ * Dale Farnswo=
rth &lt;dfarnsworth@mvista.com&gt; and Kent Borg.<br>+ * <br>+ * Copyright =
(C) 2004 Sylvain Munaut &lt;tnt@246tNt.com&gt;<br>+ * Copyright (C) 2003 Mo=
ntavista Software, Inc<br>+ *<br>+ * This file is licensed under the terms =
of the GNU General Public License<br>+ * version 2. This program is license=
d "as is" without any warranty of any<br>+ * kind, whether express or impli=
ed.<br>+ *<br>+ */<br>+<br>+#undef DEBUG<br>+<br>+#include &lt;linux/stddef=
.h&gt;<br>+#include &lt;linux/init.h&gt;<br>+#include &lt;linux/sched.h&gt;=
<br>+#include &lt;linux/signal.h&gt;<br>+#include &lt;linux/stddef.h&gt;<br=
>+#include &lt;linux/delay.h&gt;<br>+#include &lt;linux/irq.h&gt;<br>+#incl=
ude &lt;linux/hardirq.h&gt;<br>+<br>+#include &lt;asm/io.h&gt;<br>+#include=
 &lt;asm/processor.h&gt;<br>+#include &lt;asm/system.h&gt;<br>+#include &lt=
;asm/irq.h&gt;<br>+#include &lt;asm/prom.h&gt;<br>+#include &lt;asm/mpc52xx=
.h&gt;<br>+<br>+/*<br>+ *<br>+*/<br>+<br>+static struct mpc52xx_intr __iome=
m *intr;<br>+static struct mpc52xx_sdma __iomem *sdma;<br>+static struct ir=
q_host *mpc52xx_irqhost =3D NULL;<br>+<br>+static unsigned char mpc52xx_map=
_senses[4] =3D {<br>+=09IRQ_TYPE_LEVEL_HIGH,<br>+=09IRQ_TYPE_EDGE_RISING,<b=
r>+=09IRQ_TYPE_EDGE_FALLING,<br>+=09IRQ_TYPE_LEVEL_LOW,<br>+};<br>+<br>+/*<=
br>+ *<br>+*/<br>+<br>+static inline void io_be_setbit(u32 __iomem *addr, i=
nt bitno)<br>+{<br>+=09out_be32(addr, in_be32(addr) | (1 &lt;&lt; bitno) );=
<br>+}<br>+<br>+static inline void io_be_clrbit(u32 __iomem *addr, int bitn=
o)<br>+{<br>+=09out_be32(addr, in_be32(addr) &amp; ~(1 &lt;&lt; bitno));<br=
>+}<br>+<br>+/*<br>+ * IRQ[0-3] interrupt irq_chip<br>+*/<br>+<br>+static v=
oid mpc52xx_extirq_mask(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09int=
 l2irq;<br>+<br>+=09irq =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp=
; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug=
("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);<br>+<br>+=09io_be_clrbit(=
&amp;intr-&gt;ctrl, 11 - l2irq);<br>+}<br>+<br>+static void mpc52xx_extirq_=
unmask(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09int l2irq;<br>+<br>+=
=09irq =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_=
MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug("%s: irq=3D%x. l=
2=3D%dn", __func__, irq, l2irq);<br>+<br>+=09io_be_setbit(&amp;intr-&gt;ctr=
l, 11 - l2irq);<br>+}<br>+<br>+static void mpc52xx_extirq_ack(unsigned int =
virq)<br>+{<br>+=09int irq;<br>+=09int l2irq;<br>+<br>+=09irq =3D irq_map[v=
irq].hwirq;<br>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52=
xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, =
irq, l2irq);<br>+<br>+=09io_be_setbit(&amp;intr-&gt;ctrl, 27-l2irq);<br>+}<=
br>+<br>+static struct irq_chip mpc52xx_extirq_irqchip =3D {<br>+=09.typena=
me =3D " MPC52xx IRQ[0-3] ",<br>+=09.mask =3D mpc52xx_extirq_mask,<br>+=09.=
unmask =3D mpc52xx_extirq_unmask,<br>+=09.ack =3D mpc52xx_extirq_ack,<br>+}=
;<br>+<br>+/*<br>+ * Main interrupt irq_chip<br>+*/<br>+<br>+static void mp=
c52xx_main_mask(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09int l2irq;<=
br>+<br>+=09irq =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp; MPC52x=
x_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug("%s: ir=
q=3D%x. l2=3D%dn", __func__, irq, l2irq);<br>+<br>+=09io_be_setbit(&amp;int=
r-&gt;main_mask, 15 - l2irq);<br>+}<br>+<br>+static void mpc52xx_main_unmas=
k(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09int l2irq;<br>+<br>+=09ir=
q =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_MASK)=
 &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug("%s: irq=3D%x. l2=3D%=
dn", __func__, irq, l2irq);<br>+<br>+=09io_be_clrbit(&amp;intr-&gt;main_mas=
k, 15 - l2irq);<br>+}<br>+<br>+static struct irq_chip mpc52xx_main_irqchip =
=3D {<br>+=09.typename =3D "MPC52xx Main",<br>+=09.mask =3D mpc52xx_main_ma=
sk,<br>+=09.mask_ack =3D mpc52xx_main_mask,<br>+=09.unmask =3D mpc52xx_main=
_unmask,<br>+};<br>+<br>+/*<br>+ * Peripherals interrupt irq_chip<br>+*/<br=
>+<br>+static void mpc52xx_periph_mask(unsigned int virq)<br>+{<br>+=09int =
irq;<br>+=09int l2irq;<br>+<br>+=09irq =3D irq_map[virq].hwirq;<br>+=09l2ir=
q =3D (irq &amp; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<=
br>+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);<br>+<br>+=
=09io_be_setbit(&amp;intr-&gt;per_mask, 31 - l2irq);<br>+}<br>+<br>+static =
void mpc52xx_periph_unmask(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09=
int l2irq;<br>+<br>+=09irq =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &=
amp; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_de=
bug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);<br>+<br>+=09io_be_clrb=
it(&amp;intr-&gt;per_mask, 31 - l2irq);<br>+}<br>+<br>+static struct irq_ch=
ip mpc52xx_periph_irqchip =3D {<br>+=09.typename =3D "MPC52xx Peripherals",=
<br>+=09.mask =3D mpc52xx_periph_mask,<br>+=09.mask_ack =3D mpc52xx_periph_=
mask,<br>+=09.unmask =3D mpc52xx_periph_unmask,<br>+};<br>+<br>+/*<br>+ * S=
DMA interrupt irq_chip<br>+*/<br>+<br>+static void mpc52xx_sdma_mask(unsign=
ed int virq)<br>+{<br>+=09int irq;<br>+=09int l2irq;<br>+<br>+=09irq =3D ir=
q_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_MASK) &gt;&gt=
; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __f=
unc__, irq, l2irq);<br>+<br>+=09io_be_setbit(&amp;sdma-&gt;IntMask, l2irq);=
<br>+}<br>+<br>+static void mpc52xx_sdma_unmask(unsigned int virq)<br>+{<br=
>+=09int irq;<br>+=09int l2irq;<br>+<br>+=09irq =3D irq_map[virq].hwirq;<br=
>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFS=
ET;<br>+<br>+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);<b=
r>+<br>+=09io_be_clrbit(&amp;sdma-&gt;IntMask, l2irq);<br>+}<br>+<br>+stati=
c void mpc52xx_sdma_ack(unsigned int virq)<br>+{<br>+=09int irq;<br>+=09int=
 l2irq;<br>+<br>+=09irq =3D irq_map[virq].hwirq;<br>+=09l2irq =3D (irq &amp=
; MPC52xx_IRQ_L2_MASK) &gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09pr_debug=
("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);<br>+<br>+=09out_be32(&amp=
;sdma-&gt;IntPend, 1 &lt;&lt; l2irq);<br>+}<br>+<br>+static struct irq_chip=
 mpc52xx_sdma_irqchip =3D {<br>+=09.typename =3D "MPC52xx SDMA",<br>+=09.ma=
sk =3D mpc52xx_sdma_mask,<br>+=09.unmask =3D mpc52xx_sdma_unmask,<br>+=09.a=
ck =3D mpc52xx_sdma_ack,<br>+};<br>+<br>+/*<br>+ * irq_host<br>+*/<br>+<br>=
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *n=
ode)<br>+{<br>+=09pr_debug("%s: node=3D%pn", __func__, node);<br>+=09return=
 mpc52xx_irqhost-&gt;host_data =3D=3D node;<br>+}<br>+<br>+static int mpc52=
xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,<br>+=09=09=09=
=09 u32 * intspec, unsigned int intsize,<br>+=09=09=09=09 irq_hw_number_t *=
 out_hwirq,<br>+=09=09=09=09 unsigned int *out_flags)<br>+{<br>+=09int intr=
vect_l1;<br>+=09int intrvect_l2;<br>+=09int intrvect_type;<br>+=09int intrv=
ect_linux;<br>+<br>+=09if (intsize !=3D 3)<br>+=09=09return -1;<br>+<br>+=
=09intrvect_l1 =3D (int)intspec[0];<br>+=09intrvect_l2 =3D (int)intspec[1];=
<br>+=09intrvect_type =3D (int)intspec[2];<br>+<br>+=09intrvect_linux =3D<b=
r>+=09    (intrvect_l1 &lt;&lt; MPC52xx_IRQ_L1_OFFSET) &amp; MPC52xx_IRQ_L1=
_MASK;<br>+=09intrvect_linux |=3D<br>+=09    (intrvect_l2 &lt;&lt; MPC52xx_=
IRQ_L2_OFFSET) &amp; MPC52xx_IRQ_L2_MASK;<br>+<br>+=09pr_debug("return %x, =
l1=3D%d, l2=3D%dn", intrvect_linux, intrvect_l1,<br>+=09=09 intrvect_l2);<b=
r>+<br>+=09*out_hwirq =3D intrvect_linux;<br>+=09*out_flags =3D mpc52xx_map=
_senses[intrvect_type];<br>+<br>+=09return 0;<br>+}<br>+<br>+/*<br>+ * this=
 function retrieves the correct IRQ type out<br>+ * of the MPC regs<br>+ * =
Only externals IRQs needs this<br>+*/<br>+static int mpc52xx_irqx_gettype(i=
nt irq)<br>+{<br>+=09int type;<br>+=09u32 ctrl_reg;<br>+<br>+=09ctrl_reg =
=3D in_be32(&amp;intr-&gt;ctrl);<br>+=09type =3D (ctrl_reg &gt;&gt; (22 - i=
rq * 2)) &amp; 0x3;<br>+<br>+=09return mpc52xx_map_senses[type];<br>+}<br>+=
<br>+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,<=
br>+=09=09=09       irq_hw_number_t irq)<br>+{<br>+=09int l1irq;<br>+=09int=
 l2irq;<br>+=09struct irq_chip *good_irqchip;<br>+=09void *good_handle;<br>=
+=09int type;<br>+<br>+=09l1irq =3D (irq &amp; MPC52xx_IRQ_L1_MASK) &gt;&gt=
; MPC52xx_IRQ_L1_OFFSET;<br>+=09l2irq =3D (irq &amp; MPC52xx_IRQ_L2_MASK) &=
gt;&gt; MPC52xx_IRQ_L2_OFFSET;<br>+<br>+=09/*<br>+=09 * Most of ours IRQs w=
ill be level low<br>+=09 * Only external IRQs on some platform may be other=
s<br>+=09 */<br>+=09type =3D IRQ_TYPE_LEVEL_LOW;<br>+<br>+=09switch (l1irq)=
 {<br>+=09case MPC52xx_IRQ_L1_CRIT:<br>+=09=09pr_debug("%s: Critical. l2=3D=
%xn", __func__, l2irq);<br>+<br>+=09=09BUG_ON(l2irq !=3D 0);<br>+<br>+=09=
=09type =3D mpc52xx_irqx_gettype(l2irq);<br>+=09=09good_irqchip =3D &amp;mp=
c52xx_extirq_irqchip;<br>+=09=09break;<br>+<br>+=09case MPC52xx_IRQ_L1_MAIN=
:<br>+=09=09pr_debug("%s: Main IRQ[1-3] l2=3D%xn", __func__, l2irq);<br>+<b=
r>+=09=09if ((l2irq &gt;=3D 1) &amp;&amp; (l2irq &lt;=3D 3)) {<br>+=09=09=
=09type =3D mpc52xx_irqx_gettype(l2irq);<br>+=09=09=09good_irqchip =3D &amp=
;mpc52xx_extirq_irqchip;<br>+=09=09} else {<br>+=09=09=09good_irqchip =3D &=
amp;mpc52xx_main_irqchip;<br>+=09=09}<br>+=09=09break;<br>+<br>+=09case MPC=
52xx_IRQ_L1_PERP:<br>+=09=09pr_debug("%s: Peripherals. l2=3D%xn", __func__,=
 l2irq);<br>+=09=09good_irqchip =3D &amp;mpc52xx_periph_irqchip;<br>+=09=09=
break;<br>+<br>+=09case MPC52xx_IRQ_L1_SDMA:<br>+=09=09pr_debug("%s: SDMA. =
l2=3D%xn", __func__, l2irq);<br>+=09=09good_irqchip =3D &amp;mpc52xx_sdma_i=
rqchip;<br>+=09=09break;<br>+<br>+=09default:<br>+=09=09pr_debug("%s: Error=
, unknown L1 IRQ (0x%x)n", __func__, l1irq);<br>+=09=09printk(KERN_ERR "Unk=
now IRQ!n");<br>+=09=09return -EINVAL;<br>+=09}<br>+<br>+=09switch (type) {=
<br>+=09case IRQ_TYPE_EDGE_FALLING:<br>+=09case IRQ_TYPE_EDGE_RISING:<br>+=
=09=09good_handle =3D handle_edge_irq;<br>+=09=09break;<br>+=09default:<br>=
+=09=09good_handle =3D handle_level_irq;<br>+=09}<br>+<br>+=09set_irq_chip_=
and_handler(virq, good_irqchip, good_handle);<br>+<br>+=09pr_debug("%s: vir=
q=3D%x, hw=3D%x. type=3D%xn", __func__, virq,<br>+=09=09 (int)irq, type);<b=
r>+<br>+=09return 0;<br>+}<br>+<br>+static struct irq_host_ops mpc52xx_irqh=
ost_ops =3D {<br>+=09.match =3D mpc52xx_irqhost_match,<br>+=09.xlate =3D mp=
c52xx_irqhost_xlate,<br>+=09.map =3D mpc52xx_irqhost_map,<br>+};<br>+<br>+/=
*<br>+ * init (public)<br>+*/<br>+<br>+void __init mpc52xx_init_irq(void)<b=
r>+{<br>+=09struct device_node *picnode =3D NULL;<br>+=09int picnode_regsiz=
e;<br>+=09u32 picnode_regoffset;<br>+<br>+=09struct device_node *sdmanode =
=3D NULL;<br>+=09int sdmanode_regsize;<br>+=09u32 sdmanode_regoffset;<br>+<=
br>+=09u64 size64;<br>+=09int flags;<br>+<br>+=09u32 intr_ctrl;<br>+<br>+=
=09picnode =3D of_find_compatible_node(NULL, "interrupt-controller", "mpc52=
00-pic");<br>+=09if (picnode =3D=3D NULL) {<br>+=09=09printk(KERN_ERR "MPC5=
2xx PIC: Unable to find the interrupt controller in the OpenFirmware device=
 treen");<br>+=09=09goto end;<br>+=09}<br>+<br>+=09sdmanode =3D of_find_com=
patible_node(NULL, "dma-controller", "mpc5200-bestcomm");<br>+=09if (sdmano=
de =3D=3D NULL) {<br>+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to find th=
e Bestcomm DMA controller device in the OpenFirmware device treen");<br>+=
=09=09goto end;<br>+=09}<br>+<br>+=09/* Retrieve PIC ressources */<br>+=09p=
icnode_regoffset =3D (u32) of_get_address(picnode, 0, &amp;size64, &amp;fla=
gs);<br>+=09if (picnode_regoffset =3D=3D 0) {<br>+=09=09printk(KERN_ERR "MP=
C52xx PIC: Unable to get the interrupt controller addressn");<br>+=09=09got=
o end;<br>+=09}<br>+<br>+=09picnode_regoffset =3D of_translate_address(picn=
ode, (u32 *) picnode_regoffset);<br>+=09picnode_regsize =3D (int) size64;=
=09<br>+<br>+=09/* Retrieve SDMA ressources */<br>+=09sdmanode_regoffset =
=3D (u32) of_get_address(sdmanode, 0, &amp;size64, &amp;flags);<br>+=09if (=
sdmanode_regoffset =3D=3D 0) {<br>+=09=09printk(KERN_ERR "MPC52xx PIC: Unab=
le to get the Bestcomm DMA controller addressn");<br>+=09=09goto end;<br>+=
=09}<br>+<br>+=09sdmanode_regoffset =3D of_translate_address(sdmanode, (u32=
 *) sdmanode_regoffset);<br>+=09sdmanode_regsize =3D (int) size64;<br>+<br>=
+=09/* Remap the necessary zones */<br>+=09intr =3D ioremap(picnode_regoffs=
et, picnode_regsize);<br>+=09if (intr =3D=3D NULL) {<br>+=09=09printk(KERN_=
ERR "MPC52xx PIC: Unable to ioremap interrupt controller registers!");<br>+=
=09=09goto end;<br>+=09}<br>+<br>+=09sdma =3D ioremap(sdmanode_regoffset, s=
dmanode_regsize);<br>+=09if (sdma =3D=3D NULL) {<br>+=09=09iounmap(intr);<b=
r>+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to ioremap Bestcomm DMA contr=
oller registers!");<br>+=09=09goto end;<br>+=09}<br>+<br>+=09printk(KERN_IN=
FO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8xn", picnode_regoffset);<br>=
+=09printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8xn", sdma=
node_regoffset);<br>+<br>+=09/* Disable all interrupt sources. */<br>+=09ou=
t_be32(&amp;sdma-&gt;IntPend, 0xffffffff);=09/* 1 means clear pending */<br=
>+=09out_be32(&amp;sdma-&gt;IntMask, 0xffffffff);=09/* 1 means disabled */<=
br>+=09out_be32(&amp;intr-&gt;per_mask, 0x7ffffc00);=09/* 1 means disabled =
*/<br>+=09out_be32(&amp;intr-&gt;main_mask, 0x00010fff);=09/* 1 means disab=
led */<br>+=09intr_ctrl =3D in_be32(&amp;intr-&gt;ctrl);<br>+=09intr_ctrl &=
amp;=3D 0x00ff0000;=09/* Keeps IRQ[0-3] config */<br>+=09intr_ctrl |=3D 0x0=
f000000 |=09/* clear IRQ 0-3 */<br>+=09    0x00001000 |=09/* MEE master ext=
ernal enable */<br>+=09    0x00000000 |=09/* 0 means disable IRQ 0-3 */<br>=
+=09    0x00000001;=09=09/* CEb route critical normally */<br>+=09out_be32(=
&amp;intr-&gt;ctrl, intr_ctrl);<br>+<br>+=09/* Zero a bunch of the priority=
 settings.  */<br>+=09out_be32(&amp;intr-&gt;per_pri1, 0);<br>+=09out_be32(=
&amp;intr-&gt;per_pri2, 0);<br>+=09out_be32(&amp;intr-&gt;per_pri3, 0);<br>=
+=09out_be32(&amp;intr-&gt;main_pri1, 0);<br>+=09out_be32(&amp;intr-&gt;mai=
n_pri2, 0);<br>+<br>+=09/*<br>+=09 * As last step, add an irq host to trans=
late the real<br>+=09 * hw irq information provided by the ofw to linux vir=
q<br>+=09 */<br>+<br>+=09mpc52xx_irqhost =3D<br>+=09    irq_alloc_host(IRQ_=
HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,<br>+=09=09=09   &amp;mpc52xx_ir=
qhost_ops, -1);<br>+<br>+=09if (mpc52xx_irqhost) {<br>+=09=09mpc52xx_irqhos=
t-&gt;host_data =3D picnode;<br>+=09=09printk(KERN_INFO "MPC52xx PIC is up =
and running!n");<br>+=09} else {<br>+=09=09printk(KERN_ERR "MPC52xx PIC: Un=
able to allocate the IRQ hostn");<br>+=09}<br>+<br>+end:<br>+=09of_node_put=
(picnode);<br>+=09of_node_put(sdmanode);<br>+}<br>+<br>+/*<br>+ * get_irq (=
public)<br>+*/<br>+unsigned int mpc52xx_get_irq(void)<br>+{<br>+=09u32 stat=
us;<br>+=09int irq =3D NO_IRQ_IGNORE;<br>+<br>+=09status =3D in_be32(&amp;i=
ntr-&gt;enc_status);<br>+=09if (status &amp; 0x00000400) {=09/* critical */=
<br>+=09=09irq =3D (status &gt;&gt; 8) &amp; 0x3;<br>+=09=09if (irq =3D=3D =
2)=09/* high priority peripheral */<br>+=09=09=09goto peripheral;<br>+=09=
=09irq |=3D<br>+=09=09    (MPC52xx_IRQ_L1_CRIT &lt;&lt; MPC52xx_IRQ_L1_OFFS=
ET) &amp;<br>+=09=09    MPC52xx_IRQ_L1_MASK;<br>+=09} else if (status &amp;=
 0x00200000) {=09/* main */<br>+=09=09irq =3D (status &gt;&gt; 16) &amp; 0x=
1f;<br>+=09=09if (irq =3D=3D 4)=09/* low priority peripheral */<br>+=09=09=
=09goto peripheral;<br>+=09=09irq |=3D<br>+=09=09    (MPC52xx_IRQ_L1_MAIN &=
lt;&lt; MPC52xx_IRQ_L1_OFFSET) &amp;<br>+=09=09    MPC52xx_IRQ_L1_MASK;<br>=
+=09} else if (status &amp; 0x20000000) {=09/* peripheral */<br>+=09      p=
eripheral:<br>+=09=09irq =3D (status &gt;&gt; 24) &amp; 0x1f;<br>+=09=09if =
(irq =3D=3D 0) {=09/* bestcomm */<br>+=09=09=09status =3D in_be32(&amp;sdma=
-&gt;IntPend);<br>+=09=09=09irq =3D ffs(status) - 1;<br>+=09=09=09irq |=3D<=
br>+=09=09=09    (MPC52xx_IRQ_L1_SDMA &lt;&lt; MPC52xx_IRQ_L1_OFFSET) &amp;=
<br>+=09=09=09    MPC52xx_IRQ_L1_MASK;<br>+=09=09} else<br>+=09=09=09irq |=
=3D<br>+=09=09=09    (MPC52xx_IRQ_L1_PERP &lt;&lt; MPC52xx_IRQ_L1_OFFSET) &=
amp;<br>+=09=09=09    MPC52xx_IRQ_L1_MASK;<br>+<br>+=09}<br>+<br>+=09pr_deb=
ug("%s: irq=3D%x. virq=3D%dn", __func__, irq,<br>+=09=09 irq_linear_revmap(=
mpc52xx_irqhost, irq));<br>+<br>+=09return irq_linear_revmap(mpc52xx_irqhos=
t, irq);<br>+}<br>--- a/arch/powerpc/sysdev/Makefile=092006-11-01 09:18:43.=
000000000 +0100<br>+++ b/arch/powerpc/sysdev/Makefile=092006-11-06 11:10:46=
.000000000 +0100<br>@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)=09=09+=3D fsl_s=
oc.o<br> obj-$(CONFIG_PPC_TODC)=09=09+=3D todc.o<br> obj-$(CONFIG_TSI108_BR=
IDGE)=09+=3D tsi108_pci.o tsi108_dev.o<br> obj-$(CONFIG_QUICC_ENGINE)=09+=
=3D qe_lib/<br>+obj-$(CONFIG_PPC_MPC52xx)=09+=3D mpc52xx_pic.o<br> <br> ife=
q ($(CONFIG_PPC_MERGE),y)<br> obj-$(CONFIG_PPC_I8259)=09=09+=3D i8259.o<br>=
--- a/include/asm-powerpc/mpc52xx.h=091970-01-01 01:00:00.000000000 +0100<b=
r>+++ b/include/asm-powerpc/mpc52xx.h=092006-11-06 11:10:29.000000000 +0100=
<br>@@ -0,0 +1,283 @@<br>+/*<br>+ * Prototypes, etc. for the Freescale MPC5=
2xx embedded cpu chips<br>+ * May need to be cleaned as the port goes on ..=
.<br>+ *<br>+ * Copyright (C) 2004-2005 Sylvain Munaut &lt;tnt@246tNt.com&g=
t;<br>+ * Copyright (C) 2003 MontaVista, Software, Inc.<br>+ *<br>+ * This =
file is licensed under the terms of the GNU General Public License<br>+ * v=
ersion 2. This program is licensed "as is" without any warranty of any<br>+=
 * kind, whether express or implied.<br>+ */<br>+<br>+#ifndef __ASM_POWERPC=
_MPC52xx_H__<br>+#define __ASM_POWERPC_MPC52xx_H__<br>+<br>+#ifndef __ASSEM=
BLY__<br>+#include &lt;asm/types.h&gt;<br>+#include &lt;asm/prom.h&gt;<br>+=
#endif /* __ASSEMBLY__ */<br>+<br>+/* HW IRQ mapping */<br>+#define MPC52xx=
_IRQ_L1_CRIT=09(0)<br>+#define MPC52xx_IRQ_L1_MAIN=09(1)<br>+#define MPC52x=
x_IRQ_L1_PERP=09(2)<br>+#define MPC52xx_IRQ_L1_SDMA=09(3)<br>+<br>+#define =
MPC52xx_IRQ_L1_OFFSET   (6)<br>+#define MPC52xx_IRQ_L1_MASK     (0xc0)<br>+=
<br>+#define MPC52xx_IRQ_L2_OFFSET   (0)<br>+#define MPC52xx_IRQ_L2_MASK   =
  (0x3f)<br>+<br>+#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)<br>+<br>+/* Inte=
rrupt controller Register set */<br>+struct mpc52xx_intr {<br>+=09u32 per_m=
ask;=09=09/* INTR + 0x00 */<br>+=09u32 per_pri1;=09=09/* INTR + 0x04 */<br>=
+=09u32 per_pri2;=09=09/* INTR + 0x08 */<br>+=09u32 per_pri3;=09=09/* INTR =
+ 0x0c */<br>+=09u32 ctrl;=09=09/* INTR + 0x10 */<br>+=09u32 main_mask;=09=
=09/* INTR + 0x14 */<br>+=09u32 main_pri1;=09=09/* INTR + 0x18 */<br>+=09u3=
2 main_pri2;=09=09/* INTR + 0x1c */<br>+=09u32 reserved1;=09=09/* INTR + 0x=
20 */<br>+=09u32 enc_status;=09=09/* INTR + 0x24 */<br>+=09u32 crit_status;=
=09/* INTR + 0x28 */<br>+=09u32 main_status;=09/* INTR + 0x2c */<br>+=09u32=
 per_status;=09=09/* INTR + 0x30 */<br>+=09u32 reserved2;=09=09/* INTR + 0x=
34 */<br>+=09u32 per_error;=09=09/* INTR + 0x38 */<br>+};<br>+<br>+<br>+/* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */<br>+/=
* Structures mapping of some unit register set                             =
*/<br>+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D */<br>+<br>+#ifndef __ASSEMBLY__<br>+<br>+/* Memory Mapping Control */<=
br>+struct mpc52xx_mmap_ctl {<br>+=09u32 mbar;=09=09/* MMAP_CTRL + 0x00 */<=
br>+<br>+=09u32 cs0_start;=09=09/* MMAP_CTRL + 0x04 */<br>+=09u32 cs0_stop;=
=09=09/* MMAP_CTRL + 0x08 */<br>+=09u32 cs1_start;=09=09/* MMAP_CTRL + 0x0c=
 */<br>+=09u32 cs1_stop;=09=09/* MMAP_CTRL + 0x10 */<br>+=09u32 cs2_start;=
=09=09/* MMAP_CTRL + 0x14 */<br>+=09u32 cs2_stop;=09=09/* MMAP_CTRL + 0x18 =
*/<br>+=09u32 cs3_start;=09=09/* MMAP_CTRL + 0x1c */<br>+=09u32 cs3_stop;=
=09=09/* MMAP_CTRL + 0x20 */<br>+=09u32 cs4_start;=09=09/* MMAP_CTRL + 0x24=
 */<br>+=09u32 cs4_stop;=09=09/* MMAP_CTRL + 0x28 */<br>+=09u32 cs5_start;=
=09=09/* MMAP_CTRL + 0x2c */<br>+=09u32 cs5_stop;=09=09/* MMAP_CTRL + 0x30 =
*/<br>+<br>+=09u32 sdram0;=09=09/* MMAP_CTRL + 0x34 */<br>+=09u32 sdram1;=
=09=09/* MMAP_CTRL + 0X38 */<br>+<br>+=09u32 reserved[4];=09/* MMAP_CTRL + =
0x3c .. 0x48 */<br>+<br>+=09u32 boot_start;=09=09/* MMAP_CTRL + 0x4c */<br>=
+=09u32 boot_stop;=09=09/* MMAP_CTRL + 0x50 */<br>+<br>+=09u32 ipbi_ws_ctrl=
;=09/* MMAP_CTRL + 0x54 */<br>+<br>+=09u32 cs6_start;=09=09/* MMAP_CTRL + 0=
x58 */<br>+=09u32 cs6_stop;=09=09/* MMAP_CTRL + 0x5c */<br>+=09u32 cs7_star=
t;=09=09/* MMAP_CTRL + 0x60 */<br>+=09u32 cs7_stop;=09=09/* MMAP_CTRL + 0x6=
4 */<br>+};<br>+<br>+/* SDRAM control */<br>+struct mpc52xx_sdram {<br>+=09=
u32 mode;=09=09/* SDRAM + 0x00 */<br>+=09u32 ctrl;=09=09/* SDRAM + 0x04 */<=
br>+=09u32 config1;=09=09/* SDRAM + 0x08 */<br>+=09u32 config2;=09=09/* SDR=
AM + 0x0c */<br>+};<br>+<br>+/* SDMA */<br>+struct mpc52xx_sdma {<br>+=09u3=
2 taskBar;=09=09/* SDMA + 0x00 */<br>+=09u32 currentPointer;=09/* SDMA + 0x=
04 */<br>+=09u32 endPointer;=09=09/* SDMA + 0x08 */<br>+=09u32 variablePoin=
ter;=09/* SDMA + 0x0c */<br>+<br>+=09u8 IntVect1;=09=09/* SDMA + 0x10 */<br=
>+=09u8 IntVect2;=09=09/* SDMA + 0x11 */<br>+=09u16 PtdCntrl;=09=09/* SDMA =
+ 0x12 */<br>+<br>+=09u32 IntPend;=09=09/* SDMA + 0x14 */<br>+=09u32 IntMas=
k;=09=09/* SDMA + 0x18 */<br>+<br>+=09u16 tcr[16];=09=09/* SDMA + 0x1c .. 0=
x3a */<br>+<br>+=09u8 ipr[32];=09=09/* SDMA + 0x3c .. 0x5b */<br>+<br>+=09u=
32 cReqSelect;=09=09/* SDMA + 0x5c */<br>+=09u32 task_size0;=09=09/* SDMA +=
 0x60 */<br>+=09u32 task_size1;=09=09/* SDMA + 0x64 */<br>+=09u32 MDEDebug;=
=09=09/* SDMA + 0x68 */<br>+=09u32 ADSDebug;=09=09/* SDMA + 0x6c */<br>+=09=
u32 Value1;=09=09/* SDMA + 0x70 */<br>+=09u32 Value2;=09=09/* SDMA + 0x74 *=
/<br>+=09u32 Control;=09=09/* SDMA + 0x78 */<br>+=09u32 Status;=09=09/* SDM=
A + 0x7c */<br>+=09u32 PTDDebug;=09=09/* SDMA + 0x80 */<br>+};<br>+<br>+/* =
GPT */<br>+struct mpc52xx_gpt {<br>+=09u32 mode;=09=09/* GPTx + 0x00 */<br>=
+=09u32 count;=09=09/* GPTx + 0x04 */<br>+=09u32 pwm;=09=09/* GPTx + 0x08 *=
/<br>+=09u32 status;=09=09/* GPTx + 0X0c */<br>+};<br>+<br>+/* GPIO */<br>+=
struct mpc52xx_gpio {<br>+=09u32 port_config;=09/* GPIO + 0x00 */<br>+=09u3=
2 simple_gpioe;=09/* GPIO + 0x04 */<br>+=09u32 simple_ode;=09=09/* GPIO + 0=
x08 */<br>+=09u32 simple_ddr;=09=09/* GPIO + 0x0c */<br>+=09u32 simple_dvo;=
=09=09/* GPIO + 0x10 */<br>+=09u32 simple_ival;=09/* GPIO + 0x14 */<br>+=09=
u8 outo_gpioe;=09=09/* GPIO + 0x18 */<br>+=09u8 reserved1[3];=09/* GPIO + 0=
x19 */<br>+=09u8 outo_dvo;=09=09/* GPIO + 0x1c */<br>+=09u8 reserved2[3];=
=09/* GPIO + 0x1d */<br>+=09u8 sint_gpioe;=09=09/* GPIO + 0x20 */<br>+=09u8=
 reserved3[3];=09/* GPIO + 0x21 */<br>+=09u8 sint_ode;=09=09/* GPIO + 0x24 =
*/<br>+=09u8 reserved4[3];=09/* GPIO + 0x25 */<br>+=09u8 sint_ddr;=09=09/* =
GPIO + 0x28 */<br>+=09u8 reserved5[3];=09/* GPIO + 0x29 */<br>+=09u8 sint_d=
vo;=09=09/* GPIO + 0x2c */<br>+=09u8 reserved6[3];=09/* GPIO + 0x2d */<br>+=
=09u8 sint_inten;=09=09/* GPIO + 0x30 */<br>+=09u8 reserved7[3];=09/* GPIO =
+ 0x31 */<br>+=09u16 sint_itype;=09=09/* GPIO + 0x34 */<br>+=09u16 reserved=
8;=09=09/* GPIO + 0x36 */<br>+=09u8 gpio_control;=09/* GPIO + 0x38 */<br>+=
=09u8 reserved9[3];=09/* GPIO + 0x39 */<br>+=09u8 sint_istat;=09=09/* GPIO =
+ 0x3c */<br>+=09u8 sint_ival;=09=09/* GPIO + 0x3d */<br>+=09u8 bus_errs;=
=09=09/* GPIO + 0x3e */<br>+=09u8 reserved10;=09=09/* GPIO + 0x3f */<br>+};=
<br>+<br>+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD=094<br>+#define M=
PC52xx_GPIO_PSC_CONFIG_UART_WITH_CD=095<br>+#define MPC52xx_GPIO_PCI_DIS=09=
=09=09(1&lt;&lt;15)<br>+<br>+/* GPIO with WakeUp*/<br>+struct mpc52xx_gpio_=
wkup {<br>+=09u8 wkup_gpioe;=09=09/* GPIO_WKUP + 0x00 */<br>+=09u8 reserved=
1[3];=09/* GPIO_WKUP + 0x03 */<br>+=09u8 wkup_ode;=09=09/* GPIO_WKUP + 0x04=
 */<br>+=09u8 reserved2[3];=09/* GPIO_WKUP + 0x05 */<br>+=09u8 wkup_ddr;=09=
=09/* GPIO_WKUP + 0x08 */<br>+=09u8 reserved3[3];=09/* GPIO_WKUP + 0x09 */<=
br>+=09u8 wkup_dvo;=09=09/* GPIO_WKUP + 0x0C */<br>+=09u8 reserved4[3];=09/=
* GPIO_WKUP + 0x0D */<br>+=09u8 wkup_inten;=09=09/* GPIO_WKUP + 0x10 */<br>=
+=09u8 reserved5[3];=09/* GPIO_WKUP + 0x11 */<br>+=09u8 wkup_iinten;=09=09/=
* GPIO_WKUP + 0x14 */<br>+=09u8 reserved6[3];=09/* GPIO_WKUP + 0x15 */<br>+=
=09u16 wkup_itype;=09=09/* GPIO_WKUP + 0x18 */<br>+=09u8 reserved7[2];=09/*=
 GPIO_WKUP + 0x1A */<br>+=09u8 wkup_maste;=09=09/* GPIO_WKUP + 0x1C */<br>+=
=09u8 reserved8[3];=09/* GPIO_WKUP + 0x1D */<br>+=09u8 wkup_ival;=09=09/* G=
PIO_WKUP + 0x20 */<br>+=09u8 reserved9[3];=09/* GPIO_WKUP + 0x21 */<br>+=09=
u8 wkup_istat;=09=09/* GPIO_WKUP + 0x24 */<br>+=09u8 reserved10[3];=09/* GP=
IO_WKUP + 0x25 */<br>+};<br>+<br>+/* XLB Bus control */<br>+struct mpc52xx_=
xlb {<br>+=09u8 reserved[0x40];<br>+=09u32 config;=09=09/* XLB + 0x40 */<br=
>+=09u32 version;=09=09/* XLB + 0x44 */<br>+=09u32 status;=09=09/* XLB + 0x=
48 */<br>+=09u32 int_enable;=09=09/* XLB + 0x4c */<br>+=09u32 addr_capture;=
=09/* XLB + 0x50 */<br>+=09u32 bus_sig_capture;=09/* XLB + 0x54 */<br>+=09u=
32 addr_timeout;=09/* XLB + 0x58 */<br>+=09u32 data_timeout;=09/* XLB + 0x5=
c */<br>+=09u32 bus_act_timeout;=09/* XLB + 0x60 */<br>+=09u32 master_pri_e=
nable;=09/* XLB + 0x64 */<br>+=09u32 master_priority;=09/* XLB + 0x68 */<br=
>+=09u32 base_address;=09/* XLB + 0x6c */<br>+=09u32 snoop_window;=09/* XLB=
 + 0x70 */<br>+};<br>+<br>+#define MPC52xx_XLB_CFG_PLDIS=09=09(1 &lt;&lt; 3=
1)<br>+#define MPC52xx_XLB_CFG_SNOOP=09=09(1 &lt;&lt; 15)<br>+<br>+/* Clock=
 Distribution control */<br>+struct mpc52xx_cdm {<br>+=09u32 jtag_id;=09=09=
/* CDM + 0x00  reg0 read only */<br>+=09u32 rstcfg;=09=09/* CDM + 0x04  reg=
1 read only */<br>+=09u32 breadcrumb;=09=09/* CDM + 0x08  reg2 */<br>+<br>+=
=09u8 mem_clk_sel;=09=09/* CDM + 0x0c  reg3 byte0 */<br>+=09u8 xlb_clk_sel;=
=09=09/* CDM + 0x0d  reg3 byte1 read only */<br>+=09u8 ipb_clk_sel;=09=09/*=
 CDM + 0x0e  reg3 byte2 */<br>+=09u8 pci_clk_sel;=09=09/* CDM + 0x0f  reg3 =
byte3 */<br>+<br>+=09u8 ext_48mhz_en;=09/* CDM + 0x10  reg4 byte0 */<br>+=
=09u8 fd_enable;=09=09/* CDM + 0x11  reg4 byte1 */<br>+=09u16 fd_counters;=
=09/* CDM + 0x12  reg4 byte2,3 */<br>+<br>+=09u32 clk_enables;=09/* CDM + 0=
x14  reg5 */<br>+<br>+=09u8 osc_disable;=09=09/* CDM + 0x18  reg6 byte0 */<=
br>+=09u8 reserved0[3];=09/* CDM + 0x19  reg6 byte1,2,3 */<br>+<br>+=09u8 c=
cs_sleep_enable;=09/* CDM + 0x1c  reg7 byte0 */<br>+=09u8 osc_sleep_enable;=
=09/* CDM + 0x1d  reg7 byte1 */<br>+=09u8 reserved1;=09=09/* CDM + 0x1e  re=
g7 byte2 */<br>+=09u8 ccs_qreq_test;=09/* CDM + 0x1f  reg7 byte3 */<br>+<br=
>+=09u8 soft_reset;=09=09/* CDM + 0x20  u8 byte0 */<br>+=09u8 no_ckstp;=09=
=09/* CDM + 0x21  u8 byte0 */<br>+=09u8 reserved2[2];=09/* CDM + 0x22  u8 b=
yte1,2,3 */<br>+<br>+=09u8 pll_lock;=09=09/* CDM + 0x24  reg9 byte0 */<br>+=
=09u8 pll_looselock;=09/* CDM + 0x25  reg9 byte1 */<br>+=09u8 pll_sm_lockwi=
n;=09/* CDM + 0x26  reg9 byte2 */<br>+=09u8 reserved3;=09=09/* CDM + 0x27  =
reg9 byte3 */<br>+<br>+=09u16 reserved4;=09=09/* CDM + 0x28  reg10 byte0,1 =
*/<br>+=09u16 mclken_div_psc1;=09/* CDM + 0x2a  reg10 byte2,3 */<br>+<br>+=
=09u16 reserved5;=09=09/* CDM + 0x2c  reg11 byte0,1 */<br>+=09u16 mclken_di=
v_psc2;=09/* CDM + 0x2e  reg11 byte2,3 */<br>+<br>+=09u16 reserved6;=09=09/=
* CDM + 0x30  reg12 byte0,1 */<br>+=09u16 mclken_div_psc3;=09/* CDM + 0x32 =
 reg12 byte2,3 */<br>+<br>+=09u16 reserved7;=09=09/* CDM + 0x34  reg13 byte=
0,1 */<br>+=09u16 mclken_div_psc6;=09/* CDM + 0x36  reg13 byte2,3 */<br>+};=
<br>+<br>+#endif /* __ASSEMBLY__ */<br>+<br>+<br>+/* =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */<br>+/* Prototypes for M=
PC52xx sysdev                                             */<br>+/* =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */<br>+<br>=
+#ifndef __ASSEMBLY__<br>+<br>+extern void mpc52xx_init_irq(void);<br>+exte=
rn unsigned int mpc52xx_get_irq(void);<br>+<br>+#endif /* __ASSEMBLY__ */<b=
r>+<br>+#endif /* __ASM_POWERPC_MPC52xx_H__ */<br>+<br><br></pre></BODY></H=
TML>
--b_01_9f75f5759d3e0c1e1a66f10cd8bb73c4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch add MPC52xx Interrupt controller for ARCH=3Dpowerpc.=0A=0AIt inc=
ludes the main code in arch/powerpc/sysdev/ ad well as an header file in=0A=
include/asm-powerpc.=0A=0ASigned-off-by: Nicolas DET <nd@bplan-gmbh.de>=0A-=
--=0A--- a/arch/powerpc/sysdev/mpc52xx_pic.c=091970-01-01 01:00:00.00000000=
0 +0100=0A+++ b/arch/powerpc/sysdev/mpc52xx_pic.c=092006-11-06 11:10:29.000=
000000 +0100=0A@@ -0,0 +1,527 @@=0A+/*=0A+ *=0A+ * Programmable Interrupt C=
ontroller functions for the Freescale MPC52xx.=0A+ *=0A+ * Copyright (C) 20=
06 bplan GmbH=0A+ *=0A+ * Based on (well, mostly copied from) the code from=
 the 2.4 kernel by=0A+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent =
Borg.=0A+ * =0A+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>=0A+ *=
 Copyright (C) 2003 Montavista Software, Inc=0A+ *=0A+ * This file is licen=
sed under the terms of the GNU General Public License=0A+ * version 2. This=
 program is licensed "as is" without any warranty of any=0A+ * kind, whethe=
r express or implied.=0A+ *=0A+ */=0A+=0A+#undef DEBUG=0A+=0A+#include <lin=
ux/stddef.h>=0A+#include <linux/init.h>=0A+#include <linux/sched.h>=0A+#inc=
lude <linux/signal.h>=0A+#include <linux/stddef.h>=0A+#include <linux/delay=
.h>=0A+#include <linux/irq.h>=0A+#include <linux/hardirq.h>=0A+=0A+#include=
 <asm/io.h>=0A+#include <asm/processor.h>=0A+#include <asm/system.h>=0A+#in=
clude <asm/irq.h>=0A+#include <asm/prom.h>=0A+#include <asm/mpc52xx.h>=0A+=
=0A+/*=0A+ *=0A+*/=0A+=0A+static struct mpc52xx_intr __iomem *intr;=0A+stat=
ic struct mpc52xx_sdma __iomem *sdma;=0A+static struct irq_host *mpc52xx_ir=
qhost =3D NULL;=0A+=0A+static unsigned char mpc52xx_map_senses[4] =3D {=0A+=
=09IRQ_TYPE_LEVEL_HIGH,=0A+=09IRQ_TYPE_EDGE_RISING,=0A+=09IRQ_TYPE_EDGE_FAL=
LING,=0A+=09IRQ_TYPE_LEVEL_LOW,=0A+};=0A+=0A+/*=0A+ *=0A+*/=0A+=0A+static i=
nline void io_be_setbit(u32 __iomem *addr, int bitno)=0A+{=0A+=09out_be32(a=
ddr, in_be32(addr) | (1 << bitno) );=0A+}=0A+=0A+static inline void io_be_c=
lrbit(u32 __iomem *addr, int bitno)=0A+{=0A+=09out_be32(addr, in_be32(addr)=
 & ~(1 << bitno));=0A+}=0A+=0A+/*=0A+ * IRQ[0-3] interrupt irq_chip=0A+*/=
=0A+=0A+static void mpc52xx_extirq_mask(unsigned int virq)=0A+{=0A+=09int i=
rq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l2irq =3D=
 (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("=
%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);=0A+=0A+=09io_be_clrbit(&in=
tr->ctrl, 11 - l2irq);=0A+}=0A+=0A+static void mpc52xx_extirq_unmask(unsign=
ed int virq)=0A+{=0A+=09int irq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq_map=
[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2=
_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq=
);=0A+=0A+=09io_be_setbit(&intr->ctrl, 11 - l2irq);=0A+}=0A+=0A+static void=
 mpc52xx_extirq_ack(unsigned int virq)=0A+{=0A+=09int irq;=0A+=09int l2irq;=
=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx_IRQ_=
L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l2=3D%=
d\n", __func__, irq, l2irq);=0A+=0A+=09io_be_setbit(&intr->ctrl, 27-l2irq);=
=0A+}=0A+=0A+static struct irq_chip mpc52xx_extirq_irqchip =3D {=0A+=09.typ=
ename =3D " MPC52xx IRQ[0-3] ",=0A+=09.mask =3D mpc52xx_extirq_mask,=0A+=09=
.unmask =3D mpc52xx_extirq_unmask,=0A+=09.ack =3D mpc52xx_extirq_ack,=0A+};=
=0A+=0A+/*=0A+ * Main interrupt irq_chip=0A+*/=0A+=0A+static void mpc52xx_m=
ain_mask(unsigned int virq)=0A+{=0A+=09int irq;=0A+=09int l2irq;=0A+=0A+=09=
irq =3D irq_map[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >>=
 MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l2=3D%d\n", __fun=
c__, irq, l2irq);=0A+=0A+=09io_be_setbit(&intr->main_mask, 15 - l2irq);=0A+=
}=0A+=0A+static void mpc52xx_main_unmask(unsigned int virq)=0A+{=0A+=09int =
irq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l2irq =
=3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debu=
g("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);=0A+=0A+=09io_be_clrbit(=
&intr->main_mask, 15 - l2irq);=0A+}=0A+=0A+static struct irq_chip mpc52xx_m=
ain_irqchip =3D {=0A+=09.typename =3D "MPC52xx Main",=0A+=09.mask =3D mpc52=
xx_main_mask,=0A+=09.mask_ack =3D mpc52xx_main_mask,=0A+=09.unmask =3D mpc5=
2xx_main_unmask,=0A+};=0A+=0A+/*=0A+ * Peripherals interrupt irq_chip=0A+*/=
=0A+=0A+static void mpc52xx_periph_mask(unsigned int virq)=0A+{=0A+=09int i=
rq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l2irq =3D=
 (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("=
%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);=0A+=0A+=09io_be_setbit(&in=
tr->per_mask, 31 - l2irq);=0A+}=0A+=0A+static void mpc52xx_periph_unmask(un=
signed int virq)=0A+{=0A+=09int irq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq=
_map[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IR=
Q_L2_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l=
2irq);=0A+=0A+=09io_be_clrbit(&intr->per_mask, 31 - l2irq);=0A+}=0A+=0A+sta=
tic struct irq_chip mpc52xx_periph_irqchip =3D {=0A+=09.typename =3D "MPC52=
xx Peripherals",=0A+=09.mask =3D mpc52xx_periph_mask,=0A+=09.mask_ack =3D m=
pc52xx_periph_mask,=0A+=09.unmask =3D mpc52xx_periph_unmask,=0A+};=0A+=0A+/=
*=0A+ * SDMA interrupt irq_chip=0A+*/=0A+=0A+static void mpc52xx_sdma_mask(=
unsigned int virq)=0A+{=0A+=09int irq;=0A+=09int l2irq;=0A+=0A+=09irq =3D i=
rq_map[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_=
IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq,=
 l2irq);=0A+=0A+=09io_be_setbit(&sdma->IntMask, l2irq);=0A+}=0A+=0A+static =
void mpc52xx_sdma_unmask(unsigned int virq)=0A+{=0A+=09int irq;=0A+=09int l=
2irq;=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l2irq =3D (irq & MPC52xx=
_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr_debug("%s: irq=3D%x. l=
2=3D%d\n", __func__, irq, l2irq);=0A+=0A+=09io_be_clrbit(&sdma->IntMask, l2=
irq);=0A+}=0A+=0A+static void mpc52xx_sdma_ack(unsigned int virq)=0A+{=0A+=
=09int irq;=0A+=09int l2irq;=0A+=0A+=09irq =3D irq_map[virq].hwirq;=0A+=09l=
2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09pr=
_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);=0A+=0A+=09out_be32=
(&sdma->IntPend, 1 << l2irq);=0A+}=0A+=0A+static struct irq_chip mpc52xx_sd=
ma_irqchip =3D {=0A+=09.typename =3D "MPC52xx SDMA",=0A+=09.mask =3D mpc52x=
x_sdma_mask,=0A+=09.unmask =3D mpc52xx_sdma_unmask,=0A+=09.ack =3D mpc52xx_=
sdma_ack,=0A+};=0A+=0A+/*=0A+ * irq_host=0A+*/=0A+=0A+static int mpc52xx_ir=
qhost_match(struct irq_host *h, struct device_node *node)=0A+{=0A+=09pr_deb=
ug("%s: node=3D%p\n", __func__, node);=0A+=09return mpc52xx_irqhost->host_d=
ata =3D=3D node;=0A+}=0A+=0A+static int mpc52xx_irqhost_xlate(struct irq_ho=
st *h, struct device_node *ct,=0A+=09=09=09=09 u32 * intspec, unsigned int =
intsize,=0A+=09=09=09=09 irq_hw_number_t * out_hwirq,=0A+=09=09=09=09 unsig=
ned int *out_flags)=0A+{=0A+=09int intrvect_l1;=0A+=09int intrvect_l2;=0A+=
=09int intrvect_type;=0A+=09int intrvect_linux;=0A+=0A+=09if (intsize !=3D =
3)=0A+=09=09return -1;=0A+=0A+=09intrvect_l1 =3D (int)intspec[0];=0A+=09int=
rvect_l2 =3D (int)intspec[1];=0A+=09intrvect_type =3D (int)intspec[2];=0A+=
=0A+=09intrvect_linux =3D=0A+=09    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) =
& MPC52xx_IRQ_L1_MASK;=0A+=09intrvect_linux |=3D=0A+=09    (intrvect_l2 << =
MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;=0A+=0A+=09pr_debug("return %x=
, l1=3D%d, l2=3D%d\n", intrvect_linux, intrvect_l1,=0A+=09=09 intrvect_l2);=
=0A+=0A+=09*out_hwirq =3D intrvect_linux;=0A+=09*out_flags =3D mpc52xx_map_=
senses[intrvect_type];=0A+=0A+=09return 0;=0A+}=0A+=0A+/*=0A+ * this functi=
on retrieves the correct IRQ type out=0A+ * of the MPC regs=0A+ * Only exte=
rnals IRQs needs this=0A+*/=0A+static int mpc52xx_irqx_gettype(int irq)=0A+=
{=0A+=09int type;=0A+=09u32 ctrl_reg;=0A+=0A+=09ctrl_reg =3D in_be32(&intr-=
>ctrl);=0A+=09type =3D (ctrl_reg >> (22 - irq * 2)) & 0x3;=0A+=0A+=09return=
 mpc52xx_map_senses[type];=0A+}=0A+=0A+static int mpc52xx_irqhost_map(struc=
t irq_host *h, unsigned int virq,=0A+=09=09=09       irq_hw_number_t irq)=
=0A+{=0A+=09int l1irq;=0A+=09int l2irq;=0A+=09struct irq_chip *good_irqchip=
;=0A+=09void *good_handle;=0A+=09int type;=0A+=0A+=09l1irq =3D (irq & MPC52=
xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;=0A+=09l2irq =3D (irq & MPC52xx_IR=
Q_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;=0A+=0A+=09/*=0A+=09 * Most of ours IRQ=
s will be level low=0A+=09 * Only external IRQs on some platform may be oth=
ers=0A+=09 */=0A+=09type =3D IRQ_TYPE_LEVEL_LOW;=0A+=0A+=09switch (l1irq) {=
=0A+=09case MPC52xx_IRQ_L1_CRIT:=0A+=09=09pr_debug("%s: Critical. l2=3D%x\n=
", __func__, l2irq);=0A+=0A+=09=09BUG_ON(l2irq !=3D 0);=0A+=0A+=09=09type =
=3D mpc52xx_irqx_gettype(l2irq);=0A+=09=09good_irqchip =3D &mpc52xx_extirq_=
irqchip;=0A+=09=09break;=0A+=0A+=09case MPC52xx_IRQ_L1_MAIN:=0A+=09=09pr_de=
bug("%s: Main IRQ[1-3] l2=3D%x\n", __func__, l2irq);=0A+=0A+=09=09if ((l2ir=
q >=3D 1) && (l2irq <=3D 3)) {=0A+=09=09=09type =3D mpc52xx_irqx_gettype(l2=
irq);=0A+=09=09=09good_irqchip =3D &mpc52xx_extirq_irqchip;=0A+=09=09} else=
 {=0A+=09=09=09good_irqchip =3D &mpc52xx_main_irqchip;=0A+=09=09}=0A+=09=09=
break;=0A+=0A+=09case MPC52xx_IRQ_L1_PERP:=0A+=09=09pr_debug("%s: Periphera=
ls. l2=3D%x\n", __func__, l2irq);=0A+=09=09good_irqchip =3D &mpc52xx_periph=
_irqchip;=0A+=09=09break;=0A+=0A+=09case MPC52xx_IRQ_L1_SDMA:=0A+=09=09pr_d=
ebug("%s: SDMA. l2=3D%x\n", __func__, l2irq);=0A+=09=09good_irqchip =3D &mp=
c52xx_sdma_irqchip;=0A+=09=09break;=0A+=0A+=09default:=0A+=09=09pr_debug("%=
s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);=0A+=09=09printk(KERN_=
ERR "Unknow IRQ!\n");=0A+=09=09return -EINVAL;=0A+=09}=0A+=0A+=09switch (ty=
pe) {=0A+=09case IRQ_TYPE_EDGE_FALLING:=0A+=09case IRQ_TYPE_EDGE_RISING:=0A=
+=09=09good_handle =3D handle_edge_irq;=0A+=09=09break;=0A+=09default:=0A+=
=09=09good_handle =3D handle_level_irq;=0A+=09}=0A+=0A+=09set_irq_chip_and_=
handler(virq, good_irqchip, good_handle);=0A+=0A+=09pr_debug("%s: virq=3D%x=
, hw=3D%x. type=3D%x\n", __func__, virq,=0A+=09=09 (int)irq, type);=0A+=0A+=
=09return 0;=0A+}=0A+=0A+static struct irq_host_ops mpc52xx_irqhost_ops =3D=
 {=0A+=09.match =3D mpc52xx_irqhost_match,=0A+=09.xlate =3D mpc52xx_irqhost=
_xlate,=0A+=09.map =3D mpc52xx_irqhost_map,=0A+};=0A+=0A+/*=0A+ * init (pub=
lic)=0A+*/=0A+=0A+void __init mpc52xx_init_irq(void)=0A+{=0A+=09struct devi=
ce_node *picnode =3D NULL;=0A+=09int picnode_regsize;=0A+=09u32 picnode_reg=
offset;=0A+=0A+=09struct device_node *sdmanode =3D NULL;=0A+=09int sdmanode=
_regsize;=0A+=09u32 sdmanode_regoffset;=0A+=0A+=09u64 size64;=0A+=09int fla=
gs;=0A+=0A+=09u32 intr_ctrl;=0A+=0A+=09picnode =3D of_find_compatible_node(=
NULL, "interrupt-controller", "mpc5200-pic");=0A+=09if (picnode =3D=3D NULL=
) {=0A+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to find the interrupt con=
troller in the OpenFirmware device tree\n");=0A+=09=09goto end;=0A+=09}=0A+=
=0A+=09sdmanode =3D of_find_compatible_node(NULL, "dma-controller", "mpc520=
0-bestcomm");=0A+=09if (sdmanode =3D=3D NULL) {=0A+=09=09printk(KERN_ERR "M=
PC52xx PIC: Unable to find the Bestcomm DMA controller device in the OpenFi=
rmware device tree\n");=0A+=09=09goto end;=0A+=09}=0A+=0A+=09/* Retrieve PI=
C ressources */=0A+=09picnode_regoffset =3D (u32) of_get_address(picnode, 0=
, &size64, &flags);=0A+=09if (picnode_regoffset =3D=3D 0) {=0A+=09=09printk=
(KERN_ERR "MPC52xx PIC: Unable to get the interrupt controller address\n");=
=0A+=09=09goto end;=0A+=09}=0A+=0A+=09picnode_regoffset =3D of_translate_ad=
dress(picnode, (u32 *) picnode_regoffset);=0A+=09picnode_regsize =3D (int) =
size64;=09=0A+=0A+=09/* Retrieve SDMA ressources */=0A+=09sdmanode_regoffse=
t =3D (u32) of_get_address(sdmanode, 0, &size64, &flags);=0A+=09if (sdmanod=
e_regoffset =3D=3D 0) {=0A+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to ge=
t the Bestcomm DMA controller address\n");=0A+=09=09goto end;=0A+=09}=0A+=
=0A+=09sdmanode_regoffset =3D of_translate_address(sdmanode, (u32 *) sdmano=
de_regoffset);=0A+=09sdmanode_regsize =3D (int) size64;=0A+=0A+=09/* Remap =
the necessary zones */=0A+=09intr =3D ioremap(picnode_regoffset, picnode_re=
gsize);=0A+=09if (intr =3D=3D NULL) {=0A+=09=09printk(KERN_ERR "MPC52xx PIC=
: Unable to ioremap interrupt controller registers!");=0A+=09=09goto end;=
=0A+=09}=0A+=0A+=09sdma =3D ioremap(sdmanode_regoffset, sdmanode_regsize);=
=0A+=09if (sdma =3D=3D NULL) {=0A+=09=09iounmap(intr);=0A+=09=09printk(KERN=
_ERR "MPC52xx PIC: Unable to ioremap Bestcomm DMA controller registers!");=
=0A+=09=09goto end;=0A+=09}=0A+=0A+=09printk(KERN_INFO "MPC52xx PIC: MPC52x=
x PIC Remapped at 0x%8.8x\n", picnode_regoffset);=0A+=09printk(KERN_INFO "M=
PC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n", sdmanode_regoffset);=0A+=
=0A+=09/* Disable all interrupt sources. */=0A+=09out_be32(&sdma->IntPend, =
0xffffffff);=09/* 1 means clear pending */=0A+=09out_be32(&sdma->IntMask, 0=
xffffffff);=09/* 1 means disabled */=0A+=09out_be32(&intr->per_mask, 0x7fff=
fc00);=09/* 1 means disabled */=0A+=09out_be32(&intr->main_mask, 0x00010fff=
);=09/* 1 means disabled */=0A+=09intr_ctrl =3D in_be32(&intr->ctrl);=0A+=
=09intr_ctrl &=3D 0x00ff0000;=09/* Keeps IRQ[0-3] config */=0A+=09intr_ctrl=
 |=3D 0x0f000000 |=09/* clear IRQ 0-3 */=0A+=09    0x00001000 |=09/* MEE ma=
ster external enable */=0A+=09    0x00000000 |=09/* 0 means disable IRQ 0-3=
 */=0A+=09    0x00000001;=09=09/* CEb route critical normally */=0A+=09out_=
be32(&intr->ctrl, intr_ctrl);=0A+=0A+=09/* Zero a bunch of the priority set=
tings.  */=0A+=09out_be32(&intr->per_pri1, 0);=0A+=09out_be32(&intr->per_pr=
i2, 0);=0A+=09out_be32(&intr->per_pri3, 0);=0A+=09out_be32(&intr->main_pri1=
, 0);=0A+=09out_be32(&intr->main_pri2, 0);=0A+=0A+=09/*=0A+=09 * As last st=
ep, add an irq host to translate the real=0A+=09 * hw irq information provi=
ded by the ofw to linux virq=0A+=09 */=0A+=0A+=09mpc52xx_irqhost =3D=0A+=09=
    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,=0A+=09=
=09=09   &mpc52xx_irqhost_ops, -1);=0A+=0A+=09if (mpc52xx_irqhost) {=0A+=09=
=09mpc52xx_irqhost->host_data =3D picnode;=0A+=09=09printk(KERN_INFO "MPC52=
xx PIC is up and running!\n");=0A+=09} else {=0A+=09=09printk(KERN_ERR "MPC=
52xx PIC: Unable to allocate the IRQ host\n");=0A+=09}=0A+=0A+end:=0A+=09of=
_node_put(picnode);=0A+=09of_node_put(sdmanode);=0A+}=0A+=0A+/*=0A+ * get_i=
rq (public)=0A+*/=0A+unsigned int mpc52xx_get_irq(void)=0A+{=0A+=09u32 stat=
us;=0A+=09int irq =3D NO_IRQ_IGNORE;=0A+=0A+=09status =3D in_be32(&intr->en=
c_status);=0A+=09if (status & 0x00000400) {=09/* critical */=0A+=09=09irq =
=3D (status >> 8) & 0x3;=0A+=09=09if (irq =3D=3D 2)=09/* high priority peri=
pheral */=0A+=09=09=09goto peripheral;=0A+=09=09irq |=3D=0A+=09=09    (MPC5=
2xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &=0A+=09=09    MPC52xx_IRQ_L1_MAS=
K;=0A+=09} else if (status & 0x00200000) {=09/* main */=0A+=09=09irq =3D (s=
tatus >> 16) & 0x1f;=0A+=09=09if (irq =3D=3D 4)=09/* low priority periphera=
l */=0A+=09=09=09goto peripheral;=0A+=09=09irq |=3D=0A+=09=09    (MPC52xx_I=
RQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &=0A+=09=09    MPC52xx_IRQ_L1_MASK;=0A=
+=09} else if (status & 0x20000000) {=09/* peripheral */=0A+=09      periph=
eral:=0A+=09=09irq =3D (status >> 24) & 0x1f;=0A+=09=09if (irq =3D=3D 0) {=
=09/* bestcomm */=0A+=09=09=09status =3D in_be32(&sdma->IntPend);=0A+=09=09=
=09irq =3D ffs(status) - 1;=0A+=09=09=09irq |=3D=0A+=09=09=09    (MPC52xx_I=
RQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &=0A+=09=09=09    MPC52xx_IRQ_L1_MASK;=
=0A+=09=09} else=0A+=09=09=09irq |=3D=0A+=09=09=09    (MPC52xx_IRQ_L1_PERP =
<< MPC52xx_IRQ_L1_OFFSET) &=0A+=09=09=09    MPC52xx_IRQ_L1_MASK;=0A+=0A+=09=
}=0A+=0A+=09pr_debug("%s: irq=3D%x. virq=3D%d\n", __func__, irq,=0A+=09=09 =
irq_linear_revmap(mpc52xx_irqhost, irq));=0A+=0A+=09return irq_linear_revma=
p(mpc52xx_irqhost, irq);=0A+}=0A--- a/arch/powerpc/sysdev/Makefile=092006-1=
1-01 09:18:43.000000000 +0100=0A+++ b/arch/powerpc/sysdev/Makefile=092006-1=
1-06 11:10:46.000000000 +0100=0A@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)=09=
=09+=3D fsl_soc.o=0A obj-$(CONFIG_PPC_TODC)=09=09+=3D todc.o=0A obj-$(CONFI=
G_TSI108_BRIDGE)=09+=3D tsi108_pci.o tsi108_dev.o=0A obj-$(CONFIG_QUICC_ENG=
INE)=09+=3D qe_lib/=0A+obj-$(CONFIG_PPC_MPC52xx)=09+=3D mpc52xx_pic.o=0A =
=0A ifeq ($(CONFIG_PPC_MERGE),y)=0A obj-$(CONFIG_PPC_I8259)=09=09+=3D i8259=
.o=0A--- a/include/asm-powerpc/mpc52xx.h=091970-01-01 01:00:00.000000000 +0=
100=0A+++ b/include/asm-powerpc/mpc52xx.h=092006-11-06 11:10:29.000000000 +=
0100=0A@@ -0,0 +1,283 @@=0A+/*=0A+ * Prototypes, etc. for the Freescale MPC=
52xx embedded cpu chips=0A+ * May need to be cleaned as the port goes on ..=
.=0A+ *=0A+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>=0A+ *=
 Copyright (C) 2003 MontaVista, Software, Inc.=0A+ *=0A+ * This file is lic=
ensed under the terms of the GNU General Public License=0A+ * version 2. Th=
is program is licensed "as is" without any warranty of any=0A+ * kind, whet=
her express or implied.=0A+ */=0A+=0A+#ifndef __ASM_POWERPC_MPC52xx_H__=0A+=
#define __ASM_POWERPC_MPC52xx_H__=0A+=0A+#ifndef __ASSEMBLY__=0A+#include <=
asm/types.h>=0A+#include <asm/prom.h>=0A+#endif /* __ASSEMBLY__ */=0A+=0A+/=
* HW IRQ mapping */=0A+#define MPC52xx_IRQ_L1_CRIT=09(0)=0A+#define MPC52xx=
_IRQ_L1_MAIN=09(1)=0A+#define MPC52xx_IRQ_L1_PERP=09(2)=0A+#define MPC52xx_=
IRQ_L1_SDMA=09(3)=0A+=0A+#define MPC52xx_IRQ_L1_OFFSET   (6)=0A+#define MPC=
52xx_IRQ_L1_MASK     (0xc0)=0A+=0A+#define MPC52xx_IRQ_L2_OFFSET   (0)=0A+#=
define MPC52xx_IRQ_L2_MASK     (0x3f)=0A+=0A+#define MPC52xx_IRQ_HIGHTESTHW=
IRQ (0xd0)=0A+=0A+/* Interrupt controller Register set */=0A+struct mpc52xx=
_intr {=0A+=09u32 per_mask;=09=09/* INTR + 0x00 */=0A+=09u32 per_pri1;=09=
=09/* INTR + 0x04 */=0A+=09u32 per_pri2;=09=09/* INTR + 0x08 */=0A+=09u32 p=
er_pri3;=09=09/* INTR + 0x0c */=0A+=09u32 ctrl;=09=09/* INTR + 0x10 */=0A+=
=09u32 main_mask;=09=09/* INTR + 0x14 */=0A+=09u32 main_pri1;=09=09/* INTR =
+ 0x18 */=0A+=09u32 main_pri2;=09=09/* INTR + 0x1c */=0A+=09u32 reserved1;=
=09=09/* INTR + 0x20 */=0A+=09u32 enc_status;=09=09/* INTR + 0x24 */=0A+=09=
u32 crit_status;=09/* INTR + 0x28 */=0A+=09u32 main_status;=09/* INTR + 0x2=
c */=0A+=09u32 per_status;=09=09/* INTR + 0x30 */=0A+=09u32 reserved2;=09=
=09/* INTR + 0x34 */=0A+=09u32 per_error;=09=09/* INTR + 0x38 */=0A+};=0A+=
=0A+=0A+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D */=0A+/* Structures mapping of some unit register set                  =
           */=0A+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D */=0A+=0A+#ifndef __ASSEMBLY__=0A+=0A+/* Memory Mapping Contro=
l */=0A+struct mpc52xx_mmap_ctl {=0A+=09u32 mbar;=09=09/* MMAP_CTRL + 0x00 =
*/=0A+=0A+=09u32 cs0_start;=09=09/* MMAP_CTRL + 0x04 */=0A+=09u32 cs0_stop;=
=09=09/* MMAP_CTRL + 0x08 */=0A+=09u32 cs1_start;=09=09/* MMAP_CTRL + 0x0c =
*/=0A+=09u32 cs1_stop;=09=09/* MMAP_CTRL + 0x10 */=0A+=09u32 cs2_start;=09=
=09/* MMAP_CTRL + 0x14 */=0A+=09u32 cs2_stop;=09=09/* MMAP_CTRL + 0x18 */=
=0A+=09u32 cs3_start;=09=09/* MMAP_CTRL + 0x1c */=0A+=09u32 cs3_stop;=09=09=
/* MMAP_CTRL + 0x20 */=0A+=09u32 cs4_start;=09=09/* MMAP_CTRL + 0x24 */=0A+=
=09u32 cs4_stop;=09=09/* MMAP_CTRL + 0x28 */=0A+=09u32 cs5_start;=09=09/* M=
MAP_CTRL + 0x2c */=0A+=09u32 cs5_stop;=09=09/* MMAP_CTRL + 0x30 */=0A+=0A+=
=09u32 sdram0;=09=09/* MMAP_CTRL + 0x34 */=0A+=09u32 sdram1;=09=09/* MMAP_C=
TRL + 0X38 */=0A+=0A+=09u32 reserved[4];=09/* MMAP_CTRL + 0x3c .. 0x48 */=
=0A+=0A+=09u32 boot_start;=09=09/* MMAP_CTRL + 0x4c */=0A+=09u32 boot_stop;=
=09=09/* MMAP_CTRL + 0x50 */=0A+=0A+=09u32 ipbi_ws_ctrl;=09/* MMAP_CTRL + 0=
x54 */=0A+=0A+=09u32 cs6_start;=09=09/* MMAP_CTRL + 0x58 */=0A+=09u32 cs6_s=
top;=09=09/* MMAP_CTRL + 0x5c */=0A+=09u32 cs7_start;=09=09/* MMAP_CTRL + 0=
x60 */=0A+=09u32 cs7_stop;=09=09/* MMAP_CTRL + 0x64 */=0A+};=0A+=0A+/* SDRA=
M control */=0A+struct mpc52xx_sdram {=0A+=09u32 mode;=09=09/* SDRAM + 0x00=
 */=0A+=09u32 ctrl;=09=09/* SDRAM + 0x04 */=0A+=09u32 config1;=09=09/* SDRA=
M + 0x08 */=0A+=09u32 config2;=09=09/* SDRAM + 0x0c */=0A+};=0A+=0A+/* SDMA=
 */=0A+struct mpc52xx_sdma {=0A+=09u32 taskBar;=09=09/* SDMA + 0x00 */=0A+=
=09u32 currentPointer;=09/* SDMA + 0x04 */=0A+=09u32 endPointer;=09=09/* SD=
MA + 0x08 */=0A+=09u32 variablePointer;=09/* SDMA + 0x0c */=0A+=0A+=09u8 In=
tVect1;=09=09/* SDMA + 0x10 */=0A+=09u8 IntVect2;=09=09/* SDMA + 0x11 */=0A=
+=09u16 PtdCntrl;=09=09/* SDMA + 0x12 */=0A+=0A+=09u32 IntPend;=09=09/* SDM=
A + 0x14 */=0A+=09u32 IntMask;=09=09/* SDMA + 0x18 */=0A+=0A+=09u16 tcr[16]=
;=09=09/* SDMA + 0x1c .. 0x3a */=0A+=0A+=09u8 ipr[32];=09=09/* SDMA + 0x3c =
.. 0x5b */=0A+=0A+=09u32 cReqSelect;=09=09/* SDMA + 0x5c */=0A+=09u32 task_=
size0;=09=09/* SDMA + 0x60 */=0A+=09u32 task_size1;=09=09/* SDMA + 0x64 */=
=0A+=09u32 MDEDebug;=09=09/* SDMA + 0x68 */=0A+=09u32 ADSDebug;=09=09/* SDM=
A + 0x6c */=0A+=09u32 Value1;=09=09/* SDMA + 0x70 */=0A+=09u32 Value2;=09=
=09/* SDMA + 0x74 */=0A+=09u32 Control;=09=09/* SDMA + 0x78 */=0A+=09u32 St=
atus;=09=09/* SDMA + 0x7c */=0A+=09u32 PTDDebug;=09=09/* SDMA + 0x80 */=0A+=
};=0A+=0A+/* GPT */=0A+struct mpc52xx_gpt {=0A+=09u32 mode;=09=09/* GPTx + =
0x00 */=0A+=09u32 count;=09=09/* GPTx + 0x04 */=0A+=09u32 pwm;=09=09/* GPTx=
 + 0x08 */=0A+=09u32 status;=09=09/* GPTx + 0X0c */=0A+};=0A+=0A+/* GPIO */=
=0A+struct mpc52xx_gpio {=0A+=09u32 port_config;=09/* GPIO + 0x00 */=0A+=09=
u32 simple_gpioe;=09/* GPIO + 0x04 */=0A+=09u32 simple_ode;=09=09/* GPIO + =
0x08 */=0A+=09u32 simple_ddr;=09=09/* GPIO + 0x0c */=0A+=09u32 simple_dvo;=
=09=09/* GPIO + 0x10 */=0A+=09u32 simple_ival;=09/* GPIO + 0x14 */=0A+=09u8=
 outo_gpioe;=09=09/* GPIO + 0x18 */=0A+=09u8 reserved1[3];=09/* GPIO + 0x19=
 */=0A+=09u8 outo_dvo;=09=09/* GPIO + 0x1c */=0A+=09u8 reserved2[3];=09/* G=
PIO + 0x1d */=0A+=09u8 sint_gpioe;=09=09/* GPIO + 0x20 */=0A+=09u8 reserved=
3[3];=09/* GPIO + 0x21 */=0A+=09u8 sint_ode;=09=09/* GPIO + 0x24 */=0A+=09u=
8 reserved4[3];=09/* GPIO + 0x25 */=0A+=09u8 sint_ddr;=09=09/* GPIO + 0x28 =
*/=0A+=09u8 reserved5[3];=09/* GPIO + 0x29 */=0A+=09u8 sint_dvo;=09=09/* GP=
IO + 0x2c */=0A+=09u8 reserved6[3];=09/* GPIO + 0x2d */=0A+=09u8 sint_inten=
;=09=09/* GPIO + 0x30 */=0A+=09u8 reserved7[3];=09/* GPIO + 0x31 */=0A+=09u=
16 sint_itype;=09=09/* GPIO + 0x34 */=0A+=09u16 reserved8;=09=09/* GPIO + 0=
x36 */=0A+=09u8 gpio_control;=09/* GPIO + 0x38 */=0A+=09u8 reserved9[3];=09=
/* GPIO + 0x39 */=0A+=09u8 sint_istat;=09=09/* GPIO + 0x3c */=0A+=09u8 sint=
_ival;=09=09/* GPIO + 0x3d */=0A+=09u8 bus_errs;=09=09/* GPIO + 0x3e */=0A+=
=09u8 reserved10;=09=09/* GPIO + 0x3f */=0A+};=0A+=0A+#define MPC52xx_GPIO_=
PSC_CONFIG_UART_WITHOUT_CD=094=0A+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH=
_CD=095=0A+#define MPC52xx_GPIO_PCI_DIS=09=09=09(1<<15)=0A+=0A+/* GPIO with=
 WakeUp*/=0A+struct mpc52xx_gpio_wkup {=0A+=09u8 wkup_gpioe;=09=09/* GPIO_W=
KUP + 0x00 */=0A+=09u8 reserved1[3];=09/* GPIO_WKUP + 0x03 */=0A+=09u8 wkup=
_ode;=09=09/* GPIO_WKUP + 0x04 */=0A+=09u8 reserved2[3];=09/* GPIO_WKUP + 0=
x05 */=0A+=09u8 wkup_ddr;=09=09/* GPIO_WKUP + 0x08 */=0A+=09u8 reserved3[3]=
;=09/* GPIO_WKUP + 0x09 */=0A+=09u8 wkup_dvo;=09=09/* GPIO_WKUP + 0x0C */=
=0A+=09u8 reserved4[3];=09/* GPIO_WKUP + 0x0D */=0A+=09u8 wkup_inten;=09=09=
/* GPIO_WKUP + 0x10 */=0A+=09u8 reserved5[3];=09/* GPIO_WKUP + 0x11 */=0A+=
=09u8 wkup_iinten;=09=09/* GPIO_WKUP + 0x14 */=0A+=09u8 reserved6[3];=09/* =
GPIO_WKUP + 0x15 */=0A+=09u16 wkup_itype;=09=09/* GPIO_WKUP + 0x18 */=0A+=
=09u8 reserved7[2];=09/* GPIO_WKUP + 0x1A */=0A+=09u8 wkup_maste;=09=09/* G=
PIO_WKUP + 0x1C */=0A+=09u8 reserved8[3];=09/* GPIO_WKUP + 0x1D */=0A+=09u8=
 wkup_ival;=09=09/* GPIO_WKUP + 0x20 */=0A+=09u8 reserved9[3];=09/* GPIO_WK=
UP + 0x21 */=0A+=09u8 wkup_istat;=09=09/* GPIO_WKUP + 0x24 */=0A+=09u8 rese=
rved10[3];=09/* GPIO_WKUP + 0x25 */=0A+};=0A+=0A+/* XLB Bus control */=0A+s=
truct mpc52xx_xlb {=0A+=09u8 reserved[0x40];=0A+=09u32 config;=09=09/* XLB =
+ 0x40 */=0A+=09u32 version;=09=09/* XLB + 0x44 */=0A+=09u32 status;=09=09/=
* XLB + 0x48 */=0A+=09u32 int_enable;=09=09/* XLB + 0x4c */=0A+=09u32 addr_=
capture;=09/* XLB + 0x50 */=0A+=09u32 bus_sig_capture;=09/* XLB + 0x54 */=
=0A+=09u32 addr_timeout;=09/* XLB + 0x58 */=0A+=09u32 data_timeout;=09/* XL=
B + 0x5c */=0A+=09u32 bus_act_timeout;=09/* XLB + 0x60 */=0A+=09u32 master_=
pri_enable;=09/* XLB + 0x64 */=0A+=09u32 master_priority;=09/* XLB + 0x68 *=
/=0A+=09u32 base_address;=09/* XLB + 0x6c */=0A+=09u32 snoop_window;=09/* X=
LB + 0x70 */=0A+};=0A+=0A+#define MPC52xx_XLB_CFG_PLDIS=09=09(1 << 31)=0A+#=
define MPC52xx_XLB_CFG_SNOOP=09=09(1 << 15)=0A+=0A+/* Clock Distribution co=
ntrol */=0A+struct mpc52xx_cdm {=0A+=09u32 jtag_id;=09=09/* CDM + 0x00  reg=
0 read only */=0A+=09u32 rstcfg;=09=09/* CDM + 0x04  reg1 read only */=0A+=
=09u32 breadcrumb;=09=09/* CDM + 0x08  reg2 */=0A+=0A+=09u8 mem_clk_sel;=09=
=09/* CDM + 0x0c  reg3 byte0 */=0A+=09u8 xlb_clk_sel;=09=09/* CDM + 0x0d  r=
eg3 byte1 read only */=0A+=09u8 ipb_clk_sel;=09=09/* CDM + 0x0e  reg3 byte2=
 */=0A+=09u8 pci_clk_sel;=09=09/* CDM + 0x0f  reg3 byte3 */=0A+=0A+=09u8 ex=
t_48mhz_en;=09/* CDM + 0x10  reg4 byte0 */=0A+=09u8 fd_enable;=09=09/* CDM =
+ 0x11  reg4 byte1 */=0A+=09u16 fd_counters;=09/* CDM + 0x12  reg4 byte2,3 =
*/=0A+=0A+=09u32 clk_enables;=09/* CDM + 0x14  reg5 */=0A+=0A+=09u8 osc_dis=
able;=09=09/* CDM + 0x18  reg6 byte0 */=0A+=09u8 reserved0[3];=09/* CDM + 0=
x19  reg6 byte1,2,3 */=0A+=0A+=09u8 ccs_sleep_enable;=09/* CDM + 0x1c  reg7=
 byte0 */=0A+=09u8 osc_sleep_enable;=09/* CDM + 0x1d  reg7 byte1 */=0A+=09u=
8 reserved1;=09=09/* CDM + 0x1e  reg7 byte2 */=0A+=09u8 ccs_qreq_test;=09/*=
 CDM + 0x1f  reg7 byte3 */=0A+=0A+=09u8 soft_reset;=09=09/* CDM + 0x20  u8 =
byte0 */=0A+=09u8 no_ckstp;=09=09/* CDM + 0x21  u8 byte0 */=0A+=09u8 reserv=
ed2[2];=09/* CDM + 0x22  u8 byte1,2,3 */=0A+=0A+=09u8 pll_lock;=09=09/* CDM=
 + 0x24  reg9 byte0 */=0A+=09u8 pll_looselock;=09/* CDM + 0x25  reg9 byte1 =
*/=0A+=09u8 pll_sm_lockwin;=09/* CDM + 0x26  reg9 byte2 */=0A+=09u8 reserve=
d3;=09=09/* CDM + 0x27  reg9 byte3 */=0A+=0A+=09u16 reserved4;=09=09/* CDM =
+ 0x28  reg10 byte0,1 */=0A+=09u16 mclken_div_psc1;=09/* CDM + 0x2a  reg10 =
byte2,3 */=0A+=0A+=09u16 reserved5;=09=09/* CDM + 0x2c  reg11 byte0,1 */=0A=
+=09u16 mclken_div_psc2;=09/* CDM + 0x2e  reg11 byte2,3 */=0A+=0A+=09u16 re=
served6;=09=09/* CDM + 0x30  reg12 byte0,1 */=0A+=09u16 mclken_div_psc3;=09=
/* CDM + 0x32  reg12 byte2,3 */=0A+=0A+=09u16 reserved7;=09=09/* CDM + 0x34=
  reg13 byte0,1 */=0A+=09u16 mclken_div_psc6;=09/* CDM + 0x36  reg13 byte2,=
3 */=0A+};=0A+=0A+#endif /* __ASSEMBLY__ */=0A+=0A+=0A+/* =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */=0A+/* Prototypes =
for MPC52xx sysdev                                             */=0A+/* =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */=0A+=
=0A+#ifndef __ASSEMBLY__=0A+=0A+extern void mpc52xx_init_irq(void);=0A+exte=
rn unsigned int mpc52xx_get_irq(void);=0A+=0A+#endif /* __ASSEMBLY__ */=0A+=
=0A+#endif /* __ASM_POWERPC_MPC52xx_H__ */=0A+=0A=0A
--b_01_9f75f5759d3e0c1e1a66f10cd8bb73c4--
