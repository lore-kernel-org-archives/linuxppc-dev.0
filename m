Message-ID: <01139FC052A0D411900B00508B9535FC015E9E43@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: "linuxppc-dev@lists. linuxppc. org (E-mail)" <linuxppc-dev@lists.linuxppc.org>
Subject: Why the following codes in do_basic_setup() are always executed ?
Date: Wed, 11 Apr 2001 10:56:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,
	Currently, I am porting HardHat linux 2.2.14 to my platform based on ppc823.
The bootloader is ppcboot(0.8.3), and I use ramdisk. But when I boot linux on my board,
 the following codes in do_basic_setup() are always executed and my board halt.

#ifdef CONFIG_BLK_DEV_INITRD
	root_mountflags = real_root_mountflags;
	if (mount_initrd && ROOT_DEV != real_root_dev
	    && MAJOR(ROOT_DEV) == RAMDISK_MAJOR && MINOR(ROOT_DEV) == 0) {
		int error;
		int i, pid;

		pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
		if (pid>0)
			while (pid != wait(&i));
		if (MAJOR(real_root_dev) != RAMDISK_MAJOR
		     || MINOR(real_root_dev) != 0) {
			error = change_root(real_root_dev,"/initrd");
			if (error)
				printk(KERN_ERR "Change root to /initrd: "
				    "error %d\n",error);
		}
	}
#endif

I know the halt is caused by this line "kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD)",
because there is no "/linuxrc" in my ramdisk. I just wonder why the above codes are executed.
Such codes are in do_basic_setup() in /init/main.c, and after that we will execute "/sbin/init" or
just "/bin/sash", which are the usual ones.

BRs
Rolf Liu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
