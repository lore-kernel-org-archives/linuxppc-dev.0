Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1204DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 02:27:06 +1100 (EST)
Received: from [172.26.6.74] ([172.26.6.74]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	mAHFCex4029996
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Nov 2008 16:12:41 +0100
Message-ID: <492189ED.6050700@selcomgroup.com>
Date: Mon, 17 Nov 2008 16:12:45 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Device tree and IRQ for chip on PCI
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a chip connected on the PCI bus on an MPC512x, but if I get the 
IRQ property from the PCI chip, it is not set up by Linux.
The IRQ line goes directly from the chip to the MPC512x uc, so I don't 
know if I should create a separate node just to get the interrupt, or I 
should expect the pci functions to assign it an interrupt based on the 
PCI bus.

The description for the PCI bus is like this:
        pci: pci@80008500 {
                interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
                interrupt-map = <
                                // IDSEL 0x15 - Slot PCI
                                 0xa800 0x0 0x0 0x1 &ipic 0x0 0x8
                                 0xa800 0x0 0x0 0x2 &ipic 0x1 0x8
                                 0xa800 0x0 0x0 0x3 &ipic 0x2 0x8
                                 0xa800 0x0 0x0 0x4 &ipic 0x3 0x8

                                >;
                interrupt-parent = < &ipic >;
                interrupts = <17 0x8>;
                bus-range = <0 0>;
                ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 
0x10000000
                          0x02000000 0x0 0xb0000000 0xb0000000 0x0 
0x10000000
                          0x01000000 0x0 0x00000000 0x84000000 0x0 
0x01000000>;
                clock-frequency = <66000000>;
                #interrupt-cells = <1>;
                #size-cells = <2>;
                #address-cells = <3>;
                reg = <0x80008500 0x100>;
                compatible = "fsl,mpc5121-pci";
                device_type = "pci";
        };


Thanks,
Matteo
