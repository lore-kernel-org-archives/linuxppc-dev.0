Message-Id: <200008060938.KAA25433@hyperion.valhalla.net>
Date: Sun, 06 Aug 2000 10:38:01 +0100
Subject: Re: CDDA playback on Pismo (and other newer models)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
CC: Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Henry,
 Sun, Aug 6, 2000, Henry Worth wrote:
> Iain Sandoe wrote:

>> I've been using the xmms CVS tree (www.xmms.org and follow the links).  It
>> works fine with .wavs of different sample rates etc.  [xmms --version ==
>> 1.2.1].

> Which output plugin do you use?  And was that on a Pismo?

OSS - and no, but on several different machines (I don't yet have a pismo -
my portable is a Lombard).

You, Matthias & Ben are (at the moment) chief pismo sound testers :-)

> Looking at eSound and the XMMS ESD output plugin, they simply can't work
> with little endian formats like .wav on a big endian machine. The esd
> daemon
> uses, and sets the output device to, native endiness (there isn't even a
> parm to indicate endiness of the incoming data buffer). The XMMS ESD
> output plugin completely ignores endiness of the incoming data stream
> and
> passes it through unchanged (versions 0.9.5, 1.2.1, 1.2.2). A quick hack
> to swap bytes in the ESD plugin fixed playback of .wav files. The small
> files that had worked before were all 8-bit mono format.

OK - there's a lot of this in apps that came from x86 - they assume that the
output is LE.

If you use my back-port - I "fixed" (kludged) the default dsp settings to
44.1k, 16 bit , stereo LE -- to be compatible with x86 progs that don't
bother to set things up :-(

> OTOH, the OSS output plugin appears to correctly pass the data stream's
> endiness to the sound device, but a quick hack to swap data bytes also
> fixed its playback problems.

??? this is strange - if it tells the truth (endianess, sample rate, depth &
stereo/mono) - I think it should work...  there's no need to swap bytes at
all with the audio - the hardware can do it...

> I need to dig into the code some more, but
> are we sure the AWACS Screamer in the Pismo isn't one of those variants
> that only supports big-endian data?

This is news to me see below.... (have you any reference for this issue?)

> A quick test forcing the
> AFMT_*_[LB]E
> value to either value for the IOCTL doesn't make a difference.

The awacs, screamer and burgundy chips *all* have an endian-swap capability
AFAICT.  So, providing you tell the driver what you are supplying - it will
work OK:

""If you set dmasound_awacs to the *correct settings for the data you pass
to it* - it works.""

I have tested (yesterday - on a screamer) with:
44.1k LE stereo
22050 LE stereo
11025 A & mu Mono
8000 mu (into /dev/audio as well)

I'll increase the coverage as/when I have time (it was incidental to some
other testing).

What you could send me that would be *very* helpful is:

a dump of any device-tree contents that relate to sound.

I need to be able to try and build different mixer abstractions on the basis
of which machine we have - because this is where most of our difficulty
lies.

========

There is a residual "gottcha".

If you machine *only* supports 44.1k playback (we shall see - from
device-tree sample-rates stuff)... then:

If you try and playback low sample rate stuff, it needs to be "up-converted"
to 44.1k.

The kernel driver can only afford to implement a fairly simple algorithm for
this... and it is, for that reason, fairly 'nasty' in sound.

You would be much better off using some off-line process (which can make use
of FP) to do the up-conversions.

other than that - I can, at the moment (at least with the back-port) see no
reason why the sound output will not work properly.

Getting sound in-out to work is a different matter (I believe you have no CD
connection through the screamer no?)

HTH
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
