Date: Thu, 7 Jan 1999 22:32:47 +1100
Message-Id: <199901071132.WAA01174@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: tas@mindspring.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <v04011701b2ba429e00af@[209.86.156.161]> (tas@mindspring.com)
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199901060601.RAA00588@tango.anu.edu.au> <v04011701b2ba429e00af@[209.86.156.161]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Seufert <tas@mindspring.com> wrote:

> This works on the PowerBook 2400 as well.  It so happens that the IDE
> controllers also sit at 0xf3020000 and 0xf3021000 on the O'Hare.  The value
> of the register at offset 0x200 is slightly different under MacOS:
> 0x221025.  I tried both values, it didn't seem to make a difference.  I did
> a quick hack to ide-pmac.c (it just stuffs the value in, no questions
> asked, though it does actually use the correct base address instead of hard
> coding 0xf3020000) and that worked.  Performance is up to 5.6 MB/s (was in
> the region of 1.6 before).
> 
> Right now my cheap hack is using 0x221025, but if somebody wants I will do
> 0x211025 instead for an extended period to see if there are any problems.

The hack also works on my powerbook 3400, but I only get 4.3MB/s.  On
the iMac I get 10.53MB/s with 211025, but only 8.47MB/s with 221025.

I did some fiddling around, testing the speed with different values in
the register, and I think it is something like this:

- the 3ff000 bits control the speed of dma accesses, the 000fff bits
  control the speed of PIO accesses
- I think the 3f0000 and 00f000 bits control different aspects of dma
  access speed
- the c00, 300 and ff bitfields seem to control different aspects of
  PIO timing.  I think there are bitfields inside of the ff bitfield,
  but I haven't worked out exactly what's going on.  Time for a CRO
  maybe :-)

I think probably any modern drive would be OK with 211025.  Ideally we
would work out exactly how the values relate to the PIO and DMA modes
defined in the ATA-2 spec, then implement the code for selecting
PIO/DMA modes in the ide-pmac driver as requested by the higher level
IDE driver (based on the capabilities reported by the disk).

> Any guesses about the meaning of this register?  It feels wrong somehow to
> just ape MacOS without knowing what's really going on.  :)

It's nice to know what's really going on, but we have managed without
it more-or-less in several other places (e.g. the swim3 floppy
driver).

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
