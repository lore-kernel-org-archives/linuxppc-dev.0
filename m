Message-Id: <200006050548.HAA00780@piglet.grunz.lu>
Date: Mon, 5 Jun 2000 07:48:00 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000604104844.A13914@quaketop.them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Jun, this message from Daniel Jacobowitz echoed through cyberspace:
>
> On Sun, Jun 04, 2000 at 10:08:39AM -0500, Tony Mantler wrote:
>> dcbi = data cache block invalidate. If you do this on a dirty cache block,
>> data will be lost.
>>
>> dcbf = data cache block flush. If you do this on a block that isn't in a
>> coherent state, data will be lost.
>>
>> If you have a block that's both dirty and incoherent... well, don't do that. :)
>
> Ew.  I wonder if that's our problem...

Would make sense, and I thought so too.... dcbi is wrong in any case for
us, since we did modify that block. However, I wonder whether caching is
on at all for the framebuffer adresses? (And if so, is that a good idea?
Do we want to trash the cache with a xsetroot?)

Anyway, a quick test showed no changes in the detection with dcbf
instead of dcbi. I'll have to test more thoroughly, but only after I get
Xpmac to run again...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
