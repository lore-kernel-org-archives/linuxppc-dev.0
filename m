Message-ID: <399C134C.6BCBAA67@wanadoo.fr>
Date: Thu, 17 Aug 2000 18:31:08 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] mount -o loop in 2.4.0 fixed
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

For a long time, mount or losetup with /dev/loop* did not work for me on
2.3 development kernels. I typically got the following

root[255]#mount -o loop /tmp/ramdisk.image /mnt/ram1
memlock: Invalid argument
Couldn't lock into memory, exiting.

I found the bug in include/asm-ppc/mman.h which, according to bitkeeper,
was introduced on 2000/03/20 into 2.3.99-pre3. The patch below fixes the
problem for me. Please test if this causes other problems.

So far, I haven't seen any. I even tried the following: Do an NFS-mount
of the sunsite.doc.ic.ac.uk server, go into
Mirrors/ftp.linuxppc.org/pub/linuxppc-2000/images and
mount -o loop LinuxPPC_2000_Source.image /mnt/ram2
df -h now shows proudly the following (and I can walk around inside the
mounted CD image):

Filesystem            Size  Used Avail Use% Mounted on
193.63.255.4:/public  480G  480G   74M 100% /mnt/sunsite
/mnt/sunsite/Mirrors/ftp.linuxppc.org/pub/linuxppc-2000/images/LinuxPPC_2000_Source.image
                      650M  590M   59M  91% /mnt/ram2

This kind of remote mounting of a 650MB HFS image didn't work for me
with any 2.2.X kernel.

In fact, the patch kills another bird with the same stone: I can now say

mount -o loop /dev/cdrom /mnt/cdrom

and mount the LinuxPPC CD-ROMs from my SCSI CD drive. mount now shows

/dev/scsi/host0/bus0/target3/lun0/cd on /mnt/cdrom type hfs
(rw,loop=/dev/loop0)

Without -o loop, I get the well known bug (bug in the SCSI cdrom driver)
on 2.4.0 kernels:

root[20]#mount -t hfs /dev/cdrom /mnt/cdrom
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems

--
Martin


--- include/asm-ppc/mman.h.ori  Sat Mar 25 06:50:09 2000
+++ include/asm-ppc/mman.h      Thu Aug 17 17:18:47 2000
@@ -22,8 +22,8 @@
 #define MS_INVALIDATE  2               /* invalidate the caches */
 #define MS_SYNC                4               /* synchronous memory
sync */

-#define MCL_CURRENT    1               /* lock all current mappings */
-#define MCL_FUTURE     2               /* lock all future mappings */
+#define MCL_CURRENT    0x2000          /* lock all current mappings */
+#define MCL_FUTURE     0x4000          /* lock all future mappings */

 #define MADV_NORMAL    0x0             /* default page-in behavior */
 #define MADV_RANDOM    0x1             /* page-in minimum required */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
