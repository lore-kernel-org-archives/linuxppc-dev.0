Date: Fri, 7 Jun 2002 18:31:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@samba.org, Paul Mackerras <paulus@samba.org>
Subject: More OCP cleanups
Message-ID: <20020607083146.GN2630@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok, never mind that last OCP change I sent you, this patch obsoletes
it.  This cleans up a bunch of functions in ocp.c and removes some
unused cruft from ocp.h.

More importantly though, it replaces the irq_resources field of struct
ocp_dev with a simple integer irq field.  The only thing that ever
used the irq_resources field to store more than a single irq was the
EMAC, and it required special cases all over the place anyway.

The next step is to get rid of irq_resources entirely, since its use
for the EMAC is a horrible abstraction violation.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp.c linux-grinch/arch/ppc/kernel/ocp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp.c	Wed May 29 10:05:14 2002
+++ linux-grinch/arch/ppc/kernel/ocp.c	Fri Jun  7 18:20:02 2002
@@ -126,19 +126,14 @@

 	for (i = 0; core_ocp[i].type != OCP_NULL_TYPE; i++) {
 		if (type == core_ocp[i].type) {
-			if (dev_num > a) {
-				a++;
-			} else {
-				break;
-			}
+			if (a == dev_num)
+				return core_ocp[i].irq;
+
+			a++;
 		}
 	}

-	if (a > (ocp_get_max(type) - 1)) {
-		return(OCP_IRQ_NA);
-	} else {
-		return(core_ocp[i].irq);
-	}
+	return OCP_IRQ_NA;
 }

 /**
@@ -157,19 +152,14 @@

 	for (i = 0; core_ocp[i].type != OCP_NULL_TYPE; i++) {
 		if (type == core_ocp[i].type) {
-			if (dev_num > a) {
-				a++;
-			} else {
-				break;
-			}
+			if (a == dev_num)
+				return core_ocp[i].paddr;
+
+			a++;
 		}
 	}

-	if (a > (ocp_get_max(type) - 1)) {
-		return 0x0;
-	} else {
-		return ((unsigned long) core_ocp[i].paddr);
-	}
+	return 0;
 }


@@ -180,57 +170,47 @@
 	int a, i;
 	a = 0;

+	strcpy(ocp->name,ocp_type_info[ocp->type].name);
+
 	for (i = 0; core_ocp[i].type != OCP_NULL_TYPE; i++) {
 		if (ocp->type == core_ocp[i].type) {
-			if (ocp->num > a) {
-				a++;
-			} else {
-				break;
+			if (a == ocp->num) {
+				ocp->paddr = core_ocp[i].paddr;
+				ocp->irq = core_ocp[i].irq;
+				return 1;
 			}
+
+			a++;
 		}
 	}

-	strcpy(ocp->name,ocp_type_info[ocp->type].name);
-
-	if (a > (ocp_get_max(ocp->type) - 1)) {
-		ocp->paddr = 0x0;
-		ocp->irq_resource[0][0].irq = OCP_IRQ_NA;
-		return 0;
-	} else {
-		ocp->paddr = core_ocp[i].paddr;
-		ocp->irq_resource[0][0].irq = core_ocp[i].irq;
-	}
-	return 1;
+	ocp->paddr = 0;
+	ocp->irq = OCP_IRQ_NA;
+	return 0;
 }

 /**
- * ocp_get_numtypes - This determines how many "ocp type's" are
+ * ocp_get_numtypes - This determines how many OCP devices of a given
+ * type are registered.
  * registered
  * @type: OCP type such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
  *
- * The routine returns number of types are registered or -ENXIO when
- * no type is registered
+ * The routine returns number of devices registered of the given type.
  */
-int
+static int
 ocp_get_numtypes(int type)
 {
-	int count, max;
+	int count = 0;
 	struct ocp_dev *ocp;
 	struct list_head *ocp_l;

-	count = 0;
-	max = ocp_get_max(type);
-
-	for (ocp_l = ocp_list.next; ocp_l != &ocp_list; ocp_l = ocp_l->next) {
+	list_for_each(ocp_l, &ocp_list) {
 		ocp = list_entry(ocp_l, struct ocp_dev, ocp_list);
 		if (type == ocp->type)
 			count++;
-		if (count > max)
-			return -ENXIO;
 	}

-	return (count);
-
+	return count;
 }

 /**
@@ -297,17 +277,18 @@
 int
 ocp_register(struct ocp_dev *drv)
 {
-	int index;
-	int count = 0;
+	int max;
+
+	max = ocp_get_max(drv->type);

 	list_add(&drv->ocp_list, &ocp_list);

-	if ((count = ocp_get_numtypes(drv->type)) < 0) {
+	drv->num = ocp_get_numtypes(drv->type) - 1;
+	if (drv->num >= max) {
 		list_del(&drv->ocp_list);
 		return -ENXIO;
 	}

-	drv->num = count - 1;
 	if (!ocp_set_dev(drv)) {
 		list_del(&drv->ocp_list);
 		return -ENXIO;
@@ -318,7 +299,7 @@
 #endif
 #ifdef OCP_DEBUG
 	printk("Dev: %s Num:%d @ paddr:0x%x irq:%d\n", drv->name, drv->num,
-	       drv->paddr, drv->irq_resource[0][0].irq);
+	       drv->paddr, drv->irq);
 #endif
 	return (drv->num);
 }
@@ -356,26 +337,22 @@
 {
 	struct ocp_dev *ocp;
 	struct list_head *ocp_l;
-	int max;
 	int count = 0;
-	if ((max = ocp_get_numtypes(type)) > 0)
-		for (ocp_l = ocp_list.next;
-		     (count < max) && (ocp_l != &ocp_list);
-		     ocp_l = ocp_l->next) {
-			ocp = list_entry(ocp_l, struct ocp_dev, ocp_list);
-			if (type == ocp->type) {
-				if (dev_num == count)
-					return ocp;
-				count++;
-			}
+
+	list_for_each(ocp_l, &ocp_list) {
+		ocp = list_entry(ocp_l, struct ocp_dev, ocp_list);
+		if (type == ocp->type) {
+			if (dev_num == count)
+				return ocp;
+			count++;
 		}
+	}
 	return NULL;
 }

 EXPORT_SYMBOL(ocp_get_irq);
 EXPORT_SYMBOL(ocp_get_paddr);
 EXPORT_SYMBOL(ocp_get_max);
-EXPORT_SYMBOL(ocp_get_numtypes);
 EXPORT_SYMBOL(ocp_get_dev);
 EXPORT_SYMBOL(ocp_alloc_dev);
 EXPORT_SYMBOL(ocp_free_dev);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_proc.c linux-grinch/arch/ppc/kernel/ocp_proc.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_proc.c	Fri May 31 09:49:15 2002
+++ linux-grinch/arch/ppc/kernel/ocp_proc.c	Fri Jun  7 17:53:52 2002
@@ -50,6 +50,7 @@
 #include <asm/byteorder.h>
 #include <asm/ocp.h>
 extern struct type_info ocp_type_info[];
+extern struct irq_resources irq_resource[][OCP_MAX_IRQS];

 /* iterator */
 static void *
@@ -91,33 +92,21 @@

 	drv = ocp_dev_g(p);
 	seq_printf(m, "%s\t %02d", drv->name, drv->num);
-	switch (drv->type) {
-	case UART:
-	case IDE:
-	case USB:
-	case IIC:
-		seq_printf(m, " %02d", drv->irq_resource[0][0].irq);
-		break;
-	case GPIO:
-	case ZMII:
-		/* no IRQ */
-		seq_printf(m, " N/A");
-		break;
-	case EMAC:
-
+	if (drv->type == EMAC) {
 		for (i = 0; i < OCP_MAX_IRQS; i++) {
 			seq_printf(m, " %02d",
-				   drv->irq_resource[drv->num][i].irq);
+				   irq_resource[drv->num][i].irq);
 		}
-
-		break;
-	default:
-		seq_printf(m, " %02d", drv->irq_resource[0][0].irq);
+	} else if (drv->irq != OCP_IRQ_NA) {
+		seq_printf(m, " %02d", drv->irq);
+	} else {
+		/* no IRQ */
+		seq_printf(m, " N/A");
 	}

 	seq_printf(m, " %8.8lx", drv->paddr);
 	if (drv->vaddr)
-		seq_printf(m, " %8.8lx", drv->vaddr);
+		seq_printf(m, " %p", drv->vaddr);
 	else
 		seq_printf(m, " N/A");
 	seq_putc(m, '\n');
@@ -147,33 +136,22 @@
 	drv = ocp_dev_g(p);
 	seq_printf(m, "  Device: %s%02d\n", drv->name, drv->num);
 	seq_printf(m, "  description: %s\n",ocp_type_info[drv->type].desc);
-	switch (drv->type) {
-	case UART:
-	case IDE:
-	case USB:
-	case IIC:
-		seq_printf(m, "   Irq: %02d\n", drv->irq_resource[0][0].irq);
-		break;
-	case GPIO:
-	case ZMII:
-		/* no IRQ */
-		seq_printf(m, "    Irq: N/A\n");
-		break;
-	case EMAC:
+	if (drv->type == EMAC) { /* Blech, special case */
 		for (i = 0; i < OCP_MAX_IRQS; i++) {
 			seq_printf(m, "    Irq: %02d   Name: %s\n",
-				   drv->irq_resource[drv->num][i].irq,
-				   drv->irq_resource[drv->num][i].irq_name);
+				   irq_resource[drv->num][i].irq,
+				   irq_resource[drv->num][i].irq_name);
 		}
-
-		break;
-	default:
-		seq_printf(m, "   Irq: %02d\n", drv->irq_resource[0][0].irq);
+	} else if (drv->irq != OCP_IRQ_NA) {
+		seq_printf(m, "   Irq: %02d\n", drv->irq);
+	} else {
+		/* no IRQ */
+		seq_printf(m, "    Irq: N/A\n");
 	}

 	seq_printf(m, "   Physical Address start 0x%lx\n", drv->paddr);
 	if (drv->vaddr)
-		seq_printf(m, "   Virtual  Address start 0x%lx\n\n", drv->vaddr);
+		seq_printf(m, "   Virtual  Address start %p\n\n", drv->vaddr);
 	else
 		seq_printf(m, "   Virtual  Address start N/A\n\n");
 	return 0;
@@ -209,7 +187,7 @@
 int
 ocp_proc_attach_device(struct ocp_dev *dev)
 {
-	struct proc_dir_entry *de, *e;
+	struct proc_dir_entry *e;
 	char name[16];

 	sprintf(name, "%s%d", dev->name, dev->num);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_uart.c linux-grinch/arch/ppc/kernel/ocp_uart.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_uart.c	Wed May 29 10:05:14 2002
+++ linux-grinch/arch/ppc/kernel/ocp_uart.c	Fri Jun  7 17:53:00 2002
@@ -102,7 +102,7 @@
 		uart_drv->type = UART;
 		/* this returns the next uart number */
 		if ((curr_uart = ocp_register(uart_drv)) != -ENXIO) {
-			uart_drv->irq_resource[0][0].irq =
+			uart_drv->irq =
 			    uart_table[curr_uart].irq;

 		} else {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/i2c/i2c-adap-ibm_ocp.c linux-grinch/drivers/i2c/i2c-adap-ibm_ocp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/i2c/i2c-adap-ibm_ocp.c	Wed May 29 10:05:14 2002
+++ linux-grinch/drivers/i2c/i2c-adap-ibm_ocp.c	Fri Jun  7 17:48:17 2002
@@ -122,7 +122,7 @@
 	 * sleep.  This process will be awakened by two events -- either the
 	 * the IIC peripheral interrupts or the timeout expires.
 	 */
-	if (iic_dev->irq_resource[0][0].irq > 0) {
+	if (iic_dev->irq > 0) {
 		cli();
 		if (iic_pending == 0) {
 			interruptible_sleep_on_timeout(&
@@ -180,9 +180,9 @@

 	for (i = 0; i < ocp_get_max(IIC); i++) {
 		iic_drv = ocp_get_dev(IIC, i);
-		if (iic_drv->irq_resource[0][0].irq > 0) {
-			disable_irq(iic_drv->irq_resource[0][0].irq);
-			free_irq(iic_drv->irq_resource[0][0].irq, 0);
+		if (iic_drv->irq > 0) {
+			disable_irq(iic_drv->irq);
+			free_irq(iic_drv->irq, 0);
 		}
 	}

@@ -253,11 +253,11 @@
 			    ("iic_hw_resrc_init: Physical Base address: 0x%lx\n",
 			     iic_drv->paddr));
 			DEB(printk
-			    ("iic_hw_resrc_init: ioremapped base address: 0x%lx\n",
+			    ("iic_hw_resrc_init: ioremapped base address: %p\n",
 			     iic_drv->vaddr));
 			DEB(printk
 			    ("Adapter irq %x\n",
-			     iic_drv->irq_resource[0][0].irq));
+			     iic_drv->irq));

 			strcpy(adap->name, "IBM OCP IIC adapter");
 			adap->data = (void *) iic_drv;
@@ -270,15 +270,14 @@

 			init_waitqueue_head(&(iic_wait[curr_iic]));

-			if (iic_drv->irq_resource[0][0].irq > 0) {
+			if (iic_drv->irq > 0) {
 				if (request_irq
-				    (iic_drv->irq_resource[0][0].irq,
+				    (iic_drv->irq,
 				     iic_ibmocp_handler, 0, "IBM OCP IIC",
 				     iic_drv)) {
 					printk(KERN_ERR "iic_hw_resrc_init: Request irq%d
-				failed\n", iic_drv->irq_resource[0][0].
-					       irq);
-					iic_drv->irq_resource[0][0].irq = 0;
+				failed\n", iic_drv->irq);
+					iic_drv->irq = 0;
 				} else {
 					DEB3(printk
 					     ("iic_hw_resrc_init: Enabled interrupt\n"));
@@ -290,7 +289,7 @@

 			DEB(printk
 			    (KERN_INFO
-			     "iic_ibmocp_init: found device at %#lx.\n\n",
+			     "iic_ibmocp_init: found device at %p.\n\n",
 			     iic_drv->vaddr));
 		} else {
 			ocp_free_dev(iic_drv);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/ide/ibm_ocp_ide.c linux-grinch/drivers/ide/ibm_ocp_ide.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/ide/ibm_ocp_ide.c	Wed May 29 10:05:14 2002
+++ linux-grinch/drivers/ide/ibm_ocp_ide.c	Fri Jun  7 18:16:21 2002
@@ -656,7 +656,7 @@
 		hw->io_ports[IDE_CONTROL_OFFSET] = (int) (&(idp->si_c0adc));

 		if (irq)
-			*irq = ide_dev->irq_resource[0][0].irq;
+			*irq = ide_dev->irq;

 		pio_mode[0] = pio_mode[1] = -1;

@@ -693,6 +693,6 @@

 		memcpy(ide_hwifs[data_port].io_ports, hw->io_ports,
 		       sizeof (hw->io_ports));
-		ide_hwifs[data_port].irq = ide_dev->irq_resource[0][0].irq;
+		ide_hwifs[data_port].irq = ide_dev->irq;
 	}
 }
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h linux-grinch/include/asm-ppc/ocp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h	Thu May 30 11:16:20 2002
+++ linux-grinch/include/asm-ppc/ocp.h	Fri Jun  7 17:46:50 2002
@@ -51,19 +51,11 @@

 #include <linux/list.h>
 #include <linux/config.h>
-#include <linux/devfs_fs_kernel.h>

 #include <asm/mmu.h>		/* For phys_addr_t */

-#if defined(CONFIG_IBM_OCP)
-#include <platforms/ibm_ocp.h>
-#endif
-
 #define OCP_MAX_IRQS	7
 #define MAX_EMACS	4
-#define MAX_OCP_DEVS	20
-#define OCP_ACTIVE	1
-#define OCP_INACTIVE	2
 #define OCP_IRQ_NA	-1	/* used when ocp device does not have an irq */
 #define OCP_IRQ_MUL	-2	/* used for ocp devices with multiply irqs */
 #define OCP_NULL_TYPE	-1	/* used to mark end of list */
@@ -120,14 +112,8 @@
 	phys_addr_t paddr;
 	void *vaddr;
 	u32 flags;
-	struct irq_resources irq_resource[MAX_EMACS][OCP_MAX_IRQS];
+	int irq;
 	void *ocpdev;		/* ocp device struct  pointer */
-	u64		dma_mask;	/* Mask of the bits of bus address this
-					   device implements.  Normally this is
-					   0xffffffff.  You only need to change
-					   this if your device has broken DMA
-					   or supports 64-bit transfers.  */
-
 #if defined(CONFIG_PM)
 	u32 current_state;	/* Current operating state. In ACPI-speak,
 				   this is D0-D3, D0 being fully functional,
@@ -139,14 +125,10 @@
 	int (*enable_wake) (u32 state, int enable);	/* Enable wake event */
 #endif
 #if defined(CONFIG_OCP_PROC)
-	struct proc_dir_entry *procdir;	/* dir entry in /proc/bus */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/ocp */
 #endif
 };
 #define ocp_dev_g(n) list_entry(n, struct ocp_dev, ocp_list)
-#define ocp_for_each_dev(dev) \
-	for(dev = ocp_dev_g(ocp_devs.next); dev != ocp_dev_g(&ocp_devs); dev = ocp_dev_g(dev->ocp_list.next))
-

 extern int ocp_register(struct ocp_dev *drv);
 extern void ocp_unregister(struct ocp_dev *drv);
@@ -156,7 +138,6 @@
 extern int ocp_proc_attach_device(struct ocp_dev *dev);
 extern int ocp_proc_detach_device(struct ocp_dev *dev);
 extern unsigned long ocp_get_paddr(int type, int dev_num);
-extern int ocp_get_numtypes(int type);
 extern int ocp_get_max(int type);
 extern int ocp_get_irq(int type, int dev_num);

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
