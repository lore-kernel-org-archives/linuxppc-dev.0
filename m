Date: Wed, 11 Aug 1999 22:43:44 -0700
From: Richard Henderson <rth@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990811224344.A14713@cygnus.com>
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com> <199908120500.PAA30022@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=RnlQjJ0d97Da+TV1
In-Reply-To: <199908120500.PAA30022@tango.anu.edu.au>; from Paul Mackerras on Thu, Aug 12, 1999 at 03:00:46PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii

On Thu, Aug 12, 1999 at 03:00:46PM +1000, Paul Mackerras wrote:
> Show us the numbers?

Attached is a quick userland study wrt main memory.  How much
more accurate to a real device do I need to get to convice you
that the test is valid enough?

As I see it, testing against main memory should be the lower
bound of the numbers, since it's the quickest to respond.  A
real device will take longer to respond, so any enforced delays
(or failures to write-combine) will only exagerate the difference.

Anyway, the results (in cycles) from my 533MHz sx164 are:

10
10
10
10
10
223
94
94
94
94

So the cost of wmb for 8 store+wmb, versus 8 stores with one wmb,
is over 9:1.

> I don't believe the frame-buffer guys will actually
> see any measurable improvement in performance from taking out the
> eieio from readl/writel on PPC.

For grins, will you try the same test on your ppc?


r~

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="z.c"

#include <stdio.h>

main()
{
  int i;
  unsigned s, e;
  unsigned long mem;

  for (i = 0; i < 5; ++i)
    {
      asm("rpcc %0
	   stq $31,%2
	   stq $31,%2
	   stq $31,%2
	   stq $31,%2
	   stq $31,%2
	   stq $31,%2
	   stq $31,%2
	   wmb
	   stq $31,%2
	   rpcc %1"
	: "=r"(s), "=r"(e), "=m"(mem));
      printf("%u\n", e-s);
    }

  for (i = 0; i < 5; ++i)
    {
      asm("rpcc %0
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   stq $31,%2
	   wmb
	   rpcc %1"
	: "=r"(s), "=r"(e), "=m"(mem));
      printf("%u\n", e-s);
    }
}

--RnlQjJ0d97Da+TV1--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
