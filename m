Message-ID: <3A676DC6.FD21D5D8@matrox.com>
Date: Thu, 18 Jan 2001 17:27:18 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I finally figured out a small part of the problem...  My initrd_start
was overwritten (to 0) by the function start_kernel in init/main.c :

#ifdef CONFIG_BLK_DEV_INITRD
	if (initrd_start && !initrd_below_start_ok &&
			initrd_start < min_low_pfn << PAGE_SHIFT) {
		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
		initrd_start = 0;
	}
#endif

I don't really understand this function... Why would my initrd be
overwritten?!?  Anyways, I commented it out to see what would happen.
This time, it opened the root device (in function mount_root()) but
didn't go very far:

	sb = get_super(ROOT_DEV);
	if (sb) {
		fs_type = sb->s_type;
		goto mount_it;
	}
	...
	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));


sb is NULL.  Damn..  What now?  Is it possible that my initrd has been
erased like the kernel told me?  What else could it be?

I was also wondering if I loaded the kernel correctly.  I put my
zImage+initrd (zvmlinux.initrd) at address 0 of ram.  Since I compiled
the kernel with debug symbols, it takes a few Megs... Could it be too
large for it's own good?  Maybe somebody knows about the answer to that
one!

By the way, I forgot to mention it in the first email but I'm using
linux-2.4.0-test2.


Sébastien Côté

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
