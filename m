Date: Thu, 12 Aug 1999 17:07:02 +1000
Message-Id: <199908120707.RAA30438@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rth@cygnus.com
CC: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
In-reply-to: <19990811224344.A14713@cygnus.com> (message from Richard
	Henderson on Wed, 11 Aug 1999 22:43:44 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com> <199908120500.PAA30022@tango.anu.edu.au> <19990811224344.A14713@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Henderson <rth@cygnus.com> wrote:

> As I see it, testing against main memory should be the lower
> bound of the numbers, since it's the quickest to respond.  A
> real device will take longer to respond, so any enforced delays
> (or failures to write-combine) will only exagerate the difference.

Hmmm, no, doesn't it go the other way around?

Going to L1 cache will mean that we can isolate the overhead of the
wmb, and will exaggerate the ratio between the two cases.

A real device that takes longer to respond will make the overhead of
the wmb a smaller fraction of the total time.  And you would hope that
the cpu could overlap the wmb, or at least the time to decode and
issue it, with the time waiting for the device to respond.

> Anyway, the results (in cycles) from my 533MHz sx164 are:
> 
> 10

One-cycle access to L1 cache, I guess?

> 10
> 10
> 10
> 10
> 223

Because of i-cache misses, presumably

> 94
> 94
> 94
> 94
> 
> So the cost of wmb for 8 store+wmb, versus 8 stores with one wmb,
> is over 9:1.

Interesting.  Sounds like each wmb takes about 12 cycles ((94-10)/7),
which sounds a bit like it is going all the way out to the memory bus
and back before the cpu does the next instruction.

(Ob. nitpicking: if a wmb takes 12 cycles, how come we can do a wmb
and 8 stores in 10 cycles? :-)

> For grins, will you try the same test on your ppc?

Sure, happy to.

I think I have correctly understood the alpha assembly syntax.  My PPC
version is below.  I've added a couple of things.  First, PPC has a
`timebase' register which counts at 1/4 of the bus clock, which means
once every 16 cycles on my G3 desktop at work.  For this reason I have
put a loop around the sets of stores to do them 16 times.  The
overhead of the loop should be zero (the branch is pretty easily
predictable :-).  The numbers should thus be cycles per iteration.

Secondly, I added stuff to mmap a framebuffer and do the stores to a
word in it, just for grins.

The results tended to vary quite a lot from run to run, but here's a
typical set:

17 10 9 9 9
24 17 16 16 16
732 731 736 786 727
666 755 840 774 801

So the eieio doesn't look to be nearly as expensive on PPC as wmb is
on alpha.  (16 - 9) / 7 = 1 cycle for the eieio, which is going to be
insignificant in the context of an access to a device register, which
can easily take ~ 50 to 100 cycles.

The average of the 3rd line is 742, and of the 4th line is 767.  But
given the spread of the numbers, I don't think that the difference is
statistically significant.  This is going to the framebuffer on an ATI
Rage chip.  760 cycles is 95 cpu cycles per access, or about 350ns.  I
guess ATI chips expect you to use the drawing engine if you are doing
any significant amount of stuff. :-)

What numbers do you get on alpha if you point it at a framebuffer,
just for interest?

Paul.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

test(unsigned long *ptr)
{
  int i;
  unsigned s, e;

  for (i = 0; i < 5; ++i)
    {
      asm("mftb %0
	   mtctr %3
	1: stw 16,%2
	   stw 16,%2
	   stw 16,%2
	   stw 16,%2
	   stw 16,%2
	   stw 16,%2
	   stw 16,%2
	   eieio
	   stw 16,%2
	   bdnz 1b
	   mftb %1"
	: "=r"(s), "=r"(e), "=m"(*ptr)
	: "r"(16));
      printf("%u ", e-s);
    }
  printf("\n");

  for (i = 0; i < 5; ++i)
    {
      asm("mftb %0
	   mtctr %3
	1: stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   stw 16,%2
	   eieio
	   bdnz 1b
	   mftb %1"
	: "=r"(s), "=r"(e), "=m"(*ptr)
	: "r"(16));
      printf("%u ", e-s);
    }
  printf("\n");
}

#define PAGESIZE	0x1000

main(int ac, char **av)
{
	unsigned long base, offset;
	int fd;
	unsigned long mem;
	unsigned long *ptr;

	test(&mem);
	if (ac > 1) {
		base = strtoul(av[1], 0, 16);
		offset = (base & (PAGESIZE - 1)) / sizeof(unsigned long);
		base &= -PAGESIZE;
		if ((fd = open("/dev/mem", 2)) < 0) {
			perror("/dev/mem");
			exit(1);
		}
		ptr = (unsigned long *)
			mmap(0, PAGESIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, base);
		if ((long)ptr == -1) {
			perror("mmap");
			exit(1);
		}
		test(ptr + offset);
	}
	exit(0);
}

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
