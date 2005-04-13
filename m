Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 31B2667B6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 08:01:50 +1000 (EST)
In-Reply-To: <20050413205839.71410.qmail@web53702.mail.yahoo.com>
References: <20050413205839.71410.qmail@web53702.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <3f69c186751bbf18871e6418e23f859f@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 13 Apr 2005 17:01:39 -0500
To: Junita Ajith <junita_ppc@yahoo.com>
Cc: ari@gdatech.com, linuxppc-embedded@ozlabs.org
Subject: Re: Help needed Linux-2.6 - MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Junita,

We encountered a similar error when bringing up 83xx support, and it =20
was due to the platform code not properly passing in the register space =20=

of the TSEC driver.  The graceful stop check is the first point in the =20=

driver that the registers actually have to contain sane data (the =20
driver stops the controller before doing anything with the registers), =20=

so it would make sense that, if the address for the registers were =20
wrong, this spot would get stuck.  Investigate the platform init code, =20=

is my suggestion.

Andy

On Apr 13, 2005, at 15:58, Junita Ajith wrote:

> Hello Clement Koller,
> =A0=A0=A0 =A0 Thanks for your response.
> =A0
> We have both Marvel & Intel's phy in our 8541 board.
> =A0
> As of now in the kernel we have just enabled support for Marvel's PHY.
> =A0
>  It doesnt even=A0 come to the point of detecting=A0 the PHY ID =20
> (88E1011S). It just reads the PHy Address(Board specific)=A0correclty.
> =A0
> Even before it gets into gianfar_phy.c it hangs at gianfar.c.
> =A0
> This is the screen dump.
> ---------------------------------------
> =A0
> =A0
> Board: PCI-G8500 [PowerQUICC III]
> =A0=A0=A0=A0=A0=A0=A0 CPU: 825 MHz
> =A0=A0=A0=A0=A0=A0=A0 CCB: 330 MHz
> =A0=A0=A0=A0=A0=A0=A0 DDR: 165 MHz
> =A0=A0=A0=A0=A0=A0=A0 LBC: 82 MHz
> L1 D-cache 32KB, L1 I-cache 32KB enabled.
> I2C:=A0=A0 ready
> DRAM:=A0 256 MB
> RMCG8400 in PCI Host Mode.
> RMCG8400 is the PCI Arbiter.
> FLASH:=A0 8 MB
> L2 cache enabled: 256KB
> In:=A0=A0=A0 serial
> Out:=A0=A0 serial
> Err:=A0=A0 serial
> Net:=A0=A0 MOTO ENET0: PHY is Marvell 88E1011S (1410c67)
> MOTO ENET2: PHY is Intel LXT971A (1378e2)
> MOTO ENET0, MOTO ENET2
> Hit any key to stop autoboot:=A0 0
> RMCG8500#>tftp 2000000 8541/vmlinux.img
> Speed: 1000, full duplex
> Using MOTO ENET0 device
> TFTP from server 192.168.201.11; our IP address is 192.168.201.191
> Filename '8541/vmlinux.img'.
> Load address: 0x2000000
> Loading: =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 ###########################################
> done
> Bytes transferred =3D 883219 (d7a13 hex)
> RMCG8500#>tftp 3000000 8541/ramdisk.image-8541.hdr
> Speed: 1000, full duplex
> Using MOTO ENET0 device
> TFTP from server 192.168.201.11; our IP address is 192.168.201.191
> Filename '8541/ramdisk.image-8541.hdr'.
> Load address: 0x3000000
> Loading: =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 =20
> #################################################################
> =A0=A0=A0=A0=A0=A0=A0=A0 ##################
> done
> Bytes transferred =3D 2751871 (29fd7f hex)
> RMCG8500#>bootm 2000000 3000000
> ## Booting image at 02000000 ...
> =A0=A0 Image Name:=A0=A0 PCIG8400-Rel-1.1
> =A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)
> =A0=A0 Data Size:=A0=A0=A0 883155 Bytes =3D 862.5 kB
> =A0=A0 Load Address: 00000000
> =A0=A0 Entry Point:=A0 00000000
> =A0=A0 Verifying Checksum ... OK
> =A0=A0 Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 03000000 ...
> =A0=A0 Image Name:=A0=A0 PCIG8400
> =A0=A0 Image Type:=A0=A0 PowerPC Linux RAMDisk Image (gzip compressed)
> =A0=A0 Data Size:=A0=A0=A0 2751807 Bytes =3D=A0 2.6 MB
> =A0=A0 Load Address: 00000000
> =A0=A0 Entry Point:=A0 00000000
> =A0=A0 Verifying Checksum ... OK
> =A0=A0 Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK
> Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
> Linux version 2.6.11 (pari@sjswsvr11) (gcc version 3.3.2) #16 Tue Apr =20=

> 5 11:19:57
> =A0PDT 2005
> Built 1 zonelists
> Kernel command line: console=3DttyS0,115200 root=3D/dev/ram rw doPci=3D1=

> OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000
> PID hash table entries: 2048 (order: !  11, 32768 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k =
=20
> highmem)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> checking if image is initramfs...it isn't (no cpio magic); looks like =20=

> an initrd
> Freeing initrd memory: 2687k freed
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing =20
> enabled
> ttyS0 at MMIO 0xfdf04500 (irq =3D 90) is a 16550A
> io scheduler noop registered inside elv_register()
> RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
> Inside gfar_probe() of gianfar.c
> *************************************
> Inside alloc_etherdev() for eth-1072721460
> PHY base Addr is 0xd1002000
> Before DMA engine stop for IEVENT
> value of DMACTRL reg before writing to it : 0x0
> value to be written to DMACTRL reg : 0x18
> value of DMACTRL reg after writing to it=A0 : 0x80000000
> value of IEVENT reg : 0x80000000
> =
***********************************************************************=20=

> ****
> =A0
> And after this it just gets into the loop where it looks if the =20
> 'Gracious receive and Gracious stop' bits of the IEVENT register are =20=

> set.
> In our case it doesnt get set and so the kernel hangs at that point.
> =A0
> Thanks
> Junita
>
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hi, Junita!
>
> What PHYs do you use on the 8541?
> Check if they are supported in gianfar_phy or if they
> can be used with Generic MII
> Check if you get the the phy_id is correct.
> Some more debug-output would be nice.
>
> I had to add Intel LXT971 support to the gianfar_phy
> for my platform which is a 100MBit MII PHY only.
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
>
> Junita Ajith wrote:
> > Andy
> >
> > 1. The code hangs exaclty at the point where it looks for the =20
> 'graceful transmit/receive' bits set in the IEVENT register. =20
> (IEVENT_GRSC , IEVENT_GTSC) .
> > File - (linux-2.6/drivers/net/gianfar.c)
> > Function - static int gfar_probe(struct d! evice *device) ;
> >
> > In that ,we write Graceful Receive Stop and Graceful Transmit Stop, =20=

> and then wait until the corresponding bits in IEVENT indicate the =20
> stops have completed.
>  >
> > This never happens and hence hangs at the 'while' loop inside that =20=

> function.
> >
> > 2. We are using Linux-2.6.11
> >
> > Here's the serial output dump with a few debug messages.
> >
> > ## Booting image at 02000000 ...
> > Image Name: PCIG8400-Rel-1.1
> > Image Type: PowerPC Linux Kernel Image (gzip compressed)
> > Data Size: 883221 Bytes =3D 862.5 kB
> > Load Address: 00000000
> > Entry Point: 00000000
> > Verifying Checksum ... OK
> > Uncompressing Kernel Image ... OK
> > ## Loading RAMDisk Image at 03000000 ...
> > Image Name: PCIG8400
> > Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
> > Data Size: 2751807 Bytes =3D 2.6 MB
> > Load Address: 00000000
> > Entry Point: 00000000
> > Ve! rifying Checksum ... OK
> > Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK
> > Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: =
0Mb
> > Linux version 2.6.11 (pari@sjswsvr11) (gcc version 3.3.2) #16 Tue =20=

> Apr 5 11:19:57
> > PDT 2005
> > Built 1 zonelists
> > Kernel command line: console=3DttyS0,115200 root=3D/dev/ram rw =
doPci=3D1
> > OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000
> > PID hash table entries: 2048 (order: 11, 32768 bytes)
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> > Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> > Memory: 254720k available (1252k kernel code, 444k data, 292k init, =20=

> 0k highmem)
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > checking if image is initramfs...it isn't (no cpio magic); looks =20
> like an initrd
> > Freeing initrd memory: 2687k freed
> > NET: Registered protocol ! family 16
> > PCI: Probing PCI hardware
> > devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> > devfs: boot_options: 0x0
> > Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing =20
> enabled
> > ttyS0 at MMIO 0xfdf04500 (irq =3D 90) is a 16550A
> > io scheduler noop registered inside elv_register()
> > RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 =20
> blocksize
> > Inside gfar_probe()
> > einfo Phy ID 7
> > gfar 1: additional data!
> > Inside alloc_etherdev() for eth-1072721560
> > start e0024000
> > Resetting MAC........
> > --2--MACCFG1 is 0x80000000
> > MACCFG2 is 0x 0
> > -2- tempval 000000db
> > -3- tempval 00000000
> > -4-1- tempval 00000000
> > -4-2- tempval 00000000
> > -4-2-a tempval 00000000
> > -4-3 tempval 00000000
> > -4-4 tempval 00000000
> > Before loop -5- after writing to IEVENT tempval
> > -5- after writing to IEVENT tempval 80000000
> > -5- ! after writing to IEVENT tempval 80000000
> > -5- after writing to IEVENT tempval 80000000
> > -5- after writing to IEVENT tempval 80000000
> > -5- after writing to IEVENT tempval 80000000
> > -5- after writing to IEVENT tempval 80000000
> > -5- after writing to IEVENT tempval 80000000
> >
> >
> >
> > thanks,
> > Junita
> > Andy Fleming wrote:
> >
> > Could you send me what the kernel prints up to the point of the =
hang?
> >
> > Also, what version of 2.6 are you using? The board interface for the
>  > driver changed recently to support the new driver model.
> >
> > Andy
> >
> > On Apr 12, 2005, at 12:38, Junita Ajith wrote:
> >
> >
> >>Hi
> >>We are trying to port Linux-2.6 for our custom
> >>MPC8541 board.
> >>
> >>We have a TSEC and an FEC in the board.
> >>
> >>With the "Networking Support" disabled in the Kernel,
> >>the board boots up fine and gets to the prompt.
> >>
> >>But with the "Networking Support" enabled in the
> >>kernel the board hangs where it identifies the PHY,
> >>inspite of giving the corrct PHY ID.
> >>
> >>
> >>Any help is greatly appreciated.
> >>
> >>PS:
> >>We have linux-2.4 ported for the same board and so
> >>taking that as reference trying to port Linux-2.6 ,
> >>but havent succeeded yet.
> >>
> >>Thanks
> >>Junita
> >>
> >>
> >>
> >>__________________________________
> >>Do you Yahoo!?
> >>Make Yahoo! your home page
> >>http://www.yahoo.com/r/hs
> >>_______________________________________________
> >>Linuxppc-embedded mailing list
> >>Linuxppc-embedded@ozlabs.org
> >>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >
> >
> >
> &g! t;
>  >
> > ---------------------------------
> > Do you Yahoo!?
> > Yahoo! Small Business - Try our new resources site!
>  >
> >
> > =20
> =
-----------------------------------------------------------------------=20=

> -
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
