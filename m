Return-Path: <robherring2@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtxN6D2PzDrKQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:45:12 +1000 (AEST)
Received: by mail-pf0-f196.google.com with SMTP id q85so4060834pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:45:12 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] tty: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:34 -0500
Message-Id: <20170718214339.7774-54-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/ehv_bytechan.c        |  2 +-
 drivers/tty/hvc/hvc_opal.c        | 16 ++++++++--------
 drivers/tty/hvc/hvc_vio.c         |  6 +++---
 drivers/tty/serdev/core.c         |  2 +-
 drivers/tty/serial/mpc52xx_uart.c | 12 ++++++------
 drivers/tty/serial/pmac_zilog.c   |  4 ++--
 drivers/tty/serial/sunsu.c        |  4 ++--
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 61fe8d6fd24e..a1c7125cb968 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -122,7 +122,7 @@ static int find_console_handle(void)

 	stdout_irq = irq_of_parse_and_map(np, 0);
 	if (stdout_irq == NO_IRQ) {
-		pr_err("ehv-bc: no 'interrupts' property in %s node\n", np->full_name);
+		pr_err("ehv-bc: no 'interrupts' property in %pOF node\n", np);
 		return 0;
 	}

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 510799311099..16331a90c1e8 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -179,8 +179,8 @@ static int hvc_opal_probe(struct platform_device *dev)
 		proto = HV_PROTOCOL_HVSI;
 		ops = &hvc_opal_hvsi_ops;
 	} else {
-		pr_err("hvc_opal: Unknown protocol for %s\n",
-		       dev->dev.of_node->full_name);
+		pr_err("hvc_opal: Unknown protocol for %pOF\n",
+		       dev->dev.of_node);
 		return -ENXIO;
 	}

@@ -204,14 +204,14 @@ static int hvc_opal_probe(struct platform_device *dev)
 		/* Instanciate now to establish a mapping index==vtermno */
 		hvc_instantiate(termno, termno, ops);
 	} else {
-		pr_err("hvc_opal: Device %s has duplicate terminal number #%d\n",
-		       dev->dev.of_node->full_name, termno);
+		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
+		       dev->dev.of_node, termno);
 		return -ENXIO;
 	}

-	pr_info("hvc%d: %s protocol on %s%s\n", termno,
+	pr_info("hvc%d: %s protocol on %pOF%s\n", termno,
 		proto == HV_PROTOCOL_RAW ? "raw" : "hvsi",
-		dev->dev.of_node->full_name,
+		dev->dev.of_node,
 		boot ? " (boot console)" : "");

 	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
@@ -222,8 +222,8 @@ static int hvc_opal_probe(struct platform_device *dev)
 	}

 	if (!irq) {
-		pr_err("hvc_opal: Unable to map interrupt for device %s\n",
-			dev->dev.of_node->full_name);
+		pr_err("hvc_opal: Unable to map interrupt for device %pOF\n",
+			dev->dev.of_node);
 		return irq;
 	}

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index b05dc5086627..78b003be7f67 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -312,12 +312,12 @@ static int hvc_vio_probe(struct vio_dev *vdev,
 		proto = HV_PROTOCOL_HVSI;
 		ops = &hvterm_hvsi_ops;
 	} else {
-		pr_err("hvc_vio: Unknown protocol for %s\n", vdev->dev.of_node->full_name);
+		pr_err("hvc_vio: Unknown protocol for %pOF\n", vdev->dev.of_node);
 		return -ENXIO;
 	}

-	pr_devel("hvc_vio_probe() device %s, using %s protocol\n",
-		 vdev->dev.of_node->full_name,
+	pr_devel("hvc_vio_probe() device %pOF, using %s protocol\n",
+		 vdev->dev.of_node,
 		 proto == HV_PROTOCOL_RAW ? "raw" : "hvsi");

 	/* Is it our boot one ? */
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ae1aaa0075d1..c68fb3a8ea1c 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -363,7 +363,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		if (!of_get_property(node, "compatible", NULL))
 			continue;

-		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
+		dev_dbg(&ctrl->dev, "adding child %pOF\n", node);

 		serdev = serdev_device_alloc(ctrl);
 		if (!serdev)
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3970d6a9aaca..4cacaadbd14b 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1634,8 +1634,8 @@ mpc52xx_console_setup(struct console *co, char *options)
 		return -EINVAL;
 	}

-	pr_debug("Console on ttyPSC%x is %s\n",
-		 co->index, mpc52xx_uart_nodes[co->index]->full_name);
+	pr_debug("Console on ttyPSC%x is %pOF\n",
+		 co->index, mpc52xx_uart_nodes[co->index]);

 	/* Fetch register locations */
 	ret = of_address_to_resource(np, 0, &res);
@@ -1755,8 +1755,8 @@ static int mpc52xx_uart_of_probe(struct platform_device *op)
 			break;
 	if (idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
-	pr_debug("Found %s assigned to ttyPSC%x\n",
-		 mpc52xx_uart_nodes[idx]->full_name, idx);
+	pr_debug("Found %pOF assigned to ttyPSC%x\n",
+		 mpc52xx_uart_nodes[idx], idx);

 	/* set the uart clock to the input clock of the psc, the different
 	 * prescalers are taken into account in the set_baudrate() methods
@@ -1881,8 +1881,8 @@ mpc52xx_uart_of_enumerate(void)

 	for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
 		if (mpc52xx_uart_nodes[i])
-			pr_debug("%s assigned to ttyPSC%x\n",
-				 mpc52xx_uart_nodes[i]->full_name, i);
+			pr_debug("%pOF assigned to ttyPSC%x\n",
+				 mpc52xx_uart_nodes[i], i);
 	}
 }

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 0da52947e59e..6ccdd018fb45 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1671,8 +1671,8 @@ static int __init pmz_probe(void)
 		if (!node_a && !node_b) {
 			of_node_put(node_a);
 			of_node_put(node_b);
-			printk(KERN_ERR "pmac_zilog: missing node %c for escc %s\n",
-				(!node_a) ? 'a' : 'b', node_p->full_name);
+			printk(KERN_ERR "pmac_zilog: missing node %c for escc %pOF\n",
+				(!node_a) ? 'a' : 'b', node_p);
 			continue;
 		}

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 72df2e1b88af..5380407bb0be 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1212,8 +1212,8 @@ static int sunsu_kbd_ms_init(struct uart_sunsu_port *up)
 	if (up->port.type == PORT_UNKNOWN)
 		return -ENODEV;

-	printk("%s: %s port at %llx, irq %u\n",
-	       up->port.dev->of_node->full_name,
+	printk("%pOF: %s port at %llx, irq %u\n",
+	       up->port.dev->of_node,
 	       (up->su_type == SU_PORT_KBD) ? "Keyboard" : "Mouse",
 	       (unsigned long long) up->port.mapbase,
 	       up->port.irq);
--
2.11.0
