Date: Thu, 12 Aug 1999 14:31:25 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: rth@cygnus.com, Jes.Sorensen@cern.ch, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <199908120707.RAA30438@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9908121428020.14133-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Aug 1999, Paul Mackerras wrote:
> Richard Henderson <rth@cygnus.com> wrote:
> The results tended to vary quite a lot from run to run, but here's a
> typical set:
> 
> 17 10 9 9 9
> 24 17 16 16 16
> 732 731 736 786 727
> 666 755 840 774 801
> 
> So the eieio doesn't look to be nearly as expensive on PPC as wmb is
> on alpha.  (16 - 9) / 7 = 1 cycle for the eieio, which is going to be

I'm seeing different things (results don't tend to vary a lot):

| [14:27:01]/tmp# ./a.out 0xc2800000
| 35 29 30 31 28 
| 261 251 247 248 248 
| 429 332 358 374 348 
| 541 532 529 531 529 
| [14:27:05]/tmp# 

Hence eieio() is quite expensive on memory.

This in on an IBM LongTrail (CHRP), with 604e at 200 MHz, 512 KB L2 cache,
66 MHz SDRAM bus, and 33 MHz PCI to an ATI RAGE II+.

> insignificant in the context of an access to a device register, which
> can easily take ~ 50 to 100 cycles.

For ISA (through PCI/ISA bridge). Isn't real PCI faster?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
