Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406x9K6GwSzF21K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 19:12:37 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id d26so4441335pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 01:12:37 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linux-nvdimm@lists.01.org
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 6/6] doc/devicetree: NVDIMM region documentation
Date: Fri, 23 Mar 2018 19:12:09 +1100
Message-Id: <20180323081209.31387-6-oohall@gmail.com>
In-Reply-To: <20180323081209.31387-1-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add device-tree binding documentation for the nvdimm region driver.

Cc: devicetree@vger.kernel.org
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 .../devicetree/bindings/nvdimm/nvdimm-region.txt   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvdimm/nvdimm-region.txt

diff --git a/Documentation/devicetree/bindings/nvdimm/nvdimm-region.txt b/Documentation/devicetree/bindings/nvdimm/nvdimm-region.txt
new file mode 100644
index 000000000000..02091117ff16
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvdimm/nvdimm-region.txt
@@ -0,0 +1,45 @@
+Device-tree bindings for NVDIMM memory regions
+-----------------------------------------------------
+
+Non-volatile DIMMs are memory modules used to provide (cacheable) main memory
+that retains its contents across power cycles. In more practical terms, they
+are kind of storage device where the contents can be accessed by the CPU
+directly, rather than indirectly via a storage controller or similar. The an
+nvdimm-region specifies a physical address range that is hosted on an NVDIMM
+device.
+
+Bindings for the region nodes:
+-----------------------------
+
+Required properties:
+	- compatible = "nvdimm-region"
+
+	- reg = <base, size>;
+		The system physical address range of this nvdimm region.
+
+Optional properties:
+	- Any relevant NUMA assocativity properties for the target platform.
+	- A "volatile" property indicating that this region is actually in
+	  normal DRAM and does not require cache flushes after each write.
+
+A complete example:
+--------------------
+
+/ {
+	#size-cells = <2>;
+	#address-cells = <2>;
+
+	platform {
+		region@5000 {
+			compatible = "nvdimm-region;
+			reg = <0x00000001 0x00000000 0x00000000 0x40000000>
+
+		};
+
+		region@6000 {
+			compatible = "nvdimm-region";
+			reg = <0x00000001 0x00000000 0x00000000 0x40000000>
+			volatile;
+		};
+	};
+};
-- 
2.9.5
