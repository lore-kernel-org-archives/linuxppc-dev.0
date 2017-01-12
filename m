Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYp5p9tzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:01 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 34/37] tools: PCI: Add sample test script to invoke pcitest
Date: Thu, 12 Jan 2017 15:56:23 +0530
Message-ID: <1484216786-17292-35-git-send-email-kishon@ti.com>
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

Add a simple test script that invokes the pcitest userspace tool
to perform all the PCI endpoint tests (BAR tests, interrupt tests,
read tests, write tests and copy tests).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 tools/pci/pcitest.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tools/pci/pcitest.sh

diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
new file mode 100644
index 0000000..5442bbe
--- /dev/null
+++ b/tools/pci/pcitest.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+echo "BAR tests"
+echo
+
+bar=0
+
+while [ $bar -lt 6 ]
+do
+	pcitest -b $bar
+	bar=`expr $bar + 1`
+done
+echo
+
+echo "Interrupt tests"
+echo
+
+pcitest -l
+msi=1
+
+while [ $msi -lt 33 ]
+do
+        pcitest -m $msi
+        msi=`expr $msi + 1`
+done
+echo
+
+echo "Read Tests"
+echo
+
+pcitest -r -s 1
+pcitest -r -s 1024
+pcitest -r -s 1025
+pcitest -r -s 1024000
+pcitest -r -s 1024001
+echo
+
+echo "Write Tests"
+echo
+
+pcitest -w -s 1
+pcitest -w -s 1024
+pcitest -w -s 1025
+pcitest -w -s 1024000
+pcitest -w -s 1024001
+echo
+
+echo "Copy Tests"
+echo
+
+pcitest -c -s 1
+pcitest -c -s 1024
+pcitest -c -s 1025
+pcitest -c -s 1024000
+pcitest -c -s 1024001
+echo
-- 
1.7.9.5
