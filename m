Message-ID: <3BF539A9.BA3ED260@midrivers.com>
Date: Fri, 16 Nov 2001 09:07:05 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've had to face this, taking the existing walnut/405GP work and migrating
it to a custom controller + 405PM.

some issues:
- mem mapped and DCRs have moved around, been added or taken away when
  going from the 405gp to pm.

- functional differneces exist between the parts as well: one example
  being the GP has 5 ethernet interrupts mapped into the UIC, while
  the PM they're all rolled into 1 int.

- there may be silicon errata which affect one processor which have
  been worked out of another.

- and the cards are different as well ...

for ease of replicating this port when the next kernel comes along,
I came down on the side of really isolating everything I'm adding:
1bm405pm.h instead of ibm405gp.h,
my own board and architecture setup funcs in their own module ...
my own head_ppc405pm.S ....

I've also taken a copy of ppc405_enet.c and modified it for the
new interrupt structure.

this may not be a wise approach, but it saves me ifdeffing many
files to smithereens.  Most of the ifdefs are to makefiles so
that different objects for my card and the 405pm are called for,
rather than walnut and 405GP.  Ay any rate, it'll make my port
easier and I can rethink this when I've got a more stable O/S
release to work on.

my 0.0002: an approach which isolates chip-specific funcs in a
chip-specific module, same for board-specific.  this adds maintenance
as the flavors for a given processor grow.  maybe there's a more clever
way to do this w/o globbing up a few files w/ many ifdefs.

Mark


> I've been wondering why it's architected that way as well.  It
> seems you are looking for it to follow the model of the well
> abstracted 7xx/74xx ports.  Examples are the ones that rely on
> mpc10x_common and pplus_common as libraries of common initialization
> code (MEN F1, PCore, MCPN765, MVME5100, etc.).
>
> Seems like that would be an improvement for people doing custom
> 405 ports and ease maintenance of existing ports (especially
> the #ifdef creep).

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
