Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f11.google.com (mail-gx0-f11.google.com
	[209.85.217.11]) by ozlabs.org (Postfix) with ESMTP id 8AEB4474C8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:41:16 +1100 (EST)
Received: by gxk4 with SMTP id 4so614135gxk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 08:41:14 -0800 (PST)
Message-ID: <fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
Date: Wed, 7 Jan 2009 09:41:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
In-Reply-To: <20090107140132.140980@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 7:01 AM, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> This device tree does not provide the correct CPU name, as various CPU
> models and revisions are used in AmigaOnes.  Also the PCI root node does
> not contain a interrupt mapping property, as all boards have different
> interrupt routing. However the kernel can do a 1:1 mapping of all PCI
> interrupts, as only i8259 legacy interrupts are used.

Sounds to me like you need different device tree variants for each of
the AmigaOne boards.  Do any of the boards have physical PCI slots?
If so, then the lack of an interrupt map will break them.

>
> Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> ---
>  arch/powerpc/boot/dts/amigaone.dts |  233 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 233 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/amigaone.dts
>
> diff --git a/arch/powerpc/boot/dts/amigaone.dts b/arch/powerpc/boot/dts/amigaone.dts
> new file mode 100644
> index 0000000..9794bbc
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/amigaone.dts
> @@ -0,0 +1,233 @@
> +/*
> + * AmigaOne Device Tree Source
> + *
> + * Copyright 2008 Gerhard Pircher (gerhard_pircher@gmx.net)
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +       model = "AmigaOne";
> +       compatible = "eyetech,amigaone","mai-logic,teron";

Experience has shown that trying to claim one board to be compatible
with another is too ambiguous.  It is better to make the board level
compatible property have a single value specifying the exact board
model and have the platform support code include a list of supported
board models.  Otherwise you end up with odd heuristic code to try and
differentiate between the models (for bug fixes and such).

> +       coherency-off;
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               #cpus = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <32>;       // 32 bytes
> +                       i-cache-line-size = <32>;       // 32 bytes
> +                       d-cache-size = <32768>;         // L1, 32K
> +                       i-cache-size = <32768>;         // L1, 32K
> +                       timebase-frequency = <0>;       // 33.3 MHz, from U-boot
> +                       clock-frequency = <0>;          // From U-boot
> +                       bus-frequency = <0>;            // From U-boot
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0>;                            // From U-boot
> +       };
> +
> +       pci@80000000 {
> +               device_type = "pci";
> +               compatible = "mai-logic,articia-s";
> +               bus-frequency = <33333333>;
> +               bus-range = <0 0xff>;
> +               ranges = <0x01000000 0 0x00000000 0xfe000000 0 0x00c00000       // PCI I/O
> +                         0x02000000 0 0x80000000 0x80000000 0 0x7d000000       // PCI memory
> +                         0x02000000 0 0x00000000 0xfd000000 0 0x01000000>;     // PCI alias memory (ISA)
> +               8259-interrupt-acknowledge = <0xfef00000>;
> +               /* Do not define a interrupt-parent here, if there is no interrupt-map property. */
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +
> +               host@0 {
> +                       compatible = "pciclass,0600";
> +                       vendor-id = <0x000010cc>;
> +                       device-id = <0x00000660>;
> +                       revision-id = <0x00000001>;
> +                       class-code = <0x00060000>;
> +                       subsystem-id = <0>;
> +                       subsystem-vendor-id = <0>;
> +                       devsel-speed = <0x00000001>;
> +                       66mhz-capable;
> +                       min-grant = <0>;
> +                       max-latency = <0>;
> +                       // AGP aperture is unset.
> +//                     reg = <0x42000010 0 0x00000000 0 0x00400000>;
> +//                     assigned-addresses = <0x42000010 0 0x00000000 0 0x00400000>;
> +               };

What does this node describe?  Is it something that isn't probeable?

> +                       8042@60 {
> +                               device_type = "8042";
> +                               reg = <1 0x00000060 0x00000001
> +                                      1 0x00000064 0x00000001>;
> +                               // IRQ1, IRQ12 (rising edge)
> +                               interrupts = <1 3 12 3>;

For the flattened device tree, I think we've settled on the convention
that every node with an IRQ connection should have both the
interrupt-parent and interrupts properties.  (ie. don't rely on the
parent node's interrupt-parent property.)

> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               keyboard@0 {
> +                                       device_type = "keyboard";

Drop device type in the flattened tree.  There are a few places where
you still need to have it for Linux to work; but it Linux doesn't look
for it, then don't add it.

> +                       serial@3f8 {
> +                               device_type = "serial";
> +                               compatible = "pnpPNP,501","pnpPNP,500";
> +                               reg = <1 0x000003f8 0x00000008>;
> +                               // IRQ4 (rising edge)
> +                               interrupts = <4 3>;
> +                               clock-frequency = <1843200>;
> +                               current-speed = <115200>;
> +                       };
> +
> +                       serial@2f8 {
> +                               device_type = "serial";
> +                               compatible = "pnpPNP,501","pnpPNP,500";
> +                               reg = <1 0x000002f8 0x00000008>;
> +                               // IRQ3 (rising edge)
> +                               interrupts = <3 3>;
> +                               clock-frequency = <1843200>;
> +                               current-speed = <115200>;
> +                       };
> +
> +                       parallel@378 {
> +                               device_type = "parallel";
> +                               // No ECP support for now, otherwise add "pnpPNP,401".
> +                               compatible = "pnpPNP,400";
> +                               reg = <1 0x00000378 0x00000003
> +                                      1 0x00000778 0x00000003>;
> +/*                             interrupts = <7 0>; */
> +                               // Parallel port DMA mode unknown.
> +/*                             dma = <0x3 0x0 0x0 0x0>; */
> +                       };
> +
> +                       fdc@3f0 {
> +                               device_type = "fdc";
> +                               compatible = "pnpPNP,700";
> +                               reg = <1 0x000003f0 0x00000008>;
> +                               // IRQ6 (rising edge)
> +                               interrupts = <6 3>;
> +                               // Floppy DMA mode unknown.
> +/*                             dma = < >; */
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               disk@0 {
> +                                       device_type = "block";
> +                                       reg = <0>;
> +                               };
> +                       };
> +               };
> +
> +               ide@7,1 {
> +                       compatible = "pciclass,01018a";
> +                       vendor-id = <0x00001106>;
> +                       device-id = <0x00000571>;
> +                       revision-id = <0x00000006>;

Can this PCI device be probed?  Typically PCI devices don't get added
to the flattened device tree because PCI is a probeable bus.

> +       chosen {
> +               linux,stdout-path = "/pci@80000000/isa@7/serial@3f8";

If you put a 'serial-console:' label on the serial port node, then you
can use the simpler form of:
        linux,stdout-path = &serial-console;

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
