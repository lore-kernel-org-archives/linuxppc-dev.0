Date: Fri, 7 Jul 2000 10:22:40 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <qpvgyihp9w.fsf@erbium.epact.se>
Message-ID: <Pine.HPX.4.10.10007070959030.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 7 Jul 2000, Michael Lundkvist wrote:

>
> Gabriel Paubert <paubert@iram.es> writes:
>
> > Ok, never had any problems with SCSI since DMA always gets the byte order
> > right ;-)
> >
>
> It wasn't my decision to go with IDE...

Well, it may be better since right now I'm stuck with 8 bit old SCSI
drives and running extremely short on disk space.

>
> >
> > Where is and what is Bugboot ?
> >
>
> It's a bootloader for flashed kernels. Written by Matt Porter from Motorola.
> http://members.home.net/mmporter/linux/

Ok...

> Could I do the same thing with your bootloader?
>
> I would like to have a bootloader that can read from disk so that it
> is easy to replace the kernel.

Mine cannot read from disk (for now). With OF it would be easy to call
methods to read from a disk, but with PPCBUG you woule have either:

- to use firmware specific calls (provided the interface is supported) and
you don't switch the MMU on (even mapped 1:1) since it does not work
whatever the documentation claims (actually I think I know where the bug
is in PPCBUG).

- to write your own drivers for the bootloader (might be quite simple
actually, since performance is not a concern, and you only need to read).
But then you have to know where to stop (include readonly filesystems ?).

So for now the (compressed) kernel is always in the initially loaded
image (very handy for network boots which is what I mostly use).

> > Quite a lot. A complete bootloader, drivers for VME and many small patches
> > in the arch/ppc/kernel subtree. A diffstat of both patches gives:
> >
> >  73 files changed, 19880 insertions, 478 deletions
> >
>
> OK. Then I'd like to try it. My initial tests with 2.2.17pre10 didn't
> turn out well.

Note that thiss was for 2.2.12, as I said I've not booted 2.2.16 so I did
not put the patches on my ftp site (that's the only QA I do :-)).

> I ran the Debian 2.2.12 (with Motorola SROM bug patch) on a 2300 with
> a fair bit of compiling and it was stable. The same kernel on an 2400
> was unstable during compiles.

Ok, since the main difference is the host bridge. I would rather suspect a
bad bit setting which results in coherency problems, or bad
memory/whatever (did you try several MVME2400 to see whether it was
reproducible ?)

> I'll give your 2.4 a try. I need to get atleast one more PMC disk so I
> can have one stable and one unstable evironment.

I usually netboot 2 different versions of the kernel (and I select the
kernel to boot with a symlink on the server to avoid editing
/etc/dhcpd.conf and restarting dhcpd). The rest of the system is
identical.

> On an unrelated subject. I would like to have a Linux-board as SYSCON
> on the VME bus that is able to generate a reset on the bus but doesn't
> listen to it. Have you got any idea if it would be possible to modify
> a MVME-card that way? To me it looks like it would be possible to
> disconnect the signal from the Universe-bridge.

It should be but I don't know how. I implemented the capability to reset
the VME bus in my Universe driver and tested it on an Pentium VME board
but right now it is disabled since the driver is compiled by default with
#define SUICIDAL_VME_RESET.

Trying to modify such a multilayer board with connections to a BGA is a
daunting prospect. The VME bus buffers might be te right place to do it
since they should be more or less accessible (with extreme care).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
