To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
References: <Pine.A41.3.96LJ1.1b7.1000914213033.93706B-100000@unlserve.unl.edu>
	<v04220802b5e7588b82e0@[10.0.0.42]>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 15 Sep 2000 15:50:28 +0200
In-Reply-To: "Timothy A. Seufert"'s message of Thu, 14 Sep 2000 21:50:43 -0700
Message-ID: <8xbsxp228r.fsf@s63.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" <tas@mindspring.com> writes:

>
>
> At 9:35 PM -0500 9/14/00, Takashi Oe wrote:
> >On Wed, 13 Sep 2000, Geert Uytterhoeven wrote:
> >
> >>  On the m68k, we have some code to guestimate the CPU clock based on the
> >>  BogoMIPS (see get_cpuinfo() in arch/m68k/kernel/setup.c). Since we
> >>  didn't care about the overhead incurred by interrupt processing, it's
> >>  not that accurate though (I get 24.8 MHz on my 25 MHz 68040).
> >
> >That thought had occured to me.  Only problem is that the relationship
> >between bogomips and cpu clock speed depends on, well, CPU.  For 601, it's
> >one to one, and, for 604, two to one, and so on.  I don't know the ratios
> >for 603, G3, or G4.
>
> It gets more fun than that.  I've found that the G3's ratio varies
> depending on how many of its features are turned on.  It's usually
> 2:1, but if the BTIC and BHT (Branch Target Instruction Cache, Branch
> History Table) are turned off, it drops way down (1:1 I think, but I
> may be misremembering).
>
Would a rewrite of the bogomips loop be an option?

In that case one could chose a sequence of dependant instructions in
the loop body, preventing possible superscalar execution. (One could
specifically use instructions that are commonly 'execution
serializing', like 'adde', to again enforce execution of only a single
instruction per clock.)

If the loop body was long enough, effects of varying branching
efficiency could also be masked. That way, bogomips should correlate
very well with actual MHz.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
