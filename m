Mime-Version: 1.0
Message-Id: <p05101400b888906c9a08@[10.0.0.42]>
In-Reply-To: 
 <Pine.LNX.4.43.0202071127340.16392-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.43.0202071127340.16392-100000@andromeda.dsdk12.net>
Date: Thu, 7 Feb 2002 12:35:48 -0800
To: Derrik Pates <dpates@dsdk12.net>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: two aty128 frame buffers?
Cc: <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:29 AM -0700 2/7/02, Derrik Pates wrote:
>On Wed, 6 Feb 2002, Ani Joshi wrote:
>
>>  You can't use 2 cards which require ISA IO (vgaHW uses ISA IO on rage128)
>>  right now, because of the multiple busses on the G4 machines.  You can
>>  comment out all the vgaHW calls and that will probably work, but without
>>  doing that it will always crash on any ISA IO operation.  The reason is
>>  because your second bus's ISA IO isn't mapped.
>
>The issue is the same with the G3 tower - the video card is by default in
>the 32-bit, 66 MHz PCI slot, which is a logically separate bus from the
>64-bit, 33 MHz bus that the other 3 slots are part of.

Actually it's not the same issue.  The blue&white G3 tower really has
just one logical PCI bus.  The host bridge interfaces the processor
to the 66 MHz bus, and the 33 MHz bus is bridged to the 66 MHz bus
via a PCI-to-PCI bridge IC.  I'm pretty sure ISA I/O is already
supposed to work for busses behind bridges.

The problem in the G4s is that Apple's Uni-N host bridge has three
logically distinct PCI busses which are peers rather than
subordinates.  Each of them thinks it is PCI bus #0 -- the namespaces
are separate.  The Linux kernel APIs for ISA I/O don't account for
the possibility of multiple PCI roots.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
