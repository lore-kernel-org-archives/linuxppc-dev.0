Message-Id: <l03130301b2e69f7f1da5@[209.251.79.177]>
In-Reply-To: <19990209131436.011982@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 9 Feb 1999 21:35:49 -0500
To: BenH <bh40@calva.net>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: NuBus PowerMacs and PDM video
Cc: linuxppc-dev@lists.linuxppc.org,
        mklinux-development-system@public.lists.apple.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:14 AM -0500 2/9/99, BenH wrote:

>I'm doing some experiments with the MMU (learning it's usage). The goal
>is to add some better bootstrap code to BootX (get rid of the -622 error
>with MacOS VM) and to add support for the rather "special" memory
>mappings of the NuBus PowerMacs.

The PDM PowerMacs have their guts designed after 68k macs. They have the
same weird problems like aliasing, and a discontiguous memory.

>I beleive MkLinux booter moves it elswhere, but I don't know how to do
>that (I don't have infos about the chip and I don't have one of those
>machines to test with).

You just need to know the physical base address of the frame buffer.
Once you know that you can just rewrite the page tables to put the
frame buffer anywhere you'd like it.

You need to write a program under MacOS that will find a physical address
for a given virtual address. You'll probably need to do this in assembly
or there may even be a toolbox call that will do this for you.



_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
