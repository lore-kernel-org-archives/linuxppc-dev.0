Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 89C25DDDA5
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 07:34:10 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so795690yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Apr 2009 13:34:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1238613385.5034.15.camel@roderick64>
References: <1238613385.5034.15.camel@roderick64>
Date: Fri, 3 Apr 2009 14:33:53 -0600
Message-ID: <fa686aa40904031333l5cbf2e54j76b42ed07a097eda@mail.gmail.com>
Subject: Re: Draft version of ML510 Linux patch (patch inlined)
From: Grant Likely <grant.likely@secretlab.ca>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 1, 2009 at 1:16 PM, Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
> Hi,
>
> As requested by Grant Likely here the same patch but now inlined.

word wrapped.  neener neener.

Mostly looks good to me.  It would help to split the PCI driver out
into a separate patch from the board support.  Comments below.

> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/boot/dts/virtex440-ml510.dts
> ml510-dev/linux-2.6.29/arch/powerpc/boot/dts/virtex440-ml510.dts
> --- linux-2.6.29/arch/powerpc/boot/dts/virtex440-ml510.dts
> +++ ml510-dev/linux-2.6.29/arch/powerpc/boot/dts/virtex440-ml510.dts

A bunch of oddities in this .dts file; but that's not your fault.  The
xilinx device tree generator needs some TLC.

> +/dts-v1/;
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +       compatible =3D "xlnx,ml510-ref-design";

I still haven't decided how best to handle the board level compatible
value for the Virtex, but this will do for now.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plbv46_pci_0: plbv46-pci@85e00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,plbv46=
-pci-1.03.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x85e00000 0x1000=
0 >; /* addr is at +0x10c, data at +0x110
> */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The PCI bus is implement=
ed by a soft-core which is connected to
> the PLB bus which is seen by the CPU at 0xa0000000.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Both the PLB and PCI h=
ave their own address domain. The PCI
> soft-core performs this translation. The Xilinx plbpci doc
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mentions 'the number o=
f high-order bits substituted in the PLB
> address presented to the bridge is given by the number
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of bits that are the S=
AME between C_IPIFBAR_N and
> C_IPIF_HIGHADDR_N.'
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For the default ml510_=
bsb1_pcores_ppc440 reference design this
> means:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIFBAR_0 =A0 =A0 =
=A0 =A0=3D 0xa0000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIF_HIGHADDR_0 =A0=
=3D 0xbfffffff <- only the last 3 bits of
> (0xa=3D1010b, 0xb=3D1011b) are similar
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIFBAR2PCIBAR_0 =3D=
 0x00000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIFBAR_1 =A0 =A0 =
=A0 =A0=3D 0x94000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIF_HIGHADDR_1 =A0=
=3D 0x97ffffff <- only the last 6 bits are
> similar
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C_IPIFBAR2PCIBAR_1 =3D=
 0x00000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This means that a CPU =
write to 0xa0001234 translates to
> 0x00001234 on the PCI bus and that
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the pcibar_0 base and =
pcibar_1 base are zero. In order to prevent
> collision between inbound
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and outbound memory re=
ads/writes C_IPIFBAR2PCIBAR_0 needs to be
> set to 0x80000000.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/

Line lengths, especially in comment blocks, should be restricted to 80
characters.

This description really belongs in the device tree binding
documentation in Documentation/powerpc/dts-bindings because it is not
ml510 specific.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x02000000 0x00=
000000 0x80000000 0xa0000000 0x00000000
> 0x20000000

I think we've been over this before, but why do the PLB and PCI
addresses differ here?  For mem regions I:q
t is legal for them to be different, but things are simpler if they match.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01000=
000 0x00000000 0x00000000 0x94000000 0x00000000
> 0x00010000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_=
intc_0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map-mask =3D <0xf=
f00 0x0 0x0 0x7>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x=
15 / dev=3D5, bus=3D0 / PCI slot 5 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pci irq =
a is connected to xintc irq 5, b to 4, c to 3 and d to 2
> */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Accordin=
g to the datasheet + schematic ABCD [FPGA] of slot 5 is
> mapped to DABC, testing showed that at least A maps to B */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 =
1 &xps_intc_0 4 2
> +// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 2 =
&xps_intc_0 5 2
> +// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 3 =
&xps_intc_0 4 2
> +// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 4 =
&xps_intc_0 3 2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x=
16 / dev=3D6, bus=3D0 / PCI slot 3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 =
1 &xps_intc_0 3 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 =
2 &xps_intc_0 2 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 =
3 &xps_intc_0 5 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 =
4 &xps_intc_0 4 2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x=
11 / dev=3D1, bus=3D0 / AC97 audio */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0800 0 0 =
1 &i8259 7 2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x=
1b / dev=3D11, bus=3D0 / IDE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5800 0 0 =
1 &i8259 14 2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x=
1f / dev 15, bus=3D0 / USB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x7800 0 0 =
1 &i8259 7 2

What about the other ALI devices?  May as well fill those in too.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ali_m1533 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells=
 =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-ce=
lls =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i8259: inte=
rrupt-controller@20 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 reg =3D <1 0x20 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 0xa0 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 0x4d0 2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 device_type =3D "interrupt-controller";

You should be able to drop device_type here

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 #address-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 #interrupt-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 compatible =3D "chrp,iic";
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 interrupts =3D <1 2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 interrupt-parent =3D <&xps_intc_0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffff=
0000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-br=
am-if-cntlr-1.00.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0xffff0000 0x1000=
0 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xps_intc_0: interrupt-controller@81800000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <0x2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-in=
tc-1.00.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81800000 0x1000=
0 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-intr-inputs =3D <0=
xc>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
> + =A0 =A0 =A0 } ;
> +} =A0;

> linux-2.6.29/arch/powerpc/configs/44x/virtex5_defconfig
> ml510-dev/linux-2.6.29/arch/powerpc/configs/44x/virtex5_defconfig
> --- linux-2.6.29/arch/powerpc/configs/44x/virtex5_defconfig =A0 =A0 2009-=
03-24
> 00:12:14.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/configs/44x/virtex5_defconfig

Put the defconfig changes into a separate patch.

> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/platforms/44x/Kconfig
> ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/Kconfig
> --- linux-2.6.29/arch/powerpc/platforms/44x/Kconfig =A0 =A0 2009-03-24
> 00:12:14.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/Kconfig =A0 2009-03=
-27
> 15:50:28.000000000 +0100
> @@ -160,6 +160,16 @@
> =A0 =A0 =A0 =A0 =A0Most Virtex 5 designs should use this unless it needs =
to do some
> =A0 =A0 =A0 =A0 =A0special configuration at board probe time.
>
> +config XILINX_ML510
> + =A0 =A0 =A0 bool "Xilinx ML510 Reference Design support"
> + =A0 =A0 =A0 depends on 44x
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 select XILINX_VIRTEX_5_FXT
> + =A0 =A0 =A0 select PPC_PCI_CHOICE
> + =A0 =A0 =A0 select XILINX_VIRTEX_PCI if PCI
> + =A0 =A0 =A0 select PPC_INDIRECT_PCI if PCI
> + =A0 =A0 =A0 select PPC_I8259 if PCI
> +
> =A0config PPC44x_SIMPLE
> =A0 =A0 =A0 =A0bool "Simple PowerPC 44x board support"
> =A0 =A0 =A0 =A0depends on 44x
> @@ -232,4 +242,3 @@
> =A0config XILINX_VIRTEX_5_FXT
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0select XILINX_VIRTEX
> -
^^^^^^^^^^^^^^^^^^^^^^
unrelated whitespace change

> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/platforms/44x/Makefile
> ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/Makefile
> --- linux-2.6.29/arch/powerpc/platforms/44x/Makefile =A0 =A02009-03-24
> 00:12:14.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/Makefile
> 2009-04-01 11:59:28.000000000 +0200
> @@ -4,3 +4,4 @@
> =A0obj-$(CONFIG_SAM440EP) =A0 =A0 =A0 =A0 +=3D sam440ep.o
> =A0obj-$(CONFIG_WARP) =A0 =A0 +=3D warp.o
> =A0obj-$(CONFIG_XILINX_VIRTEX_5_FXT) +=3D virtex.o
> +obj-$(CONFIG_XILINX_ML510) +=3D ml510.o
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^
Fix this.

> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/platforms/44x/ml510.c
> ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/ml510.c
> --- linux-2.6.29/arch/powerpc/platforms/44x/ml510.c =A0 =A0 1970-01-01
> 01:00:00.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/platforms/44x/ml510.c =A0 2009-04=
-01
> 12:42:28.000000000 +0200
> @@ -0,0 +1,161 @@
> +/*
> + * Xilinx ML510 Reference Design support, derived from
> + * the generic Xilinx Virtex 5 board support
> + *
> + * Copyright 2007 Secret Lab Technologies Ltd.
> + * Copyright 2008 Xilinx, Inc.
> + * Copyright 2009 Roderick Colenbrander
> + *
> + * The i8259 cascade code was derived from 86xx/pic.c which is
> copyrighted by Freescale Semiconductor, Inc.
> + * Xilinx ML510 PCI initialization code, derived from the Xilinx
> ML300/ML410 based board support.

Keep line lengths under 80 characters.

> + *
> + * This file is licensed under the terms of the GNU General Public
> License
> + * version 2. This program is licensed "as is" without any warranty of
> any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/time.h>
> +#include <asm/xilinx_intc.h>
> +#include <asm/reg.h>
> +#include <asm/ppc4xx.h>
> +#ifdef CONFIG_PPC_I8259
> +#include <asm/i8259.h>
> +#endif
> +#ifdef CONFIG_PCI
> +#include <linux/pci.h>
> +#endif
> +#include "44x.h"
> +
> +static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "simple-bus", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v46-1.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v46-1.02.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v34-1.01.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v34-1.02.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,opb-v20-1.10.c", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,dcr-v29-1.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,compound", },
> + =A0 =A0 =A0 {}
> +};
> +
> +#ifdef CONFIG_PPC_I8259
> +static void ml510_8259_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> + =A0 =A0 =A0 unsigned int cascade_irq =3D i8259_irq();
> + =A0 =A0 =A0 if (cascade_irq !=3D NO_IRQ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(cascade_irq);
> +
> + =A0 =A0 =A0 /* Let xilinx_intc end the interrupt */
> + =A0 =A0 =A0 desc->chip->ack(irq);
> + =A0 =A0 =A0 desc->chip->unmask(irq);
> +}
> +
> +static void __init ml510_setup_i8259_cascade(void)
> +{
> + =A0 =A0 =A0 struct device_node *np, *cascade_node =3D NULL;
> + =A0 =A0 =A0 int cascade_irq;
> +
> + =A0 =A0 =A0 /* Initialize i8259 controller */
> + =A0 =A0 =A0 for_each_node_by_type(np, "interrupt-controller")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible=
(np, "chrp,iic")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cascade_node =3D np;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (cascade_node =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "Could no=
t find i8259 PIC\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cascade_irq =3D irq_of_parse_and_map(cascade_node, 0);
> + =A0 =A0 =A0 if (cascade_irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to =
map cascade interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i8259_init(cascade_node, 0);
> +
> + =A0 =A0 =A0 of_node_put(cascade_node);
> + =A0 =A0 =A0 set_irq_chained_handler(cascade_irq, ml510_8259_cascade);
> +}
> +#endif /* CONFIG_PPC_I8259 */
> +
> +#ifdef CONFIG_PCI
> +static void __devinit ali_quirk(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 /* Enable the IDE controller */
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x58, 0x4c);
> + =A0 =A0 =A0 /* Assign irq 14 to the primary ide channel */
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x44, 0x0d);
> + =A0 =A0 =A0 /* Assign irq 15 to the secondary ide channel */
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x75, 0x0f);
> + =A0 =A0 =A0 /* Set the ide controller in native mode */
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x09, 0xff);
> +
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x48, 0x00); // INTB =3D disable=
d, INTA =3D
> disabled
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x4a, 0x00); // INTD =3D disable=
d, INTC =3D
> disabled
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x4b, 0x00); // Audio =3D INT7, =
Modem =3D
> disabled.
> + =A0 =A0 =A0 pci_write_config_byte(dev, 0x74, 0x06); // USB =3D INT7
> +}
> +DECLARE_PCI_FIXUP_EARLY(0x10b9, 0x1533, ali_quirk);
> +#endif /* CONFIG_PCI */
> +
> +static int __init ml510_device_probe(void)
> +{
> + =A0 =A0 =A0 of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +machine_device_initcall(ml510, ml510_device_probe);
> +
> +static int __init ml510_probe(void)
> +{
> + =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();
> +
> + =A0 =A0 =A0 if (!of_flat_dt_is_compatible(root, "xlnx,ml510-ref-design"=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return 1;

or just: return of_flat_dt_is_compatible(root, "xlnx,ml510-ref-design");

> +}
> +
> +void virtex_pci_init(void);
> +static void __init ml510_setup_arch(void)
> +{
> + =A0 =A0 =A0 struct device_node *pci_node =3D of_find_compatible_node(NU=
LL, NULL,
> "xlnx,plbv46-pci-1.03.a");
> +
> +#ifdef CONFIG_PCI
> + =A0 =A0 =A0 if(pci_node)
> + =A0 =A0 =A0 {
> +//Is this the right way or should this be done using OF?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the host bridge */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtex_pci_init();
> + =A0 =A0 =A0 }

No, you don't need to use of_platform bus here.  Doing it with
discrete reads of the device tree is fine.  However, you should move
the of_find_compatible_node() call into virtex_pci_init() itself.

Oh, and don't use '//' style comments.

> +#endif /* CONFIG_PCI */
> +}
> +
> +static void ml510_init_IRQ(void)
> +{
> + =A0 =A0 =A0 xilinx_intc_init_tree();
> +
> +#ifdef CONFIG_PPC_I8259
> + =A0 =A0 =A0 /* The devices on the ALI M1553 south bridge are connected =
to an
> internal i8259 */
> + =A0 =A0 =A0 ml510_setup_i8259_cascade();
> + =A0 =A0 =A0 /* Program irq 7 (usb/audio), 14/15 (ide) to level sensitiv=
e */
> + =A0 =A0 =A0 outb(0xc0, 0x4d0);
> + =A0 =A0 =A0 outb(0xc0, 0x4d1);
> +#endif /* CONFIG_PPC_I8259 */
> +}
> +
> +define_machine(ml510) {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "Xilinx ML510=
 Reference Design support",
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ml510_probe,
> + =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D ml510_setup_arch,
> + =A0 =A0 =A0 .init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ml510_init_IRQ,
> + =A0 =A0 =A0 .get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D xilinx_intc_get=
_irq,
> + =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr,
> + =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ppc4xx_reset_sy=
stem,
> +};
> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/sysdev/Kconfig
> ml510-dev/linux-2.6.29/arch/powerpc/sysdev/Kconfig
> --- linux-2.6.29/arch/powerpc/sysdev/Kconfig =A0 =A02009-03-24
> 00:12:14.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/sysdev/Kconfig =A02009-03-27
> 12:50:29.000000000 +0100
> @@ -12,3 +12,7 @@
> =A0 =A0 =A0 =A0depends on PCI_MSI
> =A0 =A0 =A0 =A0default y if MPIC
> =A0 =A0 =A0 =A0default y if FSL_PCI
> +
> +config XILINX_VIRTEX_PCI
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on PCI
> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/sysdev/Makefile
> ml510-dev/linux-2.6.29/arch/powerpc/sysdev/Makefile
> --- linux-2.6.29/arch/powerpc/sysdev/Makefile =A0 2009-03-24
> 00:12:14.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/sysdev/Makefile 2009-03-27
> 11:57:45.000000000 +0100
> @@ -34,6 +34,7 @@
> =A0obj-$(CONFIG_4xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D uic.o
> =A0obj-$(CONFIG_4xx_SOC) =A0 =A0 =A0 =A0 =A0+=3D ppc4xx_soc.o
> =A0obj-$(CONFIG_XILINX_VIRTEX) =A0 =A0+=3D xilinx_intc.o
> +obj-$(CONFIG_XILINX_VIRTEX_PCI) =A0 =A0 =A0 =A0+=3D virtex_pci.o
> =A0obj-$(CONFIG_OF_RTC) =A0 =A0 =A0 =A0 =A0 +=3D of_rtc.o
> =A0ifeq ($(CONFIG_PCI),y)
> =A0obj-$(CONFIG_4xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D ppc4xx_pci.o
> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/arch/powerpc/sysdev/virtex_pci.c
> ml510-dev/linux-2.6.29/arch/powerpc/sysdev/virtex_pci.c
> --- linux-2.6.29/arch/powerpc/sysdev/virtex_pci.c =A0 =A0 =A0 1970-01-01
> 01:00:00.000000000 +0100
> +++ ml510-dev/linux-2.6.29/arch/powerpc/sysdev/virtex_pci.c =A0 =A0 2009-=
04-01
> 12:54:42.000000000 +0200
> @@ -0,0 +1,95 @@
> +/*
> + * PCI support for Xilinx plbv46_pci soft-core which can be used on
> Xilinx Virtex ML410 / ML510 boards.
> + *
> + * Copyright 2009 Roderick Colenbrander
> + *
> + * The pci bridge fixup code was copied from ppc4xx_pci.c and was
> written by Benjamin Herrenschmidt.
> + * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM
> Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public
> License
> + * version 2. This program is licensed "as is" without any warranty of
> any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/pci.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/io.h>
> +
> +#define XPLB_PCI_ADDR 0x10c
> +#define XPLB_PCI_DATA 0x110
> +#define XPLB_PCI_BUS =A00x114
> +
> +#define PCI_HOST_ENABLE_CMD PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
> PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
> +
> +static void fixup_virtex_pci_bridge(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct pci_controller *hose;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (dev->devfn !=3D 0 || dev->bus->self !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

Could simply be: if (dev->devfn || dev->bus->self)

> +
> + =A0 =A0 =A0 hose =3D pci_bus_to_host(dev->bus);
> + =A0 =A0 =A0 if (hose =3D=3D NULL)

if (!hose)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if(!of_device_is_compatible(hose->dn, "xlnx,plbv46-pci-1.03=
.a"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* Hide the PCI host BARs from the kernel as their content =
doesn't
> + =A0 =A0 =A0 =A0* fit well in the resource management
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->resource[i].start =3D dev->resource[i]=
.end =3D 0;

Chaining up start =3D end =3D 0 like this is discouraged.  Use one
assignment per line.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->resource[i].flags =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 printk(KERN_INFO "PCI: Hiding Xilinx plb-pci host bridge re=
sources %s
> \n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_name(dev));

replace printk(KERN_INFO "...");  with dev_info();

> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> fixup_virtex_pci_bridge);
> +
> +void virtex_pci_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *pci_node =3D of_find_compatible_node(NU=
LL, NULL,
> "xlnx,plbv46-pci-1.03.a");
> +
> + =A0 =A0 =A0 if(pci_node)
> + =A0 =A0 =A0 {

if (!pci_node)
        return;

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_controller *hose;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *pci_reg;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Found a Xilinx plb-pci host bridge\=
n");

ditto here

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(of_address_to_resource(pci_node, 0, &r))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("No address for Xili=
nx plb-pci host bridge\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose =3D pcibios_alloc_controller(pci_node)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hose)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->first_busno =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->last_busno =3D 1; /* there are two sl=
ots behind a TI2250
> pci-to-pci bridge */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup config space */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setup_indirect_pci(hose, r.start + XPLB_PCI=
_ADDR, r.start +
> XPLB_PCI_DATA, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* According to the xilinx plbv46_pci docum=
entation the soft-core
> starts a self-init when the bus master enable bit is set.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Without this bit set the pci bus can't=
 be scanned. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 early_write_config_word(hose, 0, 0, PCI_COM=
MAND,
> PCI_HOST_ENABLE_CMD);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the max latency timer to 255 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 early_write_config_byte(hose, 0, 0, PCI_LAT=
ENCY_TIMER, 0xff);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the max bus number to 255 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_reg =3D of_iomap(pci_node, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(pci_reg + XPLB_PCI_BUS, 0xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(pci_reg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the host bridge with the linux =
kernel! */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_process_bridge_OF_ranges(hose, pci_node=
, 1 /* primary=3Dyes */);

Drop the comment in the parameters.  Readers will go and look at the
declaration of pci_process_bridge_OF_ranges()

> + =A0 =A0 =A0 }
> +}
> diff -urN -X linux-2.6.29/Documentation/dontdiff
> linux-2.6.29/drivers/ide/alim15x3.c
> ml510-dev/linux-2.6.29/drivers/ide/alim15x3.c
> --- linux-2.6.29/drivers/ide/alim15x3.c 2009-03-24 00:12:14.000000000
> +0100
> +++ ml510-dev/linux-2.6.29/drivers/ide/alim15x3.c =A0 =A0 =A0 2009-03-27
> 14:47:50.000000000 +0100
> @@ -401,7 +401,8 @@
> =A0 =A0 =A0 =A0return cbl;
> =A0}
>
> -#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
> +#if !defined(CONFIG_SPARC64)
> +// && !defined(CONFIG_PPC)

heh, I think you know what you need to do here.

> =A0/**
> =A0* =A0 =A0 init_hwif_ali15x3 =A0 =A0 =A0 - =A0 =A0 =A0 Initialize the A=
LI IDE x86 stuff
> =A0* =A0 =A0 @hwif: interface to configure
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
