MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Linux kernel panics and core dumps.
Date: Wed, 9 Apr 2003 12:19:35 -0400
Message-ID: <3D296C067098F149B11A8F4FC37C054685D89F@EXVS1.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Arun Dharankar" <ADharankar@attbi.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Boy, it took me a while to dig this out of my notes.

> David, thanks for your inputs!
>
> The working Linux kernel version for me is 2.4.20. After applying
> the patch and following the steps you outlined, the kernel boots
> ok. However,  just as the user processes startup, there are kernel
> exceptions for all the processes, and the system eventually panics.
>
> The nearest patch for Linux kernel I could get from MCLX site is
> for 2.4.17. Even so, the patch failed only for init/main.c and
> kernel/panic.c. Manually making the changes did not seem to
> need anything significant.
>
> I have not gone through the patch completely and have only some
> understanding of it. So didn't understand what you meant by "The
> code in do_init_bootmem() is trying to work in bytes, not in frames.".
> Could you elaborate, please? May be this is where I have done
> the changes correctly.

This is the proper way to do the call to crash_init:

#if defined(CONFIG_MCL_COREDUMP)
	crash_init((u_long)phys_to_virt(start),
		   (u_long)phys_to_virt(start + (33 * PAGE_SIZE)),
		   (u_long)phys_to_virt(start + (33 + crash_pages)*PAGE_SIZE));
#endif

Well, OK, those "33" literals in the code aren't so great, but
there are limits to how much cleanup I was able to do.

Also, in panic.c, these lines:

#ifdef CONFIG_MCL_COREDUMP
	smp_call_function((void*)smp_crash_funnel_cpu,0,0,0);
	crash_save_current_state(current);
#endif

should come after the invocation of "notifier_call_chain", if
you have any sort of watchdog timer on your system.  We did, and
the watchdog would expire while the crash was being generated,
since it was the call chain that shut down the watchdog.

  -- David Wright, InfiniSwitch Corp.


>
> Best regards,
> -Arun.
>
> On Tuesday 08 April 2003 12:20 pm, Wright, David wrote:
> > I looked at the SGI project, but it wasn't suitable for our
> > platform, as we didn't have the right sort of disk setup.
> >
> > I ported the MCLX code to a 405-based platform.  The code as
> > originally distributed had a few bugs in it, but I don't think
> > they ever fixed the bugs -- I fed changes back to them, and those
> > changes may have made it to IBM.  Or at least they told me IBM
> > was interested in the project.
> >
> > If you do use their code, ignore the program that uncompresses
> > the crash dumps -- as implemented, it's incredibly slow, and
> > although that can be fixed, it's pointless, since crash can read
> > the compressed dumps just fine (and can't read the uncompressed
> > ones, just as a final irony).
> >
> > I don't have a complete list of the changes I needed to make, but
> > here are a few:
> >
> > Makefile didn't specify compiling crash.c
> > crash.c (machine-specific) specified "regs" instead of "gprs"; also
> >   specified tss.ksp instead of thread.ksp; also must #define
> >   PFN_PHYS() itself.
> > The code in do_init_bootmem() is trying to work in bytes, not in
> >   frames.
> >
> > Anyway, once I got these various problems ironed out, plus a few
> > in crash(1), the facility worked fine.  The main problem you're
> > apt to run into is having enough physical memory to run your
> > system, hold the dump, and copy the dump from RAM into some file.
> > NFS can be very useful here.
> >
> > The dump facility did prove to be quite useful and we did use it
> > on live systems to track down problems.  One thing to watch out
> > for is diags that scrub memory, since they'll scrub out your dump,
> > too.
> >
> > > -----Original Message-----
> > > From: Arun Dharankar [mailto:ADharankar@attbi.com]
> > > Sent: Tuesday, April 08, 2003 11:58 AM
> > > To: linuxppc-embedded@lists.linuxppc.org
> > > Subject: Linux kernel panics and core dumps.
> > >
> > > On x86 architectures there seem to be at least two ways of
> > > producing  Linux kernel panic dumps. These projects are
> > > hosted at
> > >
> > >     "http://lkcd.sourceforge.net/" (originated in SGI), and
> > >
> > >     "http://oss.missioncriticallinux.com/projects/mcore/"
> > >         (originated in MCLX).
> > >
> > > Of the two, the second one seems to work quite well on x86
> > > PCs. I dont know how much of it is actively supported on
> > > PowerPCs. So, the first question is:
> > >
> > >     Has anyone tried this on PowerPC, specifically Linux
> > >     kernel versions 2.4.x? The code for PowerPC seems to
> > >     be there, but the Makefiles dont seem to be up-to-date,
> > >     and could be broken.
> > >
> > > Further more, this same project has some documentation
> > > which has a good discussion on different approaches to Linux
> > > kernel memory dumps. One item in this discussion is about
> > > the BIOS/bootloader support.
> > >
> > > Essentially, if PPCBoot/U-Boot was to recognize the Linux
> > > kernel memory layout, a much more reliable scheme could
> > > be implemented. For example, under all panic or hang
> > > conditions (watchdog), the system could just be rebooted.
> > > During the startup, PPCBoot/U-Boot along with Linux, could
> > > save the Linux kernel dump reliably. MCLX scheme seems
> > > to follow this approach, but does not rely on the bootloader.
> > >
> > >   Has anyone investigated this? Or anything already done,
> > >   and cares to share it? Any thoughts on this?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
