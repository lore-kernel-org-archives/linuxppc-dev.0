Message-ID: <389AF42D.C62639B0@email.sps.mot.com>
Date: Fri, 04 Feb 2000 09:45:49 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Clinton Lam <clinton@AudeSi.com>,
        "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 booting problem
References: <2044A9F15B38D211A89900104BD36C02381B4E@thebank.audesi.com> <0002031748410T.00733@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can either have the TB/DEC run from the oscclk/4, or from the
system clock/16.  I would assume Linux would use oscclk/4, or 8kHz,
and assume that value for its calculations.  You'll have to change
the funtion that calculates the timeout value.

Alan Mimms wrote:
>
> Sounds like you need to turn on some prescaling for the timebase/decrementer.
> If you can't find the required stuff, maybe I can help, but I'm not all THAT
> familiar with these cockamamie 8xx processors myself.  Perhaps someone else?
>
> a
>
> On
> Thu, 03 Feb 2000, Clinton Lam wrote: > Alan,
> >
> > After another 5 hours of debugging, I've narrowed the problem to the
> > decrement counter interrupt. For some unknown reasons, the interrupt never
> > gets clear. The system just keep looping and waiting for this interrupt to
> > be cleared.
> >
> > In the file time.c (this is the file where all of the timer interrupt code
> > is), it mentions something about making an assumption that MBX board is
> > running off a 32.768KHz crystal. But the Touchstone board has a 3.57 MHz
> > crystal. So, something has to be changed to make this work! Anyone has any
> > ideas???
> >
> > BTW, the network bootloader is modified from a comercial OS. We use it to
> > jump start our project. I don't think we can share the code with everyone,
> > sorry...
> >
> > Regards
> > Clinton Lam
> >
> > > -----Original Message-----
> > > From: Alan Mimms [mailto:alan@packetengines.com]
> > > Sent: Thursday, February 03, 2000 10:03 AM
> > > To: Clinton Lam; Linuxppc-Embedded (E-mail)
> > > Subject: Re: mpc8xx-2.2.13 booting problem
> > >
> > >
> > > Clinton,
> > >
> > > This function enables interrupts.  Some bit of hardware is leaving an
> > > interrupt asserted permanently, or else your port or your
> > > driver for some bit
> > > of hardware is not turning off the interrupt request by
> > > servicing the interrupt
> > > properly.  Or, possibly, your 8xx interrupt management is screwed up.
> > >
> > > One of those explanations is it, just about guaranteed...
> > >
> > > Luck.
> > > a
> > >
> > > On Thu, 03 Feb 2000, Clinton Lam wrote:
> > > > Hi,
> > > >
> > > > I am new to the embeded linux. I am trying to port
> > > mpc8xx-2.2.13 kernel to
> > > > our custom board, called Touchstone. It is a reference
> > > design based on
> > > > mpc823, which has 32 Mbyte of SDRAM, and 4 Mbyte of flash.
> > > >
> > > > So far, I've developed a network bootloader, which
> > > downloads the zImage to
> > > > the target. I am at the stage where I can unzip the kernel
> > > image to address
> > > > location 0x0, and jump to it. Then, inside the routine
> > > "start_kernel", I am
> > > > able to get the console up and have the linux banner
> > > partially displayed at
> > > > the cosole.
> > > >
> > > > However, after some more kernel initialization in
> > > "start_kernel", the
> > > > program stuck in a routine called "sti()". I've debugged
> > > through this
> > > > routine (it is an assembly routine) , and it seems that it
> > > is looping
> > > > forever inside the routine. I know that the routine is
> > > trying to set the EE
> > > > bit in MSR, and also doing some thing with
> > > ppc_n_lost_interrupts, which I
> > > > don't quite understand.
> > > >
> > > > Does anyone have any idea what is wrong with my port? Can
> > > someone explain to
> > > > me what is the purpose of this "sti()" routine, what are
> > > the possible cause
> > > > for it to hang?
> > > >
> > > > Your response is greately appreciated!
> > > >
> > > > Thanks in advance.
> > > >
> > > > Clinton Lam
> > --
> > Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
> >   USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
> > Despite the cost of living, have you noticed how popular it remains?
> >   -- Steven Wright?
> --
> Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
>   USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
> Despite the cost of living, have you noticed how popular it remains?
>   -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
