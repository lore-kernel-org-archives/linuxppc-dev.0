Date: Fri, 26 May 2000 14:49:18 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Adrian Cox <apc@agelectronics.co.uk>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
In-Reply-To: <392E4B8B.E3C70B27@agelectronics.co.uk>
Message-ID: <Pine.BSF.4.21.0005261410410.16108-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 26 May 2000, Adrian Cox wrote:

>
> Geir Frode Raanes wrote:
>
> > BTW, VxWorks can not easily handle more than 32 MBytes of local RAM
> > as the eabi specification (as a result of the PowerPC architecure)
> > rules for 26 bit (signed) relative addressing. Hence, I will design
> > in exactly 32 MBytes of soldered low power SDRAM on UPMA and assign
> > UPMB to a DIMM socket. How does PPC/Linux handle this addressing
> > problem?
>
> The current release of VxWorks is prepared to use a long jump sequence
> to jump to a 32 bit address. Tornado 2 out of the box has worked fine
> for me on a 128MByte 7400.

Yes, one can always use the "-mlongcall" flag to GCC.
Or boot the kernel with only 32 MBytes in sysLib.c, load
the application (defaults to top of memory, while the kernel
sits in low memory) and then "memAddToPool(sysMemTop(),0x2000000)"
This is a FAQ issue. I have not verified the existence of the
problem myself.

> It always placed the kernel at the bottom of
> memory and dynamically loaded code at the top, so that calls from the
> dynamically loaded code into the kernel had offsets that couldn't fit
> in a relative branch.

Yeees, this will not fit into 26 bit signed relative addressing.
But are you telling me that VxWorks do use longcalls per default...
or not? (Ie. did this >32MByte separation work or not?)

> Linux, however, never had this problem. Linux uses virtual memory, which
> keeps the application within a smaller address range.

I am aware that the MMU makes the question of addressing ranges
somewhat lame. But I am scared of the dark and in this case I can
not see past the MMU and into Linux addressing modes.

Actually, I have obviousely a blind-spot in my understanding
of how API calls work on Linux. User space is 4 GBytes linear.
At the bottom is the enviroment tables copied prom the parent
process. If I remember correctly, then the stack is at the
lowest addresses above this, then comes the ELF text segment,
then BSS, then data and the rest goes into the memory heap.

API calls results in violation exceptions which the OS will
service. But to provoce an violation exception the user
application must be able to address supervisor owned space
in the first place. Meaning that some part of of the User
space must be shared with the kernel and that this space
must contain the API functions entrypoints. Correct?

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
