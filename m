Message-ID: <3F3941A3.2090600@esteem.com>
Date: Tue, 12 Aug 2003 12:36:03 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: david.jander@protonic.nl
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
Subject: Re: Memory map with "holes"...
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

     It is possible to design a system to accomidate larger ram chips
for future expansion with out leaving holes in your memory map. We did
this on our ESTeem 192E. What you need to do is design your memory
system around the samllest chip in the memory family you intend to use.
connect the bank selects lines to the address immediately following the
highest address line used by the smallest memory part. Then following
the bank selects place the other address lines to the larger memory parts

This is how we did ours ( and it works with the larger parts )

We designed our board using a Micron part MT48LC2M32B2. But we decieded
to include an extra clock cycle so we could use other manufacturers parts,
Such as Toshiba TC59S6432CFT and Samsung K4S643232C(not tested)

Micron has said that they will make a bigger parts in the same foot print.

This is how we hooked up our ram to make provisions for the larger parts.
(Note that the two additional address lines have an * next to them)

MPC850                    SDRAM
=============================
A29                        A0
A28                        A1
A27                        A2
A26                        A3
A25                        A4
A24                        A5
A23                        A6
A22                        A7
A13                        A8
A12                        A9
GPL_A0                     A10
*A8                        A11 (pin 71)
*A7                        A12 (pin 69)
A10                        BA0
A9                         BA1
OE_GPL_A1                  RAS
GPL_A2                     CAS
GPL_A3                     WE

This design will probably work with little modification on all of the MPC860
family.

Hope this helps

     Conn

David Jander wrote:
 >
 > We are designing a board based on the MPC852T (MPC866 serivate), and
 > I want to make sure there is the possibility to mount different-size
 > SDRAM chips on it, so I just connect the two bank-select pins to some
 > higher address lines, leaving some out in between, in order to acomodate
 > for bigger chips in the future. The bottom line is that I will get the
 > memory map split up into 4 segments with vast holes between each segment
 > that are undefined. What do I need to keep in mind regarding linux
 > about this? I suppose it isn't an issue, but I want to be sure I don't
 > get any trouble later. Any experience with memory holes? I suppose the
 > boot-loader should tell the kernel about the memory-map, in a way just
 > like lilo on an x86 machine, am I right? Does this work the same way on
 > linux-ppc ?

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
