Mime-Version: 1.0
Message-Id: <v04220802b5e7588b82e0@[10.0.0.42]>
In-Reply-To: 
 <Pine.A41.3.96LJ1.1b7.1000914213033.93706B-100000@unlserve.unl.edu>
References: 
 <Pine.A41.3.96LJ1.1b7.1000914213033.93706B-100000@unlserve.unl.edu>
Date: Thu, 14 Sep 2000 21:50:43 -0700
To: Takashi Oe <toe@unlserve.unl.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: zeroing pages in the idle task?
Cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:35 PM -0500 9/14/00, Takashi Oe wrote:
>On Wed, 13 Sep 2000, Geert Uytterhoeven wrote:
>
>>  On the m68k, we have some code to guestimate the CPU clock based on the
>>  BogoMIPS (see get_cpuinfo() in arch/m68k/kernel/setup.c). Since we
>>didn't care
>>  about the overhead incurred by interrupt processing, it's not that accurate
>>  though (I get 24.8 MHz on my 25 MHz 68040).
>
>That thought had occured to me.  Only problem is that the relationship
>between bogomips and cpu clock speed depends on, well, CPU.  For 601, it's
>one to one, and, for 604, two to one, and so on.  I don't know the ratios
>for 603, G3, or G4.

It gets more fun than that.  I've found that the G3's ratio varies
depending on how many of its features are turned on.  It's usually
2:1, but if the BTIC and BHT (Branch Target Instruction Cache, Branch
History Table) are turned off, it drops way down (1:1 I think, but I
may be misremembering).

Why would they be off, you ask?  Because Apple's OF doesn't always
turn them on.  I found out when I upgraded a B&W G3 from its original
CPU to a 450 MHz G3; all of a sudden my BogoMIPS were actually lower
than they were before the upgrade.  The real world performance
difference I've measured from BTIC & BHT being on/off is more like
5-10%, but it was rather startling to see BogoMIPS go down when the
clock speed went up.

The point may be moot, because I think recent kernel versions always
turn on BTIC and BHT during initialization.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
