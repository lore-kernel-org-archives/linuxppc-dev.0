Message-Id: <200008222110.XAA00741@piglet.grunz.lu>
Date: Tue, 22 Aug 2000 23:10:41 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Control fb problem on 8500
To: daenzerm@student.ethz.ch
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
In-Reply-To: <39A23ADB.25E233F@relog.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  22 Aug, this message from Michel Dänzer echoed through cyberspace:
>> > > I suppose
>> > >
>> > >     if (fix.line_length)
>> > >         pScrn->displayWidth = fix.line_length*8/var.bits_per_pixel;
>> > >     else
>> > >         pScrn->displayWidth = var.xres_virtual;
>> > >
>> > > should work fine, except on hardware were
>> > > fix.line_length*8/var.bits_per_pixel might not be integer (e.g. if
>> > > 1280x1024x24 mode requires a line_length of 4096).
>> >
>> > I've thought of this as well. The problem is that the mode hasn't been
>> > initialized when displayWidth is set and used.
>>
>> So the X server initializes the internal screen structures before it even
>> knows that it can use them later?
>
> Yes. This really seems to be a rather serious design flaw - the driver is
> assumed to know at any time whether it can cope with what the user wants and
> how.
>
> Anyway, what do you think about the patch I posted? Michel, can you please try
> it?

I'll try to get some time next weekend to do so. I need to get new X
sources (4.0.1), and I need to do that at work rather than via my ISDN
dial-up ;-)

> I don't think having to use ShadowFB with the fbdev driver is too bad
> because it should generally enhance performance :)

I guess control is the exception. I found out it isn't worth the memory
impact. I once ran a complete x11perf run comparing with and without
shadowfb, and with shadowfb was overall slower. Some operations were
faster, though, but not in general.

I suppose this is because main memory isn't faster on my box than access
to the VRAM. Both are accessed via a 50 MHz bus, and are of the same
basic type (plain old DRAM, that is).

I'll let you know....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
