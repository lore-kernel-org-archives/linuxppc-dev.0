Message-ID: <3A6DF184.D160C4CF@mvista.com>
Date: Tue, 23 Jan 2001 14:03:00 -0700
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
MIME-Version: 1.0
To: Sébastien Côté <scote1@matrox.com>
CC: mgreer@mvista.com,
        LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <3A6794B1.D0B70C1C@mvista.com> <3A6854DD.A370D56B@matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'd had a similar problem with a 2.5 kernel from late nov
or early dec.  I had to comment out the follow code from
init/main.c::do_basic_setup() to get it working.  I also
had to apply the head.S and <board>_setup.c file as
already mentioned in this thread.  I also played with devfs
support but don't remember if either enabled or disabled was
required.  I never followed up on this, but I suspect this
is a bad kludge and that there is a better way to solve this
problem.  Let me know if this works for you.

    718 #if 0
    719 #ifdef CONFIG_BLK_DEV_INITRD
    720         root_mountflags = real_root_mountflags;
    721         if (mount_initrd && ROOT_DEV != real_root_dev
    722             && MAJOR(ROOT_DEV) == RAMDISK_MAJOR && MINOR(ROOT_DEV) == 0) {
    723                 int error;
    724                 int i, pid;
    725
    726                 pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
    727                 if (pid>0)
    728                         while (pid != wait(&i));
    729                 if (MAJOR(real_root_dev) != RAMDISK_MAJOR
    730                      || MINOR(real_root_dev) != 0) {
    731                         error = change_root(real_root_dev,"/initrd");
    732                         if (error)
    733                                 printk(KERN_ERR "Change root to /initrd: "
    734                                     "error %d\n",error);
    735                 }
    736         }
    737 #endif
    738 #endif



Sébastien Côté wrote:
>
> "Mark A. Greer" wrote:
> >
> > Where did you get this version of that kernel?  From the MontaVista CDK or from
> > the website?  If from the website, when did you get it?
>
> I'm pretty sure it came from the web..  I think it was downloaded at the
> end of November but I can't be sure...  I could probably answer this
> next week.
>
> > Try this (if its not already done).  Go into arch/ppc/boot/head.S and add the
> > following lines after the set up of r6 to hold the cmd_line.
> >
> >         /* r4,r5 have initrd_start, size */
> >         lis     r2,initrd_start@h
> >         ori     r2,r2,initrd_start@l
> >         lwz     r4,0(r2)
> >         lis     r2,initrd_end@h
> >         ori     r2,r2,initrd_end@l
> >         lwz     r5,0(r2)
> >
> > Go into arch/ppc/kernel/sandpoint_setup.c.  Find sandpoint_setup_arch() and add
> > something like (again, if its not already there).
> >
> >      #ifdef CONFIG_BLK_DEV_INITRD
> >              if (initrd_start)
> >                      ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
> >
> >        #endif
> >
>
> I tried that patch that I found in the list archives but it didn't make
> any difference.
>
> Sébastien Côté
>

--
Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
