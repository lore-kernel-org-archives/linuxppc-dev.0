Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B27E0DDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:13 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 03/28] Document local bus nodes in the device tree.
Message-ID: <20070917165731.GC6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cuboot-pq2 is updated to match the binding, and get rid of phandle linkage.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   38 ++++++++++++++++++++++++++
 arch/powerpc/boot/cuboot-pq2.c               |   29 +++++--------------
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a599f1a..42cbfb0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2017,6 +2017,44 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,cpm-command = <2e600000>;
 	};
 
+   m) Chipselect/Local Bus
+
+   Properties:
+   - name : Should be localbus
+   - #address-cells : Should be either two or three.  The first cell is the
+                      chipselect number, and the remaining cells are the
+                      offset into the chipselect.
+   - #size-cells : Either one or two, depending on how large each chipselect
+                   can be.
+   - ranges : Each range should correspond to a single chipselect, and cover
+              the entire access window as configured.
+
+   Example:
+	localbus@f0010100 {
+		compatible = "fsl,mpc8272ads-localbus",
+		             "fsl,mpc8272-localbus",
+		             "fsl,pq2-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <f0010100 40>;
+
+		ranges = <0 0 fe000000 02000000
+		          1 0 f4500000 00008000>;
+
+		flash@0,0 {
+			compatible = "jedec-flash";
+			reg = <0 0 2000000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
+
+		board-control@1,0 {
+			reg = <1 0 20>;
+			compatible = "fsl,mpc8272ads-bcsr";
+		};
+	};
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index b150bd4..e5d94ff 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -43,22 +43,21 @@ struct pci_range pci_ranges_buf[MAX_PROP_LEN / sizeof(struct pci_range)];
  * some don't set up the PCI PIC at all, so we assume the device tree is
  * sane and update the BRx registers appropriately.
  *
- * For any node defined as compatible with fsl,pq2-chipselect,
- * #address/#size must be 2/1 for chipselect bus, 1/1 for parent bus,
- * and ranges must be for whole chip selects.
+ * For any node defined as compatible with fsl,pq2-localbus,
+ * #address/#size must be 2/1 for the localbus, and 1/1 for the parent bus.
+ * Ranges must be for whole chip selects.
  */
 static void update_cs_ranges(void)
 {
-	u32 ctrl_ph;
-	void *ctrl_node, *bus_node, *parent_node;
+	void *bus_node, *parent_node;
 	u32 *ctrl_addr;
 	unsigned long ctrl_size;
 	u32 naddr, nsize;
 	int len;
 	int i;
 
-	bus_node = finddevice("/chipselect");
-	if (!bus_node || !dt_is_compatible(bus_node, "fsl,pq2-chipselect"))
+	bus_node = finddevice("/localbus");
+	if (!bus_node || !dt_is_compatible(bus_node, "fsl,pq2-localbus"))
 		return;
 
 	dt_get_reg_format(bus_node, &naddr, &nsize);
@@ -73,19 +72,7 @@ static void update_cs_ranges(void)
 	if (naddr != 1 || nsize != 1)
 		goto err;
 
-	len = getprop(bus_node, "fsl,ctrl", &ctrl_ph, 4);
-	if (len != 4)
-		goto err;
-
-	ctrl_node = find_node_by_prop_value(NULL, "linux,phandle",
-	                                    (char *)&ctrl_ph, 4);
-	if (!ctrl_node)
-		goto err;
-
-	if (!dt_is_compatible(ctrl_node, "fsl,pq2-chipselect-ctrl"))
-		goto err;
-
-	if (!dt_xlate_reg(ctrl_node, 0, (unsigned long *)&ctrl_addr,
+	if (!dt_xlate_reg(bus_node, 0, (unsigned long *)&ctrl_addr,
 	                  &ctrl_size))
 		goto err;
 
@@ -122,7 +109,7 @@ static void update_cs_ranges(void)
 	return;
 
 err:
-	printf("Bad /chipselect or fsl,pq2-chipselect-ctrl node\r\n");
+	printf("Bad /localbus node\r\n");
 }
 
 /* Older u-boots don't set PCI up properly.  Update the hardware to match
-- 
1.5.3.1
