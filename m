Message-Id: <200009112000.WAA00793@piglet.grunz.lu>
Date: Mon, 11 Sep 2000 22:00:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Discrepancy in BAT mapping?
To: toe@unlserve.unl.edu
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000910124843.660G-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Sep, this message from Takashi Oe echoed through cyberspace:
> In arch/ppc/kernel/prom.c, frame buffer is mapped via BAT with
> _PAGE_GUARDED for 603, 604, 750, etc.  The same value is loaded to both
> IBAT and DBAT in arch/ppc/kernel/head.S.
>
> However, in arch/ppc/mm/init.c's setbat(), G bit is stripped off for IBAT.
>
> I suppose it doesn't matter too much since it's frame buffer, but which is
> correct technically?

Hmmm, setting the G bit for instruction pages should never be necessary.
I may be totally wrong, but as I see the logic, your instructions are
not supposed to modify themselves when read. So there is no reason to
protect them from speculative access. Hence, clear the G bit on all
instruction-only mappings, so speculative access may be used to a
performance advantage.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
