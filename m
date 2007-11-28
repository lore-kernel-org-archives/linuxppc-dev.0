Return-Path: <robertlazarski@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by ozlabs.org (Postfix) with ESMTP id 7F2E9DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 08:45:29 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so734062ele
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 13:45:28 -0800 (PST)
Message-ID: <f87675ee0711281345t11cb530g7290d7edd4486d12@mail.gmail.com>
Date: Wed, 28 Nov 2007 16:45:27 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: Device tree and /proc/iomem question
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <7793CF97-2634-4EB2-B354-F842605BE2E6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711261026k65d2d4e3pe74697abbc39930e@mail.gmail.com>
	<7793CF97-2634-4EB2-B354-F842605BE2E6@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 28, 2007 2:02 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Take a look at the device trees in the kernel source.  You'll see we
> moved PCI around so its at the root level.  Not sure if that's your
> issue.
>
> > I see all the above in /proc/device-tree/soc8548@e0000000 when booting
> > the kernel. I double checked my memory mapping in u-boot and it
> > appears to match my device tree. Yet I don't see any pci here:
> >
> > root:~> cat /proc/iomem
> > e0004500-e0004507 : serial
> > e0004600-e0004607 : serial
> > e0024000-e0024fff : ethernet
> >  e0024520-e002453f : mdio
> > e0025000-e0025fff : ethernet
> > e0026000-e0026fff : ethernet
> > e0027000-e0027fff : ethernet
> >
> > cat /proc/bus/pci/devices shows nothing though I have a card in PCI1,
> > and all I see from dmesg is "PCI: Probing PCI hardware" . Any ideas?
>
> It seems like its not even really probing or finding the buses.
>
> Can you post what your board/platform code looks like?
>
> - k
>

Indeed, for 2.6.24RC2 I had to move PCI to the root level and I also
had some problems in my board/platform code. I still seem to have
problems though - I have a common intel pro 100 card in PCI1 that
doesn't seem to be detected. Here's what I have now:

bash-3.00# lspci -v
00:00.0 Class 0b20: 1057:0012 (rev 20)
        Flags: bus master, 66Mhz, fast devsel, latency 128, IRQ 19
        Memory at <unassigned> (32-bit, prefetchable)
        Memory at <unassigned> (64-bit, non-prefetchable)
        Memory at <unassigned> (64-bit, non-prefetchable)
        Capabilities: [60] #00 [0000]

I need to run the bus at 33MHZ. The devices seem to mapped correctly now:

bash-3.00# cat /proc/iomem
80000000-9fffffff : /pci@e0008000
a0000000-bfffffff : /pcie@e000a000
c0000000-dfffffff : /pci@e000c000
e0004500-e0004507 : serial
e0004600-e0004607 : serial
e0024000-e0024fff : ethernet
  e0024520-e002453f : mdio
e0025000-e0025fff : ethernet
e0026000-e0026fff : ethernet
e0027000-e0027fff : ethernet

bash-3.00# cat /proc/ioports
00000000-000fffff : /pci@e0008000
feefc000-ffefbfff : /pcie@e000a000
ffefe000-ffffdfff : /pci@e000c000

This is a custom 8548 board we are trying to bring PCI up on and I'm
not sure if the hardware has issues, or my code is the issue. Here's
my current PCI tree which is now at the root level. My u-boot memory
map matches this AFAICT. Any further ideas greatly appreciated:

	pci@e0008000 {
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x11 J17 Slot 1 */
			8800 0 0 1 &mpic 2 1
			8800 0 0 2 &mpic 3 1
			8800 0 0 3 &mpic 4 1
			8800 0 0 4 &mpic 1 1

			/* IDSEL 0x12 J16 Slot 2 */

			9000 0 0 1 &mpic 3 1
			9000 0 0 2 &mpic 4 1
			9000 0 0 3 &mpic 2 1
			9000 0 0 4 &mpic 1 1>;

		interrupt-parent = <&mpic>;
		interrupts = <18 2>;
		bus-range = <0 ff>;
		ranges = <02000000 0 80000000 80000000 0 20000000
			  01000000 0 00000000 e2000000 0 00100000>;
		clock-frequency = <1fca055>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e0008000 1000>;
		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
		device_type = "pci";
	};

	pci@e000c000 {
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x11 J17 Slot 1 */
			8800 0 0 1 &mpic 2 1
			8800 0 0 2 &mpic 3 1
			8800 0 0 3 &mpic 4 1
			8800 0 0 4 &mpic 1 1

			/* IDSEL 0x12 J16 Slot 2 */

			9000 0 0 1 &mpic 3 1
			9000 0 0 2 &mpic 4 1
			9000 0 0 3 &mpic 2 1
			9000 0 0 4 &mpic 1 1>;

		interrupt-parent = <&mpic>;
		interrupts = <18 2>;
		bus-range = <0 ff>;
		ranges = <02000000 0 c0000000 c0000000 0 20000000
			  01000000 0 00000000 e2800000 0 00100000>;
		clock-frequency = <1fca055>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e000c000 1000>;
		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
		device_type = "pci";
	};

	pcie@e000a000 {
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x0 (PEX) */
			00000 0 0 1 &mpic 0 1
			00000 0 0 2 &mpic 1 1
			00000 0 0 3 &mpic 2 1
			00000 0 0 4 &mpic 3 1>;

		interrupt-parent = <&mpic>;
		interrupts = <1a 2>;
		bus-range = <0 ff>;
		ranges = <02000000 0 a0000000 a0000000 0 20000000
			  01000000 0 00000000 e3000000 0 08000000>;
		clock-frequency = <1fca055>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e000a000 1000>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		pcie@0 {
			reg = <0 0 0 0 0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <02000000 0 a0000000
				  02000000 0 a0000000
				  0 20000000

				  01000000 0 00000000
				  01000000 0 00000000
				  0 08000000>;
		};
	};

Thanks!
Robert
