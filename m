Message-Id: <200006062158.XAA00842@piglet.grunz.lu>
Date: Tue, 6 Jun 2000 23:58:47 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: nicoya@apia.dhs.org, drow@false.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10006062147140.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   6 Jun, this message from Michael Schmitz echoed through cyberspace:
>> Anyways, that's the long answer. The short answer is: no, you probably
>> don't want to cache the framebuffer.
>
> Thanks for the long answer, and all those nasty gremlins have actually
> been observed long time ago when people started to play with the
> framebuffer drivers. At least on m68k, the framebuffer address space was
> set non-cacheable right from the start (in head.S). I would hope that
> somehow translated to PPC as well :-)

That's what fbmem.c does in its default mmap(). However, at least for
control (and maybe other comparable video implementations as well), you
get much better performance on scroll and other fb-to-fb copy
operations, without visible inconvenients, when the framebuffer is set
to write-through caching.

For fun, I tried write-back caching as well. Makes for some really nice
visual effects when your killed netscape starts to fade away as the
cache gets slowly flushed ;-))) And it doesn't even get you any speed
improvement...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
