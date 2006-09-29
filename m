Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] Cell interrupt rework (final)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 15:00:29 +1000
Message-Id: <1159506029.15792.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the cell iic interrupt handling so that:

 - Node ID is back in the interrupt number (only one IRQ host is created
for all nodes). This allows interrupts from sources on another node to
be routed non-locally. This will allow possibly one day to fix maxcpus=1
or 2 and still get interrupts from devices on BE 1. (A bit more fixing
is needed for that) and it will allow us to implement actual affinity
control of external interrupts.

 - Added handling of the IO exceptions interrupts (badly named, but I
re-used the name initially used by STI). Those are the interrupts
exposed by IIC_ISR and IIC_IRR, such as the IOC translation exception,
performance monitor, etc... Those get their special numbers in the IRQ
number space and are internally implemented as a cascade on unit 0xe,
class 1 of each node.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Hi Arnd !

It occurred to me that the version of the Cell interrupt rework I sent
you was still not the latest one ! In fact, I wasn't using the latest
one myself, only Jeremy was :) I messed up with my patch handling
locally. The result is that the version you have is causing occasional
loss of interrupts, typically the case where IDE disappears after
loading the SPUs a bit.

This is the real latest version that works and that survives parallel
SPU torture and hard disk activity. The problem was that unexepcted
interrupts wouldn't be ack'ed (the priority register wouldn't be put
back to 0xff). The bug was in the original code but it would somewhat
recover after some fairly high latency by getting some even higher
priority interrupt since it's eoi would unconditionally set back the
priority to 0xff. The new code implements a nice prio stack however, and
thus ends up with the priority never going back down.

Paulus: please merge upstream too.

Index: linux-cell/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/interrupt.c	2006-09-08 17:17:10.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/interrupt.c	2006-09-29 14:36:23.000000000 +1000
@@ -21,6 +21,12 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * TODO:
+ * - Fix various assumptions related to HW CPU numbers vs. linux CPU numbers
+ *   vs node numbers in the setup code
+ * - Implement proper handling of maxcpus=1/2 (that is, routing of irqs from
+ *   a non-active node to the active node)
  */
 
 #include <linux/interrupt.h>
@@ -44,24 +50,25 @@ struct iic {
 	u8 target_id;
 	u8 eoi_stack[16];
 	int eoi_ptr;
-	struct irq_host *host;
+	struct device_node *node;
 };
 
 static DEFINE_PER_CPU(struct iic, iic);
 #define IIC_NODE_COUNT	2
-static struct irq_host *iic_hosts[IIC_NODE_COUNT];
+static struct irq_host *iic_host;
 
 /* Convert between "pending" bits and hw irq number */
 static irq_hw_number_t iic_pending_to_hwnum(struct cbe_iic_pending_bits bits)
 {
 	unsigned char unit = bits.source & 0xf;
+	unsigned char node = bits.source >> 4;
+	unsigned char class = bits.class & 3;
 
+	/* Decode IPIs */
 	if (bits.flags & CBE_IIC_IRQ_IPI)
-		return IIC_IRQ_IPI0 | (bits.prio >> 4);
-	else if (bits.class <= 3)
-		return (bits.class << 4) | unit;
+		return IIC_IRQ_TYPE_IPI | (bits.prio >> 4);
 	else
-		return IIC_IRQ_INVALID;
+		return (node << IIC_IRQ_NODE_SHIFT) | (class << 4) | unit;
 }
 
 static void iic_mask(unsigned int irq)
@@ -86,21 +93,70 @@ static struct irq_chip iic_chip = {
 	.eoi = iic_eoi,
 };
 
+
+static void iic_ioexc_eoi(unsigned int irq)
+{
+}
+
+static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc,
+			    struct pt_regs *regs)
+{
+	struct cbe_iic_regs *node_iic = desc->handler_data;
+	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
+	unsigned long bits, ack;
+	int cascade;
+
+	for (;;) {
+		bits = in_be64(&node_iic->iic_is);
+		if (bits == 0)
+			break;
+		/* pre-ack edge interrupts */
+		ack = bits & IIC_ISR_EDGE_MASK;
+		if (ack)
+			out_be64(&node_iic->iic_is, ack);
+		/* handle them */
+		for (cascade = 63; cascade >= 0; cascade--)
+			if (bits & (0x8000000000000000UL >> cascade)) {
+				unsigned int cirq =
+					irq_linear_revmap(iic_host,
+							  base | cascade);
+				if (cirq != NO_IRQ)
+					generic_handle_irq(cirq, regs);
+			}
+		/* post-ack level interrupts */
+		ack = bits & ~IIC_ISR_EDGE_MASK;
+		if (ack)
+			out_be64(&node_iic->iic_is, ack);
+	}
+	desc->chip->eoi(irq);
+}
+
+
+static struct irq_chip iic_ioexc_chip = {
+	.typename = " CELL-IOEX",
+	.mask = iic_mask,
+	.unmask = iic_unmask,
+	.eoi = iic_ioexc_eoi,
+};
+
 /* Get an IRQ number from the pending state register of the IIC */
 static unsigned int iic_get_irq(struct pt_regs *regs)
 {
   	struct cbe_iic_pending_bits pending;
  	struct iic *iic;
+	unsigned int virq;
 
  	iic = &__get_cpu_var(iic);
  	*(unsigned long *) &pending =
  		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
+	if (!(pending.flags & CBE_IIC_IRQ_VALID))
+		return NO_IRQ;
+	virq = irq_linear_revmap(iic_host, iic_pending_to_hwnum(pending));
+	if (virq == NO_IRQ)
+		return NO_IRQ;
  	iic->eoi_stack[++iic->eoi_ptr] = pending.prio;
  	BUG_ON(iic->eoi_ptr > 15);
-	if (pending.flags & CBE_IIC_IRQ_VALID)
-		return irq_linear_revmap(iic->host,
- 					 iic_pending_to_hwnum(pending));
-	return NO_IRQ;
+	return virq;
 }
 
 #ifdef CONFIG_SMP
@@ -108,12 +164,7 @@ static unsigned int iic_get_irq(struct p
 /* Use the highest interrupt priorities for IPI */
 static inline int iic_ipi_to_irq(int ipi)
 {
-	return IIC_IRQ_IPI0 + IIC_NUM_IPIS - 1 - ipi;
-}
-
-static inline int iic_irq_to_ipi(int irq)
-{
-	return IIC_NUM_IPIS - 1 - (irq - IIC_IRQ_IPI0);
+	return IIC_IRQ_TYPE_IPI + 0xf - ipi;
 }
 
 void iic_setup_cpu(void)
@@ -123,7 +174,7 @@ void iic_setup_cpu(void)
 
 void iic_cause_IPI(int cpu, int mesg)
 {
-	out_be64(&per_cpu(iic, cpu).regs->generate, (IIC_NUM_IPIS - 1 - mesg) << 4);
+	out_be64(&per_cpu(iic, cpu).regs->generate, (0xf - mesg) << 4);
 }
 
 u8 iic_get_target_id(int cpu)
@@ -134,9 +185,7 @@ EXPORT_SYMBOL_GPL(iic_get_target_id);
 
 struct irq_host *iic_get_irq_host(int node)
 {
-	if (node < 0 || node >= IIC_NODE_COUNT)
-		return NULL;
-	return iic_hosts[node];
+	return iic_host;
 }
 EXPORT_SYMBOL_GPL(iic_get_irq_host);
 
@@ -149,34 +198,20 @@ static irqreturn_t iic_ipi_action(int ir
 
 	return IRQ_HANDLED;
 }
-
 static void iic_request_ipi(int ipi, const char *name)
 {
-	int node, virq;
+	int virq;
 
-	for (node = 0; node < IIC_NODE_COUNT; node++) {
-		char *rname;
-		if (iic_hosts[node] == NULL)
-			continue;
-		virq = irq_create_mapping(iic_hosts[node],
-					  iic_ipi_to_irq(ipi));
-		if (virq == NO_IRQ) {
-			printk(KERN_ERR
-			       "iic: failed to map IPI %s on node %d\n",
-			       name, node);
-			continue;
-		}
-		rname = kzalloc(strlen(name) + 16, GFP_KERNEL);
-		if (rname)
-			sprintf(rname, "%s node %d", name, node);
-		else
-			rname = (char *)name;
-		if (request_irq(virq, iic_ipi_action, IRQF_DISABLED,
-				rname, (void *)(long)ipi))
-			printk(KERN_ERR
-			       "iic: failed to request IPI %s on node %d\n",
-			       name, node);
+	virq = irq_create_mapping(iic_host, iic_ipi_to_irq(ipi));
+	if (virq == NO_IRQ) {
+		printk(KERN_ERR
+		       "iic: failed to map IPI %s\n", name);
+		return;
 	}
+	if (request_irq(virq, iic_ipi_action, IRQF_DISABLED, name,
+			(void *)(long)ipi))
+		printk(KERN_ERR
+		       "iic: failed to request IPI %s\n", name);
 }
 
 void iic_request_IPIs(void)
@@ -193,16 +228,24 @@ void iic_request_IPIs(void)
 
 static int iic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return h->host_data != NULL && node == h->host_data;
+	return device_is_compatible(node,
+				    "IBM,CBEA-Internal-Interrupt-Controller");
 }
 
 static int iic_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
-	if (hw < IIC_IRQ_IPI0)
-		set_irq_chip_and_handler(virq, &iic_chip, handle_fasteoi_irq);
-	else
+	switch (hw & IIC_IRQ_TYPE_MASK) {
+	case IIC_IRQ_TYPE_IPI:
 		set_irq_chip_and_handler(virq, &iic_chip, handle_percpu_irq);
+		break;
+	case IIC_IRQ_TYPE_IOEXC:
+		set_irq_chip_and_handler(virq, &iic_ioexc_chip,
+					 handle_fasteoi_irq);
+		break;
+	default:
+		set_irq_chip_and_handler(virq, &iic_chip, handle_fasteoi_irq);
+	}
 	return 0;
 }
 
@@ -211,11 +254,39 @@ static int iic_host_xlate(struct irq_hos
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 
 {
-	/* Currently, we don't translate anything. That needs to be fixed as
-	 * we get better defined device-trees. iic interrupts have to be
-	 * explicitely mapped by whoever needs them
-	 */
-	return -ENODEV;
+	unsigned int node, ext, unit, class;
+	const u32 *val;
+
+	if (!device_is_compatible(ct,
+				     "IBM,CBEA-Internal-Interrupt-Controller"))
+		return -ENODEV;
+	if (intsize != 1)
+		return -ENODEV;
+	val = get_property(ct, "#interrupt-cells", NULL);
+	if (val == NULL || *val != 1)
+		return -ENODEV;
+
+	node = intspec[0] >> 24;
+	ext = (intspec[0] >> 16) & 0xff;
+	class = (intspec[0] >> 8) & 0xff;
+	unit = intspec[0] & 0xff;
+
+	/* Check if node is in supported range */
+	if (node > 1)
+		return -EINVAL;
+
+	/* Build up interrupt number, special case for IO exceptions */
+	*out_hwirq = (node << IIC_IRQ_NODE_SHIFT);
+	if (unit == IIC_UNIT_IIC && class == 1)
+		*out_hwirq |= IIC_IRQ_TYPE_IOEXC | ext;
+	else
+		*out_hwirq |= IIC_IRQ_TYPE_NORMAL |
+			(class << IIC_IRQ_CLASS_SHIFT) | unit;
+
+	/* Dummy flags, ignored by iic code */
+	*out_flags = IRQ_TYPE_EDGE_RISING;
+
+	return 0;
 }
 
 static struct irq_host_ops iic_host_ops = {
@@ -225,7 +296,7 @@ static struct irq_host_ops iic_host_ops 
 };
 
 static void __init init_one_iic(unsigned int hw_cpu, unsigned long addr,
-				struct irq_host *host)
+				struct device_node *node)
 {
 	/* XXX FIXME: should locate the linux CPU number from the HW cpu
 	 * number properly. We are lucky for now
@@ -237,28 +308,27 @@ static void __init init_one_iic(unsigned
 
 	iic->target_id = ((hw_cpu & 2) << 3) | ((hw_cpu & 1) ? 0xf : 0xe);
 	iic->eoi_stack[0] = 0xff;
-	iic->host = host;
+	iic->node = of_node_get(node);
 	out_be64(&iic->regs->prio, 0);
 
-	printk(KERN_INFO "IIC for CPU %d at %lx mapped to %p, target id 0x%x\n",
-	       hw_cpu, addr, iic->regs, iic->target_id);
+	printk(KERN_INFO "IIC for CPU %d target id 0x%x : %s\n",
+	       hw_cpu, iic->target_id, node->full_name);
 }
 
 static int __init setup_iic(void)
 {
 	struct device_node *dn;
 	struct resource r0, r1;
-	struct irq_host *host;
-	int found = 0;
- 	u32 *np;
+	unsigned int node, cascade, found = 0;
+	struct cbe_iic_regs *node_iic;
+ 	const u32 *np;
 
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn,"interrupt-controller")) != NULL;) {
 		if (!device_is_compatible(dn,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 			continue;
- 		np = (u32 *)get_property(dn, "ibm,interrupt-server-ranges",
-					 NULL);
+ 		np = get_property(dn, "ibm,interrupt-server-ranges", NULL);
  		if (np == NULL) {
 			printk(KERN_WARNING "IIC: CPU association not found\n");
 			of_node_put(dn);
@@ -270,19 +340,33 @@ static int __init setup_iic(void)
 			of_node_put(dn);
 			return -ENODEV;
 		}
-		host = NULL;
-		if (found < IIC_NODE_COUNT) {
-			host = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
-					      IIC_SOURCE_COUNT,
-					      &iic_host_ops,
-					      IIC_IRQ_INVALID);
-			iic_hosts[found] = host;
-			BUG_ON(iic_hosts[found] == NULL);
-			iic_hosts[found]->host_data = of_node_get(dn);
-			found++;
-		}
-		init_one_iic(np[0], r0.start, host);
-		init_one_iic(np[1], r1.start, host);
+		found++;
+		init_one_iic(np[0], r0.start, dn);
+		init_one_iic(np[1], r1.start, dn);
+
+		/* Setup cascade for IO exceptions. XXX cleanup tricks to get
+		 * node vs CPU etc...
+		 * Note that we configure the IIC_IRR here with a hard coded
+		 * priority of 1. We might want to improve that later.
+		 */
+		node = np[0] >> 1;
+		node_iic = cbe_get_cpu_iic_regs(np[0]);
+		cascade = node << IIC_IRQ_NODE_SHIFT;
+		cascade |= 1 << IIC_IRQ_CLASS_SHIFT;
+		cascade |= IIC_UNIT_IIC;
+		cascade = irq_create_mapping(iic_host, cascade);
+		if (cascade == NO_IRQ)
+			continue;
+		set_irq_data(cascade, node_iic);
+		set_irq_chained_handler(cascade , iic_ioexc_cascade);
+		out_be64(&node_iic->iic_ir,
+			 (1 << 12)		/* priority */ |
+			 (node << 4)		/* dest node */ |
+			 IIC_UNIT_THREAD_0	/* route them to thread 0 */);
+		/* Flush pending (make sure it triggers if there is
+		 * anything pending
+		 */
+		out_be64(&node_iic->iic_is, 0xfffffffffffffffful);
 	}
 
 	if (found)
@@ -293,6 +377,12 @@ static int __init setup_iic(void)
 
 void __init iic_init_IRQ(void)
 {
+	/* Setup an irq host data structure */
+	iic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, IIC_SOURCE_COUNT,
+				  &iic_host_ops, IIC_IRQ_INVALID);
+	BUG_ON(iic_host == NULL);
+	irq_set_default_host(iic_host);
+
 	/* Discover and initialize iics */
 	if (setup_iic() < 0)
 		panic("IIC: Failed to initialize !\n");
Index: linux-cell/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/interrupt.h	2006-09-08 17:17:10.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/interrupt.h	2006-09-22 12:56:14.000000000 +1000
@@ -2,48 +2,76 @@
 #define ASM_CELL_PIC_H
 #ifdef __KERNEL__
 /*
- * Mapping of IIC pending bits into per-node
- * interrupt numbers.
+ * Mapping of IIC pending bits into per-node interrupt numbers.
  *
- * IRQ     FF CC SS PP   FF CC SS PP	Description
+ * Interrupt numbers are in the range 0...0x1ff where the top bit
+ * (0x100) represent the source node. Only 2 nodes are supported with
+ * the current code though it's trivial to extend that if necessary using
+ * higher level bits
  *
- * 00-3f   80 02 +0 00 - 80 02 +0 3f	South Bridge
- * 00-3f   80 02 +b 00 - 80 02 +b 3f	South Bridge
- * 41-4a   80 00 +1 ** - 80 00 +a **	SPU Class 0
- * 51-5a   80 01 +1 ** - 80 01 +a **	SPU Class 1
- * 61-6a   80 02 +1 ** - 80 02 +a **	SPU Class 2
- * 70-7f   C0 ** ** 00 - C0 ** ** 0f	IPI
+ * The bottom 8 bits are split into 2 type bits and 6 data bits that
+ * depend on the type:
  *
- *    F flags
- *    C class
- *    S source
- *    P Priority
- *    + node number
- *    * don't care
+ * 00 (0x00 | data) : normal interrupt. data is (class << 4) | source
+ * 01 (0x40 | data) : IO exception. data is the exception number as
+ *                    defined by bit numbers in IIC_SR
+ * 10 (0x80 | data) : IPI. data is the IPI number (obtained from the priority)
+ *                    and node is always 0 (IPIs are per-cpu, their source is
+ *                    not relevant)
+ * 11 (0xc0 | data) : reserved
  *
- * A node consists of a Cell Broadband Engine and an optional
- * south bridge device providing a maximum of 64 IRQs.
- * The south bridge may be connected to either IOIF0
- * or IOIF1.
- * Each SPE is represented as three IRQ lines, one per
- * interrupt class.
- * 16 IRQ numbers are reserved for inter processor
- * interruptions, although these are only used in the
- * range of the first node.
+ * In addition, interrupt number 0x80000000 is defined as always invalid
+ * (that is the node field is expected to never extend to move than 23 bits)
  *
- * This scheme needs 128 IRQ numbers per BIF node ID,
- * which means that with the total of 512 lines
- * available, we can have a maximum of four nodes.
  */
 
 enum {
-	IIC_IRQ_INVALID		= 0xff,
-	IIC_IRQ_MAX		= 0x3f,
-	IIC_IRQ_EXT_IOIF0	= 0x20,
-	IIC_IRQ_EXT_IOIF1	= 0x2b,
-	IIC_IRQ_IPI0		= 0x40,
-	IIC_NUM_IPIS    	= 0x10, /* IRQs reserved for IPI */
-	IIC_SOURCE_COUNT	= 0x50,
+	IIC_IRQ_INVALID		= 0x80000000u,
+	IIC_IRQ_NODE_MASK	= 0x100,
+	IIC_IRQ_NODE_SHIFT	= 8,
+	IIC_IRQ_MAX		= 0x1ff,
+	IIC_IRQ_TYPE_MASK	= 0xc0,
+	IIC_IRQ_TYPE_NORMAL	= 0x00,
+	IIC_IRQ_TYPE_IOEXC	= 0x40,
+	IIC_IRQ_TYPE_IPI	= 0x80,
+	IIC_IRQ_CLASS_SHIFT	= 4,
+	IIC_IRQ_CLASS_0		= 0x00,
+	IIC_IRQ_CLASS_1		= 0x10,
+	IIC_IRQ_CLASS_2		= 0x20,
+	IIC_SOURCE_COUNT	= 0x200,
+
+	/* Here are defined the various source/dest units. Avoid using those
+	 * definitions if you can, they are mostly here for reference
+	 */
+	IIC_UNIT_SPU_0		= 0x4,
+	IIC_UNIT_SPU_1		= 0x7,
+	IIC_UNIT_SPU_2		= 0x3,
+	IIC_UNIT_SPU_3		= 0x8,
+	IIC_UNIT_SPU_4		= 0x2,
+	IIC_UNIT_SPU_5		= 0x9,
+	IIC_UNIT_SPU_6		= 0x1,
+	IIC_UNIT_SPU_7		= 0xa,
+	IIC_UNIT_IOC_0		= 0x0,
+	IIC_UNIT_IOC_1		= 0xb,
+	IIC_UNIT_THREAD_0	= 0xe, /* target only */
+	IIC_UNIT_THREAD_1	= 0xf, /* target only */
+	IIC_UNIT_IIC		= 0xe, /* source only (IO exceptions) */
+
+	/* Base numbers for the external interrupts */
+	IIC_IRQ_EXT_IOIF0	=
+		IIC_IRQ_TYPE_NORMAL | IIC_IRQ_CLASS_2 | IIC_UNIT_IOC_0,
+	IIC_IRQ_EXT_IOIF1	=
+		IIC_IRQ_TYPE_NORMAL | IIC_IRQ_CLASS_2 | IIC_UNIT_IOC_1,
+
+	/* Base numbers for the IIC_ISR interrupts */
+	IIC_IRQ_IOEX_TMI	= IIC_IRQ_TYPE_IOEXC | IIC_IRQ_CLASS_1 | 63,
+	IIC_IRQ_IOEX_PMI	= IIC_IRQ_TYPE_IOEXC | IIC_IRQ_CLASS_1 | 62,
+	IIC_IRQ_IOEX_ATI	= IIC_IRQ_TYPE_IOEXC | IIC_IRQ_CLASS_1 | 61,
+	IIC_IRQ_IOEX_MATBFI	= IIC_IRQ_TYPE_IOEXC | IIC_IRQ_CLASS_1 | 60,
+	IIC_IRQ_IOEX_ELDI	= IIC_IRQ_TYPE_IOEXC | IIC_IRQ_CLASS_1 | 59,
+
+	/* Which bits in IIC_ISR are edge sensitive */
+	IIC_ISR_EDGE_MASK	= 0x4ul,
 };
 
 extern void iic_init_IRQ(void);
@@ -52,7 +80,6 @@ extern void iic_request_IPIs(void);
 extern void iic_setup_cpu(void);
 
 extern u8 iic_get_target_id(int cpu);
-extern struct irq_host *iic_get_irq_host(int node);
 
 extern void spider_init_IRQ(void);
 
Index: linux-cell/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spider-pic.c	2006-09-08 17:17:10.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spider-pic.c	2006-09-29 14:37:00.000000000 +1000
@@ -240,10 +240,9 @@ static void spider_irq_cascade(unsigned 
 static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 {
 	unsigned int virq;
-	u32 *imap, *tmp;
+	const u32 *imap, *tmp;
 	int imaplen, intsize, unit;
 	struct device_node *iic;
-	struct irq_host *iic_host;
 
 #if 0 /* Enable that when we have a way to retreive the node as well */
 	/* First, we check wether we have a real "interrupts" in the device
@@ -258,25 +257,25 @@ static unsigned int __init spider_find_c
 #endif
 
 	/* Now do the horrible hacks */
-	tmp = (u32 *)get_property(pic->of_node, "#interrupt-cells", NULL);
+	tmp = get_property(pic->of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
-	imap = (u32 *)get_property(pic->of_node, "interrupt-map", &imaplen);
+	imap = get_property(pic->of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
 		return NO_IRQ;
 	iic = of_find_node_by_phandle(imap[intsize]);
 	if (iic == NULL)
 		return NO_IRQ;
 	imap += intsize + 1;
-	tmp = (u32 *)get_property(iic, "#interrupt-cells", NULL);
+	tmp = get_property(iic, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
 	/* Assume unit is last entry of interrupt specifier */
 	unit = imap[intsize - 1];
 	/* Ok, we have a unit, now let's try to get the node */
-	tmp = (u32 *)get_property(iic, "ibm,interrupt-server-ranges", NULL);
+	tmp = get_property(iic, "ibm,interrupt-server-ranges", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
 		return NO_IRQ;
@@ -289,11 +288,11 @@ static unsigned int __init spider_find_c
 	 * the iic host from the iic OF node, but that way I'm still compatible
 	 * with really really old old firmwares for which we don't have a node
 	 */
-	iic_host = iic_get_irq_host(pic->node_id);
-	if (iic_host == NULL)
-		return NO_IRQ;
 	/* Manufacture an IIC interrupt number of class 2 */
-	virq = irq_create_mapping(iic_host, 0x20 | unit);
+	virq = irq_create_mapping(NULL,
+				  (pic->node_id << IIC_IRQ_NODE_SHIFT) |
+				  (2 << IIC_IRQ_CLASS_SHIFT) |
+				  unit);
 	if (virq == NO_IRQ)
 		printk(KERN_ERR "spider_pic: failed to map cascade !");
 	return virq;
Index: linux-cell/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_base.c	2006-09-08 17:17:10.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spu_base.c	2006-09-22 12:56:14.000000000 +1000
@@ -568,24 +568,23 @@ static void spu_unmap(struct spu *spu)
 /* This function shall be abstracted for HV platforms */
 static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
 {
-	struct irq_host *host;
 	unsigned int isrc;
 	u32 *tmp;
 
-	host = iic_get_irq_host(spu->node);
-	if (host == NULL)
-		return -ENODEV;
-
-	/* Get the interrupt source from the device-tree */
+	/* Get the interrupt source unit from the device-tree */
 	tmp = (u32 *)get_property(np, "isrc", NULL);
 	if (!tmp)
 		return -ENODEV;
-	spu->isrc = isrc = tmp[0];
+	isrc = tmp[0];
+
+	/* Add the node number */
+	isrc |= spu->node << IIC_IRQ_NODE_SHIFT;
+	spu->isrc = isrc;
 
 	/* Now map interrupts of all 3 classes */
-	spu->irqs[0] = irq_create_mapping(host, 0x00 | isrc);
-	spu->irqs[1] = irq_create_mapping(host, 0x10 | isrc);
-	spu->irqs[2] = irq_create_mapping(host, 0x20 | isrc);
+	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
+	spu->irqs[1] = irq_create_mapping(NULL, IIC_IRQ_CLASS_1 | isrc);
+	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
 
 	/* Right now, we only fail if class 2 failed */
 	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
