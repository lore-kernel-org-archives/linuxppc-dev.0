Message-Id: <199911242105.WAA08911@piglet.grunz.lu>
Date: Wed, 24 Nov 1999 22:05:47 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PoerPC 750 (I-) Address Translation Problem
To: brega@ifr.mavt.ethz.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <B4606FE2.3256%brega@ifr.mavt.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Roberto,

On  23 Nov, this message from Roberto Brega echoed through cyberspace:
> My OS traps right after bootstrapping, as soon as I enable instruction
> address translation, with a very clumsy error (the srr1 register shows an
> I-fetch from a direct-store segment - which I do not use; or an I-fetch from
> guarded space - same here; or an I-fetch from a "no-exec" segment - I do not
> set No-Exec in segment registers.
> 
> The really weird thing is that the same MMU code (the initialisation of
> other parts differ, but the MMU part does not) runs without errors on
> 603/603e/604/604e processors.

This may be a shot into complete darkness (or maybe not), but after
upgrading my 7600 from a 604 to a 750 CPU, the bootloader (quik)
started to misbehave. Turns out its not liking the way quik sets up the
BAT registers (probably the CPU sees the valid bit before both upper
and lower part are correctly initialized). The error was a default
catch in OF, trap 0x0400 (instruction access exception).

At the time it was speculated that the 750 might implement (or
optimise) access to the BAT's differently in such a way that the valid
bit gets set before the other half of the BAT is set, making code that
works on other processors, fail on the 750.

Hope this helps...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
