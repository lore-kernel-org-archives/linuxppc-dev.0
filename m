Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE46D2C0113
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Sep 2013 00:54:11 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5232D778.20007@keymile.com>
Date: Fri, 13 Sep 2013 09:53:51 -0500
Message-Id: <1B0AEBE4-FAE3-405C-8BAE-CACF5B12CB59@kernel.crashing.org>
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
 <5232D778.20007@keymile.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>, scottwood@freescale.com,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 13, 2013, at 4:14 AM, Valentin Longchamp wrote:

> On 09/11/2013 08:58 AM, Prabhakar Kushwaha wrote:
>> The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 =
PA
>> processor cores with high-performance data path acceleration =
architecture
>> and network peripheral interfaces required for networking & =
telecommunications.
>>=20
>> T1042 personality is a reduced personality of T1040 without =
Integrated 8-port
>> Gigabit Ethernet switch.
>>=20
>> The T1040/T1042 SoC includes the following function and features:
>>=20
>> - Four e5500 cores, each with a private 256 KB L2 cache
>> - 256 KB shared L3 CoreNet platform cache (CPC)
>> - Interconnect CoreNet platform
>> - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and =
interleaving
>>   support
>> - Data Path Acceleration Architecture (DPAA) incorporating =
acceleration
>> for the following functions:
>>    -  Packet parsing, classification, and distribution
>>    -  Queue management for scheduling, packet sequencing, and =
congestion
>>    	management
>>    -  Cryptography Acceleration (SEC 5.0)
>>    - RegEx Pattern Matching Acceleration (PME 2.2)
>>    - IEEE Std 1588 support
>>    - Hardware buffer management for buffer allocation and =
deallocation
>> - Ethernet interfaces
>>    - Integrated 8-port Gigabit Ethernet switch (T1040 only)
>>    - Four 1 Gbps Ethernet controllers
>> - Two RGMII interfaces or one RGMII and one MII interfaces
>> - High speed peripheral interfaces
>>   - Four PCI Express 2.0 controllers running at up to 5 GHz
>>   - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
>>   - Upto two QSGMII interface
>>   - Upto six SGMII interface supporting 1000 Mbps
>>   - One SGMII interface supporting upto 2500 Mbps
>> - Additional peripheral interfaces
>>   - Two USB 2.0 controllers with integrated PHY
>>   - SD/eSDHC/eMMC
>>   -  eSPI controller
>>   - Four I2C controllers
>>   - Four UARTs
>>   - Four GPIO controllers
>>   - Integrated flash controller (IFC)
>>   - Change this to  LCD/ HDMI interface (DIU) with 12 bit dual data =
rate
>>   - TDM interface
>> - Multicore programmable interrupt controller (PIC)
>> - Two 8-channel DMA engines
>> - Single source clocking implementation
>> - Deep Sleep power implementaion (wakeup from =
GPIO/Timer/Ethernet/USB)
>>=20
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>> ---
>> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
>>=20
>> TODO: Add noded for ethernet
>>=20
>> arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  116 ++++++++
>> arch/powerpc/boot/dts/fsl/t1042si-post.dtsi |  430 =
+++++++++++++++++++++++++++
>> arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |  111 +++++++
>> 3 files changed, 657 insertions(+)
>> create mode 100644 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
>> create mode 100644 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
>> create mode 100644 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
>>=20
>=20
> I am currently working on a design bases on the p2041 but my issue =
seems to be
> generic to all the QorIQ dtsi files since the structure is exactly the =
same, so
> I pick the opportunity that such a file is submitted to the =
mailing-list to
> raise it.
>=20
> DISCLAIMER: I am no DTS expert, so there may be a way to achieve what =
I want to
> I have not seen.
>=20
> My understanding is that the SOC-NAMEsi-post.dtsi and =
SOC-NAMEsi-pre.dtsi are
> files that describe the SoC internals. They will be maintained when =
new drivers
> are merged or changed and therefore they should be used by all boards =
using the
> SoCs. Can someone confirm this or am I already wrong (since there are =
on
> Freescale boards that use them in mainline) ?

That is the intent. of the SOC*.dtsi files. =20

>=20
> [snip]
>=20
>> +
>> +&pci0 {
>> +	compatible =3D "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", =
"fsl,qoriq-pcie";
>> +	device_type =3D "pci";
>> +	#size-cells =3D <2>;
>> +	#address-cells =3D <3>;
>> +	bus-range =3D <0x0 0xff>;
>> +	interrupts =3D <20 2 0 0>;
>> +	fsl,iommu-parent =3D <&pamu0>;
>> +	pcie@0 {
>> +		reg =3D <0 0 0 0 0>;
>> +		#interrupt-cells =3D <1>;
>> +		#size-cells =3D <2>;
>> +		#address-cells =3D <3>;
>> +		device_type =3D "pci";
>> +		interrupts =3D <20 2 0 0>;
>> +		interrupt-map-mask =3D <0xf800 0 0 7>;
>> +		interrupt-map =3D <
>> +			/* IDSEL 0x0 */
>> +			0000 0 0 1 &mpic 40 1 0 0
>> +			0000 0 0 2 &mpic 1 1 0 0
>> +			0000 0 0 3 &mpic 2 1 0 0
>> +			0000 0 0 4 &mpic 3 1 0 0
>> +			>;
>> +	};
>> +};
>> +
>> +&pci1 {
>> +	compatible =3D "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", =
"fsl,qoriq-pcie";
>> +	device_type =3D "pci";
>> +	#size-cells =3D <2>;
>> +	#address-cells =3D <3>;
>> +	bus-range =3D <0 0xff>;
>> +	interrupts =3D <21 2 0 0>;
>> +	fsl,iommu-parent =3D <&pamu0>;
>> +	pcie@0 {
>> +		reg =3D <0 0 0 0 0>;
>> +		#interrupt-cells =3D <1>;
>> +		#size-cells =3D <2>;
>> +		#address-cells =3D <3>;
>> +		device_type =3D "pci";
>> +		interrupts =3D <21 2 0 0>;
>> +		interrupt-map-mask =3D <0xf800 0 0 7>;
>> +		interrupt-map =3D <
>> +			/* IDSEL 0x0 */
>> +			0000 0 0 1 &mpic 41 1 0 0
>> +			0000 0 0 2 &mpic 5 1 0 0
>> +			0000 0 0 3 &mpic 6 1 0 0
>> +			0000 0 0 4 &mpic 7 1 0 0
>> +			>;
>> +	};
>> +};
>> +
>> +&pci2 {
>> +	compatible =3D "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", =
"fsl,qoriq-pcie";
>> +	device_type =3D "pci";
>> +	#size-cells =3D <2>;
>> +	#address-cells =3D <3>;
>> +	bus-range =3D <0x0 0xff>;
>> +	interrupts =3D <22 2 0 0>;
>> +	fsl,iommu-parent =3D <&pamu0>;
>> +	pcie@0 {
>> +		reg =3D <0 0 0 0 0>;
>> +		#interrupt-cells =3D <1>;
>> +		#size-cells =3D <2>;
>> +		#address-cells =3D <3>;
>> +		device_type =3D "pci";
>> +		interrupts =3D <22 2 0 0>;
>> +		interrupt-map-mask =3D <0xf800 0 0 7>;
>> +		interrupt-map =3D <
>> +			/* IDSEL 0x0 */
>> +			0000 0 0 1 &mpic 42 1 0 0
>> +			0000 0 0 2 &mpic 9 1 0 0
>> +			0000 0 0 3 &mpic 10 1 0 0
>> +			0000 0 0 4 &mpic 11 1 0 0
>> +			>;
>> +	};
>> +};
>> +
>> +&pci3 {
>> +	compatible =3D "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", =
"fsl,qoriq-pcie";
>> +	device_type =3D "pci";
>> +	#size-cells =3D <2>;
>> +	#address-cells =3D <3>;
>> +	bus-range =3D <0x0 0xff>;
>> +	interrupts =3D <23 2 0 0>;
>> +	fsl,iommu-parent =3D <&pamu0>;
>> +	pcie@0 {
>> +		reg =3D <0 0 0 0 0>;
>> +		#interrupt-cells =3D <1>;
>> +		#size-cells =3D <2>;
>> +		#address-cells =3D <3>;
>> +		device_type =3D "pci";
>> +		interrupts =3D <23 2 0 0>;
>> +		interrupt-map-mask =3D <0xf800 0 0 7>;
>> +		interrupt-map =3D <
>> +			/* IDSEL 0x0 */
>> +			0000 0 0 1 &mpic 43 1 0 0
>> +			0000 0 0 2 &mpic 0 1 0 0
>> +			0000 0 0 3 &mpic 4 1 0 0
>> +			0000 0 0 4 &mpic 8 1 0 0
>> +			>;
>> +	};
>> +};
>> +
>=20
> The above 4 nodes have the consequence that it will then be mandatory =
that a
> board support .dts file that would like to inlcude the =
SOC-NAMEsi-post.dtsi
> defines the pci0, pci1, pci2, pci3 aliases.
>=20
> Now it is possible that a board does not implement pci1 for instance. =
So its
> .dts file would ideally not define a node for it, and thus not define =
the
> respective alias. However, this triggers this dtc compile error (which =
is correct):
>=20
>> [chlongv1@chber1-10533x linux-km]$ make kmp204x.dtb
>>  DTC     arch/powerpc/boot/kmp204x.dtb
>> Error: arch/powerpc/boot/dts/fsl/p2041si-post.dtsi:98.2-3 label or =
path, 'pci1', not found
>> FATAL ERROR: Syntax error parsing input tree
>> make[1]: *** [arch/powerpc/boot/kmp204x.dtb] Error 1
>> make: *** [kmp204x.dtb] Error 2
>=20
> The solution I have found is to define a "dummy" disabled node so that =
I can
> define the alias, but I am not really happy about this:
>=20
>> 	pci1: pcie@ffe201000 {
>> 		status =3D "disabled";
>> 	};
>=20
> I am here missing something obvious or shouldn't it be possible that =
such .dtsi
> files allow not to define unused/unnecessary nodes ?

Isn't this correct, that you are disabling the PCIe1 interface on the =
SoC for your board?

- k=
