Date: Fri, 10 Aug 2001 19:28:34 +0100
Subject: Re: Fix for PPC audio devices that can't reendianize samples
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Derrik Pates <demon@devrandom.net>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010810183346.9F02E2F040@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The attached patch adds code to drivers/sound/dmasound/trans_16.c to
> byteswap little-endian audio samples for hardware that needs it (like the
> DACA audio chip in the iBook and iBook FireWire), and also marks the DACA
> in the iBook FireWire as being unable to handle little-endian audio
> samples (in dmasound_awacs.c).

we've been round this loop ;-)))

the reason that the byte-swap code was taken out of trans_16.c is that it
will never be allowed into the kernel.

The way to solve the problem is to:

(a) as you've done, mark the DACA and so on as BE-only (which, I thought was
already done in the latest patches - barring the Keylargo rev.3 detection).

(b) if applications don't work properly with BE-only devs then bang on the
app maintainer (or send patches) to fix it.

Otherise you end up with having to maintain a never-to-be-merged patch
against dmasound (and believe me, that's a PITA).

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
