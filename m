Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6.jnb1.host-h.net [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE93EDE106
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 19:58:36 +1100 (EST)
Received: from [196.213.226.33] (helo=[172.16.63.116])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1LRNIa-0002W7-BZ
	for linuxppc-dev@ozlabs.org; Mon, 26 Jan 2009 10:58:28 +0200
Message-ID: <497D7B37.9060909@vastech.co.za>
Date: Mon, 26 Jan 2009 10:58:31 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Need help creating Device tree source for custom MPC8548 board
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all

I have inherited  a cusom MPC 8548 board and am currently in the
processes of porting to U-Boot 2008 and Linux 2.6.27. The board worked
using U-boot 1.2 and linux 2.6.24 not using FDT.

I have completed the U-boot source and am able to boot up to the point
where control is handed to Linux kernel , where the board hangs. This
lead me to believe that my device tree source is not accurate.

    ## Transferring control to Linux (at address 00000000) ...
       Booting using OF flat tree...

I assembled a minimal "equus.dts"  by using the tqm8458.dts and
sbc8548.dts as examples and the "Booting the Linux/ppc kernel without
Open Firmware" document supplied with Lnux 2.6.27. I am uncertain about
assigning interrupts to the variouse nodes.

I compiled the blob using dtc Version: 1.1.0:
dtc -b 0 -V 17 -p 0x2000 -I dts -R 8 -O dtb -f
arch/powerpc/boot/dts/equus.dts > SDH0/tftp/equus.dtb

can anyone please help? My device tree source is as follows:

    /dts-v1/;
    / {
        model = "EQUUS";
        compatible = "Equus 2009";
        #address-cells = <1>;
        #size-cells = <1>;
        aliases {
            ethernet0 = &enet0;
            ethernet1 = &enet1;
            ethernet2 = &enet2;
            serial0 = &serial1;
            serial1 = &serial0;
        };

        cpus {
            #address-cells = <1>;
            #size-cells = <0>;
            PowerPC,8548@0 {
                device_type = "cpu";
                reg = <0>;
                d-cache-line-size = <0x20>;    // 32 bytes
                i-cache-line-size = <0x20>;    // 32 bytes
                d-cache-size = <0x8000>;    // L1, 32K
                i-cache-size = <0x8000>;    // L1, 32K
                timebase-frequency = <0>;    // From uboot
                bus-frequency = <0>;        // From uboot
                clock-frequency = <0>;        // From uboot
                next-level-cache = <&L2>;   
            };
        };

        memory {
            device_type = "memory";
            reg = <0x00000000 0x20000000>;    //512M at 0x0
        };

        soc8548@e0000000 {
            #address-cells = <1>;
            #size-cells = <1>;
            device_type = "soc";
            ranges = <0x00000000 0xe0000000 0x00100000>;
            reg = <0xe0000000 0x00001000>;    // CCSRBAR
            bus-frequency = <0>;
            compatible ="fsl,mpc8548-immr", "simple-bus";

            memory-controller@2000 {
                compatible = "fsl,8548-memory-controller";
                reg = <0x2000 0x1000>;
                interrupt-parent = <&mpic>;
                interrupts = <0x12 0x2>; 
            };

            L2: l2-cache-controller@20000 {
                compatible = "fsl,8548-l2-cache-controller";
                reg = <0x20000 0x1000>;
                cache-line-size = <0x20>;    // 32 bytes
                cache-size = <0x80000>;    // L2, 512K
                interrupt-parent = <&mpic>;
                interrupts = <0x10 0x2>;
            };

            i2c@3000 {
                #address-cells = <1>;
                #size-cells = <0>;
                cell-index = <0>;
                compatible = "fsl-i2c";
                reg = <0x3000 0x100>;
                interrupts = <0x2b 0x2>;
                interrupt-parent = <&mpic>;
                dfsrr;
            };

            i2c@3100 {
                #address-cells = <1>;
                #size-cells = <0>;
                cell-index = <1>;
                compatible = "fsl-i2c";
                reg = <0x3100 0x100>;
                interrupts = <0x2b 0x2>;
                interrupt-parent = <&mpic>;
                dfsrr;
            };

            dma@21300 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
                reg = <0x21300 0x4>;
                ranges = <0x0 0x21100 0x200>;
                cell-index = <0>;
                dma-channel@0 {
                    compatible = "fsl,mpc8548-dma-channel",
                            "fsl,eloplus-dma-channel";
                    reg = <0x0 0x80>;
                    cell-index = <0>;
                    interrupt-parent = <&mpic>;
                    interrupts = <20 2>;
                };
                dma-channel@80 {
                    compatible = "fsl,mpc8548-dma-channel",
                            "fsl,eloplus-dma-channel";
                    reg = <0x80 0x80>;
                    cell-index = <1>;
                    interrupt-parent = <&mpic>;
                    interrupts = <21 2>;
                };
                dma-channel@100 {
                    compatible = "fsl,mpc8548-dma-channel",
                            "fsl,eloplus-dma-channel";
                    reg = <0x100 0x80>;
                    cell-index = <2>;
                    interrupt-parent = <&mpic>;
                    interrupts = <22 2>;
                };
                dma-channel@180 {
                    compatible = "fsl,mpc8548-dma-channel",
                            "fsl,eloplus-dma-channel";
                    reg = <0x180 0x80>;
                    cell-index = <3>;
                    interrupt-parent = <&mpic>;
                    interrupts = <23 2>;
                };
            };

            mdio@24520 {
                #address-cells = <1>;
                #size-cells = <0>;
                compatible = "fsl,gianfar-mdio";
                reg = <0x24520 0x20>;

                phy0: ethernet-phy@0 {
                    interrupt-parent = <&mpic>;
                    interrupts = <8 1>;
                    reg = <1>;
                    device_type = "ethernet-phy";
                };
                phy1: ethernet-phy@1 {
                    interrupt-parent = <&mpic>;
                    interrupts = <8 1>;
                    reg = <2>;
                    device_type = "ethernet-phy";
                };
                phy2: ethernet-phy@3 {
                    interrupt-parent = <&mpic>;
                    interrupts = <8 1>;
                    reg = <3>;
                    device_type = "ethernet-phy";
                };
                phy3: ethernet-phy@4 {
                    interrupt-parent = <&mpic>;
                    interrupts = <8 1>;
                    reg = <4>;
                    device_type = "ethernet-phy";
                };
            };

            enet0: ethernet@24000 {
                cell-index = <0>;
                device_type = "network";
                model = "eTSEC";
                compatible = "gianfar";
                reg = <0x24000 0x1000>;
                local-mac-address = [ 00 00 00 00 00 00 ];
                interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
                interrupt-parent = <&mpic>;
                phy-handle = <&phy0>;
            };

            enet1: ethernet@25000 {
                cell-index = <1>;
                device_type = "network";
                model = "eTSEC";
                compatible = "gianfar";
                reg = <0x25000 0x1000>;
                local-mac-address = [ 00 00 00 00 00 00 ];
                interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
                interrupt-parent = <&mpic>;
                phy-handle = <&phy1>;
            };

            enet2: ethernet@26000 {
                cell-index = <2>;
                device_type = "network";
                model = "eTSEC";
                compatible = "gianfar";
                reg = <0x26000 0x1000>;
                local-mac-address = [ 00 00 00 00 00 00 ];
                interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
                interrupt-parent = <&mpic>;
                phy-handle = <&phy2>;
            };


            serial0: serial@4500 {
                cell-index = <0>;
                device_type = "serial";
                compatible = "ns16550";
                reg = <0x4500 0x100>;        // reg base, size
                clock-frequency = <0>;    // should we fill in in uboot?
                interrupts = <0x2a 0x2>;
                interrupt-parent = <&mpic>;
            };

            serial1: serial@4600 {
                cell-index = <1>;
                device_type = "serial";
                compatible = "ns16550";
                reg = <0x4600 0x100>;        // reg base, size
                clock-frequency = <0>;    // should we fill in in uboot?
                interrupts = <0x2a 0x2>;
                interrupt-parent = <&mpic>;
            };

            global-utilities@e0000 {    //global utilities reg
                compatible = "fsl,mpc8548-guts";
                reg = <0xe0000 0x1000>;
                fsl,has-rstcr;
            };

            mpic: pic@40000 {
                interrupt-controller;
                #address-cells = <0>;
                #interrupt-cells = <2>;
                reg = <0x40000 0x40000>;
                compatible = "chrp,open-pic";
                device_type = "open-pic";
            };
        };

        localbus@e0000000 {
            #address-cells = <2>;
            #size-cells = <1>;
            compatible = "simple-bus";
            reg = <0xe0000000 0x5000>;
            interrupt-parent = <&mpic>;
      };
    };

thanks pieter
