Message-ID: <39D5EBEB.73E21671@snmc.com>
Date: Sat, 30 Sep 2000 08:34:35 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: jari.nguyen@smartstors.com
Subject: Re: mount RAMDISK directly on rom
References: <39D485A1.2785C0E4@serialsystem.com.sg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jari,

The QSLinux kernel supports reading from a Flash'ed filesystem.  The
kernel does not make use of the initrd image.  It stores the kernel as a
compressed image in one area of FLASH, and the remainder of FLASH is
organized as an ext2fs filesystem (using the compression patch).  You
initially boot using only the kernel and rely on an NFS mount for the
filesystem.  You then format the FLASH disk, and copy whatever files you
need, along with creating the special dev files.  Then when you reboot
you use the "init=/dev/ftla" command line option to tell the kernel to
boot using the on-board FLASH filesystem.

The QSLinux kernel contains all of the code plus scripts for
implementing this mechanism.  You can download the kernel from
ftp://qslinux.org/pub/qslinux.  On-line documentation is available at
http://qslinux.org.

Regards,

Daris Nevil


Jari wrote:
>
> Hi all,
>
> Is there anyone know how to let the uncompressed ramdisk image in the
> rom,
> and mount root system directly from it (read only)?
>
> I think that I have to modify  mount_root() function,
> reinitialize  super_block *sb directly by reading ramdisk image from the
> rom,
> before calling add_vsfmnt(sb,"/dev/root","/"),
> is that right? of course, I have to build  a kernel image with
> uncompress image,
> modify the code which copy ramdisk image to ram_device.
>
> If you have done it, and see my way is incorrect,
> or know where to look for information about it, teach me please.
>
> Thanks in advance,
> Jari
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
