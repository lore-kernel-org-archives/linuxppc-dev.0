Message-ID: <3A6794B1.D0B70C1C@mvista.com>
Date: Thu, 18 Jan 2001 18:13:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Sébastien Côté <scote1@matrox.com>
CC: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Where did you get this version of that kernel?  From the MontaVista CDK or from
the website?  If from the website, when did you get it?

Try this (if its not already done).  Go into arch/ppc/boot/head.S and add the
following lines after the set up of r6 to hold the cmd_line.

        /* r4,r5 have initrd_start, size */
        lis     r2,initrd_start@h
        ori     r2,r2,initrd_start@l
        lwz     r4,0(r2)
        lis     r2,initrd_end@h
        ori     r2,r2,initrd_end@l
        lwz     r5,0(r2)

Go into arch/ppc/kernel/sandpoint_setup.c.  Find sandpoint_setup_arch() and add
something like (again, if its not already there).

     #ifdef CONFIG_BLK_DEV_INITRD
             if (initrd_start)
                     ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);

       #endif

Try it now and see if that helps...

Mark
--


Sébastien Côté wrote:

> I finally figured out a small part of the problem...  My initrd_start
> was overwritten (to 0) by the function start_kernel in init/main.c :
>
> #ifdef CONFIG_BLK_DEV_INITRD
>         if (initrd_start && !initrd_below_start_ok &&
>                         initrd_start < min_low_pfn << PAGE_SHIFT) {
>                 printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
>                     "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
>                 initrd_start = 0;
>         }
> #endif
>
> I don't really understand this function... Why would my initrd be
> overwritten?!?  Anyways, I commented it out to see what would happen.
> This time, it opened the root device (in function mount_root()) but
> didn't go very far:
>
>         sb = get_super(ROOT_DEV);
>         if (sb) {
>                 fs_type = sb->s_type;
>                 goto mount_it;
>         }
>         ...
>         panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
>
> sb is NULL.  Damn..  What now?  Is it possible that my initrd has been
> erased like the kernel told me?  What else could it be?
>
> I was also wondering if I loaded the kernel correctly.  I put my
> zImage+initrd (zvmlinux.initrd) at address 0 of ram.  Since I compiled
> the kernel with debug symbols, it takes a few Megs... Could it be too
> large for it's own good?  Maybe somebody knows about the answer to that
> one!
>
> By the way, I forgot to mention it in the first email but I'm using
> linux-2.4.0-test2.
>
> Sébastien Côté
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
