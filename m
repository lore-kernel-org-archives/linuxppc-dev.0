Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FrqB2MPGzF27j
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 00:20:54 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id b6-v6so7020078pla.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 07:20:54 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: 000linux-nvdimm@lists.01.org, Oliver O'Halloran <oohall@gmail.com>,
 devicetree@vger.kernel.org
Subject: [PATCH 3/4] doc/devicetree: Persistent memory region bindings
Date: Wed,  4 Apr 2018 00:20:30 +1000
Message-Id: <20180403142031.28629-3-oohall@gmail.com>
In-Reply-To: <20180403142031.28629-1-oohall@gmail.com>
References: <20180403142031.28629-1-oohall@gmail.com>
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
v2: Changed name from nvdimm-region to pmem-region.
    Cleaned up the example binding and fixed the overlapping regions.
    Added support for multiple regions in a single reg.
---
 .../devicetree/bindings/pmem/pmem-region.txt       | 80 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt

diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
new file mode 100644
index 000000000000..de48dc8cd562
--- /dev/null
+++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
@@ -0,0 +1,80 @@
+Device-tree bindings for persistent memory regions
+-----------------------------------------------------
+
+Persistent memory refers to a class of memory devices that are:
+
+	a) Usable as main system memory (i.e. cacheable), and
+	b) Retain their contents across power failure.
+
+Given b) it is best to think of persistent memory as a kind of memory mapped
+storage device. To ensure data integrity the operating system needs to manage
+persistent regions separately to the normal memory pool. To aid with that this
+binding provides a standardised interface for discovering where persistent
+memory regions exist inside the physical address space.
+
+Bindings for the region nodes:
+-----------------------------
+
+Required properties:
+	- compatible = "pmem-region"
+
+	- reg = <base, size>;
+		The system physical address range of this nvdimm region.
+
+		If the reg property contains multiple address ranges
+		each address range will be treated as though it was specified
+		in a separate device node. Having multiple address ranges in a
+		node implies no special relationship between the two ranges.
+
+Optional properties:
+	- Any relevant NUMA assocativity properties for the target platform.
+
+	- A "volatile" property indicating that this region is actually in
+	  normal DRAM and does not require cache flushes after each write.
+
+	  If this property is absent then the OS must assume that the region
+	  is backed by non-volatile memory.
+
+A complete example:
+--------------------
+
+Here we define three 4KB regions:
+
+	a) A volatile region at 0x5000 on numa node 0,
+	b) A non-volatile region at 0x6000, and
+	c) A non-volatile region at 0x8000.
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	platform {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * This node specifies one non-volatile region spanning from
+		 * 0x5000 to 0x5fff.
+		 */
+		pmem@5000 {
+			compatible = "pmem-region";
+			reg = <0x00005000 0x00001000>;
+			numa-node-id = <0>;
+			volatile;
+		};
+
+		/*
+		 * This node specifies two 4KB regions that are backed by
+		 * volatile (normal) memory.
+		 */
+		pmem@6000 {
+			compatible = "pmem-region";
+			reg = <0x00006000 0x00001000 0x00008000 0x00001000>;
+		};
+	};
+};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 6ef38be700e8..fa3c9211d6ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8041,6 +8041,7 @@ L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
 F:	drivers/nvdimm/of_pmem.c
+F:	Documentation/devicetree/bindings/pmem/pmem-region.txt
 
 LIBNVDIMM: NON-VOLATILE MEMORY DEVICE SUBSYSTEM
 M:	Dan Williams <dan.j.williams@intel.com>
-- 
2.9.5
