Message-ID: <389D57C8.F4204CF@unlserve.unl.edu>
Date: Sun, 06 Feb 2000 02:15:54 -0600
From: Takashi Oe <toe@unlserve.unl.edu>
MIME-Version: 1.0
To: Brad Midgley <brad@turbolinux.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
References: <Pine.LNX.4.20.0002060210380.16199-100000@mail.turbolinux.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Brad Midgley wrote:
>
> > don't think this is dmasound's fault.  Luckily for us, many "broken"
> > OSS-compatible apps tend to work just fine if we simply modify them to
> > ask for AFMT_S16_NE not *_LE, though performance critical apps should
> > be fixed with more effort.
>
> is the app broken because it tries to use _LE formats?

No, no, no.  There is no problem in trying to use _LE or whatever
formats.  The problem is that many apps *don't* pass the data in
little-endian format when, in fact, they ask the driver to be ready for
little-endian data.  Please have a closer look at any app that you think
should work but fail.  I bet they are genuinely broken (i.e. passing
data in wrong byte order).  Note that, whenever apps use short or long
or int, they must be aware of byte order.

> i agree it's not optimal and reflects laziness on the developer's part to
> try to make everything work as if it's little-endian, but that the api
> allows it, right?

Some sound formats are little endian, and others are big endian.  If the
app can pass the multi-byte data to the driver without byte-swapping in
software, it should, but, of course, it can do in any way.

By the way, dmasound should probably optimize for stereo not mono, and
it should not support _U8/16 variants, perhaps, since AWACS doesn't
support them in hardware.  The format conversion is done in software
(kernel space).


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
