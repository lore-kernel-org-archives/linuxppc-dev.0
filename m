Return-Path: <eric.lee@hp.com>
From: "Lee, Eric" <eric.lee@hp.com>
To: "ajijuni@gmail.com" <ajijuni@gmail.com>, "Linuxppc-dev@lists.ozlabs.org"
	<Linuxppc-dev@lists.ozlabs.org>
Date: Wed, 9 Dec 2009 16:22:57 +0000
Subject: RE: dts file for MPC8343EA
Message-ID: <507B57E36B7C3A48BD1B90EFA80A782E5372EE77CD@GVW0433EXB.americas.hpqcorp.net>
References: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
In-Reply-To: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I would probably remove the bcsr region.  this was some cpld I believe on a=
 reference board.  with this dts it'll try to write to some hardware regist=
ers that do not exist or are not mapped to the same area.



-----Original Message-----
From: linuxppc-dev-bounces+eric.lee=3Dhp.com@lists.ozlabs.org [mailto:linux=
ppc-dev-bounces+eric.lee=3Dhp.com@lists.ozlabs.org] On Behalf Of ajijuni@gm=
ail.com
Sent: Sunday, December 06, 2009 11:41 PM
To: Linuxppc-dev@lists.ozlabs.org
Subject: dts file for MPC8343EA

Hi=20

We have an MPC8343EA based custom board.=20

I am not able to get Linux up and running in this. No serial output to debu=
g further.=20
 U-boot shows correct 'bdinfo' & 'clocks' output.=20
inux hangs at machine_probe.

I doubt the DTS file in Linux. anyone has DTS file for MPC8343??=20

u-boot version - 1.3.2
linux-2.6.27
The board base files are drived from MPC8349Imtx-GP since we have the refer=
ence board in which we tested the linux image.

My current DTS file=20
/dts-v1/;=20

/ {=20
        model =3D "MPC8343";=20
        compatible =3D "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";=20
        linux,phandle =3D <0x100>;=20
        #size-cells =3D <0x1>;=20
        #address-cells =3D <0x1>;=20

        aliases {=20
                ethernet0 =3D &enet0;=20
                ethernet1 =3D &enet1;=20
                serial0 =3D &serial0;=20
                serial1 =3D &serial1;=20
                pci0 =3D &pci0;=20
                pci1 =3D &pci1;=20
        };=20
         cpus {=20
                linux,phandle =3D <0x200>;=20
                #cpus =3D <0x1>;=20
                #address-cells =3D <1>;=20
                #size-cells =3D <0>;=20

 PowerPC,8343EA@0 {=20
                        device_type =3D "cpu";=20
                        reg =3D <0x0>;=20
                        d-cache-line-size =3D <20>;=20
                        i-cache-line-size =3D <20>;=20
                        d-cache-size =3D <8000>;=20
                        i-cache-size =3D <8000>;=20
                        timebase-frequency =3D <0>;       // from bootloade=
r=20
                        bus-frequency =3D <0>;            // from bootloade=
r=20
                        clock-frequency =3D <0>;          // from bootloade=
r=20
                        32-bit;=20
                };=20
        };=20


        memory {=20
                device_type =3D "memory";=20
                reg =3D <0x00000000 0x10000000>;  // 256MB at 0=20
        };=20

        bcsr@e2400000 {=20
                device_type =3D "board-control";=20
                reg =3D <0xe2400000 0x8000>;=20
        };=20
        soc8343@e0000000 {=20
                bus-frequency =3D <0x1>;=20
                reg =3D <0xe0000000 0x200>;=20
                ranges =3D <0x0 0xe0000000 0x100000>;=20
                device_type =3D "soc";=20
                #interrupt-cells =3D <0x2>;=20
                #size-cells =3D <0x1>;=20
                #address-cells =3D <0x1>;=20

                wdt@200 {=20
                        device_type =3D "watchdog";=20
                        compatible =3D "mpc83xx_wdt";=20
                        reg =3D <0x200 0x100>;=20
                };=20

i2c@3000 {=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <0>;=20
                        cell-index =3D <0>;=20
                        compatible =3D "fsl-i2c";=20
                        reg =3D <0x3000 0x100>;=20
                        interrupts =3D <14 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        dfsrr;=20

                        rtc@68 {=20
                                compatible =3D "dallas,ds1374";=20
                                reg =3D <0x68>;=20
                        };=20
                };=20

                i2c@3100 {=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <0>;=20
                        cell-index =3D <1>;=20
                        compatible =3D "fsl-i2c";=20
                        reg =3D <0x3100 0x100>;=20
                        interrupts =3D <15 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        dfsrr;=20
                };=20

                spi@7000 {=20
                        cell-index =3D <0>;=20
                        compatible =3D "fsl,spi";=20
                        reg =3D <0x7000 0x1000>;=20
                        interrupts =3D <16 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        mode =3D "cpu";=20
                };=20

dma@82a8 {=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <1>;=20
                        compatible =3D "fsl,mpc8349-dma", "fsl,elo-dma";=20
                        reg =3D <0x82a8 4>;=20
                        ranges =3D <0 0x8100 0x1a8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        interrupts =3D <71 8>;=20
                        cell-index =3D <0>;=20
                        dma-channel@0 {=20
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";=20
                                reg =3D <0 0x80>;=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <71 8>;=20
                        };=20
                        dma-channel@80 {=20
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";=20
                                reg =3D <0x80 0x80>;=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <71 8>;=20
                        };=20
                        dma-channel@100 {=20
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";=20
                                reg =3D <0x100 0x80>;=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <71 8>;=20
                        };=20
                        dma-channel@180 {=20
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";=20
                                reg =3D <0x180 0x28>;=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <71 8>;=20
                        };=20
                };=20
/* phy type (ULPI or SERIAL) are only types supported for MPH */=20
                /* port =3D 0 or 1 */=20
                usb@22000 {=20
                        compatible =3D "fsl-usb2-mph";=20
                        reg =3D <0x22000 0x1000>;=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <0>;=20
                        interrupt-parent =3D <&ipic>;=20
                        interrupts =3D <39 0x8>;=20
                        phy_type =3D "ulpi";=20
                        port1;=20
                };=20
                /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */=20
                usb@23000 {=20
                        compatible =3D "fsl-usb2-dr";=20
                        reg =3D <0x23000 0x1000>;=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <0>;=20
                        interrupt-parent =3D <&ipic>;=20
                        interrupts =3D <38 0x8>;=20
                        dr_mode =3D "otg";=20
                        phy_type =3D "ulpi";=20
                };=20

                mdio@24520 {=20
                        #address-cells =3D <1>;=20
                        #size-cells =3D <0>;=20
                        compatible =3D "fsl,gianfar-mdio";=20
                        reg =3D <0x24520 0x20>;=20

                        phy0: ethernet-phy@0 {=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <17 0x8>;=20
                                reg =3D <0x0>;=20
                                device_type =3D "ethernet-phy";=20
                        };=20
                        phy1: ethernet-phy@1 {=20
                                interrupt-parent =3D <&ipic>;=20
                                interrupts =3D <18 0x8>;=20
                                reg =3D <0x1>;=20
                                device_type =3D "ethernet-phy";=20
                        };=20
enet0: ethernet@24000 {=20
                        cell-index =3D <0>;=20
                        device_type =3D "network";=20
                        model =3D "TSEC";=20
                        compatible =3D "gianfar";=20
                        reg =3D <0x24000 0x1000>;=20
                        local-mac-address =3D [ 00 00 00 00 00 00 ];=20
                        interrupts =3D <32 0x8 33 0x8 34 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        phy-handle =3D <&phy0>;=20
                        linux,network-index =3D <0>;=20
                };=20

                enet1: ethernet@25000 {=20
                        cell-index =3D <1>;=20
                        device_type =3D "network";=20
                        model =3D "TSEC";=20
                        compatible =3D "gianfar";=20
                        reg =3D <0x25000 0x1000>;=20
                        local-mac-address =3D [ 00 00 00 00 00 00 ];=20
                        interrupts =3D <35 0x8 36 0x8 37 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        phy-handle =3D <&phy1>;=20
                        linux,network-index =3D <1>;=20
                };=20

serial0: serial@4500 {=20
                        cell-index =3D <0>;=20
                        device_type =3D "serial";=20
                        compatible =3D "ns16550";=20
                        reg =3D <0x4500 0x100>;=20
                        clock-frequency =3D <0>;=20
                        interrupts =3D <9 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                };=20

                serial1: serial@4600 {=20
                        cell-index =3D <1>;=20
                        device_type =3D "serial";=20
                        compatible =3D "ns16550";=20
                        reg =3D <0x4600 0x100>;=20
                        clock-frequency =3D <0>;=20
                        interrupts =3D <10 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                };=20

                crypto@30000 {=20
                        compatible =3D "fsl,sec2.0";=20
                        reg =3D <0x30000 0x10000>;=20
                        interrupts =3D <11 0x8>;=20
                        interrupt-parent =3D <&ipic>;=20
                        fsl,num-channels =3D <4>;=20
                        fsl,channel-fifo-len =3D <24>;=20
                        fsl,exec-units-mask =3D <0x7e>;=20
                        fsl,descriptor-types-mask =3D <0x01010ebf>;=20
                };=20

Thanks,=20
agnel=20

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
