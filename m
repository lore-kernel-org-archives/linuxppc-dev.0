Return-Path: <henk.stegeman@gmail.com>
Received: from mail-bw0-f211.google.com (mail-bw0-f211.google.com
	[209.85.218.211]) by ozlabs.org (Postfix) with ESMTP id 5CC8CB7CF6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 01:20:57 +1100 (EST)
Received: by bwz3 with SMTP id 3so910238bwz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 06:20:55 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 8 Mar 2010 15:20:53 +0100
Message-ID: <ae4f76fd1003080620o5598778cv221f05bf331768c8@mail.gmail.com>
Subject: IRQ's missing with MPC5200 GPT as an interrupt controller
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to make use of the GPT as interrupt controller.
My driver is getting most, but not all of the interrupts, besides that
I'm getting a whole bunch of spurious IRQs, so I'm trying to figure
out what's wrong.

		gpt6: timer@660 {	
			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
			reg = <0x660 0x10>;
			interrupts = <1 15 0>;
			interrupt-controller;
			#interrupt-cells = <1>;
		};

My device has the interrupt-parent property which links it to the
above interrupt controller.

		spi@f00 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
			reg = <0xf00 0x20>;
			interrupts = <2 13 0 2 14 0>;

			io-controller@0 {
				compatible = "microkey,smc4000io";
				linux,modalias = "of_smc4000io";
				spi-max-frequency = <800000>;
				spi-cpha;
				reg = <0>;
				word-delay-us = <30>;
				interrupt-parent = <&gpt6>;
				interrupts = <2>; // And make it edge falling
			};

There are two things I find suspicious:
- First of all my interrupt is listed as virq# 16, shouldn't it be
virq# 0x50 ? (16 is te L2 value virq# 0x50 of mpc52xx_irqhost_map)
- Secondly in mpc52xx_gpt.c  mpc52xx_gpt_irq_mask() and
mpc52xx_gpt_irq_unmask() resp. clear and set the IrqEn bit of the GPT,
which is described in the MPC5200B_UM as "enables interrupt generation
to the CPU for all modes". The word 'generation' makes me suspicious,
because it could mean that while irqEn is cleared an edge on the GPT's
input does not even request an IRQ immediately after the bit is
cleared.  Or in other words, clearing the bit could do more that just
masking.

~ # cat /proc/interrupts
           CPU0
 16:    1338686   MPC52xx GPT      Edge         smc4000io
129:      83224   MPC52xx Peripherals Level        mpc52xx_psc_uart
130:          1   MPC52xx Peripherals Level        mpc52xx_psc_uart
133:          0   MPC52xx Peripherals Level        mpc52xx-fec_ctrl
134:          0   MPC52xx Peripherals Level        ohci_hcd:usb1
135:      16127   MPC52xx Peripherals Level        mpc52xx_ata
141:          0   MPC52xx Peripherals Level        mpc5200-spi-modf
142:      79184   MPC52xx Peripherals Level        mpc5200-spi-spif
192:          0   MPC52xx SDMA     Level        ATA task
193:         15   MPC52xx SDMA     Level        mpc52xx-fec_rx
194:      35615   MPC52xx SDMA     Level        mpc52xx-fec_tx
LOC:     134286   Local timer interrupts
SPU:     576958   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions

~ # dmesg |grep 660
[    1.975928] irq: irq 0 on host /soc5200@f0000000/timer@660 mapped
to virtual irq 16

~ # dmesg | grep host_map
[    0.000000] mpc52xx_irqhost_map: virq=81, l1=2, l2=1
[    0.319272] mpc52xx_irqhost_map: External IRQ1 virq=41, hw=41. type=8
[    0.376117] mpc52xx_irqhost_map: virq=49, l1=1, l2=9
[    0.417213] mpc52xx_irqhost_map: virq=4a, l1=1, l2=10
[    0.452119] mpc52xx_irqhost_map: virq=4b, l1=1, l2=11
[    0.487031] mpc52xx_irqhost_map: virq=4c, l1=1, l2=12
[    0.529899] mpc52xx_irqhost_map: virq=4d, l1=1, l2=13
[    0.564821] mpc52xx_irqhost_map: virq=4e, l1=1, l2=14
[    0.599744] mpc52xx_irqhost_map: virq=4f, l1=1, l2=15
[    0.634669] mpc52xx_irqhost_map: virq=50, l1=1, l2=16
[    1.629764] mpc52xx_irqhost_map: virq=82, l1=2, l2=2
[    1.667194] mpc52xx_irqhost_map: virq=84, l1=2, l2=4
[    1.763299] mpc52xx_irqhost_map: virq=87, l1=2, l2=7
[    1.790510] mpc52xx_irqhost_map: virq=c0, l1=3, l2=0
[    1.909341] mpc52xx_irqhost_map: virq=8d, l1=2, l2=13
[    1.936712] mpc52xx_irqhost_map: virq=8e, l1=2, l2=14
[    2.055579] mpc52xx_irqhost_map: virq=c1, l1=3, l2=1
[    2.083018] mpc52xx_irqhost_map: virq=c2, l1=3, l2=2
[    2.110345] mpc52xx_irqhost_map: virq=85, l1=2, l2=5
[    2.211890] mpc52xx_irqhost_map: virq=86, l1=2, l2=6
~
