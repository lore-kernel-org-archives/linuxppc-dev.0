Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id DD0E3DDF59
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 23:56:45 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Khltz-0004Jk-W6
	for linuxppc-dev@ozlabs.org; Mon, 22 Sep 2008 15:56:40 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 22 Sep 2008 15:56:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809221556.34353.jbe@pengutronix.de>
Subject: MPC5200 PCI interrupt routing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

my MPC5200 based platform has one PCI slot, with the following interrupt
routing:

PCI slot  MPC5200
 INT A     IRQ0
 INT B     IRQ1
 INT C     IRQ2
 INT D     IRQ3

In my oftree I'm using these lines to describe this routing (slot's IDSEL is
0x18)

[...]
       pci@f0000d00 {
               #interrupt-cells =3D <1>;
               #size-cells =3D <2>;
               #address-cells =3D <3>;
               device_type =3D "pci";
               compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
               reg =3D <0xf0000d00 0x100>;
               interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
               interrupt-map =3D <0xc000 0x0 0x0 0x1 &mpc5200_pic 0x0 0x0 0=
x3
                                0xc000 0x0 0x0 0x2 &mpc5200_pic 0x1 0x1 0x3
                                0xc000 0x0 0x0 0x3 &mpc5200_pic 0x1 0x2 0x3
                                0xc000 0x0 0x0 0x4 &mpc5200_pic 0x1 0x3 0x3
                               >;
               clock-frequency =3D <0>; // From boot loader
               interrupts =3D <0x2 0x8 0x0 0x2 0x9 0x0 0x2 0xa 0x0>;
               interrupt-parent =3D <&mpc5200_pic>;
               bus-range =3D <0 0>;
               ranges =3D <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000=
000
                         0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
                         0x01000000 0x0 0x00000000 0xb0000000 0x0 0x0100000=
0>;
       };
[...]

=46irst: But /proc/interrupts states "Edge" type. From the documentation "0=
x3"
(the last number per interrupt-map-line) should be "low level", not "edge".

$ cat /proc/interrupts
           CPU0
 16:          0   MPC52xx IRQ[0-3]  Edge      uhci_hcd:usb3
 65:          0   MPC52xx IRQ[0-3]  Edge      uhci_hcd:usb4
 66:          5   MPC52xx IRQ[0-3]  Edge      ehci_hcd:usb2
131:      58585  MPC52xx Peripherals Edge      mpc52xx_psc_uart
133:          0  MPC52xx Peripherals Edge      mpc52xx-fec_ctrl
134:         34  MPC52xx Peripherals Edge      ohci_hcd:usb1
135:          0  MPC52xx Peripherals Edge      mpc52xx_ata
143:          0  MPC52xx Peripherals Edge      i2c-mpc
144:         36  MPC52xx Peripherals Edge      i2c-mpc
192:       5815  MPC52xx SDMA Edge      mpc52xx-fec_rx
193:       4512  MPC52xx SDMA Edge      mpc52xx-fec_tx
BAD:          0

Second: When I load the drivers for the uhci/ehci PCI card I get:

[...]
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: device not accepting address 2, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 5
usb 1-1: device not accepting address 5, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1
usb 1-2: new high speed USB device using ehci_hcd and address 6
usb 1-2: device descriptor read/64, error -110
[...]
uhci_hcd 0000:00:18.0: Unlink after no-IRQ?  Controller is probably using t=
he wrong IRQ.
[...]

$ lspci
00:18.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 61)
00:18.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 61)
00:18.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63)

USB driver (endianess???) or oftee or hardware problem?

Anyone experience with VIA USB hardware on PowerPc?

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
