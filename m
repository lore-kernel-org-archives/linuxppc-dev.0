Message-Id: <200008091942.VAA06989@piglet.grunz.lu>
Date: Wed, 9 Aug 2000 21:42:08 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Compile error with Paul's pmac-devel rsync tree
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-965850131=:6987"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-965850131=:6987
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

Thought I let you all know so you don't have to search for yourself.
Patch is below...

- There is a problem in compiling ext2 fs support, in fs/ext2/dir.c.
  This looks like part of a patch submitted to linux-kernel sometime in
  June. I haven't checked whether this is wrong in kernel.org kernels as
  well...

- The same goes for mark_buffer_dirty_inode() in fs/ext2/truncate.c,
  which seems to come out of the same patch...

- arch/ppc/kernel/chrp_setup.c has a conditional in the wrong place. Can
  somebody correct this? Paul? It only appears as an error if sysrq key
  is not enabled, so that's probably why nobody noticed...

Now I'll check whether it actually works ;-)

Happy compiling!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


--134458388-1804289383-965850131=:6987
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="rsync.patch"

--- linux-2.4.paul/fs/ext2/dir.c	Mon Jun 12 02:10:39 2000
+++ linux/fs/ext2/dir.c	Wed Aug  9 20:21:23 2000
@@ -26,7 +26,7 @@
 	read:		generic_read_dir,
 	readdir:	ext2_readdir,
 	ioctl:		ext2_ioctl,
-	fsync:		ext2_fsync_file,
+	fsync:		ext2_sync_file,
 };

 int ext2_check_dir_entry (const char * function, struct inode * dir,
--- linux-2.4.paul/arch/ppc/kernel/chrp_setup.c	Tue Aug  8 08:07:45 2000
+++ linux/arch/ppc/kernel/chrp_setup.c	Wed Aug  9 20:40:04 2000
@@ -477,8 +477,8 @@
 #ifdef CONFIG_MAGIC_SYSRQ
 		ppc_md.ppc_kbd_sysrq_xlate	 = mackbd_sysrq_xlate;
 		SYSRQ_KEY = 0x69;
-	}
 #endif /* CONFIG_MAGIC_SYSRQ */
+	}
 #endif /* CONFIG_VT && CONFIG_ADB_KEYBOARD */
 }

--- linux-2.4.paul/fs/ext2/truncate.c	Mon Jun 12 02:10:39 2000
+++ linux/fs/ext2/truncate.c	Wed Aug  9 20:47:42 2000
@@ -211,7 +211,7 @@
 			inode->i_ino, tmp);
 		*p = 0;
 		if (dind_bh)
-			mark_buffer_dirty_inode(dind_bh, 1, inode);
+			mark_buffer_dirty(dind_bh, 1);
 		else
 			mark_inode_dirty(inode);
 		return 0;
@@ -279,7 +279,7 @@
 			inode->i_ino, tmp);
 		*p = 0;
 		if (tind_bh)
-			mark_buffer_dirty_inode(tind_bh, 1, inode);
+			mark_buffer_dirty(tind_bh, 1);
 		else
 			mark_inode_dirty(inode);
 		return 0;

--134458388-1804289383-965850131=:6987--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
