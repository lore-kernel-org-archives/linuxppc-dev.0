Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 119DFDDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 19:50:47 +1000 (EST)
Message-ID: <483E7C73.3060701@matrix-vision.de>
Date: Thu, 29 May 2008 11:50:43 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Li Yang <LeoLi@freescale.com>
Subject: USB @ MPC834x
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott, Li,

I'm sorry to bother you again ... but after bringing up all parts of my
MPC8343 based board the not working USB is the last pending problem.
Actually I'm running on 2.6.25 with a custom board.

Since USB is different for MPC8349/7/3 (depending on package) there
_could_ be a configuration problem.
Maybe you can help me out or give some hints at last.

Situation:
MPC8343A with ULPI-PHY (USB3300 from SMSC) connected the same way as on
the Freescale "MPC8349EA_MDS_PB-TBGA" Board, i.e. using ULPI mode of the
USB dual role module.


Do you know if this PHY has ever been running on any Freescale board ?
Do you know of _any_ MPC8343 based board running USB with an OTG PHY ?
Or has it always been a 8349 thus having both ports available ?


There are quite a few things that make me wonder :

Regarding to MPC8343EA manual I only have DR_D0..D7 pins available for
the DualRole module.
The port is labeled "Port1" - it's the only one that is bonded inside
the small package.

On the Freescale schematics the pins DR_D0..D7 are labeld "Port0".


"arch/powerpc/platforms/83xx/usb.c" contains "mpc834x_usb_cfg" which is
called during board init :

- sccr gets modified to match DR/MPH clock settings -> I don't have the
MPH defined in my dts - it's only DR @ 0x23000 :

                usb@23000 {
                        device_type = "usb";
                        compatible = "fsl-usb2-dr";
                        reg = <0x23000 0x1000>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        interrupt-parent = <&ipic>;
                        interrupts = <38 0x8>;
                        dr_mode = "host";
                        phy_type = "ulpi";
                };

- In SICRH bit14 gets cleared by "sicrh = in_be32(immap +
MPC83XX_SICRH_OFFS) & ~MPC834X_SICRH_USB_UTMI".
Is bit14 not required to be set in DR configuration ?

- If ULPI is set then SICRL always uses port0:

               } else if (prop && !strcmp(prop, "ulpi")) {
                        sicrl |= MPC834X_SICRL_USB0;

Is this also correct for MPC8343 ? Do we need MPC834X_SICRL_USB1 on 8343 ?




Any help is welcome.


regards,
Andre Schwarz
Matrix Vision



log messages during boot :

....
mpc83xx_spi.0: MPC83xx SPI Controller driver at 0xd1062000 (irq = 20)
ehci_hcd: block sizes: qh 128 qtd 96 itd 160 sitd 96
initializing FSL-SOC USB Controller
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: reset hcs_params 0x10011 dbg=0 ind cc=0 pcc=0
ordered ports=1
fsl-ehci fsl-ehci.0: reset hcc_params 0006 thresh 0 uframes 256/512/1024
park
fsl-ehci fsl-ehci.0: park 0
fsl-ehci fsl-ehci.0: reset command 080b02 park=3 ithresh=8 period=1024
Reset HALT
fsl-ehci fsl-ehci.0: ...powerdown ports...
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: reset command 080b02 park=3 ithresh=8 period=1024
Reset HALT
fsl-ehci fsl-ehci.0: init command 010009 (park)=0 ithresh=1 period=256 RUN
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25 ehci_hcd
usb usb1: SerialNumber: fsl-ehci.0
usbcore: registered new interface driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for
USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
....



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
