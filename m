Message-ID: <8177F6132F4D7F43AD9E832D5AAAEE240602BF1E@il02exm04.corp.mot.com>
From: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: Kernel Panic in 2.2.x
Date: Fri, 30 May 2003 17:47:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With respect to the Issue of the PANIC, I have made a
simple correction in the Kernel procfs Support.  The
correction/change was to add a NULL Check to the
KSTK_ Macros (this fix is already in the 2.4.x Kernel).

The root cause was as I indicated,  access to the /proc
file system by a "ps" command, and the execution of a
Module Load Attempt (via a modprobe) by the Kernel.  The
TSS Registers Pointer for the Process/Thread executing
the modprobe being NULL.

In anycase, I am happy with the small fix, and will be
testing it over the weekend with the failure scenario we
were able to produce the Panic.





> -----Original Message-----
> From: Hawkins Jeffrey-CJH016 [mailto:Jeffrey.F.Hawkins@Motorola.com]
> Sent: Friday, May 30, 2003 11:11 AM
> To: linuxppc-dev@lists.linuxppc.org
> Subject: RE: Kernel Panic in 2.2.x
>
>
>
> Follow-up to my Kernel Panic Investigations, it appears
> that the Process as having "tss->regs" as NULL, during
> the execution of "ps" command, is a modprobe being performed
> by the Kernel for attempting to Load net-pf-10 Module
> (IPV6 Packet Filter).
>
>
>
>
>
>
> > -----Original Message-----
> > From: Hawkins Jeffrey-CJH016
> > Sent: Thursday, May 29, 2003 2:05 PM
> > To: linuxppc-dev@lists.linuxppc.org
> > Subject: Kernel Panic in 2.2.x
> >
> >
> >
> > Request for Info/Feedbak....
> >
> > With a Standard 2.2.17 Kernel, with some Proprietary
> Hardware Drivers,
> > we intermittently encounter a Kernel Panic due to Reference
> to a NULL
> > Pointer.  I have isolated the NULL Reference to the
> "procfs" Support.
> > In particular, in "array.c", the "get_stat" function, with usage
> > of the KSTK_EIP and KSTK_ESP Macros.  The NULL access is due to
> > the "regs" pointer in the "tss" structure being NULL.  My theory
> > is there is a race condition with procfs access and a process
> > terminating at the same time.  At the time of a our failure, a
> > Process is terminating (a Daemon Restart induced by our
> Application),
> > as well as,  one of our Application's is performing Raw Socket
> > I/O for Network Monitoring -- the strange thing is that if we
> > remove the Raw Socket Functionality we can not get the Failure
> > to occur.
> >
> > I noticed in the 2.4.x Tree the KSTK_ Macros have been modified
> > to check for NULL. Does anybody know if this was the reason for
> > the change.  Looking at the Kernel List Archives, it seems the
> > change was for "init" issues in "BootX"?
> >
> > Also, reviewing the Kernel List Archives, I noticed in 2.2.x
> > there was a race condition with "procfs" access, but related
> > to the MM Stats/Params of a Process, not the TSS Registers.
> >
> > Anybody have any insight into this Issue?
> >
> > Also, insight into how the tss->regs is utilized and updated
> > would be appreciated.  I have started reviewing the PPC Specific
> > Kernel Code to get this info on the Task Switching Implementation,
> > but I thought maybe someone here could give me some insight, or
> > direct me to a Book/URL/Reference that has this type of information.
> >
> > With respect to responses, please don't say go to the 2.4.x Kernel
> > as a solution for the Issue....:)  This is in our plans, but
> > at this time,
> > we are locked into the 2.2 Kernel due to Proprietary Hardware Driver
> > Support.  For the short term, I just want to identify the true root
> > cause (to appease the Management Gods), and to possibly implement
> > a short term fix until we migrate to the 2.4.x or 2.6 Kernel.
> >
> >
> > Jeff
> >
> >
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
