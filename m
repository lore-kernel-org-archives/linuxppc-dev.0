Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id 287B0679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 20:48:11 +1000 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: Ben Warren <bwarren@qstreams.com>,
 linuxppc-embedded@ozlabs.org
Subject: Re: JFFS2 FS is read-only (not what I want)
Date: Mon, 3 Jul 2006 12:42:35 +0200
References: <44A6E57A.3080302@qstreams.com>
In-Reply-To: <44A6E57A.3080302@qstreams.com>
MIME-Version: 1.0
Message-Id: <200607031241.27979.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Ben,

On Saturday 01 July 2006 23:13, Ben Warren wrote:
> Hello,
>
> When I boot from a JFFS2 file system on my eval board, the file system
> is effectively read-only, and I can't figure out why.  I'm pretty sure
> the kernel's configured for R/W MTD block access.  Any help is greatly
> appreciated.
>
Do you mean that you can't even created a void file on / as root ? Else
can you then put for instance text in it ? My point is can or can't you
first create a new fs node and then can you write to file your
changes, that's two possible causes.
>
> The hardware in use is:
>
> Freescale MPC8349EMDS eval board.
> 8MB Q-flash with 64 uniform 128k sectors
>

[...]

> # mount
> /dev/mtdblock4 on / type jffs2 (rw)
> /proc on /proc type proc (rw)
>
[...]
>
> I created the MTD partitions in a u-boot image that was pulled from the

Yes indeed what about drivers/mtd/maps/physmap.c ? your parts are
mask_flags:  MTD_WRITEB_WRITEABLE and not  MTD_CAP_ROM,
aren't they ?

> GIT tree about a week ago, and my kernel is 2.6.17-based.  I wrote some
> board init code that sets the MTD physical mappings.
>
> Here are the MTD and JFFS2 parts of my .config file:
>
> ***
> # Memory Technology Devices (MTD)
> #
> CONFIG_MTD=y
> # CONFIG_MTD_DEBUG is not set
> # CONFIG_MTD_CONCAT is not set
> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
>
[...]
> # CONFIG_JFFS_FS is not set
> CONFIG_JFFS2_FS=y

Better avoid redundacy but this is not a clue, I guess
make won't be fooled by this.

> CONFIG_JFFS2_FS_DEBUG=0
> # CONFIG_JFFS2_FS_WRITEBUFFER is not set
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_RTIME=y
> # CONFIG_JFFS2_RUBIN is not set
> ***
>
> The file system is the SELF that is included with DENX's ELDK, and built
> as at:
> http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding
>
> I used the following command to create the file system image, that was
>
> then loaded at address 0xfe480000 via U-boot:
>  > mkfs.jffs2 -U -d rootfs -D rootfs_device.tab -b -e 0x20000 -o jffs2.img
>

IMHO, it's not a generation-time issue

>
[...]


That's all I have for now. Good luck.


Regards,

Mathieu Deschamps
Com2gether Design Center
Electronic and Embedded Engineering Services
www.com2gether.net 
