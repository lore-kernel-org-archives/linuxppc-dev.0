Return-Path: <rob@landley.net>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsz2t1Q0LzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 09:51:33 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id q8so1060267qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:51:33 -0700 (PDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, mingo@kernel.org, akpm@linux-foundation.org,
 keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
 rostedt@goodmis.org, mhocko@suse.com, viresh.kumar@linaro.org,
 tj@kernel.org, thomas.lendacky@amd.com, lauraa@codeaurora.org,
 lokeshvutla@ti.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
 <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
 <87r2z86ykt.fsf@concordia.ellerman.id.au>
From: Rob Landley <rob@landley.net>
Subject: [PATCH v3] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
Message-ID: <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
Date: Wed, 13 Sep 2017 18:51:25 -0500
MIME-Version: 1.0
In-Reply-To: <87r2z86ykt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Landley <rob@landley.net>

Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
/dev/console open after devtmpfs mount.

Add workaround for Debian bug that was copied by Ubuntu.

Signed-off-by: Rob Landley <rob@landley.net>
---

v2 discussion: http://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html

 drivers/base/Kconfig |   14 ++++----------
 fs/namespace.c       |   14 ++++++++++++++
 init/main.c          |   15 +++++++++------
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f046d21..97352d4 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -48,16 +48,10 @@ config DEVTMPFS_MOUNT
 	bool "Automount devtmpfs at /dev, after the kernel mounted the rootfs"
 	depends on DEVTMPFS
 	help
-	  This will instruct the kernel to automatically mount the
-	  devtmpfs filesystem at /dev, directly after the kernel has
-	  mounted the root filesystem. The behavior can be overridden
-	  with the commandline parameter: devtmpfs.mount=0|1.
-	  This option does not affect initramfs based booting, here
-	  the devtmpfs filesystem always needs to be mounted manually
-	  after the rootfs is mounted.
-	  With this option enabled, it allows to bring up a system in
-	  rescue mode with init=/bin/sh, even when the /dev directory
-	  on the rootfs is completely empty.
+	  Automatically mount devtmpfs at /dev on the root filesystem, which
+	  lets the system to come up in rescue mode with [rd]init=/bin/sh.
+	  Override with devtmpfs.mount=0 on the commandline. Initramfs can
+	  create a /dev dir as needed, other rootfs needs the mount point.
 
 config STANDALONE
 	bool "Select only drivers that don't need compile-time external firmware"
diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc..06057d7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2417,7 +2417,21 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 	err = -EBUSY;
 	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
 	    path->mnt->mnt_root == path->dentry)
+	{
+		if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT) &&
+		    !strcmp(path->mnt->mnt_sb->s_type->name, "devtmpfs"))
+		{
+			/* Debian's kernel config enables DEVTMPFS_MOUNT, then
+			   its initramfs setup script tries to mount devtmpfs
+			   again, and if the second mount-over-itself fails
+			   the script overmounts a tmpfs on /dev to hide the
+			   existing contents, then boot fails with empty /dev. */
+			printk(KERN_WARNING "Debian bug workaround for devtmpfs overmount.");
+
+			err = 0;
+		}
 		goto unlock;
+	}
 
 	err = -EINVAL;
 	if (d_is_symlink(newmnt->mnt.mnt_root))
diff --git a/init/main.c b/init/main.c
index 0ee9c686..0d8e5ec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1065,12 +1065,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
-	/* Open the /dev/console on the rootfs, this should never fail */
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
-
-	(void) sys_dup(0);
-	(void) sys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
@@ -1082,8 +1076,17 @@ static noinline void __init kernel_init_freeable(void)
 	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
+	} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
+		sys_mkdir("/dev", 0755);
+		devtmpfs_mount("/dev");
 	}
 
+	/* Open the /dev/console on the rootfs, this should never fail */
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		pr_err("Warning: unable to open an initial console.\n");
+	(void) sys_dup(0);
+	(void) sys_dup(0);
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the
