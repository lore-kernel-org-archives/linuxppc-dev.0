Message-ID: <369FF829.9BF97E11@phx.mcd.mot.com>
Date: Fri, 15 Jan 1999 19:23:38 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think this is the same problem I was seeing.  This machine is also the

known as
the Utah.  I fixed this in arch/ppc/boot/misc.c.  Here is the diff:



454c454
<       if (( (unsigned long)zimage_start <= 0x01000000 ) &&
initrd_start)
---
>       if ( (unsigned long)zimage_start <= 0x01000000 )

Johnnie

Michael Meissner wrote:

> On Fri, Jan 15, 1999 at 04:28:55PM +0100, Alois Fertl wrote:
> > Cort Dougan wrote:
> > >
> > > It looks like your zImage is being stomped on before it can be
> > > decompressed.  I'll take a look at the boot loader code and see
why it
> > > isn't adjusting your free ram section.  You might want to try
changing to
> > > load address in the PPCBug to be near the top of memory in the
mean time.
> > I guess this system is running "PowerPC Open Firmware". You can
change the
> > load address via the firmware menu:
> >   Administrative Options...
> >     ---> Modify the Configuration Settings...
> >           ---> Edit Configuration Variables
> > step to the parameter "load-base" and enter a new value (decimal).
> > One other problem is the this firmware version obviously does not
provide
> > residual data. So Linux will probably not find the PCI devices
correctly.
>
> I tried setting the load-base to various values, and all of them
caused dumps
> within the monitor (I tried 10 meg, 64 meg, 3 meg, 120 meg, and even 4

meg + 4
> all to no avail).
>
> Also, Gary Thomas's 2.0.32 kernel seemed to have no problem in sizing
memory,
> so I presume it is able to pick up the residual data.
>
> > >
> > > }       loaded at:     00400400 00415FD0
> > > }       relocated to:  00600000 00615BD0
> > > }       zimage at:     0040A400 0049A889
> > > }       avail ram:     00400000 00600000
> > > }
> > > }       Linux/PPC load: console=tty0 console=ttyS0,9600n8
root=/dev/sda2 mem=127M
> > > }       Uncompressing Linux...done.
> > > }       Now booting the kernel
>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
