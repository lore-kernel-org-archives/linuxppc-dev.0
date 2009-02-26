Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id DD338DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 02:57:56 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <49A50D74.50409@vastech.co.za>
References: <49A50D74.50409@vastech.co.za>
Date: Thu, 26 Feb 2009 08:57:54 -0700
Message-ID: <fa686aa40902260757j326bb175ud22c0639acba625c@mail.gmail.com>
Subject: Re: defining platform_devices in DTS
From: Grant Likely <grant.likely@secretlab.ca>
To: Pieter <phenning@vastech.co.za>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(note: added the devicetree-discuss mailing list to this thread)

On Wed, Feb 25, 2009 at 2:20 AM, Pieter <phenning@vastech.co.za> wrote:
> Hi all
>
> I am busy porting my board to Linux 2.6.27 from 2.6.19. The old Linux
> was compiled using the ppc architecture, and had a "platform_device"
> struct ure containing the custom devices on my board. (
> /arch/ppc/platform/sdh8548.c and /arch/ppc/platform/sdh8548.h )
>
> I assume these devices should now be declared in the device tree source.
> Building the new Linux using the powerpc architecture, but I am
> strugeling translating teh information defined in the "platform_device"
> to a device tree node. In particular what happens to the resource.flags
> could anyone help please?

For the most common flags (IO_RESOURCE_MEM & IO_RESOURCE_IRQ), you use
the 'reg' and 'interrupts' properties respectively to describe your
device.  The usage of them is well established.

> Below is the "platform_device" definition and my interpretation of how
> it should look in the device tree. Am I on the right track?

Yes, you're on the right track; comments below

> thanks pieter
>
> platform_device definition:
> =A0{
> =A0 =A0 =A0 =A0.name =3D "bio",
> =A0 =A0 =A0 =A0.id =3D 0,
> =A0 =A0 =A0 =A0.dev.platform_data =3D NULL,
> =A0 =A0 =A0 =A0.num_resources =3D 2,
> =A0 =A0 =A0 =A0.resource =3D (struct resource[]) {
> =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D 0xe0100000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.end =A0 =A0=3D 0xe0100000 + 0x10000 -1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_MEM, =A0 =A0/* 0x=
00000200 */
> =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "int",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D MPC85xx_IRQ_EXT0, =A0 =A0/* =
48 +
> MPC85xx_OPENPIC_IRQ_OFFSET */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.end =A0 =A0=3D MPC85xx_IRQ_EXT0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ, =A0 =A0/*0x0=
0000400 */
> =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
>
> FDT source:
> =A0 =A0localbus@e0000000 {
> =A0 =A0 =A0 =A0#address-cells =3D <2>;
> =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0compatible =3D "simple-bus";
> =A0 =A0 =A0 =A0reg =3D <0xe0000000 0x5000>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&mpic>;
>
> =A0 =A0 =A0 =A0ranges =3D <
> =A0 =A0 =A0 =A0 =A0 =A00x0 0x0 0xf8000000 0x07ffffff =A0 =A0 =A0 =A0/*128=
MB Flash*/
> =A0 =A0 =A0 =A0 =A0 =A00x1 0x0 0xe0200000 0x00200000 =A0 =A0 =A0 =A0/*2MB=
 FPGA*/
> =A0 =A0 =A0 =A0 =A0 =A00x2 0x0 0xe0100000 0x00100000 =A0 =A0 =A0 =A0 /*1M=
B BIO CPLD*/
> =A0 =A0 =A0 =A0>;

Your ranges property appears to be correct.

> =A0 =A0 =A0 =A0bio@2,0 {
> =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "wrs,epld-localbus";

This property is what the whole system hangs of and it is important
that it is unique for the device you are describing.  Device drivers
read the compatible property and use it to decide whether or not it
can drive the device.  If this is a board-specific EPLD, then the name
of the board should be part of the name.  Once you've selected a name,
you must document what the name means in
Documentation/powerpc/dts-bindings/ and what properties are required
in nodes with this value.

> =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;

Only use #address-cells and #size-cells if there is a child node that
has a 'reg' property.

> =A0 =A0 =A0 =A0 =A0 =A0//interrupt-parent =3D <&mpic>;

You don't need interrupt-parent if the parent node already sets it correctl=
y.

> =A0 =A0 =A0 =A0 =A0 =A0//interrupts =3D <48>;

This is probably where you are having trouble.  To determine the
format of the interrupts property you need to look at the interrupt
parent node.  The #interrupt-cells property in the interrupt parent
will tell you how many numbers (cells) need to be in the interrupts
property for each irq line.  In this case the mpic specifies
'#interrupt-cells=3D<2>;'.  So, the interrupts property here should be
in the form: "interrupts =3D < [irq-number] [irq-type] >;"

irq-number is the irq line
irq-type is the sense (edge/level, high/low).  See mpic_host_xlate()
in arch/powerpc/sysdev/mpic.c for the mapping (map_mpic_senses)
between the irq-type value and the type of interrupt (duplicated
here):
        static unsigned char map_mpic_senses[4] =3D {
                IRQ_TYPE_EDGE_RISING,
                IRQ_TYPE_LEVEL_LOW,
                IRQ_TYPE_LEVEL_HIGH,
                IRQ_TYPE_EDGE_FALLING,
        };

> =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x2 0x0 0x0010000>;

reg looks correct.

> =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0x0 0x0 0x2 0x0 0x00100000>;

Only use ranges if there is a child node.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
