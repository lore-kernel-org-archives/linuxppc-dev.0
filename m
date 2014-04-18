Return-Path: <Diana.Craciun@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD3071400F4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Apr 2014 01:12:27 +1000 (EST)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/fsl: Added binding for Freescale CoreNet coherency
 fabric (CCF)
Date: Fri, 18 Apr 2014 18:11:57 +0300
Message-ID: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, devicetree@vger.kernel.org,
 Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

The CoreNet coherency fabric is a fabric-oriented, conectivity
infrastructure that enables the implementation of coherent, multicore
systems. The CCF acts as a central interconnect for cores,
platform-level caches, memory subsystem, peripheral devices and I/O host
bridges in the system.

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/ccf.txt        | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
new file mode 100644
index 0000000..f0b7143
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
@@ -0,0 +1,36 @@
+Freescale CoreNet Coherency Fabric(CCF) Device Tree Binding
+
+DESCRIPTION
+
+The CoreNet coherency fabric is a fabric-oriented, connectivity infrastructure
+that enables the implementation of coherent, multicore systems.
+
+Required properties:
+
+- compatible : <string>
+		Must include "fsl,corenetX-cf", "fsl,corenet-cf" - CoreNet coherency 
+		fabric version X
+
+- reg : <prop-encoded-array>
+		A standard property. Represents the CCF registers.
+
+- interrupts : <prop-encoded-array>
+		Interrupt mapping for CCF error interrupt.
+
+- fsl,ccf-num-csdids: <u32>
+		Specifies the number of Coherency Subdomain ID Port Mapping
+		Registers that are supported by the CCF.
+
+- fsl,ccf-num-snoopids: <u32>
+		Specifies the number of Snoop ID Port Mapping Registers that
+		are supported by CCF.
+
+Example:
+
+	corenet-cf@18000 {
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
+		reg = <0x18000 0x1000>;
+		interrupts = <16 2 1 31>;
+		fsl,ccf-num-csdids = <32>;
+		fsl,ccf-num-snoopids = <32>;
+	};
-- 
1.7.11.7
