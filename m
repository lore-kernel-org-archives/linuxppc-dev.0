Message-Id: <200008070101.CAA05135@hyperion.valhalla.net>
Date: Mon, 07 Aug 2000 02:00:48 +0100
Subject: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
        linux-apus-devel@lists.sourceforge.net
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This patch makes a common code base for dmasound between 2.4.0 and 2.2.17.

It is, essentially, the same as Geert's 2.4.0 split-up applied back to
2.2.17.

I would like to ask Paulus to consider including this patch in pmac 2.2.17.
However, it affects other archs.

It is unlikely to work 'out-of-the-box' for these archs - although I have
tried to do as much of the 'wrapper' work as poss.

I would like to know if the other dmasound users consider it worthwhile
putting this in at 2.2.17, and whether it has been tried.

There is an alternative possibility if it is only wanted for pmac.

======

Motivation:

1/  The main beneficiary of this is pmac.  There are now so many new
machines (and extensions to deal with older machines) that I would guess the
size of the pmac portion of the code could grow by 2X.  This is getting
impractical with the monolithic dmasound.c (and will be different to 2.4.0
where the split has already been done).

So this patch, primarily, makes the driver more maintainable.

2/  There seems to be a need to continue for a little while, at least, with
2.2.X.

3/  this code-base is identical between 2.4.0-testX and 2.2.17preY.   I.E.
you can symlink to the same directory for 2.2.17 & 2.4.0 - which means that
effort is not repeated for 2.4.0.

======

Changes/Fixes:

There are a few small additions at the top level (affecting all archs):

1. the look-up tables have been moved to the lower levels.
2. The conditionalisation on HAS_RECORD has been made a run-time decision

This means, AFAICT that it will no longer be necessary to have different
versions of dmasound_core.o for different machines (in the same arch).

3.  A SNDCTL_GET_CAPS ioctl has been added: it needs filling in for Q40,
Paula & Atari.   One line of code for someone who knows their machine :-)

Other changes are pmac-only and I'll leave them out of this post.

=====

The latest version of this can be found at:
http://www.drfruitcake.com/linux/linuxppc.html (including binaries etc. for
pmac)

It has also been uploaded to the (brand-new) patch-tracking system...

http://sourceforge.net/projects/ppclinux/

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
