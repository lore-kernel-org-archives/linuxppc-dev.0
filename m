Return-Path: <wb1hbu@runbox.com>
Received: from aibo.runbox.com (aibo.runbox.com [87.238.52.70])
	by ozlabs.org (Postfix) with ESMTP id DE11DDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 01:36:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
From: "Eric Cottrell" <wb1hbu@runbox.com>
To: nvbolhuis@aimvalley.nl
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
Date: Tue, 24 Feb 2009 09:36:08 -0500 (EST)
References: <E1LbNft-0007z6-Pf@garm.runbox.com> <49A3EBFF.4030906@aimvalley.nl>
In-Reply-To: <49A3EBFF.4030906@aimvalley.nl>
Message-Id: <E1LbyOG-0000uL-Hf@garm.runbox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Thanks for the help.  I will look into that.  It is confusing as the latest=
 ltib appears not to have the aliases.  This is my first venture into Embed=
ded Linux as our existing PowerPC products use PSOS.  Most of my Linux expe=
rience is on the Intel PC platform.

Yes, the 1.3.3 version was what was shipped with the board.  The rootfs and=
 kernel appear to be older.  So I suspect someone upgraded the uBoot and ra=
n into trouble.

I am comparing this with the Rev B board we also got.  I hope to return the=
 Rev A4 and make the boards all Rev B because it has a later processor.  Th=
e Rev B boards have 1.3.0 so it should need the aliases as well.  Looking i=
n the uBoot changelogs there are some nice additions and fixes for this boa=
rd so I will look to dig more into uBoot and upgrade it.  I hate to stumble=
 out of the box.

73 Eric

----- Start Original Message -----
Sent: Tue, 24 Feb 2009 13:45:51 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
To: Eric Cottrell <wb1hbu@runbox.com>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image

> Hi Eric,
>=20
> I have the same board and same problem. It's just an incompatibility betw=
een the
> DTB and u-boot.
> Recent u-boots (and without a doubt also your u-boot 1.3.3) expect aliases
> in the DTB, these ones I guess:
>=20
> .
> .
>          aliases {
>                  ethernet0 =3D &enet0;
>                  ethernet1 =3D &enet1;
>                  serial0 =3D &serial0;
>                  serial1 =3D &serial1;
>                  pci0 =3D &pci0;
>          };
> .
> .
>=20
> Not being able to find alias "serial0" (in the DTB) causes this problem.
> see u-boot/common/fdt_support.c:fdt_fixup_stdout
>=20
> Older u-boots don't expect them. My REV A4 board was shipped with
> "U-Boot 1.1.6 (Aug 24 2007 - 13:10:12) MPC83XX" (which obviously not expe=
cts the aliases).
>=20
> If I flash a new/custom u-boot (U-Boot 2008.10) the problem occurs.
>=20
> I assume Freescale ships their REV A4 boards with a u-boot not expecting =
the
> aliases.
> I assume your u-boot 1.3.3 is not the one the board was shipped with,
> are are you saying it is ?
>=20
> ---
> N. van Bolhuis.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Eric Cottrell wrote:
> > Hello,
> >=20
> > This is getting frustrating and I am beginning to think someone messed =
this board up and returned it.  I would think it would boot up the default =
flash image out of the box with very little trouble.
> >=20
> > Board is a MPC8313e-RDB Rev A4.  I set the dip switches per the instruc=
tions, S4 all off and S3 all on.
> > Uboot comes up but I can not boot either the default images in the flas=
h or images I built with ltib and tftped.  I did not touch the flash.  I ge=
t WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND and ERROR: /cho=
sen node create failed - must RESET the board to recover.  The board resets.
> >=20
> > A friend has the same board but his U-Boot is Version 1.3.0 (Jun 19 200=
8 - 13:41:53) MPC83XX and some environment variables are different.  I do n=
ot have the BOOTCMD variable but entered it manually.
> >=20
> > I tried searching for on a solution but it is confusing because if alia=
ses are needed why does the default dtb in the flash omit them?
> >=20
> > This is what happens:
> >=20
> > U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX
> >=20
> > Reset Status:
> >=20
> > CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
> > Board: Freescale MPC8313ERDB
> > I2C:   ready
> > DRAM:  128 MB
> > FLASH:  8 MB
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   TSEC0, TSEC1 [PRIME]
> > =3D> bootm fe100000 fe300000 fe700000
> > ## Booting kernel from Legacy Image at fe100000 ...
> >    Image Name:   Linux-2.6.20
> >    Created:      2007-08-24  14:59:01 UTC
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1722821 Bytes =3D  1.6 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> > ## Flattened Device Tree blob at fe700000
> >    Booting using the fdt blob at 0xfe700000
> > ## Loading init Ramdisk from Legacy Image at fe300000 ...
> >    Image Name:   uboot ext2 ramdisk rootfs
> >    Created:      2007-08-24  15:01:41 UTC
> >    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
> >    Data Size:    2831355 Bytes =3D  2.7 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Loading Device Tree to 007fd000, end 007fffff ... OK
> > WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
> > ERROR: /chosen node create failed - must RESET the board to recover.
> > Resetting the board.
> >=20
> >=20
> > U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX
> >=20
> > Reset Status: Software Hard, External/Internal Soft, External/Internal =
Hard
> >=20
> > CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
> > Board: Freescale MPC8313ERDB
> > I2C:   ready
> > DRAM:  128 MB
> > FLASH:  8 MB
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   TSEC0, TSEC1 [PRIME]
> > =3D>=20
> >=20
> > 73 Eric
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >=20
>=20
>=20

----- End Original Message -----
