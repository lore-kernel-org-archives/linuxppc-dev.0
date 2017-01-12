Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYx41jWzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:09 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 18/37] Documentation: PCI: Add specification for the *pci
 test* function device
Date: Thu, 12 Jan 2017 15:56:07 +0530
Message-ID: <1484216786-17292-19-git-send-email-kishon@ti.com>
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

Add specification for the *pci test* virtual function device. The endpoint
function driver and the host pci driver should be created based on this
specification.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                       |    2 +
 Documentation/PCI/endpoint/pci-test-function.txt |   66 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-test-function.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index f84a23c..4e5a283 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -16,3 +16,5 @@ endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
 endpoint/pci-endpoint-cfs.txt
 	- guide to use configfs to configure the pci endpoint function.
+endpoint/pci-test-function.txt
+	- specification of *pci test* function device.
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
new file mode 100644
index 0000000..1324376
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-test-function.txt
@@ -0,0 +1,66 @@
+				PCI TEST
+		    Kishon Vijay Abraham I <kishon@ti.com>
+
+Traditionally PCI RC has always been validated by using standard
+PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
+However with the addition of EP-core in linux kernel, it is possible
+to configure a PCI controller that can operate in EP mode to work as
+a test device.
+
+The PCI endpoint test device is a virtual device (defined in software)
+used to test the endpoint functionality and serve as a sample driver
+for other PCI endpoint devices (to use the EP framework).
+
+The PCI endpoint test device has the following registers:
+
+	1) PCI_ENDPOINT_TEST_MAGIC
+	2) PCI_ENDPOINT_TEST_COMMAND
+	3) PCI_ENDPOINT_TEST_STATUS
+	4) PCI_ENDPOINT_TEST_SRC_ADDR
+	5) PCI_ENDPOINT_TEST_DST_ADDR
+	6) PCI_ENDPOINT_TEST_SIZE
+	7) PCI_ENDPOINT_TEST_CHECKSUM
+
+*) PCI_ENDPOINT_TEST_MAGIC
+
+This register will be used to test BAR0. A known pattern will be written
+and read back from MAGIC register to verify BAR0.
+
+*) PCI_ENDPOINT_TEST_COMMAND:
+
+This register will be used by the host driver to indicate the function
+that the endpoint device must perform.
+
+Bitfield Description:
+  Bit 0		: raise legacy irq
+  Bit 1		: raise MSI irq
+  Bit 2 - 7	: MSI interrupt number
+  Bit 8		: read command (read data from RC buffer)
+  Bit 9		: write command (write data to RC buffer)
+  Bit 10	: copy command (copy data from one RC buffer to another
+		  RC buffer)
+
+*) PCI_ENDPOINT_TEST_STATUS
+
+This register reflects the status of the PCI endpoint device.
+
+Bitfield Description:
+  Bit 0		: read success
+  Bit 1		: read fail
+  Bit 2		: write success
+  Bit 3		: write fail
+  Bit 4		: copy success
+  Bit 5		: copy fail
+  Bit 6		: irq raised
+  Bit 7		: source address is invalid
+  Bit 8		: destination address is invalid
+
+*) PCI_ENDPOINT_TEST_SRC_ADDR
+
+This register contains the source address (RC buffer address) for the
+COPY/READ command.
+
+*) PCI_ENDPOINT_TEST_DST_ADDR
+
+This register contains the destination address (RC buffer address) for
+the COPY/WRITE command.
-- 
1.7.9.5
