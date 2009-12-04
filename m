Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 495D0B7BF5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 09:56:27 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NGh4b-00036W-50
	for linuxppc-dev@ozlabs.org; Fri, 04 Dec 2009 14:56:25 -0800
Message-ID: <26645258.post@talk.nabble.com>
Date: Fri, 4 Dec 2009 14:56:25 -0800 (PST)
From: agnel <ajijuni@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC8343EA Linux DTS file
In-Reply-To: <47F73625.9040903@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <47F73625.9040903@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Hi

We have an MPC8343EA based custom board.

I am not able to get Linux up and running in this. No serial output to debug
further.
 U-boot shows correct 'bdinfo' & 'clocks' output.

I doubt the DTS file in Linux. anyone has DTS file for MPC8343??

My current DTS file
/dts-v1/;

/ {
        model = "MPC8343";
        compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
        linux,phandle = <0x100>;
        #size-cells = <0x1>;
        #address-cells = <0x1>;

        aliases {
                ethernet0 = &enet0;
                ethernet1 = &enet1;
                serial0 = &serial0;
                serial1 = &serial1;
                pci0 = &pci0;
                pci1 = &pci1;
        };
         cpus {
                linux,phandle = <0x200>;
                #cpus = <0x1>;
                #address-cells = <1>;
                #size-cells = <0>;

 PowerPC,8343EA@0 {
                        device_type = "cpu";
                        reg = <0x0>;
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
                reg = <0x00000000 0x10000000>;  // 256MB at 0
        };

        bcsr@e2400000 {
                device_type = "board-control";
                reg = <0xe2400000 0x8000>;
        };
        soc8343@e0000000 {
                bus-frequency = <0x1>;
                reg = <0xe0000000 0x200>;
                ranges = <0x0 0xe0000000 0x100000>;
                device_type = "soc";
                #interrupt-cells = <0x2>;
                #size-cells = <0x1>;
                #address-cells = <0x1>;

                wdt@200 {
                        device_type = "watchdog";
                        compatible = "mpc83xx_wdt";
                        reg = <0x200 0x100>;
                };

i2c@3000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        cell-index = <0>;
                        compatible = "fsl-i2c";
                        reg = <0x3000 0x100>;
                        interrupts = <14 0x8>;
                        interrupt-parent = <&ipic>;
                        dfsrr;

                        rtc@68 {
                                compatible = "dallas,ds1374";
                                reg = <0x68>;
                        };
                };

                i2c@3100 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        cell-index = <1>;
                        compatible = "fsl-i2c";
                        reg = <0x3100 0x100>;
                        interrupts = <15 0x8>;
                        interrupt-parent = <&ipic>;
                        dfsrr;
                };

                spi@7000 {
                        cell-index = <0>;
                        compatible = "fsl,spi";
                        reg = <0x7000 0x1000>;
                        interrupts = <16 0x8>;
                        interrupt-parent = <&ipic>;
                        mode = "cpu";
                };

dma@82a8 {
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
                        reg = <0x82a8 4>;
                        ranges = <0 0x8100 0x1a8>;
                        interrupt-parent = <&ipic>;
                        interrupts = <71 8>;
                        cell-index = <0>;
                        dma-channel@0 {
                                compatible = "fsl,mpc8349-dma-channel",
"fsl,elo-dma-channel";
                                reg = <0 0x80>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@80 {
                                compatible = "fsl,mpc8349-dma-channel",
"fsl,elo-dma-channel";
                                reg = <0x80 0x80>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@100 {
                                compatible = "fsl,mpc8349-dma-channel",
"fsl,elo-dma-channel";
                                reg = <0x100 0x80>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@180 {
                                compatible = "fsl,mpc8349-dma-channel",
"fsl,elo-dma-channel";
                                reg = <0x180 0x28>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                };
/* phy type (ULPI or SERIAL) are only types supported for MPH */
                /* port = 0 or 1 */
                usb@22000 {
                        compatible = "fsl-usb2-mph";
                        reg = <0x22000 0x1000>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        interrupt-parent = <&ipic>;
                        interrupts = <39 0x8>;
                        phy_type = "ulpi";
                        port1;
                };
                /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
                usb@23000 {
                        compatible = "fsl-usb2-dr";
                        reg = <0x23000 0x1000>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        interrupt-parent = <&ipic>;
                        interrupts = <38 0x8>;
                        dr_mode = "otg";
                        phy_type = "ulpi";
                };

                mdio@24520 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "fsl,gianfar-mdio";
                        reg = <0x24520 0x20>;

                        phy0: ethernet-phy@0 {
                                interrupt-parent = <&ipic>;
                                interrupts = <17 0x8>;
                                reg = <0x0>;
                                device_type = "ethernet-phy";
                        };
                        phy1: ethernet-phy@1 {
                                interrupt-parent = <&ipic>;
                                interrupts = <18 0x8>;
                                reg = <0x1>;
                                device_type = "ethernet-phy";
                        };
enet0: ethernet@24000 {
                        cell-index = <0>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <0x24000 0x1000>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <32 0x8 33 0x8 34 0x8>;
                        interrupt-parent = <&ipic>;
                        phy-handle = <&phy0>;
                        linux,network-index = <0>;
                };

                enet1: ethernet@25000 {
                        cell-index = <1>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <0x25000 0x1000>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <35 0x8 36 0x8 37 0x8>;
                        interrupt-parent = <&ipic>;
                        phy-handle = <&phy1>;
                        linux,network-index = <1>;
                };

serial0: serial@4500 {
                        cell-index = <0>;
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <0x4500 0x100>;
                        clock-frequency = <0>;
                        interrupts = <9 0x8>;
                        interrupt-parent = <&ipic>;
                };

                serial1: serial@4600 {
                        cell-index = <1>;
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <0x4600 0x100>;
                        clock-frequency = <0>;
                        interrupts = <10 0x8>;
                        interrupt-parent = <&ipic>;
                };

                crypto@30000 {
                        compatible = "fsl,sec2.0";
                        reg = <0x30000 0x10000>;
                        interrupts = <11 0x8>;
                        interrupt-parent = <&ipic>;
                        fsl,num-channels = <4>;
                        fsl,channel-fifo-len = <24>;
                        fsl,exec-units-mask = <0x7e>;
                        fsl,descriptor-types-mask = <0x01010ebf>;
                };

Thanks,
agnel



-- 
View this message in context: http://old.nabble.com/MPC8343---%22unable-to-handle-paging-request-%40-0%22-tp16510741p26645258.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
