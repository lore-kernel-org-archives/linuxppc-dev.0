Date: Thu, 28 Mar 2002 08:27:05 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: slim kernel source
To: dan_bethe@yahoo.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020327183028.71552.qmail@web11002.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16qUJT-0000An-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Mar, this message from Dan Bethe echoed through cyberspace:
> Hi all.  Is there a utility or procedure which can remove a bunch of the code
> from extraneous architectures from my kernel source tree?  I only want to build
> kernels for my beloved Powermac 8500 and so I can do without code specific to
> ia32, S390, Alpha, MIPS, and friends.

Hmmm...

> Even if you just know of a few directories I can remove and save a couple dozen
> megs of space, that'd be good.

A random benh 2.4 kernel tree has 127 MB once de-tgz'ed. Of these, 69 MB
are drivers, for which it is difficult to know what you need and what
you don't need. Removing random stuff in there might break the kernel
Makefiles, too.

Which leaves arch/ (22 MB) and include/ (15 MB). In arch, 2.6 MB is ppc/
(not one of the leaner arch'es :-), but there have been cases of one
arch relying on code of some other arch.

In include/, the asm-* part is roughly 10 MB, of which asm-ppc eats
600K. Again, the caveat about dependencies between arch'es apply.

In general, the kernel sources are not meant to be cut in pieces. You
can certainly remove large parts, but you're on your own if anything
breaks.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
