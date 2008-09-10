Return-Path: <orutsch@sympatec.com>
Message-ID: <48C7D5C6.1070507@sympatec.com>
Date: Wed, 10 Sep 2008 16:12:22 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: TQM8349 and ARCH = powerpc
References: <48C68763.6030606@sympatec.com>
	<20080909112253.c9c9617f.kim.phillips@freescale.com>
In-Reply-To: <20080909112253.c9c9617f.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again,

> 
> u-boot assigns the IMMR to 0xff400000 in TQM834x.h, whereas the device
> tree you picked has it at 0xe0000000 (it's defined in the soc node).
> Don't forget to match up the PCI addresses too.  patches welcome, of
> course (we don't have tqm boards).
> 
So I modified the dts to match the IMMRMBAR and the pci section at 
0xff400000. In U-Boot I disabled the PCI_CONFIG because I don't need the 
PCI bus. But the result is always the same. It looks like the kernel 
stops booting at an earlier stage.

I hope it's OK to post my current tqm8349.dts here:
Any suggestions are welcome.

Thanks and bye,

/dts-v1/;

/ {
   model = "tqc,tqm834x";
   compatible = "tqc,tqm834x";
   #address-cells = <1>;
   #size-cells = <1>;

   aliases {
     ethernet0 = &enet0;
     ethernet1 = &enet1;
     serial0 = &serial0;
     serial1 = &serial1;
     pci0 = &pci0;
     /*pci1 = &pci1;*/
   };

   cpus {
     #address-cells = <1>;
     #size-cells = <0>;

     PowerPC,8349@0 {
       device_type = "cpu";
       reg = <0x0>;
       d-cache-line-size = <32>;
       i-cache-line-size = <32>;
       d-cache-size = <32768>;
       i-cache-size = <32768>;
       timebase-frequency = <0>; // from bootloader
       bus-frequency = <0>;      // from bootloader
       clock-frequency = <0>;    // from bootloader
     };
   };

   memory {
     device_type = "memory";
     reg = <0x00000000 0x10000000>;
   };

   soc8349@ff40000000 {
     #address-cells = <1>;
     #size-cells = <1>;
     device_type = "soc";
     compatible = "simple-bus";
     ranges = <0x0 0xff400000 0x00100000>;
     reg = <0xff400000 0x00000200>;
     bus-frequency = <0>;                    // from bootloader

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
         compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
         reg = <0 0x80>;
         interrupt-parent = <&ipic>;
         interrupts = <71 8>;
       };
       dma-channel@80 {
         compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
         reg = <0x80 0x80>;
         interrupt-parent = <&ipic>;
         interrupts = <71 8>;
       };
       dma-channel@100 {
         compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
         reg = <0x100 0x80>;
         interrupt-parent = <&ipic>;
         interrupts = <71 8>;
       };
       dma-channel@180 {
         compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
         reg = <0x180 0x28>;
         interrupt-parent = <&ipic>;
         interrupts = <71 8>;
       };
     };

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

     usb@23000 {
       compatible = "fsl-usb2-dr";
       reg = <0x23000 0x1000>;
       #address-cells = <1>;
       #size-cells = <0>;
       interrupt-parent = <&ipic>;
       interrupts = <38 0x8>;
       dr_mode = "peripheral";
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
       clock-frequency = <0>;    // from bootloader
       interrupts = <9 0x8>;
       interrupt-parent = <&ipic>;
     };

     serial1: serial@4600 {
       cell-index = <1>;
       device_type = "serial";
       compatible = "ns16550";
       reg = <0x4600 0x100>;
       clock-frequency = <0>;    // from bootloader
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

     ipic: pic@700 {
       interrupt-controller;
       #address-cells = <0>;
       #interrupt-cells = <2>;
       reg = <0x700 0x100>;
       device_type = "ipic";
     };
   };

   pci0: pci@ff408500 {
     cell-index = <1>;
     interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
     interrupt-map = <
         /* IDSEL 0x10 - SATA */
         0x8000 0x0 0x0 0x1 &ipic 22 0x8 /* SATA_INTA */
         >;
     interrupt-parent = <&ipic>;
     interrupts = <66 0x8>;
     bus-range = <0x0 0x0>;
     ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
         0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
         0x01000000 0x0 0x00000000 0xe2000000 0x0 0x01000000>;
     clock-frequency = <66666666>;
     #interrupt-cells = <1>;
     #size-cells = <2>;
     #address-cells = <3>;
     reg = <0xff408500 0x100>;
     compatible = "fsl,mpc8349-pci";
     device_type = "pci";
   };

   localbus@ff405000 {
     #address-cells = <2>;
     #size-cells = <1>;
     compatible = "fsl,mpc8349e-localbus",
            "fsl,pq2pro-localbus";
     reg = <0xff405000 0xd8>;
     ranges = <0x3 0x0 0xf0000000 0x210>;


   };
};

-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com · Tel.:+49 5323 717514
Sympatec GmbH · Am Pulverhaus 1 · D-38678 Clausthal-Zellerfeld · Germany
Geschaeftsfuehrer: Dr.-Ing. E.h. Stephan Roethele · Handelsregister: 
Amtsgericht Braunschweig, HRB 110809
