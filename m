Message-ID: <81A66F72DCACD511B0600002A551BFCB02ABC2C9@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: register_blk_dev seems to do nothing during boot for /dev/mtd
	block0
Date: Thu, 13 Mar 2003 15:30:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried with both mtdblock0 and mtdblock/0 I doesn't work.
I guess that the right name must be mtdblock0 since the devfs is mounted
after the root.
So the cramfs filesystem must be already mounted to be able to mount /devfs.

But the biggest problem for me is that when I use the standard way,
and when the cramfs filesystem is the root filesystem, the mounting of the
root
hang in the __wait_on_buffer function called by cramfs_read.

(note __wait_for_buffer is defined in fs/buffer.c and cramfs_read in
/fs/cramfs/inode.c)

The place where it "blocks" in __wait_on_buffer on the loop implementing the
waiting.
(same kind of code can be found in Linux Device Drivers 2nd Edition p.287).
Since this code has nothing to do either with the mtd driver or the cramfs
and also since I have no problem is to mount the cramfs is it is not the
root filesystem,
I have no idea to make it working.
I tried to bypass this code (putting the mtdblock driver in the cramfs
driver) but that doesn't work.
VFS complains about the /mtdblock driver He can not find. Without this hack
It can open the mtd driver.

The lacking of /dev/mtdblock0(or /dev/mtdblock/0) seems not be a problem for
linux at boot time,
devfs_find_handle returns also 0 when I uses the standard code (I use a
string constant)
The kernel uses the major and minor number to find the root device. ( see
super.c)


-----Original Message-----
From: Kári Davíðsson [mailto:kd@medcare.is]
Sent: Thursday, March 13, 2003 2:22 PM
To: "Callebaut, Benoît"; Linuxppc-Embedded (E-mail)
Subject: RE: register_blk_dev seems to do nothing during boot for
/dev/mtdblock0


Hi,

If you are using devfs, it is called /dev/mtdblock/0 _not_ /dev/mtdblock0.

Do not forget to mount the devfs on boot.

Regards,

K.D.

> -----Original Message-----
> From: "Callebaut, Benoît" [mailto:benoit.callebaut@barco.com]
> Sent: 13. mars 2003 13:11
> To: Linuxppc-Embedded (E-mail)
> Subject: register_blk_dev seems to do nothing during boot for
> /dev/mtdblock0
>
>
>
> I placed the function devfs_find_handle after registering the
> filesystem in
> the read only block driver for MTD devices.
> It returns zero and I never see a mtdblock0 entry appaering
> in /dev/ Why
> must I use MAKEDEV to do that.
> Notes that I can use MAKEDEV in my case since I want to mount
> my cramfs
> filesystem at boot up.
>
> --------------------------------------------------------------
> --------------
> ------
> Benoit Callebaut
> Software Development Engineer
> Barco | Control Rooms
> Noordlaan 5, 8520 Kuurne, Belgium
>
> Tel 	+32(0)56 36 84 28
> Fax 	+32(0)56 36 86 05
>
> mailto:benoit.callebaut@barco.com
> http://www.barcocontrolrooms.com
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
