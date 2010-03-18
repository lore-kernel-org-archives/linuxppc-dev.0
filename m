Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f189.google.com (mail-yx0-f189.google.com
	[209.85.210.189]) by ozlabs.org (Postfix) with ESMTP id 8E449B7CE6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 05:03:10 +1100 (EST)
Received: by yxe27 with SMTP id 27so1222951yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 11:03:09 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <ae4f76fd1003080620o5598778cv221f05bf331768c8@mail.gmail.com>
References: <ae4f76fd1003080620o5598778cv221f05bf331768c8@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 12:02:49 -0600
Message-ID: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
Subject: Re: IRQ's missing with MPC5200 GPT as an interrupt controller
To: Henk Stegeman <henk.stegeman@gmail.com>
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

Hi Henk,

On Mon, Mar 8, 2010 at 8:20 AM, Henk Stegeman <henk.stegeman@gmail.com> wro=
te:
> I'm trying to make use of the GPT as interrupt controller.
> My driver is getting most, but not all of the interrupts, besides that
> I'm getting a whole bunch of spurious IRQs, so I'm trying to figure
> out what's wrong.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpt6: timer@660 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-gpt","fsl,mpc5200-gpt";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x660 0x10>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <1 15 0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> My device has the interrupt-parent property which links it to the
> above interrupt controller.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi@f00 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-spi","fsl,mpc5200-spi";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf00 0x20>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 13 0 2 1=
4 0>;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0io-controller@0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "microkey,smc4000io";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,moda=
lias =3D "of_smc4000io";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-max-fr=
equency =3D <800000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-cpha;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0word-delay=
-us =3D <30>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-=
parent =3D <&gpt6>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts=
 =3D <2>; // And make it edge falling
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> There are two things I find suspicious:
> - First of all my interrupt is listed as virq# 16, shouldn't it be
> virq# 0x50 ? (16 is te L2 value virq# 0x50 of mpc52xx_irqhost_map)

The GPT irq registered as a different IRQ controller, so it will be
assigned an entirely different number within the virq range.

> - Secondly in mpc52xx_gpt.c =A0mpc52xx_gpt_irq_mask() and
> mpc52xx_gpt_irq_unmask() resp. clear and set the IrqEn bit of the GPT,
> which is described in the MPC5200B_UM as "enables interrupt generation
> to the CPU for all modes". The word 'generation' makes me suspicious,
> because it could mean that while irqEn is cleared an edge on the GPT's
> input does not even request an IRQ immediately after the bit is
> cleared. =A0Or in other words, clearing the bit could do more that just
> masking.

Could be, the IRQ support has not gotten extensive testing.  It may
require additional work.

> ~ # cat /proc/interrupts
> =A0 =A0 =A0 =A0 =A0 CPU0
> =A016: =A0 =A01338686 =A0 MPC52xx GPT =A0 =A0 =A0Edge =A0 =A0 =A0 =A0 smc=
4000io
> 129: =A0 =A0 =A083224 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mpc52x=
x_psc_uart
> 130: =A0 =A0 =A0 =A0 =A01 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mp=
c52xx_psc_uart
> 133: =A0 =A0 =A0 =A0 =A00 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mp=
c52xx-fec_ctrl
> 134: =A0 =A0 =A0 =A0 =A00 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0oh=
ci_hcd:usb1
> 135: =A0 =A0 =A016127 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mpc52x=
x_ata
> 141: =A0 =A0 =A0 =A0 =A00 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mp=
c5200-spi-modf
> 142: =A0 =A0 =A079184 =A0 MPC52xx Peripherals Level =A0 =A0 =A0 =A0mpc520=
0-spi-spif
> 192: =A0 =A0 =A0 =A0 =A00 =A0 MPC52xx SDMA =A0 =A0 Level =A0 =A0 =A0 =A0A=
TA task
> 193: =A0 =A0 =A0 =A0 15 =A0 MPC52xx SDMA =A0 =A0 Level =A0 =A0 =A0 =A0mpc=
52xx-fec_rx
> 194: =A0 =A0 =A035615 =A0 MPC52xx SDMA =A0 =A0 Level =A0 =A0 =A0 =A0mpc52=
xx-fec_tx
> LOC: =A0 =A0 134286 =A0 Local timer interrupts
> SPU: =A0 =A0 576958 =A0 Spurious interrupts
> CNT: =A0 =A0 =A0 =A0 =A00 =A0 Performance monitoring interrupts
> MCE: =A0 =A0 =A0 =A0 =A00 =A0 Machine check exceptions
>
> ~ # dmesg |grep 660
> [ =A0 =A01.975928] irq: irq 0 on host /soc5200@f0000000/timer@660 mapped
> to virtual irq 16
>
> ~ # dmesg | grep host_map
> [ =A0 =A00.000000] mpc52xx_irqhost_map: virq=3D81, l1=3D2, l2=3D1
> [ =A0 =A00.319272] mpc52xx_irqhost_map: External IRQ1 virq=3D41, hw=3D41.=
 type=3D8
> [ =A0 =A00.376117] mpc52xx_irqhost_map: virq=3D49, l1=3D1, l2=3D9
> [ =A0 =A00.417213] mpc52xx_irqhost_map: virq=3D4a, l1=3D1, l2=3D10
> [ =A0 =A00.452119] mpc52xx_irqhost_map: virq=3D4b, l1=3D1, l2=3D11
> [ =A0 =A00.487031] mpc52xx_irqhost_map: virq=3D4c, l1=3D1, l2=3D12
> [ =A0 =A00.529899] mpc52xx_irqhost_map: virq=3D4d, l1=3D1, l2=3D13
> [ =A0 =A00.564821] mpc52xx_irqhost_map: virq=3D4e, l1=3D1, l2=3D14
> [ =A0 =A00.599744] mpc52xx_irqhost_map: virq=3D4f, l1=3D1, l2=3D15
> [ =A0 =A00.634669] mpc52xx_irqhost_map: virq=3D50, l1=3D1, l2=3D16
> [ =A0 =A01.629764] mpc52xx_irqhost_map: virq=3D82, l1=3D2, l2=3D2
> [ =A0 =A01.667194] mpc52xx_irqhost_map: virq=3D84, l1=3D2, l2=3D4
> [ =A0 =A01.763299] mpc52xx_irqhost_map: virq=3D87, l1=3D2, l2=3D7
> [ =A0 =A01.790510] mpc52xx_irqhost_map: virq=3Dc0, l1=3D3, l2=3D0
> [ =A0 =A01.909341] mpc52xx_irqhost_map: virq=3D8d, l1=3D2, l2=3D13
> [ =A0 =A01.936712] mpc52xx_irqhost_map: virq=3D8e, l1=3D2, l2=3D14
> [ =A0 =A02.055579] mpc52xx_irqhost_map: virq=3Dc1, l1=3D3, l2=3D1
> [ =A0 =A02.083018] mpc52xx_irqhost_map: virq=3Dc2, l1=3D3, l2=3D2
> [ =A0 =A02.110345] mpc52xx_irqhost_map: virq=3D85, l1=3D2, l2=3D5
> [ =A0 =A02.211890] mpc52xx_irqhost_map: virq=3D86, l1=3D2, l2=3D6

This grep only shows the output from mpc52xx_intc.c.  The GPT driver
has its own IRQ mapping function; mpc52xx_gpt_irq_map(), which is why
you're not seeing your IRQ map debug message.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
