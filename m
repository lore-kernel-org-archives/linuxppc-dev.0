Date: Fri, 4 Oct 2002 16:41:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Yet more OCP cleanup (1/N)
Message-ID: <20021004064104.GO1933@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ocp_setup_dev() used ocp_get_paddr() et al to lookup the core_ocp
table, when it already has and index to the right entry in that table.
This patch makes it use the entry directly.  This removes the last
user of ocp_get_irq(), so it is removed also.

diff -urN linux-bluefish-old/drivers/ocp/ocp-probe.c linux-bluefish/drivers/ocp/ocp-probe.c
--- linux-bluefish-old/drivers/ocp/ocp-probe.c	2002-10-04 15:45:11.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp-probe.c	2002-10-04 16:28:41.000000000 +1000
@@ -106,9 +106,9 @@
 	dev->vendor = core_ocp[index].vendor;
 	dev->device = core_ocp[index].device;
 	dev->num = ocp_get_num(dev->device);
-	dev->paddr = (phys_addr_t) ocp_get_paddr(dev->device,dev->num);
-	dev->irq = ocp_get_irq(dev->device,dev->num);
-	dev->pm = ocp_get_pm(dev->device,dev->num);
+	dev->paddr = core_ocp[index].paddr;
+	dev->irq = core_ocp[index].irq;
+	dev->pm = core_ocp[index].pm;
 	dev->current_state = 4;

 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, dev->device, dev->num);
diff -urN linux-bluefish-old/drivers/ocp/ocp.c linux-bluefish/drivers/ocp/ocp.c
--- linux-bluefish-old/drivers/ocp/ocp.c	2002-10-04 15:39:27.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp.c	2002-10-04 16:20:51.000000000 +1000
@@ -166,30 +166,6 @@
 }

 /**
- * ocp_get_irq - get irq for ocp device and instance of it
- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
- * @dev_num: ocp device number whos IRQ
- * value you want
- *
- * The routine returns the power management value or OCP_CPM_NA,
- * of device and instance requested
- */
-int
-ocp_get_irq(unsigned int device, int dev_num)
-{
-	int a, i;
-
-	for (i = 0, a = 0; core_ocp[i].device != OCP_FUNC_INVALID; i++) {
-		if (device == core_ocp[i].device) {
-			if (a == dev_num)
-				return (core_ocp[i].irq);
-			a++;
-		}
-	}
-	return OCP_IRQ_NA;
-}
-
-/**
  * ocp_get_paddr - get phyical address for ocp device and instance of it
  * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII
  * @dev_num: ocp device number whos paddr you want
@@ -277,7 +253,6 @@
 }

 EXPORT_SYMBOL(ocp_get_pm);
-EXPORT_SYMBOL(ocp_get_irq);
 EXPORT_SYMBOL(ocp_get_paddr);
 EXPORT_SYMBOL(ocp_get_max);
 EXPORT_SYMBOL(ocp_get_dev);
diff -urN linux-bluefish-old/include/linux/ocp.h linux-bluefish/include/linux/ocp.h
--- linux-bluefish-old/include/linux/ocp.h	2002-10-04 15:39:23.000000000 +1000
+++ linux-bluefish/include/linux/ocp.h	2002-10-04 16:20:56.000000000 +1000
@@ -243,7 +243,6 @@
 extern struct ocp_device *ocp_get_dev(unsigned int device, int index);
 extern unsigned long ocp_get_paddr(unsigned int device, int dev_num);
 extern unsigned int ocp_get_max(unsigned int device);
-extern int ocp_get_irq(unsigned int device, int dev_num);
 extern int ocp_get_pm(unsigned int device, int dev_num);
 extern unsigned int ocp_get_num(unsigned int device);
 extern unsigned ocp_get_bus_start(unsigned int device, int bus_num);

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
