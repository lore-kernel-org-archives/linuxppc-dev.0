MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How Can The Starting Address Of An Image In ELF File BeChanged
Date: Fri, 5 Mar 2004 10:00:53 -0700
Message-ID: <8039970AF146314597457D3B51A68B382E04BC@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The linux kernel runs in VIRTUAL memory space starting at 0xC000_0000.  It needs to be loaded in PHYSICAL space where there is RAM for it to run out of.  When it starts up, it relocates itself to location 0x0000_0000, and then turns on the MMU which it uses to map the physical RAM that it is running out of to virtual memory location 0xC000_0000.

The previous paragraph is extremely simplified.  I strongly suggest you read some kernel and booting HOWTOs and/or buy some books that cover details of the kernel.

One good starting place is Denx' DULG manual
  http://www.denx.de/twiki/bin/view/DULG/Manual
(the title is "Linux for PowerPC Embedded Systems HOWTO", but much/most of it is generic to all the CPUs).

It may be helpful in future questions to identify the CPU (and possibly the board) you are using.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Thamarai
> Selvan
> Sent: Friday, March 05, 2004 1:34 AM
> To: Stephen Williams
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: How Can The Starting Address Of An Image In ELF File
> BeChanged
>
>
>
> hi
>
> iam still not clear with it
> can u guide me 2 some document/link on it or brief it little bit more
> why it is linked to that address ?
> if it is linked it should be configurable
> bcuz iam using vision ice to download my image.
> Thanks for your immediate reply
>
> with regards
> Thamarai Selvan.G
>
> [ "Stephen Williams" <612dlag102@sneakemail.com> writes: ]
>
> Thamarai Selvan Thamarai.Selvan-at-lntinfotech.com |PPC Linux
> Embedded| wrote:
> >
> > I created the elf file of the kernel using "make vmlinux", when i
> > checked the created system.map i found the the kernel image starting
> > from 0xc0000000. Can any tell where this address is defined or
> > configured? and how can this be changed to 0x0000000 is it possible?
>
> The linux cernel is linked to 0xc0000000, and the entry is really up
> there. In fact, the kernel is loaded starting at 0x0, and
> there is code
> at the beginning that turns on address translation so that it
> appears at
> the right place.
>
> In other words, there is nothing for you to change.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
