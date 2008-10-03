Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id B3982DE023
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:24:56 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so241590ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 05:24:54 -0700 (PDT)
Date: Fri, 3 Oct 2008 08:23:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Simple platform for the ISS 4xx simulator
Message-ID: <20081003122343.GC2229@yoda.jdub.homelinux.org>
References: <20081003000737.85CFEDDE17@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081003000737.85CFEDDE17@ozlabs.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 10:07:19AM +1000, Benjamin Herrenschmidt wrote:
>Index: linux-work/arch/powerpc/boot/dts/iss4xx.dts
>===================================================================
>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>+++ linux-work/arch/powerpc/boot/dts/iss4xx.dts	2008-10-02 15:46:11.000000000 +1000
>@@ -0,0 +1,107 @@
>+/*
>+ * Device Tree Source for IBM Ebony

Lazy.  ;)

>+ *
>+ * Copyright (c) 2006, 2007 IBM Corp.
>+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
>+ *
>+ * FIXME: Draft only!
>+ *
>+ * This file is licensed under the terms of the GNU General Public
>+ * License version 2.  This program is licensed "as is" without
>+ * any warranty of any kind, whether express or implied.
>+ */
>+
>+/dts-v1/;
>+
>+/ {
>+	#address-cells = <2>;
>+	#size-cells = <1>;
>+	model = "ibm,iss-4xx";
>+	compatible = "ibm,iss-4xx";
>+	dcr-parent = <&{/cpus/cpu@0}>;
>+
>+	aliases {
>+		serial0 = &UART0;
>+	};
>+
>+	cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+			model = "PowerPC,4xx"; // real CPU changed in sim
>+			reg = <0x00000000>;
>+			clock-frequency = <100000000>; // 100Mhz :-)
>+			timebase-frequency = <100000000>;
>+			i-cache-line-size = <32>; // may need fixup in sim
>+			d-cache-line-size = <32>; // may need fixup in sim
>+			i-cache-size = <32768>; /* may need fixup in sim */
>+			d-cache-size = <32768>; /* may need fixup in sim */

Does "fixup in sim" mean that the simulator itself mucks with the
device tree?  Or is there some wrapper that does this prior to kernel
boot?

>+			dcr-controller;
>+			dcr-access-method = "native";
>+		};
>+	};
>+
>+	memory {
>+		device_type = "memory";
>+		reg = <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
>+	};
>+
>+	UIC0: interrupt-controller0 {
>+		compatible = "ibm,uic-4xx", "ibm,uic";
>+		interrupt-controller;
>+		cell-index = <0>;
>+		dcr-reg = <0x0c0 0x009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+
>+	};
>+
>+	UIC1: interrupt-controller1 {
>+		compatible = "ibm,uic-4xx", "ibm,uic";
>+		interrupt-controller;
>+		cell-index = <1>;
>+		dcr-reg = <0x0d0 0x009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
>+		interrupt-parent = <&UIC0>;
>+	};
>+
>+	plb {
>+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */

Why doesn't it matter?

>+		#address-cells = <2>;
>+		#size-cells = <1>;
>+		ranges;
>+		clock-frequency = <0>; // Filled in by zImage
>+
>+		POB0: opb {
>+			compatible = "ibm,opb-4xx", "ibm,opb";
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+			/* Wish there was a nicer way of specifying a full 32-bit
>+			   range */
>+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
>+				  0x80000000 0x00000001 0x80000000 0x80000000>;
>+			clock-frequency = <0>; // Filled in by zImage
>+
>+			UART0: serial@40000200 {
>+				device_type = "serial";
>+				compatible = "ns16550";
>+				reg = <0x40000200 0x00000008>;
>+				virtual-reg = <0xe0000200>;
>+				clock-frequency = <11059200>;
>+				current-speed = <115200>;
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x0 0x4>;
>+			};
>+		};
>+	};
>+
>+	chosen {
>+		linux,stdout-path = "/plb/opb/serial@40000200";
>+	};
>+};
>Index: linux-work/arch/powerpc/platforms/44x/Kconfig
>===================================================================
>--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2008-10-02 15:45:47.000000000 +1000
>+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2008-10-02 15:47:48.000000000 +1000
>@@ -113,6 +113,17 @@ config YOSEMITE
> 	help
> 	  This option enables support for the AMCC PPC440EP evaluation board.
> 
>+config ISS4xx
>+	bool "ISS 4xx Simulator"
>+	depends on (44x || 40x)
>+	default n
>+	select PPC44x_SIMPLE
>+	select 405GP if 40x
>+	select 440GP if 44x
>+	select PPC_FPU
>+	help
>+	  This option enables support for the IBM ISS simulation environment

So I'm going to assume you tested the 40x case and that it works.  But I
find it a bit odd to be in the 44x Kconfig.

>Index: linux-work/arch/powerpc/configs/44x/iss4xx_defconfig
>===================================================================
>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>+++ linux-work/arch/powerpc/configs/44x/iss4xx_defconfig	2008-10-02 15:46:11.000000000 +1000

So.. I'm not really opposed, but do you need a full defconfig
for this?  I'm wondering if you could just add the iss4xx platform
to the multi-board ppc44x_defconfig and call it good.

josh
