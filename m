Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F421CDDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:46 +1000 (EST)
Message-ID: <466EEC01.6080807@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:57 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 29/30] PS3: Device tree source.
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PS3 device tree source.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/dts/ps3.dts |   74 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

--- /dev/null
+++ b/arch/powerpc/boot/dts/ps3.dts
@@ -0,0 +1,74 @@
+/*
+ *  PS3 Game Console device tree.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+/ {
+	model = "PS3 Game Console";
+	compatible = "PS3";
+	#size-cells = <2>;
+	#address-cells = <2>;
+
+	/*
+	 * Need to keep linux,platform for a while, not used by kernel.
+	 */
+
+	chosen {
+		linux,platform = <0>;
+	};
+
+	/*
+	 * dtc expects a memory entry, so we'll put a null entry here.
+	 * We'll get the size of the bootmem block from lv1 after startup.
+	 */
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0 0>;
+	};
+
+	/*
+	 * dtc expects a clock-frequency and timebase-frequency entries, so
+	 * we'll put a null entries here.  These will be initialized after
+	 * startup with data from lv1.
+	 *
+	 * The boot cpu is always zero for PS3.
+	 *
+	 * Seems the only way currently to indicate a processor has multiple
+	 * threads is with an ibm,ppc-interrupt-server#s entry.  We'll put one
+	 * here so we can bring up both of ours.  See smp_setup_cpu_maps().
+	 */
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		CBE,PPE {
+			device_type = "cpu";
+			reg = <0>;
+			ibm,ppc-interrupt-server#s = <0 1>;
+			clock-frequency = <0>;
+			timebase-frequency = <0>;
+			i-cache-size = <8000>;
+			d-cache-size = <8000>;
+			i-cache-line-size = <80>;
+			d-cache-line-size = <80>;
+		};
+	};
+};

-- 
