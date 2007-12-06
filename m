Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 6EC07DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 08:49:40 +1100 (EST)
Message-ID: <47586E72.3050106@anagramm.de>
Date: Thu, 06 Dec 2007 22:49:38 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: MPC85xx DMA drivers, first testing results.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi There!

I just tried to use the fsldma on the mpc8540. It seems to work fine
here, but I would be glad if somebody can confirm before I move on:

I added the following to my mpc8540ads compatible board's .dts
(see my comments, where the not yet available documentation
was unclear):

dma@21000 {
         #address-cells = <1>;
         #size-cells = <1>;
         compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
         device-id = <0>;
         reg = <21300 4>;        /* DGSR - DMA general status register */
         /* reg = <21000 4>;*/   /* or use offset of DMA machine ??? */
         ranges = <0 21100 200>; /* we have 4 DMA channels at 21100, size=80 each */
         dma-channel@0 {
                 compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
                 device-id = <0>; /* or cell-index ??? */
                 reg = <0 80>;
                 interrupt-parent = <&mpic>;
                 interrupts = <14 2>;
         };
         dma-channel@80 {        /* or use 0,1,2,3 instead of 0,80,100,180 ??? */
                 compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
                 device-id = <1>;
                 reg = <80 80>;
                 interrupt-parent = <&mpic>;
                 interrupts = <15 2>;
         };
         dma-channel@100 {
                 compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
                 device-id = <2>;
                 reg = <100 80>;
                 interrupt-parent = <&mpic>;
                 interrupts = <16 2>;
         };
         dma-channel@180 {
                 compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
                 device-id = <3>;
                 reg = <180 80>;
                 interrupt-parent = <&mpic>;
                 interrupts = <17 2>;
         };
};


$ dmesg then says:

of-fsl-dma e0021300.dma: Probe the Freescale DMA driver for fsl,mpc8540-dma controller at 0xe0021300...
of-fsl-dma-channel e0021100.dma-channe: selftest: start...
of-fsl-dma-channel e0021100.dma-channe: selftest: finished, err=0.
of-fsl-dma-channel e0021100.dma-channe: #0 (fsl,mpc8540-dma-channel), irq 21
of-fsl-dma-channel e0021180.dma-channe: selftest: start...
of-fsl-dma-channel e0021180.dma-channe: selftest: finished, err=0.
of-fsl-dma-channel e0021180.dma-channe: #1 (fsl,mpc8540-dma-channel), irq 22
of-fsl-dma-channel e0021200.dma-channe: selftest: start...
of-fsl-dma-channel e0021200.dma-channe: selftest: finished, err=0.
of-fsl-dma-channel e0021200.dma-channe: #2 (fsl,mpc8540-dma-channel), irq 23
of-fsl-dma-channel e0021280.dma-channe: selftest: start...
of-fsl-dma-channel e0021280.dma-channe: selftest: finished, err=0.
of-fsl-dma-channel e0021280.dma-channe: #3 (fsl,mpc8540-dma-channel), irq 24

I added another dev_info() to get at least a glue that the selftest is run.
It looks like dev_info(fsl_chan->dev, ...); seems to be truncated.

I have no idea if interrupts are working well... the callback isn't
used yet.

Otherwise, nice work! :-) I'm looking forward to see this functionality
in mainline.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
