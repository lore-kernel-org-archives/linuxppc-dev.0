Message-ID: <37C4FD7C.BBEC0F1@wanadoo.fr>
Date: Thu, 26 Aug 1999 10:40:28 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Paul.Mackerras@cs.anu.edu.au
Subject: vger-2.3.15 on pmac
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks to the efforts of Paul M. and Cort, the 2.3.15 kernel from
cvs.on.openprojects is now compiling on a Pmac (first time after 2.3.6,
2 months ago).

I propose 2 patches: The first one is an obvious correction in the
valkyriefb driver, and the second one allows to configure support for
Apple partition maps without going to the section of exotic partitions.
It is obvious, too.

In a second post, I'll have some questions about things that don't yet
work. I hope this is the right forum for this. I didn't see many
discussions on kernel development for the PPC like on the linux-kernel
list.

--
Martin

Index: drivers/video/valkyriefb.c
===================================================================
RCS file: /cvs/linux/linux/drivers/video/valkyriefb.c,v
retrieving revision 1.13
diff -u -r1.13 valkyriefb.c
--- drivers/video/valkyriefb.c  1999/08/20 01:43:36     1.13
+++ drivers/video/valkyriefb.c  1999/08/25 16:49:23
@@ -763,7 +763,7 @@
 {
        memset(fix, 0, sizeof(*fix));
        strcpy(fix->id, "valkyrie");
-       fix->mmio_start = (char *)p->valkyrie_regs_phys;
+       fix->mmio_start = p->valkyrie_regs_phys;
        fix->mmio_len = sizeof(struct valkyrie_regs);
        fix->type = FB_TYPE_PACKED_PIXELS;
 
Index: fs/partitions/Config.in
===================================================================
RCS file: /cvs/linux/linux/fs/partitions/Config.in,v
retrieving revision 1.1
diff -u -r1.1 Config.in
--- fs/partitions/Config.in     1999/08/20 00:22:30     1.1
+++ fs/partitions/Config.in     1999/08/25 16:49:59
@@ -23,6 +23,9 @@
   if [ "$CONFIG_ATARI" = "y" ]; then
     define_bool CONFIG_ATARI_PARTITION y
   fi
+  if [ "$CONFIG_PMAC" = "y" ]; then
+    define_bool CONFIG_MAC_PARTITION y
+  fi
   bool 'SMD disklabel (Sun partition tables) support'
CONFIG_SMD_DISKLABEL
   if [ "$ARCH" = "sparc" -o "$CONFIG_SMD_DISKLABEL" = "y" ]; then
     define_bool CONFIG_SUN_PARTITION y

===================================================================

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
