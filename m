Message-Id: <l03130302b4faf952dc0f@[24.218.140.90]>
In-Reply-To: <200003191824.TAA00265@piglet.grunz.lu>
References: <200003191141.MAA00285@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 19 Mar 2000 16:53:46 -0500
To: mlan@cpu.lu
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: controlfb: please test!
Cc: drow@false.org, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:24 PM -0500 3/19/00, Michel Lanners wrote:
>Stupidity struck...
>
>On  19 Mar, this message from <stupid> was heard:
>> I've also set up a little web page about the issue:
>>
>
>Ooopss... that was my home machine, as seen in my internal DNS.
>
>Here's the right URL:
>
>http://www.cpu.lu/~mlan/linux/dev/control.html

The phenomenon you're describing is called aliasing. It happens all over
the place on 68k Macs.

To check for this you divide the RAM into blocks that you think are aliased
(like 1Meg blocks in the case of the Control VRAM).  Usually, blocks in low
memory are aliased into high memory. So what you do is write a unique value
into each block from high memory to low memory. Then you go back and read
the values and the answers become obvious:

So if you write 4 3 2 1 into each block and get back 2 1 2 1 then it is
easy to see that banks 4 and 3 are aliases of banks 2 and 1 respectively.

This can be done with a couple of for loops which should tighten up your
code a little.

You may also wish to reverse engineer some of the ROM routines or the Apple
drivers. These usually contain code which sizes the VRAM. Rather than
probing for RAM like, this you might be able to just read a few bits out of
a memory controller chip somewhere. At least on the Quadras the memory
controller was capable of telling you what kind of VRAM was in use but you
had to size it by hand using the technique above.

Good luck!


____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
