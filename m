Message-Id: <200006062152.XAA00838@piglet.grunz.lu>
Date: Tue, 6 Jun 2000 23:52:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: geert@linux-m68k.org, daenzerm@student.ethz.ch, toe@unlserve.unl.edu,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10006062123240.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   6 Jun, this message from Michael Schmitz echoed through cyberspace:
>> > > Probably XF4 handles fix.smem_start being not on a page boundary
>> > > incorrectly.
>> >
>> > What would it have to do to handle it?
>>
>> Round down smem_start and mmap() it, and readd the offset. Cfr.
>>
>>     addr = (unsigned long)mmap(NULL, ati_smem_len, PROT_READ | PROT_WRITE,
>> 				MAP_SHARED, fb_fd, 0);
>>
>>     ati_smem = addr+ati_smem_offset;
>
> Basically what we do in fbdev.c since two years or so (first happened on
> Mac68k). But I don't think that's it: mmap would have barfed if you feed
> it a start address that isn't page aligned.

How about incorrect rounding? Here is what I see (in ASCII art ;-):

  Pixel (168,-1)                      (0,-1)(0,0)    Pixel (167,0)
  *----------------------------------------**-----------------*
  |                                        ||                 |

I _think_ it starts with line -1, and not line 0. I could be wrong...
There could be an aliased region of VRAM just below framebuffer start...

Entire diplay width is 1152 pixels à 32 bit. So there are 1152-168=984
pixels on screen that are below pixel (0,0) in memory. The offset
between fb address 0 and pixel (0,0) is 80 bytes in this mode. 984
pixels are 964*4=3936 bytes. If you look closely, offset plus
displacement is just 80 bytes (offset again...) below the next page
boundary:
		80 + 3936 = 4016 = 4096 - 80

Bug in my calculation or XF4's?

> Maybe a timing problem with the monitor?

No, because both halves of the display fit together without sync
artefacts.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
