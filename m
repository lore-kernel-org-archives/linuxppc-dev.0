Return-Path: <tinamdar@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
 by ozlabs.org (Postfix) with SMTP id 491EF1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:08:00 +1100 (EST)
Received: by mail-iy0-f180.google.com with SMTP id z35so4221604iag.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:07:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4wpGfSXbX9oTdtDaGiWFkwZfiL9Md6SGJpXtOK6rG2ww@mail.gmail.com>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
 <CA+5PVA4wpGfSXbX9oTdtDaGiWFkwZfiL9Md6SGJpXtOK6rG2ww@mail.gmail.com>
Date: Thu, 24 Nov 2011 14:37:55 +0530
Message-ID: <CACoXjc=CeNAXLwMNAm+0SDrmhiSFogZPScrcWk+BcwRPA+ry3g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
From: Tanmay Inamdar <tinamdar@apm.com>
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: multipart/alternative; boundary=90e6ba6e89dc434a7204b2775f49
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba6e89dc434a7204b2775f49
Content-Type: text/plain; charset=ISO-8859-1

Hello Josh,

Thanks for the review. The comments are appreciated. Please see my inline
replies.

Thanks,
Tanmay

On Wed, Nov 23, 2011 at 7:40 PM, Josh Boyer <jwboyer@gmail.com> wrote:

> On Wed, Nov 23, 2011 at 4:44 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index b177caa..3f2cc36 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -978,3 +978,9 @@ config PPC_LIB_RHEAP
> >        bool
> >
> >  source "arch/powerpc/kvm/Kconfig"
> > +
> > +config UART_16550_WORD_ADDRESSABLE
> > +       bool
> > +       default n
> > +       help
> > +          Enable this if your UART 16550 is word addressable.
>
> Ugh.  What is this for?  More specifically, if the UART requires word
> reads and writes, shouldn't it be using reg-shift/reg-offset in the
> device tree?  I'm confused why UDBG would need this sort of code, but
> the runtime serial driver doesn't?
>

It seems the name 'UART_16550_WORD_ADDRESSABLE' is confusing here.
The UART has been modeled after the industry-standard 16550. However,
the register address space has been relocated to 32-bit data boundaries.
For each register, only 1st bit is valid and rest 3 bits are just reserved
and read
as zero. Hence we need to pack the structure accordingly.

runtime serial driver also needs changes in register definitions. However
it is not
included in this patch.

In the next version of patch, I will remove UART stuff. I will make
separate patch
for UART.


>
> > diff --git a/arch/powerpc/boot/dts/klondike.dts
> b/arch/powerpc/boot/dts/klondike.dts
>
>
> > +       OCM: ocm@20000000 {
> > +               compatible = "ibm,ocm";
> > +               status = "enabled";
> > +               cell-index = <1>;
> > +               reg = < 0x20000000 0x1f000   /* 128K - 4K NAND */
> > +                       0xfffe0000 0x1f000>; /* 128K - 4K I2C  */
> > +               bootmode = "nand";
> > +       };
>
> What is this?  There's nothing in the kernel or in this patch that
> binds with "ibm,ocm".  Also, that 'bootmode' property doesn't seem
> like a hardware value, but a human descriptor of something that
> switches it to boot from NAND.
>
> OCM driver is not yet submitted. I will skip the blocks in the dts which
are still
not supported in the next version.

You are right about bootmode. OCM gets mapped to different addresses in
different boot modes. Uboot takes care of updating this parameter.


>
> > +               crypto: crypto@40000000 {
> > +                       device_type = "crypto";
> > +                       compatible = "405ex-crypto",
> "amcc,ppc405ex-crypto", "amcc,ppc4xx-crypto";
>
> Why is the "405ex-crypto" string there?
>
> > +               EDMA: edma@40080000 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       compatible = "amcc,edma";
> > +                       device_type = "dma";
> > +                       /*complQ-fifo-memory = "ocm";*/
> > +                       cell-index = <0>;
> > +                       reg = <0x40080000 0x00010000>;
> > +                       dcr-reg = <0x060 0x09f>;
> > +
> > +                       interrupt-parent = <&UIC0>;
> > +                       interrupts = </*complQ A */  0x4 4
> > +                                       /*EDMA Err */  0x6 4 >;
> > +
> > +                       dma-channel@0 {
> > +                               compatible = "amcc,edma-channel";
> > +                               /*descriptor-memory = "ocm";*/
> > +                               cell-index = <0>;
> > +                               dcr-reg = <0x0000006a 0x0000006b>;
> > +                       };
> > +               };
>
> What's this?  Again, nothing binds to "amcc,edma" in the kernel or
> patch.  At the very least this (and OCM above) need some binding
> descriptions added to Documentation/devicetree/bindings/powerpc/4xx/
>

I will skip this in next patch. I will consider the bindings.


> > +
> > +               MSI: dwc_pcie-msi@40090000 {
> > +                       compatible = "amcc,dwc_pcie-msi", "dwc_pcie-msi";
> > +                       status = "ok";
>
> Is the status property something that is set by U-Boot, or will it
> always be "ok"?  If the latter, I don't think you need to specify it
> at all.
>
>
Correct. There is no need of status. MSI is always enabled


> > +                       reg = <0x40090000 0x100>;
> > +                       interrupts =<0x0 0x1 0x2 0x3>;
> > +                       interrupt-parent = <&MSI>;
> > +                       #interrupt-cells = <1>;
> > +                       #address-cells = <0>;
> > +                       #size-cells = <0>;
> > +                       interrupt-map = <0x0 &UIC0 0x0C 0x1
> > +                                        0x1 &UIC0 0x0D 0x1
> > +                                        0x2 &UIC0 0x0E 0x1
> > +                                        0x3 &UIC0 0x0F 0x1>;
> > +               };
>
> Same binding comment here.
>
> > +
> > +               AHB: ahb {
> > +                       device_type = "ahb";
>
> I doubt the device_type is needed.
>

I believe device_type can be skipped in most of the cases.
I will take care of this in next revision of patch.

>
> > +                       compatible = "amcc,405ex-ahb", "ibm,ahb";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +                       clock-frequency = <0>; /* Filled in by U-Boot */
>
> Same binding comment for ahb.
>
> > +
> > +                       lcd: lcd@58060000 {
> > +                               device_type = "lcd";
>
> Drop device_type.
>
> > +                               compatible = "apm,apm-lcd","apm,db9000";
> > +                               version = "apm-1.1";
>
> Why is 'version' there?  Version of what?  The hardware itself, the
> driver?  I doubt this is needed.
>
It is chip version. There are some changes in this block with respect to
chip
revision. The PVR remains the same as old chip revision and there is no
other register to specify revision. Uboot updates this parameter.

I will skip this block from next patch and will reintroduce it when the
actual
driver is added.


> > +                               reg = <0x58060000 0x00001000>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               /*
> > +                                * interrupt index 0 for chip 1.0
> > +                                * interrupt index 1 for chip 1.1
> > +                                */
> > +                               interrupts = <0x1c 2 0x1c 4>;
> > +                       };
>
> Same binding comment for apm,apm-lcd.  I'm just going to assert again
> that anything that doesn't have a defined binding and/or driver needs
> to be documented when it's introduced.  Repeat that for the rest of
> the patch :).
>

Yes.

>
> > +
> > +                       sdhc0: sdhc@58050000 {
> > +                               device_type = "sdhc";
>
> Drop device_type.
>
> > +                               compatible = "amcc,ahb-sdhc";
> > +                               #interrupt-cells = <1>;
> > +                               reg = <0x58050000 0x100>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               interrupts = <0x18 0x4>;
> > +                               bootmode = "i2c";
> > +                       };
> > +
> > +                       tdm0: tdm@58010000 {
> > +                               device_type = "tdm";
>
> Drop device_type.
>
> > +                               status = "disabled";
>
> Is that set by U-Boot?
>
Yes. The chip is multiplexed. Some IPs get disabled/enabled based on
bootmodes.

>
> > +                               compatible = "apm,ahb-tdm";
> > +                               #interrupt-cells = <1>;
> > +                               reg = <0x58010000 0x100>;
> > +                               interrupt-parent = <&UIC1>;
> > +                               interrupts = <0x15 0x1>;
> > +                       };
> > +
> > +                       usbotg0: usbotg@58080000 {
> > +                               device_type = "usb";
>
> Drop device_type.
>
> > +                               compatible = "apm,usb-otg";
> > +                               reg = <0x58080000 0x10000>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               interrupts = <0x1B 4>;
> > +                               mode = "host";
> > +                       };
> > +                       spi0: spi@50000000 {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               device_type = "spi";
>
> Drop device_type.  I think you're starting to get the trend, so repeat
> for the rest of the devices.
>
> > +                               compatible = "apm,apm-spi";
> > +                               reg = <0x50000000 0x100>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               interrupts = <0x7 1>;  /* interrupt
> number->0x7 Polarity->HIGH Sensitivity->LEVEL */
> > +                               half_duplex = <0x1>;   /*0 = rx/tx mode,
> 1 = eprom read mode */
> > +                               sysclk = <100000000>;   /* input clock */
> > +                               bus_num = <0x0>;       /* SPI = 0 */
>
> > +
> > +                       PCIE0: pciex@58020000 {
> > +                               device_type = "pci";
> > +                               compatible = "ibm,plb-pciex",
> "dwc-pciex", "amcc,dwc-pciex";
>
> Why the unprefixed dwc-pciex compatible property?
>

I will correct it.


> > +                               #interrupt-cells = <1>;
> > +                               #size-cells = <2>;
> > +                               #address-cells = <3>;
> > +                               primary;
> > +                               port = <0>; /* port number */
> > +                               status = "ok";
>
>
> > +                       PCIE1: pciex@58030000 {
> > +                               device_type = "pci";
> > +                               compatible = "ibm,plb-pciex",
> "dwc-pciex", "amcc,dwc-pciex";
> > +                               #interrupt-cells = <1>;
> > +                               #size-cells = <2>;
> > +                               #address-cells = <3>;
> > +                               primary;
> > +                               port = <1>; /* port number */
> > +                               status = "disabled";
>
> Is this set by U-Boot?
>
Yes. Same as multiplexed comment.

>
>
> > +                       sata@58040000 {
> > +                               compatible = "sata-ahci";
>
> Uh.. what?
>
It is designware SATA IP compatible with AHCI standard.
I will reintroduce this block along with its driver.

>
> > +                               reg =  <0x58040000 0x2000>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               interrupts = <0x1a 1>;
>
>
> > +                               ufc@0xFE000000 {
> > +                                       compatible = "ibm,ufc";
> > +                                       reg = <0xFE000000 0x00010000>;
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <1>;
> > +                                       bootmode = "nand";
>
> Is UFC some kind of new flash controller that isn't NDFC?  Also,
> bootmode seems to be a human and/or driver variable, not a description
> of the hardware.
>

Yes. UFC is new flash controller. You are right about bootmode.


> > +                       UART0: serial@50001000 {
> > +                               device_type = "serial";
> > +                               compatible = "ns16550";
> > +                               reg = <0x50001000 0x00000100>;
> > +                               virtual-reg = <0x50001000>;
> > +                               clock-frequency = <300000000>; /* Filled
> in by U-Boot */
> > +                               current-speed = <115200>;
> > +                               interrupt-parent = <&UIC0>;
> > +                               interrupts = <0x0 0x4>;
> > +                               /*reg-shift = <2>;*/
>
> This is commented out, but seems to be needed when you take the
> word-addressed UDBG thing into account?
>

Yes. I will rethink on how it is implemented.


>
> > +                       IEEE1588_0: ieee1588ts0@400a5000 {
> > +                               status = "ok";
> > +                               compatible = "ieee1588-ts";
>
> What is that?
>
This is AMCC IEEE1588 block. I will correct the compatible string.


> > diff --git a/arch/powerpc/configs/40x/klondike_defconfig
> b/arch/powerpc/configs/40x/klondike_defconfig
> > new file mode 100644
> > index 0000000..840f438
> > --- /dev/null
> > +++ b/arch/powerpc/configs/40x/klondike_defconfig
> > @@ -0,0 +1,1353 @@
> > +#
> > +# Automatically generated file; DO NOT EDIT.
> > +# Linux/powerpc 3.2.0-rc2 Kernel Configuration
> > +#
> > +# CONFIG_PPC64 is not set
>
> This is a full defconfig.  We don't need a full config file.  You can
> generate one with 'make savedefconfig' that contains only the options
> you need to set.
>
> I will do that.

>
>
>
> > diff --git a/arch/powerpc/kernel/udbg_16550.c
> b/arch/powerpc/kernel/udbg_16550.c
> > index 6837f83..dd3bce9 100644
> > --- a/arch/powerpc/kernel/udbg_16550.c
> > +++ b/arch/powerpc/kernel/udbg_16550.c
> > @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iomem
> *addr);
> >  extern u8 real_205_readb(volatile u8 __iomem  *addr);
> >  extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);
> >
> > +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE
> > +struct NS16550 {
> > +       /* this struct must be packed */
> > +       unsigned char rbr;  /* 0 */ u8 s0[3];
>
> An array of length 3 for something "word-addressable"?  When did words
> change to 3 bytes?  Now, I still haven't finished my coffee yet, but
> that is really confusing.
>

Again the name  WORD_ADDRESSABLE is confusing. Hopefully my previous
comment clears the confusion.


> > +       unsigned char ier;  /* 1 */ u8 s1[3];
> > +       unsigned char fcr;  /* 2 */ u8 s2[3];
> > +       unsigned char lcr;  /* 3 */ u8 s3[3];
> > +       unsigned char mcr;  /* 4 */ u8 s4[3];
> > +       unsigned char lsr;  /* 5 */ u8 s5[3];
> > +       unsigned char msr;  /* 6 */ u8 s6[3];
> > +       unsigned char scr;  /* 7 */ u8 s7[3];
> > +};
> > +#else
> >  struct NS16550 {
> >        /* this struct must be packed */
> >        unsigned char rbr;  /* 0 */
> > @@ -29,6 +42,7 @@ struct NS16550 {
> >        unsigned char msr;  /* 6 */
> >        unsigned char scr;  /* 7 */
> >  };
> > +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */
> >
> >  #define thr rbr
> >  #define iir fcr
> > @@ -52,8 +66,16 @@ static struct NS16550 __iomem *udbg_comport;
> >  static void udbg_550_flush(void)
> >  {
> >        if (udbg_comport) {
> > +#if defined(CONFIG_APM8018X)
> > +               int index;
> > +               for (index = 0; index < 3500; index++) {
> > +                       if ((in_8(&udbg_comport->lsr) & LSR_THRE) ==
> LSR_THRE)
> > +                               break;
> > +               }
> > +#else
>
> What is index, and why do you read the same register 3500 times?  That
> doesn't sound like an index, it sounds like some kind of poor-mans
> timeout.
>
This is hardware bug. Ideally there should not be any change in the code. I
will try to
fix it in better way.

>
> >                while ((in_8(&udbg_comport->lsr) & LSR_THRE) == 0)
> >                        /* wait for idle */;
> > +#endif /* CONFIG_APM8018X */
> >        }
> >  }
> >
> > diff --git a/arch/powerpc/platforms/40x/Kconfig
> b/arch/powerpc/platforms/40x/Kconfig
> > index 1530229..3d0d1d9 100644
> > --- a/arch/powerpc/platforms/40x/Kconfig
> > +++ b/arch/powerpc/platforms/40x/Kconfig
> > @@ -186,3 +186,14 @@ config IBM405_ERR51
> >  #      bool
> >  #      depends on !STB03xxx && PPC4xx_DMA
> >  #      default y
> > +#
> > +
> > +config APM8018X
> > +       bool "APM8018X"
> > +       depends on 40x
> > +       default y
>
> default n please.
>

Yes.

>
> > +       select PPC40x_SIMPLE
> > +       select UART_16550_WORD_ADDRESSABLE
> > +       help
> > +         This option enables support for the AppliedMicro Klondike
> board.
> > +
> > diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c
> b/arch/powerpc/platforms/40x/ppc40x_simple.c
> > index e8dd5c5..c8576af 100644
> > --- a/arch/powerpc/platforms/40x/ppc40x_simple.c
> > +++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
> > @@ -17,7 +17,7 @@
> >  #include <asm/pci-bridge.h>
> >  #include <asm/ppc4xx.h>
> >  #include <asm/prom.h>
> > -#include <asm/time.h>
> > +#include <linux/time.h>
>
> Is this needed for a reason?  If so, it should be submitted as a separate
> patch.
>

checkpatch.pl scripts throws warning. It asks to change <asm/time.h> to
<linux/time.h>


> >  #include <asm/udbg.h>
> >  #include <asm/uic.h>
> >
> > @@ -29,6 +29,7 @@ static __initdata struct of_device_id ppc40x_of_bus[]
> = {
> >        { .compatible = "ibm,plb4", },
> >        { .compatible = "ibm,opb", },
> >        { .compatible = "ibm,ebc", },
> > +       { .compatible = "ibm,ahb", },
> >        { .compatible = "simple-bus", },
> >        {},
> >  };
> > @@ -55,6 +56,7 @@ static const char *board[] __initdata = {
> >        "amcc,haleakala",
> >        "amcc,kilauea",
> >        "amcc,makalu",
> > +       "amcc,klondike",
> >        "est,hotfoot"
> >  };
> >
> > --
> > 1.6.1.rc3
> >
> >
>

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--90e6ba6e89dc434a7204b2775f49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Josh,<br><br>Thanks for the review. The comments are appreciated. Ple=
ase see my inline replies.<br><br>Thanks,<br>Tanmay<br><br><div class=3D"gm=
ail_quote">On Wed, Nov 23, 2011 at 7:40 PM, Josh Boyer <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jwboyer@gmail.com">jwboyer@gmail.com</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Wed, Nov 23, 2011 at 4=
:44 AM, Tanmay Inamdar &lt;<a href=3D"mailto:tinamdar@apm.com">tinamdar@apm=
.com</a>&gt; wrote:<br>

&gt;<br>
&gt; diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig<br>
&gt; index b177caa..3f2cc36 100644<br>
&gt; --- a/arch/powerpc/Kconfig<br>
&gt; +++ b/arch/powerpc/Kconfig<br>
&gt; @@ -978,3 +978,9 @@ config PPC_LIB_RHEAP<br>
&gt; =A0 =A0 =A0 =A0bool<br>
&gt;<br>
&gt; =A0source &quot;arch/powerpc/kvm/Kconfig&quot;<br>
&gt; +<br>
&gt; +config UART_16550_WORD_ADDRESSABLE<br>
&gt; + =A0 =A0 =A0 bool<br>
&gt; + =A0 =A0 =A0 default n<br>
&gt; + =A0 =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 =A0 =A0Enable this if your UART 16550 is word addressabl=
e.<br>
<br>
</div>Ugh. =A0What is this for? =A0More specifically, if the UART requires =
word<br>
reads and writes, shouldn&#39;t it be using reg-shift/reg-offset in the<br>
device tree? =A0I&#39;m confused why UDBG would need this sort of code, but=
<br>
the runtime serial driver doesn&#39;t?<br></blockquote><div>=A0</div><div>I=
t seems the name &#39;UART_16550_WORD_ADDRESSABLE&#39; is confusing here.<b=
r>The UART=20
has been modeled after the industry-standard 16550. However,<br>the registe=
r=20
address space has been relocated to 32-bit data boundaries.<br>For each=20
register, only 1st bit is valid and rest 3 bits are just reserved and read<=
br>as=20
zero. Hence we need to pack the structure accordingly.<br><br>runtime seria=
l driver also needs changes in register definitions. However it is not<br>i=
ncluded in this patch.<br><br>In the next version of patch, I will remove U=
ART stuff. I will make separate patch<br>
for UART.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0p=
t 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1=
ex;">
<br>
&gt; diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dt=
s/klondike.dts<br>
<div class=3D"im"><br>
<br>
&gt; + =A0 =A0 =A0 OCM: ocm@20000000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;ibm,ocm&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D &quot;enabled&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt; 0x20000000 0x1f000 =A0 /* 1=
28K - 4K NAND */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfffe0000 0x1f000&gt;; =
/* 128K - 4K I2C =A0*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootmode =3D &quot;nand&quot;;<br>
&gt; + =A0 =A0 =A0 };<br>
<br>
</div>What is this? =A0There&#39;s nothing in the kernel or in this patch t=
hat<br>
binds with &quot;ibm,ocm&quot;. =A0Also, that &#39;bootmode&#39; property d=
oesn&#39;t seem<br>
like a hardware value, but a human descriptor of something that<br>
switches it to boot from NAND.<br>
<div class=3D"im"><br></div></blockquote><div>OCM driver is not yet submitt=
ed. I will skip the blocks in the dts which are still<br>not supported in t=
he next version.<br><br>You are right about bootmode. OCM gets mapped to di=
fferent addresses in<br>
different boot modes. Uboot takes care of updating this parameter.<br>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D=
"im">

<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypto: crypto@40000000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D &quot;cr=
ypto&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;405=
ex-crypto&quot;, &quot;amcc,ppc405ex-crypto&quot;, &quot;amcc,ppc4xx-crypto=
&quot;;<br>
<br>
</div>Why is the &quot;405ex-crypto&quot; string there?<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDMA: edma@40080000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;1=
&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;1&gt=
;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amc=
c,edma&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D &quot;dm=
a&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*complQ-fifo-memory =3D=
 &quot;ocm&quot;;*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D &lt;0&gt;=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x40080000 0=
x00010000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-reg =3D &lt;0x060 0x=
09f&gt;;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt=
;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;/*com=
plQ A */ =A00x4 4<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /*EDMA Err */ =A00x6 4 &gt;;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma-channel@0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;amcc,edma-channel&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*descri=
ptor-memory =3D &quot;ocm&quot;;*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-ind=
ex =3D &lt;0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-reg =
=3D &lt;0x0000006a 0x0000006b&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
<br>
</div>What&#39;s this? =A0Again, nothing binds to &quot;amcc,edma&quot; in =
the kernel or<br>
patch. =A0At the very least this (and OCM above) need some binding<br>
descriptions added to Documentation/devicetree/bindings/powerpc/4xx/<br></b=
lockquote><div><br>I will skip this in next patch. I will consider the bind=
ings.<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0=
pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;=
">

<div class=3D"im"><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSI: dwc_pcie-msi@40090000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amc=
c,dwc_pcie-msi&quot;, &quot;dwc_pcie-msi&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D &quot;ok&quot=
;;<br>
<br>
</div>Is the status property something that is set by U-Boot, or will it<br=
>
always be &quot;ok&quot;? =A0If the latter, I don&#39;t think you need to s=
pecify it<br>
at all.<br>
<div class=3D"im"><br></div></blockquote><div><br>Correct. There is no need=
 of status. MSI is always enabled<br>=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204=
, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x40090000 0=
x100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D&lt;0x0 0x=
1 0x2 0x3&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt=
;&amp;MSI&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D &lt=
;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;0=
&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;0&gt=
;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D &lt;0x=
0 &amp;UIC0 0x0C 0x1<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x1 &amp;UIC0 0x0D 0x1<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x2 &amp;UIC0 0x0E 0x1<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x3 &amp;UIC0 0x0F 0x1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
<br>
</div>Same binding comment here.<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 AHB: ahb {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D &quot;ah=
b&quot;;<br>
<br>
</div>I doubt the device_type is needed.<br></blockquote><div><br>I believe=
 device_type can be skipped in most of the cases.<br>I will take care of th=
is in next revision of patch. <br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amc=
c,405ex-ahb&quot;, &quot;ibm,ahb&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;1=
&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;1&gt=
;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D &lt;=
0&gt;; /* Filled in by U-Boot */<br>
<br>
</div>Same binding comment for ahb.<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd: lcd@58060000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;lcd&quot;;<br>
<br>
</div>Drop device_type.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;apm,apm-lcd&quot;,&quot;apm,db9000&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 version =
=3D &quot;apm-1.1&quot;;<br>
<br>
</div>Why is &#39;version&#39; there? =A0Version of what? =A0The hardware i=
tself, the<br>
driver? =A0I doubt this is needed.<br></blockquote><div>It is chip version.=
 There are some changes in this block with respect to chip<br>revision. The=
 PVR remains the same as old chip revision and there is no<br>other registe=
r to specify revision. Uboot updates this parameter.<br>
<br>I will skip this block from next patch and will reintroduce it when the=
 actual<br>driver is added.<br><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x58060000 0x00001000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* int=
errupt index 0 for chip 1.0<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* int=
errupt index 1 for chip 1.1<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x1c 2 0x1c 4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
<br>
</div>Same binding comment for apm,apm-lcd. =A0I&#39;m just going to assert=
 again<br>
that anything that doesn&#39;t have a defined binding and/or driver needs<b=
r>
to be documented when it&#39;s introduced. =A0Repeat that for the rest of<b=
r>
the patch :).<br></blockquote><div><br>Yes. <br></div><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhc0: sdhc@58050000 {<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;sdhc&quot;;<br>
<br>
</div>Drop device_type.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;amcc,ahb-sdhc&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x58050000 0x100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x18 0x4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootmode=
 =3D &quot;i2c&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdm0: tdm@58010000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;tdm&quot;;<br>
<br>
</div>Drop device_type.<br>
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D &quot;disabled&quot;;<br>
<br>
Is that set by U-Boot?<br></blockquote><div>Yes. The chip is multiplexed. S=
ome IPs get disabled/enabled based on<br>bootmodes. <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px s=
olid rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;apm,ahb-tdm&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x58010000 0x100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x15 0x1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbotg0: usbotg@58080000=
 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;usb&quot;;<br>
<br>
</div>Drop device_type.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;apm,usb-otg&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x58080000 0x10000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x1B 4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D=
 &quot;host&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi0: spi@50000000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address=
-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-ce=
lls =3D &lt;0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;spi&quot;;<br>
<br>
</div>Drop device_type. =A0I think you&#39;re starting to get the trend, so=
 repeat<br>
for the rest of the devices.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;apm,apm-spi&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x50000000 0x100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x7 1&gt;; =A0/* interrupt number-&gt;0x7 Polarity-&gt;HIGH Sens=
itivity-&gt;LEVEL */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 half_dup=
lex =3D &lt;0x1&gt;; =A0 /*0 =3D rx/tx mode, 1 =3D eprom read mode */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysclk =
=3D &lt;100000000&gt;; =A0 /* input clock */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_num =
=3D &lt;0x0&gt;; =A0 =A0 =A0 /* SPI =3D 0 */<br>
<br>
&gt; +<br>
</div>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCIE0: pciex@58020=
000 {<br>
<div class=3D"im">&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 device_type =3D &quot;pci&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;ibm,plb-pciex&quot;, &quot;dwc-pciex&quot;, &quot;amcc,dwc-pci=
ex&quot;;<br>
<br>
</div>Why the unprefixed dwc-pciex compatible property?<br></blockquote><di=
v>=A0</div><div>I will correct it. <br><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204,=
 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-ce=
lls =3D &lt;2&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address=
-cells =3D &lt;3&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port =3D=
 &lt;0&gt;; /* port number */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D &quot;ok&quot;;<br>
<br>
<br>
</div>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCIE1: pciex@58030=
000 {<br>
<div class=3D"im">&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 device_type =3D &quot;pci&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;ibm,plb-pciex&quot;, &quot;dwc-pciex&quot;, &quot;amcc,dwc-pci=
ex&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-ce=
lls =3D &lt;2&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address=
-cells =3D &lt;3&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port =3D=
 &lt;1&gt;; /* port number */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D &quot;disabled&quot;;<br>
<br>
</div>Is this set by U-Boot?<br></blockquote><div>Yes. Same as multiplexed =
comment. <br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0=
pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;=
">

<div class=3D"im"><br>
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sata@58040000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;sata-ahci&quot;;<br>
<br>
</div>Uh.. what?<br></blockquote><div>It is designware SATA IP compatible w=
ith AHCI standard.<br>I will reintroduce this block along with its driver.<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
=A0&lt;0x58040000 0x2000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x1a 1&gt;;<br>
<br>
<br>
</div>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uf=
c@0xFE000000 {<br>
<div class=3D"im">&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;ibm,ufc&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D &lt;0xFE000000 0x00010000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 #address-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 #size-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 bootmode =3D &quot;nand&quot;;<br>
<br>
</div>Is UFC some kind of new flash controller that isn&#39;t NDFC? =A0Also=
,<br>
bootmode seems to be a human and/or driver variable, not a description<br>
of the hardware.<br></blockquote><div>=A0</div><div>Yes. UFC is new flash c=
ontroller. You are right about bootmode. <br><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART0: serial@50001000 {=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_t=
ype =3D &quot;serial&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;ns16550&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
&lt;0x50001000 0x00000100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtual-=
reg =3D &lt;0x50001000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-fr=
equency =3D &lt;300000000&gt;; /* Filled in by U-Boot */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current-=
speed =3D &lt;115200&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x0 0x4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*reg-sh=
ift =3D &lt;2&gt;;*/<br>
<br>
</div>This is commented out, but seems to be needed when you take the<br>
word-addressed UDBG thing into account?<br></blockquote><div>=A0</div><div>=
Yes. I will rethink on how it is implemented. <br><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px sol=
id rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IEEE1588_0: ieee1588ts0@=
400a5000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D &quot;ok&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D &quot;ieee1588-ts&quot;;<br>
<br>
</div>What is that?<br></blockquote><div>This is AMCC IEEE1588 block. I wil=
l correct the compatible string.<br><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerp=
c/configs/40x/klondike_defconfig<br>
&gt; new file mode 100644<br>
&gt; index 0000000..840f438<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/powerpc/configs/40x/klondike_defconfig<br>
&gt; @@ -0,0 +1,1353 @@<br>
&gt; +#<br>
&gt; +# Automatically generated file; DO NOT EDIT.<br>
&gt; +# Linux/powerpc 3.2.0-rc2 Kernel Configuration<br>
&gt; +#<br>
&gt; +# CONFIG_PPC64 is not set<br>
<br>
</div>This is a full defconfig. =A0We don&#39;t need a full config file. =
=A0You can<br>
generate one with &#39;make savedefconfig&#39; that contains only the optio=
ns<br>
you need to set.<br>
<div class=3D"im"><br></div></blockquote><div>I will do that. <br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im">
<br>
<br>
<br>
&gt; diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/ud=
bg_16550.c<br>
&gt; index 6837f83..dd3bce9 100644<br>
&gt; --- a/arch/powerpc/kernel/udbg_16550.c<br>
&gt; +++ b/arch/powerpc/kernel/udbg_16550.c<br>
&gt; @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iome=
m *addr);<br>
&gt; =A0extern u8 real_205_readb(volatile u8 __iomem =A0*addr);<br>
&gt; =A0extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);<br=
>
&gt;<br>
&gt; +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE<br>
&gt; +struct NS16550 {<br>
&gt; + =A0 =A0 =A0 /* this struct must be packed */<br>
&gt; + =A0 =A0 =A0 unsigned char rbr; =A0/* 0 */ u8 s0[3];<br>
<br>
</div>An array of length 3 for something &quot;word-addressable&quot;? =A0W=
hen did words<br>
change to 3 bytes? =A0Now, I still haven&#39;t finished my coffee yet, but<=
br>
that is really confusing.<br></blockquote><div>=A0</div><div>Again the name=
=A0 WORD_ADDRESSABLE is confusing. Hopefully my previous<br>comment clears =
the confusion.<br><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-l=
eft: 1ex;">

<div><div></div><div class=3D"h5"><br>
&gt; + =A0 =A0 =A0 unsigned char ier; =A0/* 1 */ u8 s1[3];<br>
&gt; + =A0 =A0 =A0 unsigned char fcr; =A0/* 2 */ u8 s2[3];<br>
&gt; + =A0 =A0 =A0 unsigned char lcr; =A0/* 3 */ u8 s3[3];<br>
&gt; + =A0 =A0 =A0 unsigned char mcr; =A0/* 4 */ u8 s4[3];<br>
&gt; + =A0 =A0 =A0 unsigned char lsr; =A0/* 5 */ u8 s5[3];<br>
&gt; + =A0 =A0 =A0 unsigned char msr; =A0/* 6 */ u8 s6[3];<br>
&gt; + =A0 =A0 =A0 unsigned char scr; =A0/* 7 */ u8 s7[3];<br>
&gt; +};<br>
&gt; +#else<br>
&gt; =A0struct NS16550 {<br>
&gt; =A0 =A0 =A0 =A0/* this struct must be packed */<br>
&gt; =A0 =A0 =A0 =A0unsigned char rbr; =A0/* 0 */<br>
&gt; @@ -29,6 +42,7 @@ struct NS16550 {<br>
&gt; =A0 =A0 =A0 =A0unsigned char msr; =A0/* 6 */<br>
&gt; =A0 =A0 =A0 =A0unsigned char scr; =A0/* 7 */<br>
&gt; =A0};<br>
&gt; +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */<br>
&gt;<br>
&gt; =A0#define thr rbr<br>
&gt; =A0#define iir fcr<br>
&gt; @@ -52,8 +66,16 @@ static struct NS16550 __iomem *udbg_comport;<br>
&gt; =A0static void udbg_550_flush(void)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 =A0if (udbg_comport) {<br>
&gt; +#if defined(CONFIG_APM8018X)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (index =3D 0; index &lt; 3500; index=
++) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((in_8(&amp;udbg_comp=
ort-&gt;lsr) &amp; LSR_THRE) =3D=3D LSR_THRE)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; +#else<br>
<br>
</div></div>What is index, and why do you read the same register 3500 times=
? =A0That<br>
doesn&#39;t sound like an index, it sounds like some kind of poor-mans<br>
timeout.<br></blockquote><div>This is hardware bug. Ideally there should no=
t be any change in the code. I will try to<br>fix it in better way. <br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bo=
rder-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((in_8(&amp;udbg_comport-&gt;lsr)=
 &amp; LSR_THRE) =3D=3D 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait for idle */;<br=
>
&gt; +#endif /* CONFIG_APM8018X */<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; =A0}<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platfor=
ms/40x/Kconfig<br>
&gt; index 1530229..3d0d1d9 100644<br>
&gt; --- a/arch/powerpc/platforms/40x/Kconfig<br>
&gt; +++ b/arch/powerpc/platforms/40x/Kconfig<br>
&gt; @@ -186,3 +186,14 @@ config IBM405_ERR51<br>
&gt; =A0# =A0 =A0 =A0bool<br>
&gt; =A0# =A0 =A0 =A0depends on !STB03xxx &amp;&amp; PPC4xx_DMA<br>
&gt; =A0# =A0 =A0 =A0default y<br>
&gt; +#<br>
&gt; +<br>
&gt; +config APM8018X<br>
&gt; + =A0 =A0 =A0 bool &quot;APM8018X&quot;<br>
&gt; + =A0 =A0 =A0 depends on 40x<br>
&gt; + =A0 =A0 =A0 default y<br>
<br>
</div>default n please.<br></blockquote><div><br>Yes.=A0 <br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: =
1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 select PPC40x_SIMPLE<br>
&gt; + =A0 =A0 =A0 select UART_16550_WORD_ADDRESSABLE<br>
&gt; + =A0 =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 =A0 This option enables support for the AppliedMicro Klo=
ndike board.<br>
&gt; +<br>
&gt; diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc=
/platforms/40x/ppc40x_simple.c<br>
&gt; index e8dd5c5..c8576af 100644<br>
&gt; --- a/arch/powerpc/platforms/40x/ppc40x_simple.c<br>
&gt; +++ b/arch/powerpc/platforms/40x/ppc40x_simple.c<br>
&gt; @@ -17,7 +17,7 @@<br>
&gt; =A0#include &lt;asm/pci-bridge.h&gt;<br>
&gt; =A0#include &lt;asm/ppc4xx.h&gt;<br>
&gt; =A0#include &lt;asm/prom.h&gt;<br>
&gt; -#include &lt;asm/time.h&gt;<br>
&gt; +#include &lt;linux/time.h&gt;<br>
<br>
</div>Is this needed for a reason? =A0If so, it should be submitted as a se=
parate patch.<br></blockquote><div><br><a href=3D"http://checkpatch.pl">che=
ckpatch.pl</a> scripts throws warning. It asks to change &lt;asm/time.h&gt;=
 to &lt;linux/time.h&gt; <br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.=
8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
&gt; =A0#include &lt;asm/udbg.h&gt;<br>
&gt; =A0#include &lt;asm/uic.h&gt;<br>
&gt;<br>
&gt; @@ -29,6 +29,7 @@ static __initdata struct of_device_id ppc40x_of_bus[=
] =3D {<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;ibm,plb4&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;ibm,opb&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;ibm,ebc&quot;, },<br>
&gt; + =A0 =A0 =A0 { .compatible =3D &quot;ibm,ahb&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;simple-bus&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{},<br>
&gt; =A0};<br>
&gt; @@ -55,6 +56,7 @@ static const char *board[] __initdata =3D {<br>
&gt; =A0 =A0 =A0 =A0&quot;amcc,haleakala&quot;,<br>
&gt; =A0 =A0 =A0 =A0&quot;amcc,kilauea&quot;,<br>
&gt; =A0 =A0 =A0 =A0&quot;amcc,makalu&quot;,<br>
&gt; + =A0 =A0 =A0 &quot;amcc,klondike&quot;,<br>
&gt; =A0 =A0 =A0 =A0&quot;est,hotfoot&quot;<br>
&gt; =A0};<br>
&gt;<br>
&gt; --<br>
&gt; 1.6.1.rc3<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br>

<pre>CONFIDENTIALITY NOTICE: This e-mail message, including any attachmen=
ts, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
--90e6ba6e89dc434a7204b2775f49--
