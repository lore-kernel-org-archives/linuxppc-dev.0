Date: Sat, 5 Jul 2003 04:16:02 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: fsck_hfs on PPC???
Message-Id: <20030705041602.2a49d76d.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Update:

I think I've got Apple's fsck_hfs working now on PPC, with Roman Zippel's
new Linux patch and two additional patches I worked up (see attached
e-mail message):

gwiz# fsck_hfs /dev/hda9
** /dev/hda9
** Checking HFS Plus volume.
** Checking Extents Overflow file.
** Checking Catalog file.
** Checking Catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume gwiz appears to be OK.

						-Bill



Begin forwarded message:

Date: Sat, 5 Jul 2003 03:59:59 -0400
From: Bill Fink <billfink@mindspring.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: fsck_hfs on PPC???


Hi again,

On Fri, 4 Jul 2003, Roman Zippel wrote:

> On Thu, 3 Jul 2003, Bill Fink wrote:
>
> > I was trying to use your Linux patch for Apple's fsck_hfs on a
> > PPC system and not having much luck, so I was wondering if you
> > might have any ideas.  The attached message to linuxppc-dev gives
> > the details.  Basically I was able to get it to build OK with an
> > additional patch (included in the attached message) but running
> > fsck_hfs doesn't appear to do anything.  I have a similar patch
> > for newfs_hfs but I haven't even tried to use that.
>
> I've updated the patch at http://www.ardistech.com/hfsplus/diskdev_cmds.diff.gz
> It should fix these problems, could you give it a try?

I think I've got it working now with the two additional attached
patches (to fsck_hfs.tproj/dfalib/HardLinkCheck.c and
fsck_hfs.tproj/dfalib/SDevice.c):

gwiz# fsck_hfs /dev/hda9
** /dev/hda9
** Checking HFS Plus volume.
** Checking Extents Overflow file.
** Checking Catalog file.
** Checking Catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume gwiz appears to be OK.

I haven't tried messing with newfs_hfs yet, so I don't know if it
would have similar issues.

						-Thanks

						-Bill



--- fsck_hfs.tproj/dfalib/.orig/HardLinkCheck.c	2003-07-04 12:11:21.000000000 -0400
+++ fsck_hfs.tproj/dfalib/.mod/HardLinkCheck.c	2003-07-04 12:18:06.000000000 -0400
@@ -45,10 +45,16 @@
 #define _U2(v)	{ .u32 = ((((v) & 0xff000000) >> 24) | (((v) & 0xff0000) >> 8) | \
 						 (((v) & 0xff00) << 8) | (((v) & 0xff) << 24)) }
 #else
+#ifdef __BIG_ENDIAN__
+#define _U(v)	(v)
+#define _U2(v)	(v)
+
+#else
 #define _U(v)	((((v) >> 8) & 0xff) | (((v) & 0xff) << 8))
 #define _U2(v)	((((v) & 0xff000000) >> 24) | (((v) & 0xff0000) >> 8) | \
 				 (((v) & 0xff00) << 8) | (((v) & 0xff) << 24))
 #endif
+#endif

 HFSPlusCatalogKey gMetaDataDirKey = {
 	_U(48),		/* key length */
--- fsck_hfs.tproj/dfalib/.orig/SDevice.c	2003-07-04 12:11:21.000000000 -0400
+++ fsck_hfs.tproj/dfalib/.mod/SDevice.c	2003-07-05 03:44:12.000000000 -0400
@@ -29,6 +29,11 @@
 #include <errno.h>
 #include <sys/ioctl.h>

+#if __linux__
+#include <linux/fs.h>
+#include <stdio.h>
+#endif
+
 #if __APPLE__
 #include <IOKit/storage/IOMediaBSDClient.h>
 #else
@@ -71,6 +76,12 @@
 	return (0);
 #else
 	struct stat statb;
+#ifdef __linux__
+	FILE	*fp;
+	char	partline[80+2];
+	int	partmajor, partminor;
+	unsigned long long partn1kblocks;
+#endif
 	if (fstat(driveRefNum , &statb) < 0) {
 		return (-1);
 	}
@@ -79,6 +90,25 @@
 		*blockSize = 512;
 		return 0;
 	}
+	if (S_ISBLK(statb.st_mode)) {
+#ifdef __linux__
+		fp = fopen("/proc/partitions", "r");
+		if (fp) {
+			while (fgets(partline, 80, fp)) {
+				sscanf(partline, "%d %d %lld", &partmajor,
+					&partminor, &partn1kblocks);
+				if ((partmajor == MAJOR(statb.st_rdev)) &&
+				    (partminor == MINOR(statb.st_rdev))) {
+					*numBlocks = partn1kblocks * 2;
+					*blockSize = 512;
+					fclose(fp);
+					return 0;
+				}
+			}
+			fclose(fp);
+		}
+#endif
+	}
 	return (-1);
 #endif
 #else

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
