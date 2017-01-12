Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYy5kL3zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:10 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 17/37] Documentation: PCI: Guide to use pci endpoint configfs
Date: Thu, 12 Jan 2017 15:56:06 +0530
Message-ID: <1484216786-17292-18-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add Documentation to help users use pci endpoint to configure
pci endpoint function and to bind the endpoint function
with endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                      |    2 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt |   84 +++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index ba950b2..f84a23c 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -14,3 +14,5 @@ pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
 endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
+endpoint/pci-endpoint-cfs.txt
+	- guide to use configfs to configure the pci endpoint function.
diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
new file mode 100644
index 0000000..b1f1613
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
@@ -0,0 +1,84 @@
+                   CONFIGURING PCI ENDPOINT USING CONFIGFS
+                    Kishon Vijay Abraham I <kishon@ti.com>
+
+The PCI Endpoint Core exposes configfs entry (pci_ep) in order to configure the
+PCI endpoint function and in order to bind the endpoint function
+with the endpoint controller. (For introducing other mechanisms to
+configure the PCI Endpoint Function refer [1]).
+
+*) Mounting configfs
+
+The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
+directory. configfs can be mounted using the following command.
+
+	mount -t configfs none /sys/kernel/config
+
+*) Directory Structure
+
+The pci_ep configfs directory structure has been created to reflect the
+natural tree like structure of PCI devices. So every directory created
+inside pci_ep represents a EPC device and every directory created inside
+epf directory represents EPF device.
+
+/sys/kernel/config/pci_ep/
+			 | <dir>/ --------------------------------------> [2]
+				| epc
+				| epf/
+				     | <dir>/ --------------------------> [3]
+					    | vendorid
+					    | deviceid
+					    | revid
+					    | progif_code
+					    | subclass_code
+					    | baseclass_code
+					    | cache_line_size
+					    | subsys_vendor_id
+					    | subsys_id
+					    | interrupt_pin
+					    | function
+
+*) Creating configfs entry for EPC
+
+Any directory created inside *pci_ep* represents an EPC device. In the above
+directory structure [2] represents an EPC device. It consists of
+
+	*) epc: Use it to associate the configfs entry to an actual EPC device.
+		The list of valid entries for this field can be obtained from
+			ls /sys/class/pci_epc/
+
+	*) epf: Directory that contains all the endpoint functions. The name
+		of the created directory determines the driver this particular
+		epf device will be bound to. The name can be obtained either
+		from the function binding documentation [4] or
+			ls /sys/bus/pci-epf/drivers
+
+		If more than one endpoint function device has to be bound to
+		the same driver, then the directory should be created using
+		the following notation
+			mkdir <name>.<num>
+
+*) Creating configfs entry for EPF
+
+Any directory created inside *epf* directory represents an EPF device. In the
+above directory structure, [3] represents an EPF device. It consists of the
+following entries that can be used to configure the standard configuration
+header of the endpoint function. (These entries are created by the
+framework when any new directory is created inside epf directory.)
+
+        | vendorid
+        | deviceid
+        | revid
+        | progif_code
+        | subclass_code
+        | baseclass_code
+        | cache_line_size
+        | subsys_vendor_id
+        | subsys_id
+        | interrupt_pin
+
+The following entry identifies the function driver that is bound to the
+function device
+	| function
+
+[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
+[4] -> Documentation/PCI/endpoint/function/binding/
-- 
1.7.9.5
