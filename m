Message-ID: <3AC5146D.CB770D1B@mvista.com>
Date: Fri, 30 Mar 2001 16:19:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com> <20010330175204.A881@dyn-52-73.matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sébastien Côté wrote:

> On 2001.03.28 16:10:33 -0500 Mark A. Greer wrote:
> >
> > That version of the kernel does have problems.  Get the latest
> > linuxppc_2_5
> > source and try that.  I haven't tested the last couple weeks but before
> > then,
> > it was very solid.  Sandpoint support is in it.
>
> I tried that new version and it's a bit more difficult to get running than
> the one from MontaVista (remeber that I have a board -similar- to
> Sandpoint).  The function time_init() was giving me problems so I decided
> to take it out for the moment, but now I'm stuck in calibrate_delay()
> (jiffies doesn't increase), so I guess it was a bad idea to take
> time_init() out.

Hmmm, what sort of problems with time_init()?  Are you setting
ppc_md.time_init to todc_time_init and setting todc_info, etc correctly?  Is
your RTC a m48txx or mc146818?

If you find any bugs there, be sure to let me know.

> Anyway, I have another question.  In the header from
> arch/ppc/kernel/sandpoint_setup.c,I see the following comment:
>  * The firmware on the sandpoint is called DINK (not my acronym :).  This
> port
>  * depends on DINK to do some basic initialization (e.g., initialize the
> memory
>  * ctlr) and to ensure that the processor is using MAP B (CHRP map).
>
> Since I don't really have a Sandpoint, and I don't have the DINK which
> comes with it, I guess I will run into trouble.
> Is there a place where I could find info on what I should do I exactly as
> far as initialization goes?!?

No, I don't know of any place you can go that would tell you what you have to
init.  You could look at some of the open source firmwares that are out there
which should give you a good idea.  If you have a JTAG probe, you can put it
on a board similar to yours with known good firmware and look the host-bridge
regs, etc to how it sets everything up.  I dunno...

You will definitely need to have the PCI arbiter, power mgmt, memory
controller, and certain bits in HID0 and L2CR (if you have an L2 ctlr on your
processor) all set up correctly.  Maybe some board regs too.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
