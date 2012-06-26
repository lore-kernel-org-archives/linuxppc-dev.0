Return-Path: <aletes.xgr@gmail.com>
From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
 Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>,
 Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Li Yang <leoli@freescale.com>,
 Alexandre Pereira da Silva <aletes.xgr@gmail.com>,
 devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Roland Stigge <stigge@antcom.de>
Subject: [PATCH 5/5] usb: gadget: composite: parse dt overrides
Date: Tue, 26 Jun 2012 11:27:13 -0300
Message-Id: <1340720833-781-6-git-send-email-aletes.xgr@gmail.com>
In-Reply-To: <1340720833-781-1-git-send-email-aletes.xgr@gmail.com>
References: <1340720833-781-1-git-send-email-aletes.xgr@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grab the devicetree node properties to override VendorId, ProductId,
bcdDevice, Manucacturer, Product and SerialNumber

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
---
 Documentation/devicetree/bindings/usb/gadget.txt |   20 +++++++++++
 drivers/usb/gadget/composite.c                   |   39 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/gadget.txt

diff --git a/Documentation/devicetree/bindings/usb/gadget.txt b/Documentation/devicetree/bindings/usb/gadget.txt
new file mode 100644
index 0000000..93388d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/gadget.txt
@@ -0,0 +1,20 @@
+Usb Gadget DeviceTree bindings
+
+These optional properties inside the usb device controller node are used to
+change some of the gadget drivers configuration:
+- vendor-id: Usb vendor id
+- product-id: Usb product id
+- release: Version of this device
+- vendor: Textual description of the vendor
+- device: Textual description of this device
+- serial: Textual representation of the device's serial number
+
+Binding Example:
+	usbd@31020000 {
+		vendor-id = <0x0525>;
+		product-id = <0xa4a6>;
+		release = <1>;
+		vendor = "Some Corp";
+		device = "Test Device";
+		serial = "12345";
+	};
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 390749b..b39aef4 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/utsname.h>
+#include <linux/of.h>
 
 #include <linux/usb/composite.h>
 #include <asm/unaligned.h>
@@ -1419,10 +1420,44 @@ static u8 override_id(struct usb_composite_dev *cdev, u8 *desc)
 	return *desc;
 }
 
+static void composite_parse_dt(struct usb_composite_dev *cdev,
+	struct device_node *np)
+{
+	u32 reg;
+
+	if (!idVendor && of_property_read_u32(np, "vendor-id", &reg) == 0)
+		idVendor = reg;
+
+	if (!idProduct && of_property_read_u32(np, "product-id", &reg) == 0)
+		idProduct = reg;
+
+	if (!bcdDevice && of_property_read_u32(np, "release", &reg) == 0)
+		bcdDevice = reg;
+
+	if (!iManufacturer)
+		if (of_property_read_string(np, "vendor",
+			&composite->iManufacturer) == 0)
+			cdev->manufacturer_override = override_id(cdev,
+				&cdev->desc.iManufacturer);
+
+	if (!iProduct)
+		if (of_property_read_string(np, "device",
+			&composite->iProduct) == 0)
+			cdev->product_override = override_id(cdev,
+				&cdev->desc.iProduct);
+
+	if (!iSerialNumber)
+		if (of_property_read_string(np, "serial",
+			&composite->iSerialNumber) == 0)
+			cdev->serial_override = override_id(cdev,
+				&cdev->desc.iSerialNumber);
+}
+
 static int composite_bind(struct usb_gadget *gadget)
 {
 	struct usb_composite_dev	*cdev;
 	int				status = -ENOMEM;
+	struct device_node		*np = gadget->dev.of_node;
 
 	cdev = kzalloc(sizeof *cdev, GFP_KERNEL);
 	if (!cdev)
@@ -1470,6 +1505,10 @@ static int composite_bind(struct usb_gadget *gadget)
 
 	cdev->desc = *composite->dev;
 
+	/* grab overrides from devicetree */
+	if (np)
+		composite_parse_dt(cdev, np);
+
 	/* standardized runtime overrides for device ID data */
 	if (idVendor)
 		cdev->desc.idVendor = cpu_to_le16(idVendor);
-- 
1.7.10
