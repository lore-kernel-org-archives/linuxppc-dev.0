Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id EFB50B7D29
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 18:36:01 +1100 (EST)
Received: by ywh41 with SMTP id 41so3429123ywh.9
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 23:36:00 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B95F298.5040000@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Mar 2010 00:35:40 -0700
Message-ID: <fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/9 N=E9meth M=E1rton <nm127@freemail.hu>:
> Hi,
> Grant Likely wrote:
>> 2010/3/8 N=E9meth M=E1rton <nm127@freemail.hu>:
>>> Grant Likely wrote:
>>>> 2010/3/6 N=E9meth M=E1rton <nm127@freemail.hu>:
>>>>> Hi,
>>>>>
>>>>> I'm trying to cross-compile Linux 2.6.33 for Freescale MPC5554 [1][2]=
. This
>>>>> microcontroller is based on the e200z6 core. I could build the cross-=
development
>>>>> tools, but I could miss something because I get an error message when=
 building
>>>>> Linux for PowerPC e200 core. Here are the steps I used:
>>>> I doubt you'll have much luck with the mpc5554. =A0Linux doesn't inclu=
de
>>>> any support for the MPC5554, and I don't think anybody is working on
>>>> it. =A0Any of the mpc5554 systems I've see don't have enough ram to ru=
n
>>>> Linux well.
>>> I'm ready to work a bit more than just compiling the kernel and run it =
on MPC5554.
>>> On my target system there is a possibility to use external RAM connecte=
d to the
>>> External Bus Interface, so I don't see this would be a problem in my ca=
se.
>>>
>>> However, I have not much experience running Linux on PowerPC environmen=
t. Could
>>> you suggest a PowerPC port which would be a good starting point to make=
 support
>>> for MPC5554?
>>
>> I'd use the MPC5200 board support as a starting point
>> (arch/powerpc/platforms/52xx). =A0Create yourself a new directory for
>> this platform (arch/powerpc/platforms/55xx)
>>
>>> As far as I could find out I'll need to create a device tree as documen=
ted in
>>> the linux/Documentation/powerpc/booting-without-of.txt file.
>>
>> Yes, you'll need to create a device tree file for the board. =A0Again,
>> start from an existing 5200 .dts file. =A0You won't need very much in it
>> to get started. =A0I'd be happy to help you get the structure right.
>
> I tried to create a first draft of the deveice tree for MPC5554. It is
> compilable with dtc. I based this .dts file on Figure 1-1 on page 1-3 and
> Table 1-2 on page 1-21 of http://www.freescale.com/files/32bit/doc/ref_ma=
nual/MPC5553_MPC5554_RM.pdf .
>
> I'm not sure about the following points:
> 1. Where should be the on-chip FLASH described? This memory is read-only =
from
> =A0 view of software and can be used to store read-only data or execute c=
ode directly
> =A0 from there.

Hang it off the xbar node.  Name it flash@<address>, and use
'compatible =3D "fsl,mpc5554-flash";'

>
> 2. Should the co-processor (eTPU in this case) also listed in section "cp=
us"
> =A0 or not? This co-processor is not able to run code like the e200z6.

No, this is a device.  Hang it off the peripheral bridge a node.

> 3. There are three on-chip buses on MPC5554:
> =A0 - Crossbar Switch (XBAR)
> =A0 - Peripheral Bridge A (PBRIDGE_A)
> =A0 - Peripheral Bridge B (PBRIDGE_B)
> =A0 I used PBRIDGE_A and PRIDGE_B to create two /soc<SOCname> entries. Is=
 this possible?

the soc5200 naming was poorly chosen when the 5200 device tree was
written.  Use something like this:

xbar@<control-regs-base-address> {
        compatible =3D "fsl,mpc5554-xbar";
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges =3D <[put the translation ranges in here]>;
        reg =3D <address and size of xbar control registers>;

        bridge@<bridgea-base-address> {
                compatible =3D "fsl,mpc5554-pbridge-a";
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <[put the translation ranges in here]>;
                reg =3D <address and size of bridge control registers>;
                [... child device nodes ...]
        };
        bridge@<bridgea-base-address> {
                compatible =3D "fsl,mpc5554-pbridge-b";
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <[put the translation ranges in here]>;
                reg =3D <address and size of bridge control registers>;
                [... child device nodes ...]
        };
};

The idea is to use generic names for the node names, and identify
exactly what the device is by using the "compatible" property.  Also,
the aim is to build up a tree describing the interconnection of device
from the perspective of the OS on the CPU.  ie.  the full physical
address space is represented by the root node of the tree, and
everything else hangs off that.

> 4. There are modules which have multiple instances at different base addr=
esses. These
> =A0 are DSPI, SCI and FlexCAN. I used the same name for them but with dif=
ferent addresses.
> =A0 Is this correct?

yes.

> +/ {
> + =A0 =A0 =A0 model =3D "MPC5554";
> + =A0 =A0 =A0 compatible =3D "MPC5554";

Use the board name here in the form "<manufacturer>,<board>", not the SoC n=
ame.

> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PowerPC,5554@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32KiB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32KiB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <0>;=
 =A0 =A0 =A0 // from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0>; =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 flash { // read-only FLASH

flash@0

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x200000>; =A0 =A0// 2M=
iB internal FLASH
> + =A0 =A0 =A0 };

remove device_type from this node.  Only a few special nodes should
have device_type.  Make the flash node a child of the xbar node.

> +
> + =A0 =A0 =A0 memory {

memory@400000000

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x10000>; =A0 =A0 // 32=
KiB internal SRAM
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 soc5554BridgeA@c0000000 {

bridge@c0000000

Make this node a child of the xbar node.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554-bridgea";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0xc0000000 0x20000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xc0000000 0x20000000>;

The reg property here should only cover the bridge's control register.
 Not the whole range of the bridge.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =A0 =A0 =A0 =A0 =
=A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 system-frequency =3D <0>; =A0 =A0 =A0 =A0 /=
/ from bootloader
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridgea@3f00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-bridgea";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03f00000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmpll@3f80000 { =A0 =A0 =A0 =A0 // Frequenc=
y Modulated PLL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-fmpll";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03f80000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flashconfig@3f88000 { =A0 // Flash Configur=
ation
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-flashconfig";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03f88000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 siu@3f89000 { =A0 =A0 =A0 =A0 =A0 // System=
 Integration Unit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-siu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03f90000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emios@3fa0000 { =A0 =A0 =A0 =A0 // Modular =
Timer System
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-emios";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03fa0000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etpu@3fc0000 { =A0 =A0 =A0 =A0 =A0// Enhanc=
ed Time Processing Unit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-etpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03fc0000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etpudata@3fc8000 { =A0 =A0 =A0// eTPU Share=
d Data Memory (Parameter RAM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-etpudata";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03fc8000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etpudata@3fcc000 { =A0 =A0 =A0// eTPU Share=
d Data Memory (Parameter RAM) mirror
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-etpudata";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03fcc000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etpucode@3fd0000 { =A0 =A0 =A0 =A0 =A0 =A0 =
=A0// eTPU Shared Code RAM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-etpucode";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x03fd0000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 soc5554BridgeB@e0000000 {

bridge@e0000000

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554-bridgeb";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0xe0000000 0x20000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xe0000000 0x20000000>;

ditto on comment from bridge a

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =A0 =A0 =A0 =A0 =
=A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 system-frequency =3D <0>; =A0 =A0 =A0 =A0 /=
/ from bootloader
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridgeb@1ff00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-bridgeb";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff00000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xbar@1ff04000 { =A0 =A0 =A0 =A0 // System B=
us Crossbar Switch (XBAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-xbar";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff04000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

The block diagram seems to suggest that the xbar should be the root of
the tree, and the peripheral bridges should be children of it.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecsm@1ff40000 { =A0 =A0 =A0 =A0 // Error Co=
rrection Status Module (ECSM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-ecsm";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff40000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma@1ff44000 { =A0 =A0 =A0 =A0 // Enhanced=
 DMA Controller (eDMA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-edma";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff44000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 intc@1ff48000 { =A0 =A0 =A0 =A0 // Interrup=
t Controller (INTC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-intc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff48000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eqadc@1ff80000 { =A0 =A0 =A0 =A0// Enhanced=
 Queued Analog-to-Digital Converter (eQADC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-eqacd";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff80000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi@1ff90000 { =A0 =A0 =A0 =A0 // Deserial=
 Serial Peripheral Interface (DSPI_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-dspi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff90000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi@1ff94000 { =A0 =A0 =A0 =A0 // Deserial=
 Serial Peripheral Interface (DSPI_B)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-dspi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff94000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi@1ff98000 { =A0 =A0 =A0 =A0 // Deserial=
 Serial Peripheral Interface (DSPI_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-dspi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff98000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi@1ff9c000 { =A0 =A0 =A0 =A0 // Deserial=
 Serial Peripheral Interface (DSPI_D)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-dspi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ff9c000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci@1ffb0000 { =A0 =A0 =A0 =A0 =A0// Serial=
 Communications Interface (SCI_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-sci";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ffb0000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci@1ffb4000 { =A0 =A0 =A0 =A0 =A0// Serial=
 Communications Interface (SCI_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-sci";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ffb4000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@1ffc0000 { =A0 =A0 =A0 =A0 =A0// Contro=
ller Area Network (FlexCAN_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-flexcan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ffc0000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@1ffc4000 { =A0 =A0 =A0 =A0 =A0// Contro=
ller Area Network (FlexCAN_B)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-flexcan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ffc4000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@1ffc8000 { =A0 =A0 =A0 =A0 =A0// Contro=
ller Area Network (FlexCAN_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-flexcan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1ffc8000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bam@1fffc000 { =A0 =A0 =A0 =A0 =A0// Boot A=
ssist Module (BAM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-bam";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1fffc000 0x4000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 };
> +
> +};
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
