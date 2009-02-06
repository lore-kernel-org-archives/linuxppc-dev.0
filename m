Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 51840DDED6
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 00:35:10 +1100 (EST)
Message-ID: <498C3C81.7050500@matrix-vision.de>
Date: Fri, 06 Feb 2009 14:34:57 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Subject: Re: MPC5200 PCI Issues
References: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
In-Reply-To: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tobias,

are you starting with 2.6.28 or are you upgrading ?
My system runs very fine with 2.6.27 ....

Tobias Knutsson wrote:
> I am currently trying to get an MPC5200-based board to run Linux
> 2.6.28. Most of the devices are working, however i have some issues
> with the PCI-bus. More precisely, the issue is that all of
> the cards' IO-regions are mapped to address 0x0.
>   
> In my device tree I have the following:
>
>        pci@f0000d00 {
>                #interrupt-cells = <1>;
>                #size-cells = <2>;
>                #address-cells = <3>;
>                device_type = "pci";
>                compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
>                reg = <0xf0000d00 0x100>;
>                interrupt-map-mask = <0xf800 0 0 7>;
>                interrupt-map = <0xb000 0 0 1 &mpc5200_pic 0 0 3 // MPC5200
>                                 0xb000 0 0 2 &mpc5200_pic 0 0 3
>                                 0xb000 0 0 3 &mpc5200_pic 0 0 3
>                                 0xb000 0 0 4 &mpc5200_pic 0 0 3
>   
What's this ? Is the MPC5200 interrupting itself ?
>                                 0xb800 0 0 1 &mpc5200_pic 1 1 3 // c64x0
>                                 0xb800 0 0 2 &mpc5200_pic 1 1 3
>                                 0xb800 0 0 3 &mpc5200_pic 1 1 3
>                                 0xb800 0 0 4 &mpc5200_pic 1 1 3
>   
Have you connected 4 IRQ lines to each c64x device ?
>                                 0xc000 0 0 1 &mpc5200_pic 1 1 3 // c64x1
>                                 0xc000 0 0 2 &mpc5200_pic 1 1 3
>                                 0xc000 0 0 3 &mpc5200_pic 1 1 3
>                                 0xc000 0 0 4 &mpc5200_pic 1 1 3
>
>                                 0xc800 0 0 1 &mpc5200_pic 1 1 3 // c64x2
>                                 0xc800 0 0 2 &mpc5200_pic 1 1 3
>                                 0xc800 0 0 3 &mpc5200_pic 1 1 3
>                                 0xc800 0 0 4 &mpc5200_pic 1 1 3
>
>                                 0xd000 0 0 1 &mpc5200_pic 1 1 3 // c64x3
>                                 0xd000 0 0 2 &mpc5200_pic 1 1 3
>                                 0xd000 0 0 3 &mpc5200_pic 1 1 3
>                                 0xd000 0 0 4 &mpc5200_pic 1 1 3
>
>                                 0xd800 0 0 1 &mpc5200_pic 1 1 3 // c64x4
>                                 0xd800 0 0 2 &mpc5200_pic 1 1 3
>                                 0xd800 0 0 3 &mpc5200_pic 1 1 3
>                                 0xd800 0 0 4 &mpc5200_pic 1 1 3>;
>
>   
I'm using an external FPGA and an e1000 NIC connectedt to IRQ2 and IRQ3 :

                interrupt-map = <0x5800 0 0 1 &mpc5200_pic 1 2 3
                                                 0x5000 0 0 1 
&mpc5200_pic 1 3 3>;


>                clock-frequency = <0x1e84800>;  //<0>; // From boot loader
>                interrupts = <2 8 0 2 9 0 2 10 0>;
>                interrupt-parent = <&mpc5200_pic>;
>                bus-range = <0 0>;
>                ranges = <0x02000000 0 0x50000000 0x50000000 0 0x10000000
>                          0x01000000 0 0x00000000 0x60000000 0 0x01000000>;
>        };
>   
I'm using a 3 liner :

                ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
                        0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
                        0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;

> The cards' memory regions are mapped out fine to different addresses
> in the 0x50000000-0x60000000 range. However, the IO regions are all mapped
> to zero.
>
>   
Are you c64x devices responding properly ? Is IO access enabled in the 
PCI command register ?
Are they announcing a reasonable window ? How man KBytes ?
> Do you have any idea on what could be wrong or in which direction I
> should be looking?
>
>
>   

Hopefully something is useful to you.

regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
