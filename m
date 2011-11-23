Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 314591007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:10:57 +1100 (EST)
Received: by vbal1 with SMTP id l1so1400611vba.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 06:10:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
Date: Wed, 23 Nov 2011 09:10:53 -0500
Message-ID: <CA+5PVA4wpGfSXbX9oTdtDaGiWFkwZfiL9Md6SGJpXtOK6rG2ww@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
From: Josh Boyer <jwboyer@gmail.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2011 at 4:44 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b177caa..3f2cc36 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -978,3 +978,9 @@ config PPC_LIB_RHEAP
> =A0 =A0 =A0 =A0bool
>
> =A0source "arch/powerpc/kvm/Kconfig"
> +
> +config UART_16550_WORD_ADDRESSABLE
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 =A0Enable this if your UART 16550 is word addressable.

Ugh.  What is this for?  More specifically, if the UART requires word
reads and writes, shouldn't it be using reg-shift/reg-offset in the
device tree?  I'm confused why UDBG would need this sort of code, but
the runtime serial driver doesn't?

> diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/k=
londike.dts


> + =A0 =A0 =A0 OCM: ocm@20000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ibm,ocm";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "enabled";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x20000000 0x1f000 =A0 /* 128K - =
4K NAND */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfffe0000 0x1f000>; /* 128=
K - 4K I2C =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootmode =3D "nand";
> + =A0 =A0 =A0 };

What is this?  There's nothing in the kernel or in this patch that
binds with "ibm,ocm".  Also, that 'bootmode' property doesn't seem
like a hardware value, but a human descriptor of something that
switches it to boot from NAND.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypto: crypto@40000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "crypto";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "405ex-crypt=
o", "amcc,ppc405ex-crypto", "amcc,ppc4xx-crypto";

Why is the "405ex-crypto" string there?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDMA: edma@40080000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amcc,edma";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "dma";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*complQ-fifo-memory =3D "o=
cm";*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40080000 0x00010=
000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-reg =3D <0x060 0x09f>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&UIC0=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D </*complQ A =
*/ =A00x4 4
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /*EDMA Err */ =A00x6 4 >;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma-channel@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "amcc,edma-channel";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*descripto=
r-memory =3D "ocm";*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =
=3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-reg =3D=
 <0x0000006a 0x0000006b>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

What's this?  Again, nothing binds to "amcc,edma" in the kernel or
patch.  At the very least this (and OCM above) need some binding
descriptions added to Documentation/devicetree/bindings/powerpc/4xx/

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSI: dwc_pcie-msi@40090000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amcc,dwc_pc=
ie-msi", "dwc_pcie-msi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "ok";

Is the status property something that is set by U-Boot, or will it
always be "ok"?  If the latter, I don't think you need to specify it
at all.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40090000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D<0x0 0x1 0x2 =
0x3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&MSI>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <0x0 &UIC=
0 0x0C 0x1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x1 &UIC0 0x0D 0x1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x2 &UIC0 0x0E 0x1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x3 &UIC0 0x0F 0x1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

Same binding comment here.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 AHB: ahb {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "ahb";

I doubt the device_type is needed.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amcc,405ex-=
ahb", "ibm,ahb";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0>; /*=
 Filled in by U-Boot */

Same binding comment for ahb.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd: lcd@58060000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "lcd";

Drop device_type.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "apm,apm-lcd","apm,db9000";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 version =3D=
 "apm-1.1";

Why is 'version' there?  Version of what?  The hardware itself, the
driver?  I doubt this is needed.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
58060000 0x00001000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interr=
upt index 0 for chip 1.0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interr=
upt index 1 for chip 1.1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x1c 2 0x1c 4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

Same binding comment for apm,apm-lcd.  I'm just going to assert again
that anything that doesn't have a defined binding and/or driver needs
to be documented when it's introduced.  Repeat that for the rest of
the patch :).

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhc0: sdhc@58050000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "sdhc";

Drop device_type.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "amcc,ahb-sdhc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-=
cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
58050000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x18 0x4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootmode =
=3D "i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdm0: tdm@58010000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "tdm";

Drop device_type.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
"disabled";

Is that set by U-Boot?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "apm,ahb-tdm";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-=
cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
58010000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x15 0x1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbotg0: usbotg@58080000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "usb";

Drop device_type.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "apm,usb-otg";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
58080000 0x10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x1B 4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D "h=
ost";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi0: spi@50000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-ce=
lls =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells=
 =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "spi";

Drop device_type.  I think you're starting to get the trend, so repeat
for the rest of the devices.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "apm,apm-spi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
50000000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x7 1>; =A0/* interrupt number->0x7 Polarity->HIGH Sensitivity->LEVEL =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 half_duplex=
 =3D <0x1>; =A0 /*0 =3D rx/tx mode, 1 =3D eprom read mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysclk =3D =
<100000000>; =A0 /* input clock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_num =3D=
 <0x0>; =A0 =A0 =A0 /* SPI =3D 0 */

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCIE0: pciex@58020000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "pci";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ibm,plb-pciex", "dwc-pciex", "amcc,dwc-pciex";

Why the unprefixed dwc-pciex compatible property?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-=
cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells=
 =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-ce=
lls =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port =3D <0=
>; /* port number */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
"ok";


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCIE1: pciex@58030000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "pci";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ibm,plb-pciex", "dwc-pciex", "amcc,dwc-pciex";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-=
cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells=
 =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-ce=
lls =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port =3D <1=
>; /* port number */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
"disabled";

Is this set by U-Boot?


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sata@58040000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "sata-ahci";

Uh.. what?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =A0=
<0x58040000 0x2000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x1a 1>;


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ufc@0xFE000=
000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 compatible =3D "ibm,ufc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 reg =3D <0xFE000000 0x00010000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bootmode =3D "nand";

Is UFC some kind of new flash controller that isn't NDFC?  Also,
bootmode seems to be a human and/or driver variable, not a description
of the hardware.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART0: serial@50001000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type=
 =3D "serial";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ns16550";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
50001000 0x00000100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtual-reg=
 =3D <0x50001000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequ=
ency =3D <300000000>; /* Filled in by U-Boot */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current-spe=
ed =3D <115200>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <0x0 0x4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*reg-shift=
 =3D <2>;*/

This is commented out, but seems to be needed when you take the
word-addressed UDBG thing into account?


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IEEE1588_0: ieee1588ts0@400=
a5000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
"ok";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ieee1588-ts";

What is that?

> diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/c=
onfigs/40x/klondike_defconfig
> new file mode 100644
> index 0000000..840f438
> --- /dev/null
> +++ b/arch/powerpc/configs/40x/klondike_defconfig
> @@ -0,0 +1,1353 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/powerpc 3.2.0-rc2 Kernel Configuration
> +#
> +# CONFIG_PPC64 is not set

This is a full defconfig.  We don't need a full config file.  You can
generate one with 'make savedefconfig' that contains only the options
you need to set.




> diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_=
16550.c
> index 6837f83..dd3bce9 100644
> --- a/arch/powerpc/kernel/udbg_16550.c
> +++ b/arch/powerpc/kernel/udbg_16550.c
> @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iomem *=
addr);
> =A0extern u8 real_205_readb(volatile u8 __iomem =A0*addr);
> =A0extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);
>
> +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE
> +struct NS16550 {
> + =A0 =A0 =A0 /* this struct must be packed */
> + =A0 =A0 =A0 unsigned char rbr; =A0/* 0 */ u8 s0[3];

An array of length 3 for something "word-addressable"?  When did words
change to 3 bytes?  Now, I still haven't finished my coffee yet, but
that is really confusing.

> + =A0 =A0 =A0 unsigned char ier; =A0/* 1 */ u8 s1[3];
> + =A0 =A0 =A0 unsigned char fcr; =A0/* 2 */ u8 s2[3];
> + =A0 =A0 =A0 unsigned char lcr; =A0/* 3 */ u8 s3[3];
> + =A0 =A0 =A0 unsigned char mcr; =A0/* 4 */ u8 s4[3];
> + =A0 =A0 =A0 unsigned char lsr; =A0/* 5 */ u8 s5[3];
> + =A0 =A0 =A0 unsigned char msr; =A0/* 6 */ u8 s6[3];
> + =A0 =A0 =A0 unsigned char scr; =A0/* 7 */ u8 s7[3];
> +};
> +#else
> =A0struct NS16550 {
> =A0 =A0 =A0 =A0/* this struct must be packed */
> =A0 =A0 =A0 =A0unsigned char rbr; =A0/* 0 */
> @@ -29,6 +42,7 @@ struct NS16550 {
> =A0 =A0 =A0 =A0unsigned char msr; =A0/* 6 */
> =A0 =A0 =A0 =A0unsigned char scr; =A0/* 7 */
> =A0};
> +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */
>
> =A0#define thr rbr
> =A0#define iir fcr
> @@ -52,8 +66,16 @@ static struct NS16550 __iomem *udbg_comport;
> =A0static void udbg_550_flush(void)
> =A0{
> =A0 =A0 =A0 =A0if (udbg_comport) {
> +#if defined(CONFIG_APM8018X)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (index =3D 0; index < 3500; index++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((in_8(&udbg_comport->ls=
r) & LSR_THRE) =3D=3D LSR_THRE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#else

What is index, and why do you read the same register 3500 times?  That
doesn't sound like an index, it sounds like some kind of poor-mans
timeout.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((in_8(&udbg_comport->lsr) & LSR_THR=
E) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait for idle */;
> +#endif /* CONFIG_APM8018X */
> =A0 =A0 =A0 =A0}
> =A0}
>
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/=
40x/Kconfig
> index 1530229..3d0d1d9 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -186,3 +186,14 @@ config IBM405_ERR51
> =A0# =A0 =A0 =A0bool
> =A0# =A0 =A0 =A0depends on !STB03xxx && PPC4xx_DMA
> =A0# =A0 =A0 =A0default y
> +#
> +
> +config APM8018X
> + =A0 =A0 =A0 bool "APM8018X"
> + =A0 =A0 =A0 depends on 40x
> + =A0 =A0 =A0 default y

default n please.

> + =A0 =A0 =A0 select PPC40x_SIMPLE
> + =A0 =A0 =A0 select UART_16550_WORD_ADDRESSABLE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables support for the AppliedMicro Klondi=
ke board.
> +
> diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/pl=
atforms/40x/ppc40x_simple.c
> index e8dd5c5..c8576af 100644
> --- a/arch/powerpc/platforms/40x/ppc40x_simple.c
> +++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
> @@ -17,7 +17,7 @@
> =A0#include <asm/pci-bridge.h>
> =A0#include <asm/ppc4xx.h>
> =A0#include <asm/prom.h>
> -#include <asm/time.h>
> +#include <linux/time.h>

Is this needed for a reason?  If so, it should be submitted as a separate p=
atch.

> =A0#include <asm/udbg.h>
> =A0#include <asm/uic.h>
>
> @@ -29,6 +29,7 @@ static __initdata struct of_device_id ppc40x_of_bus[] =
=3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "ibm,plb4", },
> =A0 =A0 =A0 =A0{ .compatible =3D "ibm,opb", },
> =A0 =A0 =A0 =A0{ .compatible =3D "ibm,ebc", },
> + =A0 =A0 =A0 { .compatible =3D "ibm,ahb", },
> =A0 =A0 =A0 =A0{ .compatible =3D "simple-bus", },
> =A0 =A0 =A0 =A0{},
> =A0};
> @@ -55,6 +56,7 @@ static const char *board[] __initdata =3D {
> =A0 =A0 =A0 =A0"amcc,haleakala",
> =A0 =A0 =A0 =A0"amcc,kilauea",
> =A0 =A0 =A0 =A0"amcc,makalu",
> + =A0 =A0 =A0 "amcc,klondike",
> =A0 =A0 =A0 =A0"est,hotfoot"
> =A0};
>
> --
> 1.6.1.rc3
>
>
