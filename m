Message-ID: <3A671191.A0254C18@matrox.com>
Date: Thu, 18 Jan 2001 10:53:53 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: initrd problems
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to boot Sandpoint linux on my board but I can't get initrd
to load.  I'm not using any special bootloader.

I compiled the kernel using make zImage.initrd (my initrd ramdisk is
smaller than 4 MB) and I added root=/dev/ram to the cmd_line in the
function sandpoint_setup_arch() from sandpoint_setup.c.  I know I
shouldn't have to do this (acording to the HOWTO), but I am so
clueless about the cause of the problem that I'm ready to try anything.

The kernel loads until the function mount_root() (in fs/super.c).
This is where it stops:

        retval = blkdev_get(bdev, mode, 0, BDEV_FS);
        if (retval == -EROFS) {
                root_mountflags |= MS_RDONLY;
                retval = blkdev_get(bdev, FMODE_READ, 0, BDEV_FS);
        }
        if (retval) {
                /*
                 * Allow the user to distinguish between failed open
                 * and bad superblock on root device.
                 */
                printk ("VFS: Cannot open root device \"%s\" or %s\n",
                        root_device_name, kdevname (ROOT_DEV));
                printk ("Please append a correct \"root=\" boot
option\n");
                panic("VFS: Unable to mount root fs on %s",
                        kdevname(ROOT_DEV));
        }

With the help of a debugger, I found out that:
root_device_name = ram
ROOT_DEV = 0x0100  /* which is ram according to init/main.c */

So if the root_device points to ram like it should, does anybody know
why it can't open the root device?

The kernel has been copied at address 0 of the RAM on the board along
with initrd (there's no hard-drive or flash, just ram).  Do I need to
set something before I launch the kernel?  I tought everything was setup
up correctly when I did make zImage.initrd ! (INITRD_OFFSET and
INITRD_SIZE should be set by make zImage.initrd, right?)

Any help would be appreciated !


Sébastien Côté

(Sorry if you received this e-mail twice but it didn't seem to go
through the first time)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
