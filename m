Return-Path: <mdhgarcia@gmail.com>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4709CB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 02:13:12 +1100 (EST)
Received: by obbup3 with SMTP id up3so4663072obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 07:13:04 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 5 Mar 2012 10:13:03 -0500
Message-ID: <CAB+Fak0PMZP239XiJ188GWJYQtx0EygW2FCVFzNr2ajR84PnrQ@mail.gmail.com>
Subject: Intermittent failures enumerating PCIe devices on P2020
From: Matias Garcia <mdhgarcia@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm getting intermittent failures enumerating four PCIe endpoints and
looking for some help. Sometimes three will enumerate, sometimes
fewer, sometimes four but only three of them will have BARs mapped,
etc.

I'm running 2.6.37 on a Freescale P2020 (e500v2 cores), and I have
four PCIe end-points (FPGAs) routed to one of the PCIe controllers
through a PCIe switch in a 1x2->4x1 configuration. On hard boot, the
FPGAs are configured via flash PROMs sometime after U-Boot does a PCI
scan and long before the kernel is booted. On soft boot, they remain
programmed.

I've tried simply rebooting, and this yields intermittent behaviour.
I've also tried suppressing the PCIe cores until after boot, flipping
a bit in the controller (which shuts it off if there are no
end-points) and rescanning the bus. This also produces intermittent
results. I'm attaching the output of lspci -v in the success case
where all four are enumerated, and the dtc where PCI is concerned. I'd
appreciate comments on the dtc as I'm just a hack on that front.

Let me know if other data is pertinent.

Cheers,
Matias Garcia

dtc:
/*
 * There are three PCIe controllers defined here. The second is unconnected.
 * Prefetchable memory was removed since our writes and reads are always
 * order-dependant. Each PCIe controller has its own 32-bit memory space,
 * and I/O is in yet another, for clarity.
 * The vidproc controller is still in the top half of the 0x8 space for
 * historical reasons (and symmetry...)
 *
 * Global PCIe memory map:
 *		PCIe1 Memory		0x880000000-0x88fffffff 256 MB
 *		PCIe2 Memory		0x990000000-0x99fffffff 256 MB
 *		PCIe3 Memory		0xaa0000000-0xaafffffff 256 MB
 *		I/O space			0xcc0000000-0xcc002ffff  64 KB * 3
 *
 * WARNING: The I/O memory is remapped and *@^#&$ by the kernel. Do not use.
 *
 * The third PCIe controller could be given an extra 256MB (or 1 GB
total, possibly)
 * by reserving extra memory in the LAW BARs (law.c) and TLBs (tlb.c)
 */

	/* Vidproc PCIe controller */
	pci0: pcie@8ff70a000 {
		cell-index = <1>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0x8 0xff70a000 0x0 0x00001000>;
		bus-range = <0 255>;	/* primary / subordinate */

		/*
		 * Memory		0x880000000-0x88fffffff 256 MB
		 * I/O			0xcc0000000-0xcc000ffff  64 KB
		 */
		ranges = <
			0x02000000			/* flags = IORESOURCE_MEM */
			0x0 0x80000000			/* start */
			0x8 0x80000000			/* parent-phys */
			0x0 0x10000000			/* size = 256 MB */

			0x01000000			/* flags = IORESOURCE_IO */
			0x0 0x00000000			/* start */
			0xc 0xc0000000			/* parent-phys */
			0x0 0x00010000			/* size = 64 KB */
		>;
		clock-frequency = <33333333>;
		interrupt-parent = <&mpic>;
		interrupts = <26 2>;	/* Internal interrupt 10 */
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		/*
		 * The second cell of an interrupt is the sense.
		 *
		 * Kernel	Sense		DTS
		 *   1		Edge Rising	 0
		 *   8		Level Low	 1
		 *   4		Level High	 2
		 *   2		Edge Falling	 3
		 */
		interrupt-map = <
			// IDSEL 0x0
			0000 0x0 0x0 0x1 &mpic 0x0 0x0
			0000 0x0 0x0 0x2 &mpic 0x1 0x0
			0000 0x0 0x0 0x3 &mpic 0x4 0x0
			0000 0x0 0x0 0x4 &mpic 0x4 0x0
			>;
		pcie@0 {
			reg = <0x0 0x0 0x0 0x0 0x0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <
				0x02000000			/* flags = IORESOURCE_MEM */
				0x0 0x80000000			/* start */
				0x02000000
				0x0 0x80000000
				0x0 0x10000000			/* size = 256 MB */

				0x01000000			/* flags = IORESOURCE_IO */
				0x0 0x0				/* start */
				0x01000000 0x0 0x0
				0x0 0x00010000>;		/* size = 64 KB */
		};
	};

	/* Not connected */
	pci1: pcie@8ff709000 {
		cell-index = <1>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0x8 0xff709000 0x0 0x00001000>;
		status = "disabled";
		bus-range = <0 255>;	/* primary / subordinate */

		/*
		 * Memory	0x990000000-0x99fffffff 256 MB
		 * I/O		0xcc0010000-0xcc001ffff  64 KB
		 */
		ranges = <
			0x02000000			/* flags = IORESOURCE_MEM */
			0x0 0x90000000			/* start */
			0x9 0x90000000			/* parent-phys */
			0x0 0x10000000			/* size = 256 MB */

			0x01000000			/* flags = IORESOURCE_IO */
			0x0 0x00000000			/* start */
			0xc 0xc0010000			/* parent-phys */
			0x0 0x00010000			/* size = 64 KB */
		>;
		clock-frequency = <33333333>;
		interrupt-parent = <&mpic>;
		interrupts = <26 2>;	/* Internal interrupt 10 */
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		/*
		 * The second cell of an interrupt is the sense.
		 *
		 * Kernel	Sense		DTS
		 *   1		Edge Rising	 0
		 *   8		Level Low	 1
		 *   4		Level High	 2
		 *   2		Edge Falling	 3
		 */
		interrupt-map = <
			// IDSEL 0x0
			0000 0x0 0x0 0x1 &mpic 0x0 0x0
			0000 0x0 0x0 0x2 &mpic 0x1 0x0
			0000 0x0 0x0 0x3 &mpic 0x4 0x0
			0000 0x0 0x0 0x4 &mpic 0x4 0x0
			>;
		pcie@0 {
			reg = <0x0 0x0 0x0 0x0 0x0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <
				0x02000000			/* flags = IORESOURCE_MEM */
				0x0 0x90000000			/* start */
				0x02000000
				0x0 0x90000000
				0x0 0x10000000			/* size = 256 MB */

				0x01000000			/* flags = IORESOURCE_IO */
				0x0 0x0				/* start */
				0x01000000
				0x0 0x0
				0x0 0x00010000>;		/* size = 64 KB */
		};
	};

	/* MMIB PCIe controller (x2 to PCIe switch) */
	pci2: pcie@8ff708000 {
		cell-index = <1>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0x8 0xff708000 0x0 0x00001000>;
		bus-range = <0 255>;	/* primary / subordinate */

		/*
		 * Memory	0xaa0000000-0xaafffffff 256 MB
		 * I/O		0xcc0020000-0xcc002ffff  64 KB
		 */
		ranges = <
			0x02000000			/* flags = IORESOURCE_MEM */
			0x0 0xa0000000			/* start */
			0xa 0xa0000000			/* parent-phys */
			0x0 0x10000000			/* size = 512 MB */

			0x01000000			/* flags = IORESOURCE_IO */
			0x0 0x00000000			/* start */
			0xc 0xc0020000			/* parent-phys */
			0x0 0x00010000			/* size = 64 KB */
		>;
		clock-frequency = <33333333>;
		interrupt-parent = <&mpic>;
		interrupts = <26 2>;	/* Internal interrupt 10 */
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		/*
		 * The second cell of an interrupt is the sense.
		 *
		 * Kernel	Sense		DTS
		 *   1		Edge Rising	 0
		 *   8		Level Low	 1
		 *   4		Level High	 2
		 *   2		Edge Falling	 3
		 */
		interrupt-map = <
			// IDSEL 0x0
			0000 0x0 0x0 0x1 &mpic 0x0 0x0
			0000 0x0 0x0 0x2 &mpic 0x1 0x0
			0000 0x0 0x0 0x3 &mpic 0x4 0x0
			0000 0x0 0x0 0x4 &mpic 0x4 0x0
			>;
		pcie@0 {
			reg = <0x0 0x0 0x0 0x0 0x0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <
				0x02000000			/* flags = IORESOURCE_MEM */
				0x0 0xa0000000			/* start */
				0x02000000
				0x0 0xa0000000
				0x0 0x10000000			/* size = 256 MB */

				0x01000000			/* flags = IORESOURCE_IO */
				0x0 0x0				/* start */
				0x01000000 0x0 0x0
				0x0 0x00010000>;		/* size = 64 KB */
		};
	};
};


LSPCI -v:
0000:00:00.0 PCI bridge: Freescale Semiconductor Inc P2020 (rev 21)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <ignored> (32-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-8fffffff
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting

0000:01:00.0 Network and computing encryption device: Altera
Corporation Device 0004 (rev 01)
        Subsystem: Altera Corporation Device 0004
        Flags: fast devsel, IRQ 23
        Memory at 880000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 881000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 882000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: altera
        Kernel modules: amazon_drivers

0001:02:00.0 PCI bridge: Freescale Semiconductor Inc P2020 (rev 21)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <ignored> (32-bit, non-prefetchable)
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 90000000-9fffffff
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting

0002:04:00.0 PCI bridge: Freescale Semiconductor Inc P2020 (rev 21)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <ignored> (32-bit, non-prefetchable)
        Bus: primary=00, secondary=05, subordinate=0a, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: a0000000-afffffff
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting

0002:05:00.0 PCI bridge: PLX Technology, Inc. Device 8606 (rev ba)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at aa8000000 (32-bit, non-prefetchable) [size=128K]
        Bus: primary=05, secondary=06, subordinate=0a, sec-latency=0
        Memory behind bridge: a0000000-a7ffffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Upstream Port, MSI 00
        Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8606
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [138] Power Budgeting <?>
        Capabilities: [148] Virtual Channel
        Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0
Len=0cc <?>
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

0002:06:01.0 PCI bridge: PLX Technology, Inc. Device 8606 (rev ba)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=06, secondary=07, subordinate=07, sec-latency=0
        Memory behind bridge: a0000000-a1ffffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8606
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

0002:06:05.0 PCI bridge: PLX Technology, Inc. Device 8606 (rev ba)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=06, secondary=08, subordinate=08, sec-latency=0
        Memory behind bridge: a2000000-a3ffffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8606
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

0002:06:07.0 PCI bridge: PLX Technology, Inc. Device 8606 (rev ba)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=06, secondary=09, subordinate=09, sec-latency=0
        Memory behind bridge: a4000000-a5ffffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8606
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

0002:06:09.0 PCI bridge: PLX Technology, Inc. Device 8606 (rev ba)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=06, secondary=0a, subordinate=0a, sec-latency=0
        Memory behind bridge: a6000000-a7ffffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8606
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

0002:07:00.0 Network and computing encryption device: Altera
Corporation Device 0004 (rev 01)
        Subsystem: Altera Corporation Device 0004
        Flags: fast devsel, IRQ 24
        Memory at aa0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at aa1000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: altera
        Kernel modules: amazon_drivers

0002:08:00.0 Network and computing encryption device: Altera
Corporation Device 0004 (rev 01)
        Subsystem: Altera Corporation Device 0004
        Flags: fast devsel, IRQ 24
        Memory at aa2000000 (32-bit, non-prefetchable) [size=16M]
        Memory at aa3000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: altera
        Kernel modules: amazon_drivers

0002:09:00.0 Network and computing encryption device: Altera
Corporation Device 0004 (rev 01)
        Subsystem: Altera Corporation Device 0004
        Flags: fast devsel, IRQ 25
        Memory at aa4000000 (32-bit, non-prefetchable) [size=16M]
        Memory at aa5000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: altera
        Kernel modules: amazon_drivers

0002:0a:00.0 Network and computing encryption device: Altera
Corporation Device 0004 (rev 01)
        Subsystem: Altera Corporation Device 0004
        Flags: fast devsel, IRQ 24
        Memory at aa6000000 (32-bit, non-prefetchable) [size=16M]
        Memory at aa7000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: altera
        Kernel modules: amazon_drivers
