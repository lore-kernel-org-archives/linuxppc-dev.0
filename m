Message-Id: <200008111029.LAA05480@hyperion.valhalla.net>
Date: Fri, 11 Aug 2000 11:29:30 +0100
Subject: Re: dmasound - kernel panic
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Jiri Masik <masik@pc203b.fzu.cz>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've found that I can crash the kernel by cat /dev/audio. This is the
> message I'm getting immediately

The current version(s) [dmasound monolithic, back-port & 2.4.0] do not have
a read translation for:

MU law
A law.

So I'm afraid, for the moment, this will not work.

The reason for the oops is that the code does not check (having found a
translation table) that individual routines are *all* present.

This will be fixed at the next patch release.
I may do a read translation (but... feel free ;-)

Note that these days kernel-based sample-rate & size conversion is
deprecated.  It really requires FP to do the job properly.

Much better to record from /dev/dsp in some appropriate 16 bit format and
then convert off-line using sox or something like that.

Iai.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
