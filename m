Date: Wed, 28 Mar 2001 23:19:52 +0200 (MET DST)
From: Christiaan Welvaart <C.J.Welvaart@phys.uu.nl>
To: <bj93543@binghamton.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: swim3 + ide-floppy devfs patch (was Re: Q: devfs and swim3)
In-Reply-To: <Pine.GSO.BU-L4.10.10103022135250.25059-100000@bingsun2>
Message-ID: <Pine.OSF.4.33.0103282255180.22208-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Mar 2001 bj93543@binghamton.edu wrote:

> Is there known any reason why swim3 floppy controler is not inserted
> in devfs ?
> or can be swim3.c patched like:
>
> -swim3.c:1034:  ...register_blkdev...
> +swim3.c:1034:  ...devfs_register_blkdev...

This is not enough, it just prevents the floppy driver to be registered if
you tell devfs to not use the old-style device system with major/minor
numbers I believe. Below a patch that seems to work, though I'm not sure
if the permissions are right. I also included a patch for ide-floppy since
my zip drive was missing from devfs as well. That one should probably be
sent to the regular linux-kernel list though.


    Christiaan


===== swim3.c 1.2 vs edited =====
--- 1.2/drivers/block/swim3.c	Tue Feb  6 05:23:06 2001
+++ edited/swim3.c	Wed Mar 28 23:12:02 2001
@@ -33,6 +33,7 @@

 #define MAJOR_NR	FLOPPY_MAJOR
 #include <linux/blk.h>
+#include <linux/devfs_fs_kernel.h>

 static int floppy_blocksizes[2] = {512,512};
 static int floppy_sizes[2] = {2880,2880};
@@ -1011,9 +1012,13 @@
 	revalidate:		floppy_revalidate,
 };

+static devfs_handle_t	floppy_devfs_handle;
+
 int swim3_init(void)
 {
 	struct device_node *swim;
+
+	floppy_devfs_handle = devfs_mk_dir(NULL, "floppy", NULL);

 	swim = find_devices("floppy");
 	while (swim && (floppy_count < MAX_FLOPPIES))
@@ -1031,7 +1036,7 @@

 	if (floppy_count > 0)
 	{
-		if (register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
+		if (devfs_register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
 			printk(KERN_ERR "Unable to get major %d for floppy\n",
 			       MAJOR_NR);
 			return -EBUSY;
@@ -1048,6 +1053,8 @@
 {
 	struct device_node *mediabay;
 	struct floppy_state *fs = &floppy_states[floppy_count];
+	char	floppy_name[16];
+	devfs_handle_t	floppy_handle;

 	if (swim->n_addrs < 2)
 	{
@@ -1105,6 +1112,12 @@

 	printk(KERN_INFO "fd%d: SWIM3 floppy controller %s\n", floppy_count,
 		mediabay ? "in media bay" : "");
+
+	sprintf(floppy_name, "%s%d", floppy_devfs_handle ? "" : "floppy", floppy_count);
+	floppy_handle = devfs_register(floppy_devfs_handle, floppy_name,
+									DEVFS_FL_DEFAULT, MAJOR_NR, floppy_count,
+									S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
+									&floppy_fops, NULL);

 	floppy_count++;



===== ide-floppy.c 1.2 vs edited =====
--- 1.2/drivers/ide/ide-floppy.c	Sat Feb 10 18:54:17 2001
+++ edited/ide-floppy.c	Wed Mar 28 23:12:29 2001
@@ -238,6 +238,7 @@
 	int wp;							/* Write protect */

 	unsigned int flags;			/* Status/Action flags */
+	devfs_handle_t	de;
 } idefloppy_floppy_t;

 /*
@@ -1543,6 +1544,12 @@
 	floppy->pc = floppy->pc_stack;
 	if (gcw.drq_type == 1)
 		set_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags);
+
+	floppy->de = devfs_register(drive->de, "zip", DEVFS_FL_DEFAULT,
+				     major, minor,
+				     S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
+				     ide_fops, NULL);
+
 	/*
 	 *	We used to check revisions here. At this point however
 	 *	I'm giving up. Just assume they are all broken, its easier.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
