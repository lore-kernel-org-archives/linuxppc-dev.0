Date: Fri, 19 Jan 2001 01:47:39 +0000
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010119014611.67C3F2F00B@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>> this should (now I fixed a typo in the machine name) also solve the LE
>> byte-swapping problem on Pismo (by soft-swapping).
>
> Can't apps cope with it if it doesn't do the byte-swapping in H/W?  If it
> can, I think the code should be removed.  No software translation in kernel
> if we can avoid it at all.

I agree 100% - the kernel should _never_ have been doing this stuff in the
first place (it can't even make a particularly good job of some of it
without fp).... and, AFAIK, that is the way of things for ALSA.

However, in OSS-land, it seems that quite a few apps rely on it (or don't
treat endian-ness sensibly) - OK, so they are, in some sense, buggy ...

... by comparison with the large amount of other code already in there to do
rate expansion and compression/decompression it is a relatively small price
to pay for having all pmac machines behave the same...

... at the next revision of the driver we could try issuing it with "16bit
44k1 Signed BE" only - and see how much of the desktop world works ;-)

iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
