Subject: Re: Build issues with 2.6.0-test3
From: Gary Thomas <gary@mlbassoc.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030812154642.GL807@ip68-0-152-218.tc.ph.cox.net>
References: <3F33BC10.8060407@imc-berlin.de>
	 <3F33EADE.4010908@embeddededge.com> <3F38DEC4.8050708@imc-berlin.de>
	 <1060696614.31273.419.camel@hermes>
	 <20030812152503.GK807@ip68-0-152-218.tc.ph.cox.net>
	 <1060702819.31273.534.camel@hermes>
	 <20030812154642.GL807@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1060715616.31273.759.camel@hermes>
Mime-Version: 1.0
Date: 12 Aug 2003 13:13:37 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-08-12 at 09:46, Tom Rini wrote:
> On Tue, Aug 12, 2003 at 09:40:20AM -0600, Gary Thomas wrote:
> > On Tue, 2003-08-12 at 09:25, Tom Rini wrote:
> > > On Tue, Aug 12, 2003 at 07:56:55AM -0600, Gary Thomas wrote:
> > >
> > > > * How best to handle optional support?  One of the patches fixes
> > > >   a problem of a missing system call (sys_pciconfig_iobase).  In
> > > >   this case, the platform I was building for has no PCI, so it's
> > > >   not configured in.  The way I fixed it was to conditionalize
> > > >   the syscall table.  An alternate way would be to have a module
> > > >   which is compiled if CONFIG_PCI is *not* set (or alternately
> > > >   have arch/ppc/kernel/pci.c always be compiled and export the
> > > >   appropriate functions that just return -ENOSYS).  Comments?
> > >
> > > 'cond_syscall' is _supposed_ to work here.  But in this one case, it
> > > does not.  I've tried tracking this down a little bit, and the 'weak'
> > > asm bits make it as far as the pci.s file, but not the pci.o.  And to
> > > make it all the more odd, if I threw the cond_syscall into a file in
> > > kernel/ (just to try it out), it works.
> >
> > Which "pci.c"?  The one in arch/ppc/kernel isn't even being compiled
> > in this case.  Are you saying that it should (and behave differently
> > when CONFIG_PCI isn't set)?
>
> Too early in the AM.  I meant arch/ppc/kernel/syscall.c (which is being
> compiled) not arch/ppc/kernel/pci.c

I don't understand why either.  I did note that this construct is not
used in any other platform/architecture code.  For now, I'm using this
change (instead of the change to misc.S)

Index: arch/ppc/kernel/syscalls.c
===================================================================
RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/kernel/syscalls.c,v
retrieving revision 1.1
diff -u -5 -p -r1.1 syscalls.c
--- arch/ppc/kernel/syscalls.c	12 Aug 2003 12:18:16 -0000	1.1
+++ arch/ppc/kernel/syscalls.c	12 Aug 2003 19:07:58 -0000
@@ -37,10 +37,12 @@
 #include <linux/unistd.h>

 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
+#undef cond_syscall
+#define cond_syscall(x) asmlinkage long x() __attribute__((weak)); asmlinkage long x() { return -ENOSYS; }

 void
 check_bugs(void)
 {
 }

> > > > Index: arch/ppc/8260_io/uart.c
> > > > ===================================================================
> > > > RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/8260_io/uart.c,v
> > > > retrieving revision 1.1
> > > > diff -u -5 -p -r1.1 uart.c
> > > > --- arch/ppc/8260_io/uart.c	12 Aug 2003 12:18:15 -0000	1.1
> > > > +++ arch/ppc/8260_io/uart.c	12 Aug 2003 13:30:40 -0000
> > > > @@ -2389,11 +2389,11 @@ void kgdb_map_scc(void)
> > > >  	up->smc_mrblr = RX_BUF_SIZE;		/* receive buffer length */
> > > >  	up->smc_maxidl = RX_BUF_SIZE;
> > > >  }
> > > >  #endif
> > > >
> > > > -static kdev_t serial_console_device(struct console *c)
> > > > +static struct tty_driver *serial_console_device(struct console *c, int *index)
> > > >  {
> > > >  	*index = c->index;
> > > >  	return serial_driver;
> > > >  }
> > >
> > > After looking at the similar code in drivers/serial, I don't think this
> > > is sufficient.  But I didn't dig too far into seee what c->data was
> > > there.
> >
> > It seems to be [virtually] the same as in
> >   arch/ppc/8xx_io/uart.c
> >   drivers/char/amiserial.c
> >   drivers/char/serial_tx3912.c
> >   drivers/char/sh-sci.c
> >   drivers/macintosh/macserial.c
>
> Those are all of the obsolete, and probably broken drivers.
> drivers/serial is where all of the 'new' and working serial drivers are.
> If you've got some time, the 8260 serial driver really should be
> re-written as a driver inside of drivers/serial. :)

I'll look into this.  Can you suggest a good driver to use as guidance?

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
