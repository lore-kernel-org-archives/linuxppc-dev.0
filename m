Date: Sun, 27 Jun 2004 20:58:50 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
Message-ID: <20040628035850.GA30977@gate.ebshome.net>
References: <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Jun 27, 2004 at 06:46:20PM -0400, Robert P. J. Day wrote:
>
>   what is (hopefully) a simple question, before i invest the time to
> see whether it works.
>
>   currently, i have a modified rpxlite board, with two flash chips,
> each 8M -- one "system" flash, one "user" flash.  the system flash has
> the boot loader (embedded planet's planet core), and the loadable
> kernel+rootfs image.  this bootable image is only 2.5M in size, so
> there's lots of leftover space in that system flash chip.
>
>   with this configuration, it's obviously not possible to update files
> or directories in the bootable image individually -- it's just one big
> zImage.inited image.
>
>   but is it feasible to redefine the layout of that flash chip and
> take, say, 4M of it and create a JFFS2 filesystem, then put the root
> filesystem in there uncompressed?  (assuming, of course, that the
> rootfs fits in 4M.)  theoretically, then, i could have system flash
> with the bootloader (only a couple hundred K), the bootable kernel (at
> most 2M in our case), then 4M of JFFS2.  that would give me the
> freedom to update the basic root filesystem if i had to.  we could
> boot the kernel as we're doing now, and i'm assuming it wouldn't be
> difficult to have the kernel know to copy the JFFS2-based root
> filesystem into RAM, mount it, and take it from there.
>
>   the current flash layouts are defined in the file
> drivers/mtd/maps/rpxlite.c, and we've set it up so that the other 8M
> "user" flash is associated with /dev/mtdblock/0.  my thought was to
> just define half of system flash as JFFS2, at which point it would be
> accessible as /dev/mtdblock/1 (depending on the definition order, of
> course).
>
>   is this possible?  anyone done it this way, and can tell me what
> pitfalls i have to watch for?  thanks.

Yes, this is possible and actually quite trivial.

Partition your flash the way you want, e.g. reserve part of the flash chip for
root fs, place filesystem into it and mount corresponding mtdblock device during
boot, e.g. use something like "root=/dev/mtdblock1" if you have several
fs compiled into your kernel you can use additional command line parameter
"rootfstype=<your_root_fs>" to prevent kernel trying all registered fs while
mounting root.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
