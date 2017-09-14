Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtCbk1JbwzDrKx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 19:17:21 +1000 (AEST)
Subject: Re: [PATCH v3] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
To: Rob Landley <rob@landley.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, mhocko@suse.com,
 peterz@infradead.org, viresh.kumar@linaro.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, mingo@kernel.org,
 lokeshvutla@ti.com, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linux-input@vger.kernel.org, thomas.lendacky@amd.com, lauraa@codeaurora.org,
 keescook@chromium.org, Jiri Kosina <jikos@kernel.org>, rostedt@goodmis.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
 <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
 <87r2z86ykt.fsf@concordia.ellerman.id.au>
 <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3ba5ddc7-d1a2-7f54-0a26-0752f3975226@c-s.fr>
Date: Thu, 14 Sep 2017 11:17:16 +0200
MIME-Version: 1.0
In-Reply-To: <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 14/09/2017 à 01:51, Rob Landley a écrit :
> From: Rob Landley <rob@landley.net>
> 
> Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
> /dev/console open after devtmpfs mount.
> 
> Add workaround for Debian bug that was copied by Ubuntu.

Is that a bug only for Debian ? Why ?
Why should a Debian bug be fixed by a workaround in the mainline kernel ?

> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
> v2 discussion: http://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html
> 
>   drivers/base/Kconfig |   14 ++++----------
>   fs/namespace.c       |   14 ++++++++++++++
>   init/main.c          |   15 +++++++++------
>   3 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index f046d21..97352d4 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -48,16 +48,10 @@ config DEVTMPFS_MOUNT
>   	bool "Automount devtmpfs at /dev, after the kernel mounted the rootfs"
>   	depends on DEVTMPFS
>   	help
> -	  This will instruct the kernel to automatically mount the
> -	  devtmpfs filesystem at /dev, directly after the kernel has
> -	  mounted the root filesystem. The behavior can be overridden
> -	  with the commandline parameter: devtmpfs.mount=0|1.
> -	  This option does not affect initramfs based booting, here
> -	  the devtmpfs filesystem always needs to be mounted manually
> -	  after the rootfs is mounted.
> -	  With this option enabled, it allows to bring up a system in
> -	  rescue mode with init=/bin/sh, even when the /dev directory
> -	  on the rootfs is completely empty.
> +	  Automatically mount devtmpfs at /dev on the root filesystem, which
> +	  lets the system to come up in rescue mode with [rd]init=/bin/sh.
> +	  Override with devtmpfs.mount=0 on the commandline. Initramfs can
> +	  create a /dev dir as needed, other rootfs needs the mount point.

Why modifying the initial text ?
Why talking about rescue mode only, whereas this feature mainly concerns 
the standard mode.

>   
>   config STANDALONE
>   	bool "Select only drivers that don't need compile-time external firmware"
> diff --git a/fs/namespace.c b/fs/namespace.c
> index f8893dc..06057d7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2417,7 +2417,21 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
>   	err = -EBUSY;
>   	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
>   	    path->mnt->mnt_root == path->dentry)
> +	{
> +		if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT) &&
> +		    !strcmp(path->mnt->mnt_sb->s_type->name, "devtmpfs"))
> +		{
> +			/* Debian's kernel config enables DEVTMPFS_MOUNT, then
> +			   its initramfs setup script tries to mount devtmpfs
> +			   again, and if the second mount-over-itself fails
> +			   the script overmounts a tmpfs on /dev to hide the
> +			   existing contents, then boot fails with empty /dev. */

Does it matter for the kernel code what Debian's kernel config does ?

> +			printk(KERN_WARNING "Debian bug workaround for devtmpfs overmount.");

Is this log message worth it when this modification goes in mainline 
kernel ?

If so, pr_err() should be used instead.

> +
> +			err = 0;
> +		}
>   		goto unlock;
> +	}
>   
>   	err = -EINVAL;
>   	if (d_is_symlink(newmnt->mnt.mnt_root))
> diff --git a/init/main.c b/init/main.c
> index 0ee9c686..0d8e5ec 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1065,12 +1065,6 @@ static noinline void __init kernel_init_freeable(void)
>   
>   	do_basic_setup();
>   
> -	/* Open the /dev/console on the rootfs, this should never fail */
> -	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> -		pr_err("Warning: unable to open an initial console.\n");
> -
> -	(void) sys_dup(0);
> -	(void) sys_dup(0);
>   	/*
>   	 * check if there is an early userspace init.  If yes, let it do all
>   	 * the work
> @@ -1082,8 +1076,17 @@ static noinline void __init kernel_init_freeable(void)
>   	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
>   		ramdisk_execute_command = NULL;
>   		prepare_namespace();
> +	} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
> +		sys_mkdir("/dev", 0755);

Why not, but couldn't we also expect the initramfs to already contains 
that mountpoint ?

> +		devtmpfs_mount("/dev");
>   	}
>   
> +	/* Open the /dev/console on the rootfs, this should never fail */
> +	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> +		pr_err("Warning: unable to open an initial console.\n");
> +	(void) sys_dup(0);
> +	(void) sys_dup(0);
> +
>   	/*
>   	 * Ok, we have completed the initial bootup, and
>   	 * we're essentially up and running. Get rid of the
> 


Christophe
