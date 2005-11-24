Return-Path: <gnemas@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.194])
	by ozlabs.org (Postfix) with ESMTP id 5B982687DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Nov 2005 06:55:34 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so1647409wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 11:55:33 -0800 (PST)
Message-ID: <8e84e0f20511241149w6b258df1m99b8e1caeebc0d2a@mail.gmail.com>
Date: Thu, 24 Nov 2005 14:49:19 -0500
From: Gregg Nemas <gnemas@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Trouble getting Compact Flash IDE Interface to PPC440GP working
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a PPC440GP-based CPU board that has a compact flash connected
to the peripheral bus in so-called "True IDE" mode. I am able to read
and write to the device using u-boot, and now I am trying to get it
working with linux 2.6.

The connection is like this:

CF A0..A2 =3D> PPC440 A30..A28 (ppc A31 not used for 16-bit bus)
CF D0..D15 =3D> PPC440 D15..D0
CF INTRQ =3D> PPC440 IRQ0 (GPIO0)

The peripheral bus is configured for 16-bit wide accesses.

I set the offsets passed to ide_setup_ports as follows:

#define CF_HD_DATA       0x00
#define CF_HD_ERROR      0x03            /* see err-bits */
#define CF_HD_NSECTOR    0x05            /* nr of sectors to read/write */
#define CF_HD_SECTOR     0x07            /* starting sector */
#define CF_HD_LCYL       0x09            /* starting cylinder */
#define CF_HD_HCYL       0x0b            /* high byte of starting cyl */
#define CF_HD_SELECT     0x0d            /* 101dhhhh, d=3Ddrive, hhhh=3Dhea=
d */
#define CF_HD_STATUS     0x0f            /* see status-bits */
#define CF_HD_CONTROL    0x0010000d      /* control/altstatus */

In order to get this working with u-boot, I had to endian swap all
16-bit data register accesses. I found that I had to do the same thing
in the ata_input_data and ata_output_data functions in ide-iops.c file
in linux before it would correctly identify the drive. I don't
understand why I have to do this in either place, given the
connections I described above, but it seems to be required.

After doing this, I get the following at bootup:

>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=3Dxx
>ide0: CF IDE interface
>Probing IDE interface ide0...
>hda: SanDisk SDCFJ-128, CFA DISK drive
>ide0 at 0xd1080000-0xd1080007,0xd118000d on irq 23
>hda: max request size: 128KiB
>hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=3D980/8/32
>hda: cache flushes not supported
> hda: unknown partition table

I partitioned the drive using debian linux workstation with a pair of
type 83 partitions, and added a root file system to one of them. I can
see all this from u-boot, and can even load the kernel from it. I am
lost as to where to proceed to figure out why the kernel is having
trouble.

The other problem I am having is that after booting up, any attempt to
access /dev/hda using fdisk results in fdisk hanging, and "lost
interrupt" messages appearing on the console. If I look at
/proc/interrupts, it shows that 11 interrupts have occurred on
interrupt number 23. I have this set to level senstitive, positive
polarity.

Can someone offer some guidance?

Thanks.

Gregg
