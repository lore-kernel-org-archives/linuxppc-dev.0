Date: Thu, 18 Jan 2001 07:57:37 +0000
Subject: [PATCH] 2.4.1p4 : dmasound ed21 - houston,  we have record ;-)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010118075610.52EC8DB9E1@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This is only posted here - for now...

I would dearly like to post to Linux-Audio-Dev & Music-DSP to tell them that
PPC has hit the 21st century for audio... well, OK, that we can get sound in
as well as out... but - I could do with some testing for machines I don't
have.

====

This is a quickie nasty set of patches to mop up the major hassles that have
been most frequently reported in the six months I have been inactive...

1.  I think I've finally squashed the dbdma fragility bug and _hammered_ the
driver (using all the stresses from the latency test set simultaneously)
without it stopping... but I shall wait to see what you all think.

2.  In the process, I believe that record is now working reliably.
    It does for me using "rec" (front end to SoX).
    I can do an e-to-e (using a loopthrough program) and thrash the machine
without it killing the driver.  (sound drops out, of course, see below).

3.  I've fixed up the _AWACS_ mixer abstraction to make the sliders work as
expected for RecLevel

4. the AWACS mixer abstraction now keeps values so that mixer apps that
don't obey OSS rules (most of them) still work.

5. I've separated the Mic Gain control from the mic/cd/line selection
process - so that you can do it independently - it makes more sense to me in
mixer apps that don't understand PMac h/ware (description on the linked
page).

6. there's source for a loopthrough program to help test it - on the stest
page.

====

2.4.x & stest pages linked from:

http://www.drfruitcake.com/linux/linuxppc.html

there is a pre-built 2.4.1pre4 kernel and module set - with Andrew Morton's
Low-Latency patch applied (unfortunately doesn't have quite such spectacular
improvements on PPC as on x86 - but that's another story).

I would like:

(A) Pismo owners to see if it solves the LE file problems.
(B) People to tell me what the audio connectivity of different Pmac models
is.

(C) BURGUNDY:

This is a smart chip and it's hard to work on it without any test hardware

so Owners/DISTROS? if you have a spare machine with Burgundy - or (even
better) an Apple DVD/Video card for the perch slot in a G3/beige - and you
can spare it for a few months... let me know.

Alternatively - someone can volunteer to implement/test... ;-)

AUDIO LATENCY:

We have big hassles.
As it stands, Linuxppc is not usable for serious audio - even with low
latency patches applied.

Trying to get some stuff together to find out where the killers are.

GOTCHAS:

It is possible that applications which set number of frags & frag sizes
could put stuff in that would break the driver (this has always been true
AFAICT). Don't try less than three frags or more than 4 ;-))))

this is not meant to be nice code - just band-aid - there's a proper
re-write under way but that will take some time.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
