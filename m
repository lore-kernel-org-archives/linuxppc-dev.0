Message-ID: <398FB055.9FDC4B64@ncal.verio.com>
Date: Tue, 08 Aug 2000 00:01:41 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org,
        matthias pfisterer <matthias.pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <Pine.LNX.3.96LJ1.1b7.1000807235036.689a-100000@ofey.earthlink.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
>
>
> Ultimately, byte swapping and conversion should take place in esd, but
> there is a bit of problems in its API (maybe easily extensible but it
> looks convoluted somehow), and API change will break the binary
> compatibility with the existing apps quite possibly.  Well, esd is an
> alpha app, so the changes are somewhat expected, but...

Legacy can be a bitch..., on the other hand it writes my paycheck.

They might manage backwards compatibilty by defaulting to the current
behavior if functions to provide a more complete format description
aren't called. Anyone on the list have connections with the
enlightenment/eSound camp?

> Anyhow, attached is a quick hack to the xmms' esd plugin (s<->u conv is
> completely untested).
>

Thanks, I'll give it a try. Hopefully we can get it propagated back
into the XMMS cvs tree, so this isn't a reoccuring issue.

BTW, I've started debugging the Xmms_CdRead plugin, it abends
the input thread with a corrupted Xlib call. What I've found so
far is that the problem originates in a call that passes data to
the analyzer displays. A parm is getting corrupted on the last
call in a series, it's a constant, so a likely heap corruption.
But of course it only happens if a particular file
(~/xmms/input.c) is compiled with -O2 (gcc 2.95.2) ;-)

Once the offending file is compiled without optimization it plays
CD's fine with the ATAPI CDDA i/f. The analyzer displays just
display fairly uniform noise, would think endiness but the
visualization data handler has a routine to convert to NE (the
.wav input module data displays correctly). This could be related
to the problem that is causing the abend in the call the
analyzer data input call.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
