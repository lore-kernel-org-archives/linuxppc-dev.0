Message-ID: <76C7EB7C8500594F9001B118E7E778F48F4D6A@mdsms3.inside.mdsroc.com>
From: "Ruhland, Paul" <PRuhland@microwavedata.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cramfs mpc8xx 2.4.18
Date: Fri, 13 Feb 2004 14:31:09 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3F267.EE9F0CA0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3F267.EE9F0CA0
Content-Type: text/plain;
	charset="iso-8859-1"

Without more information I can't really tell what is wrong.  Did you create
an mtd partition map for your flash (need this to use the mtdblock devices)?

I used to mount cramfs images from flash, but ran into problems every so
often with the cramfs root not decompressing correctly while reprogramming
other sectors.  So I switched to mounting the cramfs image as a ramdisk.
You just build the cramfs image as usual but mount is as a ramdisk when
booting the kernel (I use u-boot so I used mkimage to prep it for that
also).

I've attached a patch against linuxppc_2_4_devel (2.4.23) which adds this
capability, if your interested.  It simply changes the ramdisk blocksize to
match cramfs blocksize if its mounting a cramfs root image.


-----Original Message-----
From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
Sent: Friday, February 13, 2004 1:33 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: cramfs mpc8xx 2.4.18



Hi Gurus,

I have a custom board running 2.4.18 with initrd. Now, I want to make cramfs
as root filesystem. When I built cramfs support in the kernel and gave it
root=/dev/mtdblock1 (where my cramfs in correct endian order is stored on
flash) rootfstype=cramfs, the kernel hangs. MTD support is built in the
kernel. If I build cramfs as module, then boot my kernel with initrd (ext2)
and then mount it (on say /mnt), I can read cramfs correctly.

I also looked at rd.c file in drivers/block and noticed that this is does
not have cramfs initrd support. Do I need this? What am I doing wrong?
Please help

Lokesh Kumar




------_=_NextPart_000_01C3F267.EE9F0CA0
Content-Type: application/octet-stream;
	name="linuxppc_2_4_devel-cramfs_ramdisk.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linuxppc_2_4_devel-cramfs_ramdisk.patch"

diff -u -p -r1.1.1.1 -r1.2=0A=
--- drivers/block/rd.c	11 Jan 2004 17:36:58 -0000	1.1.1.1=0A=
+++ drivers/block/rd.c	16 Jan 2004 21:53:25 -0000	1.2=0A=
@@ -73,6 +73,8 @@ int initrd_in_ram;=0A=
 int initrd_below_start_ok;=0A=
 #endif=0A=
 =0A=
+void rd_adjust_blocksize( unsigned int new_blocksize );=0A=
+=0A=
 /* Various static variables go here.  Most are used only in the RAM =
disk code.=0A=
  */=0A=
 =0A=
@@ -476,6 +478,28 @@ static int __init rd_init (void)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * cramfs probably has a different blocksize--adjust the=0A=
+ * ramdisk's block size to accomodate=0A=
+ * FIXME: should have a way to determine the cramfs=0A=
+ * blocksize (if it's going to be variable.....)=0A=
+ */=0A=
+void rd_adjust_blocksize( unsigned int new_blocksize )=0A=
+{=0A=
+	if (rd_blocksize !=3D new_blocksize) {=0A=
+		int i;=0A=
+=0A=
+		rd_blocksize =3D new_blocksize;=0A=
+		for (i =3D 0; i < NUM_RAMDISKS; i++) {=0A=
+			rd_hardsec[i] =3D rd_blocksize;=0A=
+			rd_blocksizes[i] =3D rd_blocksize;=0A=
+		}=0A=
+		printk(KERN_NOTICE "RAMDISK: overriding ramdisk block "=0A=
+				"size to %d for cramfs filesystem\n",=0A=
+				rd_blocksize);=0A=
+	}=0A=
+}=0A=
+=0A=
 module_init(rd_init);=0A=
 module_exit(rd_cleanup);=0A=
=0A=
diff -u -p -r1.1.1.1 -r1.2=0A=
--- init/do_mounts.c	11 Jan 2004 17:36:00 -0000	1.1.1.1=0A=
+++ init/do_mounts.c	16 Jan 2004 21:50:43 -0000	1.2=0A=
@@ -33,6 +33,9 @@ extern asmlinkage long sys_mknod(const c=0A=
 extern asmlinkage long sys_umount(char *name, int flags);=0A=
 extern asmlinkage long sys_ioctl(int fd, int cmd, unsigned long =
arg);=0A=
 =0A=
+/* to change ramdisk blocksize (ie. for cramfs) */=0A=
+extern asmlinkage void rd_adjust_blocksize( unsigned int new_blocksize =
);=0A=
+=0A=
 #ifdef CONFIG_BLK_DEV_INITRD=0A=
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t =
*/=0A=
 static int __initdata mount_initrd =3D 1;=0A=
@@ -531,6 +534,8 @@ identify_ramdisk_image(int fd, int start=0A=
 		printk(KERN_NOTICE=0A=
 		       "RAMDISK: cramfs filesystem found at block %d\n",=0A=
 		       start_block);=0A=
+		/* cramfs has blocksize of PAGE_CACHE_SIZE */=0A=
+		rd_adjust_blocksize(PAGE_CACHE_SIZE);=0A=
 		nblocks =3D (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;=0A=
 		goto done;=0A=
 	}=0A=
=0A=

------_=_NextPart_000_01C3F267.EE9F0CA0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
