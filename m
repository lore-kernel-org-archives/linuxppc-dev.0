Date: Fri, 6 Aug 2004 09:59:18 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] md raid autodetection on mac partitions
Message-ID: <20040806075918.GA11638@sunbeam2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi!

It took me some time to discover that there is no provision in the mac
parition handling code for autodetection of md raid arrays.

Is there any particular reason why this isn't implemented?

I've now added a new partition type 'Linux_raid_autodetect', which can
be used for md autodetect.

Please consider inclusion of this patch.

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.8-mac-autoraid.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.8-rc3-plain/fs/partitions/mac.c	2004-08-05 19:49:30.000000000 +0200
+++ linux-2.6.8-rc3-hw1/fs/partitions/mac.c	2004-08-05 19:52:06.000000000 +0200
@@ -4,6 +4,10 @@
  *  Code extracted from drivers/block/genhd.c
  *  Copyright (C) 1991-1998  Linus Torvalds
  *  Re-organised Feb 1998 Russell King
+ *
+ *  2004-08-05 Harald Welte <laforge@gnumonks.org>:
+ *  	- Add support for md-raid autodetection to make md-raid bootable
+ *	  (Partition type "Linux_raid_autodetect")
  */

 #include <linux/config.h>
@@ -110,6 +114,9 @@
 					goodness--;
 			}

+			if (strcasecmp(part->type, "Linux_raid_autodetect") == 0)
+				state->parts[slot].flags = 1;
+
 			if (goodness > found_root_goodness) {
 				found_root = blk;
 				found_root_goodness = goodness;

--pf9I7BMVVzbSWLtt--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
