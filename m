Date: Wed, 18 Aug 1999 13:02:43 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Paul.Mackerras@cs.anu.edu.au, rth@cygnus.com, Jes.Sorensen@cern.ch,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <Pine.LNX.4.10.9908121428020.14133-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPX.4.10.9908181211500.27955-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 12 Aug 1999, Geert Uytterhoeven wrote:

> 
> On Thu, 12 Aug 1999, Paul Mackerras wrote:
> > Richard Henderson <rth@cygnus.com> wrote:
> > The results tended to vary quite a lot from run to run, but here's a
> > typical set:
> > 
> > 17 10 9 9 9
> > 24 17 16 16 16
> > 732 731 736 786 727
> > 666 755 840 774 801
> > 
> > So the eieio doesn't look to be nearly as expensive on PPC as wmb is
> > on alpha.  (16 - 9) / 7 = 1 cycle for the eieio, which is going to be
> 
> I'm seeing different things (results don't tend to vary a lot):
> 
> | [14:27:01]/tmp# ./a.out 0xc2800000
> | 35 29 30 31 28 
> | 261 251 247 248 248 
> | 429 332 358 374 348 
> | 541 532 529 531 529 
> | [14:27:05]/tmp# 
> 
> Hence eieio() is quite expensive on memory.
> 
> This in on an IBM LongTrail (CHRP), with 604e at 200 MHz, 512 KB L2 cache,
> 66 MHz SDRAM bus, and 33 MHz PCI to an ATI RAGE II+.

Not surprising, on 603 and G3, eieio is an internal operation (it
prevents some forms of write combining on the G3). On 604 (and
601 AFAIR) every eieio translates into an actual bus cycle, which takes
time. Don't ask me exactly why (probably SMP issues).

However, expect the cost of always inserting an eieio to become huge
on a G4  if it ever comes out: it has longer memory queues and should
perform more aggressive combinations of memory operations from adjacent
addresses. 

Also a smart host bridge can merge writes from a processor into a burst
PCI transaction, the eieio cycle tells where it has to break the burst. 

> > insignificant in the context of an access to a device register, which
> > can easily take ~ 50 to 100 cycles.
> 
> For ISA (through PCI/ISA bridge). Isn't real PCI faster?

Depends on what you processor clock and whether you are speaking of reads
or writes. With posted writes which effectively stop at the host bridge,
this figure sounds exaggerated indeed (core / bus ratio between 3 and 6,
around 4 processor bus clocks for a single beat cycle).

OTOH, when filling a framebuffer, the buffers in the host bridge are
rapidly filled, write posting does not help and the figure might be
reasonable.

	Greetings,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
