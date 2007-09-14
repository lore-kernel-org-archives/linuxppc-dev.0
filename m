Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (itri.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id D707BDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 21:42:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Subject: RE: STK5200 pci_enable_device problem
Date: Fri, 14 Sep 2007 14:38:16 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F078FB151@itri.bte.mam.gov.tr>
From: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: "Oliver Rutsch" <orutsch@sympatec.com>
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

Hi,

i get the latest kernel sources and u-boot sources directly=20
from the git archives from www.denx.de.

My kernel version is Linux-2.6.23-rc5-gaa8ddd08
u-boot version is U-Boot 1.2.0-ge251e00d-dirty

i use dtc compiler with following command:
dtc -O dtb -o tqm5200.dtb -b 0 tqm5200.dts

TQM5200 doesn't boot and gives following error. Any help would be =
approciated.

Thanks a lot.

=3D> run net_nfs_fdt
Using FEC ETHERNET device
TFTP from server 10.18.2.83; our IP address is 10.18.5.44
Filename 'uImage'.
Load address: 0x200000
Loading: =
#################################################################
         ###################################
done
Bytes transferred =3D 1461683 (164db3 hex)
Using FEC ETHERNET device
TFTP from server 10.18.2.83; our IP address is 10.18.5.44
Filename 'tqm5200.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred =3D 3507 (db3 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-rc5-gaa8ddd08
   Created:      2007-09-14   6:44:52 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1461619 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
WARNING: could not create /chosen FDT_ERR_NOSPACE.
ERROR: /chosen node create failed - must RESET the board to recover.
                                                                         =
          =20




-----Original Message-----
From: Oliver Rutsch [mailto:orutsch@sympatec.com]=20
Sent: Friday, August 31, 2007 12:35 PM
To: Mustafa Cay=FDr
Subject: Re: STK5200 pci_enable_device problem

Hi Mustafa,

> Hello Oliver,
>=20
> My problems continue, could you summarize your steps to bring up the =
board?
> which u-boot version is used?
> how build tqm5200.dts file?
> did you test pci bus?
>=20
> Thanks.

You should get the latest kernel sources and u-boot sources directly=20
from the git archives from www.denx.de.
Only use the native git protocol, not the HTTP git protocol.
E.g. "git-clone git://www.denx.de/git/linux-2.6-denx linux-2.6-denx"
Build u-boot with the configuration for your board. If your card is NOT=20
a 66 MHz PCI-card, then undefine CFG_PCICLK_EQUALS_IPBCLK_DIV2 in the=20
u-boot configuration to get a 33 MHz PCI bus.
Build u-boot and flash it to the module. Then install the dtc compiler=20
from the git archive (git://www.jdl.com/software/dtc.git). Do NOT use=20
the tar archive on the web, it is out of date. Compile a dtb file out of =

the tqm5200.dts file you find in the kernel sources.
Build the kernel with tqm5200_defconfig.
Boot your module and load the kernel and the dtb file in u-boot. E.g.=20
"tftp 200000 mykernel" and "tftp 400000 mydevicetree.dtb".
Don't forget to change the serial console output. On the 2.4 kernel the=20
internal mpc5200 uarts had the name ttyS0/ttyS1/ttyS2. On the 2.6 they=20
are called ttyPSC0 up to ttyPSC2. So type in u-boot
"set addcons 'setenv bootargs ${bootargs} =
console=3DttyPSC0,${baudrate}'"
"save" (don't forget the single quotes in line above!).
Boot now with "bootm 200000 - 400000".
Now it should boot fine.
I've tested a Korenix Jetcard 1404 (Oxford 16mPCI954 chip) with this=20
kernel and it runs fine. I had no luck with the 2.4 kernel as it failed=20
to give the card an interrupt.

Bye,

--=20
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com =B7 Tel.:+49 5323 717514
Sympatec GmbH =B7 Am Pulverhaus 1 =B7 D-38678 Clausthal-Zellerfeld =B7 =
Germany
Geschaeftsfuehrer: Dr.-Ing. E.h. Stephan Roethele =B7 Handelsregister:=20
Amtsgericht Braunschweig, HRB 110809
