Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 02F04DDFA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 13:27:30 +1100 (EST)
In-Reply-To: <20071213195759.0de2a917@vader.jdub.homelinux.org>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: How is a device tree used to specifiy flash?
MIME-Version: 1.0
Message-ID: <OF21AB4B78.566958B4-ON882573B1.000D0B22-882573B1.000D7E3C@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 13 Dec 2007 18:27:23 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > 
> > flash@ff000000 {
> 
> What bus is this node under in your DTS file?  Make sure that bus is
> getting probed in the platform code.
> 

Well, I was starting to wonder about that.  This node isn't under any bus 
in the DTS file.  It's at the same level as the CPU node.  Does it need to 
be under a localbus node like the pq2fads.dts?  I've attached the entire 
DTS this time which may help.

Bruce

/ {
        model = "MPC8349EMITX";
        compatible = "MPC8349EMITX", "MPC834xMITX", "MPC83xxMITX";
        #address-cells = <1>;
        #size-cells = <1>;

        cpus {
                #cpus = <1>;
                #address-cells = <1>;
                #size-cells = <0>;

                PowerPC,8349@0 {
                        device_type = "cpu";
                        reg = <0>;
                        d-cache-line-size = <20>;
                        i-cache-line-size = <20>;
                        d-cache-size = <8000>;
                        i-cache-size = <8000>;
                        timebase-frequency = <0>;       // from bootloader
                        bus-frequency = <0>;            // from bootloader
                        clock-frequency = <0>;          // from bootloader
                        32-bit;
                };
        };

        memory {
                device_type = "memory";
                reg = <00000000 20000000>;
        };

        flash@ff000000 {
                compatible = "amd,s29g128n", "cfi-flash";
                reg = <ff000000 01000000>;
                bank-width = <2>;
                device-width = <1>;
                #address-cells = <1>;
                #size-cells = <1>;
                bit@200000 {
                        label = "bit";
                        reg = <200000 a0000>;
                };
                kernel@400000 {
                        label = "kernel";
                        reg = <400000 140000>;
                };
                blob@600000 {
                        label = "blob";
                        reg = <600000 20000>;
                };
                uboot@f00000 {
                        label = "uboot";
                        reg = <f00000 60000>;
                        read-only;
                };
        };

        soc8349@e0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                #interrupt-cells = <2>;
                device_type = "soc";
                ranges = <0 e0000000 00100000>;
                reg = <e0000000 00000200>;
                bus-frequency = <0>;                    // from bootloader

                wdt@200 {
                        device_type = "watchdog";
                        compatible = "mpc83xx_wdt";
                        reg = <200 100>;
                };

                i2c@3000 {
                        device_type = "i2c";
                        compatible = "fsl-i2c";
                        reg = <3000 100>;
                        interrupts = <e 8>;
                        interrupt-parent = < &ipic >;
                        dfsrr;

                        rtc@68 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                device_type = "rtc";
                                compatible = "stm,m41t00";
                                reg = <68 8>;
                        };
                };

                i2c@3100 {
                        device_type = "i2c";
                        compatible = "fsl-i2c";
                        reg = <3100 100>;
                        interrupts = <f 8>;
                        interrupt-parent = < &ipic >;
                        dfsrr;
                };

                spi@7000 {
                        device_type = "spi";
                        compatible = "mpc83xx_spi";
                        reg = <7000 1000>;
                        interrupts = <10 8>;
                        interrupt-parent = < &ipic >;
                        mode = <0>;
                };

                usb@22000 {
                        device_type = "usb";
                        compatible = "fsl-usb2-mph";
                        reg = <22000 1000>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        interrupt-parent = < &ipic >;
                        interrupts = <27 8>;
                        phy_type = "ulpi";
//                      port1;
                        port0;
                };

//              usb@23000 {
//                      device_type = "usb";
//                      compatible = "fsl-usb2-dr";
//                      reg = <23000 1000>;
//                      #address-cells = <1>;
//                      #size-cells = <0>;
//                      interrupt-parent = < &ipic >;
//                      interrupts = <26 8>;
//                      phy_type = "ulpi";
//              };

                mdio@24520 {
                        device_type = "mdio";
                        compatible = "gianfar";
                        reg = <24520 20>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        /* Vitesse 8201 */
                        phy0: ethernet-phy@1c {
                                interrupt-parent = < &ipic >;
                                interrupts = <12 8>;
                                reg = <0>;
                                device_type = "ethernet-phy";
                        };

                        /* Vitesse 7385 */
                        phy1: ethernet-phy@1f {
                                interrupt-parent = < &ipic >;
                                interrupts = <12 8>;
                                reg = <1>;
                                device_type = "ethernet-phy";
                        };
                };

                ethernet@24000 {
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <24000 1000>;
                        address = [ 00 00 00 00 00 00 ];
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <20 8 21 8 22 8>;
                        interrupt-parent = < &ipic >;
                        phy-handle = < &phy0 >;
                };

                ethernet@25000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <25000 1000>;
                        address = [ 00 00 00 00 00 00 ];
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <23 8 24 8 25 8>;
                        interrupt-parent = < &ipic >;
                        phy-handle = < &phy1 >;
                };

                serial@4500 {
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <4500 100>;
                        clock-frequency = <0>;          // from bootloader
                        interrupts = <9 8>;
                        interrupt-parent = < &ipic >;
                };

                serial@4600 {
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <4600 100>;
                        clock-frequency = <0>;          // from bootloader
                        interrupts = <a 8>;
                        interrupt-parent = < &ipic >;
                };

                pci@8500 {
                        interrupt-map-mask = <f800 0 0 7>;
                        interrupt-map = <
                                        // IDSEL 0x12 - FPGA
                                        9000 0 0 1 &ipic 15 8 // INTA - 
UARTS
                                        9000 0 0 2 &ipic 16 8 // INTB - 
IRIG

                                        // IDSEL 0x13 - PCI Enet
                                        9800 0 0 1 &ipic 14 8 // INTA

                                        // IDSEL 0x14 - PCI104 Slot 1
                                        a000 0 0 1 &ipic 12 8 // INTA
                                        a000 0 0 2 &ipic 13 8 // INTB
                                        a000 0 0 3 &ipic 15 8 // INTC
                                        a000 0 0 4 &ipic 16 8 // INTD

                                        // IDSEL 0x15 - PCI104 Slot 2
                                        a800 0 0 1 &ipic 13 8 // INTA
                                        a800 0 0 2 &ipic 15 8 // INTB
                                        a800 0 0 3 &ipic 16 8 // INTC
                                        a800 0 0 4 &ipic 12 8 // INTD

                                        // IDSEL 0x16 - PCI104 Slot 3
                                        b000 0 0 1 &ipic 15 8 // INTA
                                        b000 0 0 2 &ipic 16 8 // INTB
                                        b000 0 0 3 &ipic 12 8 // INTC
                                        b000 0 0 4 &ipic 13 8 // INTD
                                        >;
                        interrupt-parent = < &ipic >;
                        interrupts = <42 8>;
                        bus-range = <0 0>;
                        ranges = <42000000 0 80000000 80000000 0 10000000
                                  02000000 0 90000000 90000000 0 08000000
                                  01000000 0 98000000 98000000 0 
08000000>;
                        clock-frequency = <1f78a40>;
                        #interrupt-cells = <1>;
                        #size-cells = <2>;
                        #address-cells = <3>;
                        reg = <8500 100>;
                        compatible = "83xx";
                        device_type = "pci";
                };

                crypto@30000 {
                        device_type = "crypto";
                        model = "SEC2";
                        compatible = "talitos";
                        reg = <30000 10000>;
                        interrupts = <b 8>;
                        interrupt-parent = < &ipic >;
                        num-channels = <4>;
                        channel-fifo-len = <18>;
                        exec-units-mask = <0000007e>;
                        descriptor-types-mask = <01010ebf>;
                };

                ipic: pic@700 {
                        interrupt-controller;
                        #address-cells = <0>;
                        #interrupt-cells = <2>;
                        reg = <700 100>;
                        built-in;
                        device_type = "ipic";
                };
        };
};
