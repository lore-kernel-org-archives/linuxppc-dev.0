Message-ID: <398DB035.4BFCC4FA@ncal.verio.com>
Date: Sun, 06 Aug 2000 11:36:37 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org,
        Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <200008060938.KAA25433@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> Hi Henry,
>  Sun, Aug 6, 2000, Henry Worth wrote:
> > Iain Sandoe wrote:
>
> >> I've been using the xmms CVS tree (www.xmms.org and follow the links).  It
> >> works fine with .wavs of different sample rates etc.  [xmms --version ==
> >> 1.2.1].
>
> > Which output plugin do you use?  And was that on a Pismo?
>
> OSS - and no, but on several different machines (I don't yet have a pismo -
> my portable is a Lombard).
>
> You, Matthias & Ben are (at the moment) chief pismo sound testers :-)
>
> > Looking at eSound and the XMMS ESD output plugin, they simply can't work
> > with little endian formats like .wav on a big endian machine. The esd
> > daemon
> > uses, and sets the output device to, native endiness (there isn't even a
> > parm to indicate endiness of the incoming data buffer). The XMMS ESD
> > output plugin completely ignores endiness of the incoming data stream
> > and
> > passes it through unchanged (versions 0.9.5, 1.2.1, 1.2.2). A quick hack
> > to swap bytes in the ESD plugin fixed playback of .wav files. The small
> > files that had worked before were all 8-bit mono format.
>
> OK - there's a lot of this in apps that came from x86 - they assume that the
> output is LE.
>
> If you use my back-port - I "fixed" (kludged) the default dsp settings to
> 44.1k, 16 bit , stereo LE -- to be compatible with x86 progs that don't
> bother to set things up :-(

This won't help in the esd case, it always sets the device to
AFMT_S16_BE for 16 bit data on big endian systems (also doesn't deal
with
unsigned 16 bit data streams). Whereas the XMMS esd output plugin always
passes the data through unchanged (little endian in the case of .wav).
Niether one does any form of data conversion.

>
> > OTOH, the OSS output plugin appears to correctly pass the data stream's
> > endiness to the sound device, but a quick hack to swap data bytes also
> > fixed its playback problems.
>
> ??? this is strange - if it tells the truth (endianess, sample rate, depth &
> stereo/mono) - I think it should work...  there's no need to swap bytes at
> all with the audio - the hardware can do it...
>
> > I need to dig into the code some more, but
> > are we sure the AWACS Screamer in the Pismo isn't one of those variants
> > that only supports big-endian data?
>
> This is news to me see below.... (have you any reference for this issue?)

There is a past discussion on this in the archives (it may have
concerned
Takashi Oe's case of the NuBus P'Macs). A remote possiblity is something
has changed in the register mappings, or that this masking of the chip
is broken and Apple decided to ship it and work around the problem in SW
(a hardware designer's two most common phrases: "fix it in software" and
"software is easy:).

>
> > A quick test forcing the
> > AFMT_*_[LB]E
> > value to either value for the IOCTL doesn't make a difference.
>
> The awacs, screamer and burgundy chips *all* have an endian-swap capability
> AFAICT.  So, providing you tell the driver what you are supplying - it will
> work OK:
>
> ""If you set dmasound_awacs to the *correct settings for the data you pass
> to it* - it works.""

Using the OSS sound plugin with the hacks to force data to big endian
and
to hardcode just the IOCTL to different AFMT_ values; the only 16 bit
format
that didn't play back correctly was AFMT_U16_BE (very distorted, but
recognizable). Here the /dev/sndstat outputs from the four runs:

PowerMac (AWACS rev 3) DMA sound driver:
	sound.format = 0x20 (signed 16 bit big)
	sound.speed = 44100Hz (phys. 44100Hz)
	sound.stereo = 0x1 (stereo)
	sq.block_size = 4096 sq.max_count = 4 sq.max_active = 4
	sq.count = 0 sq.rear_size = 2048
	sq.playing = 0 sq.syncing = 0
[root@localhost linux]# cat /dev/sndstat
PowerMac (AWACS rev 3) DMA sound driver:
	sound.format = 0x10 (signed 16 bit little)
	sound.speed = 44100Hz (phys. 44100Hz)
	sound.stereo = 0x1 (stereo)
	sq.block_size = 4096 sq.max_count = 4 sq.max_active = 4
	sq.count = 4 sq.rear_size = 2048
	sq.playing = 2 sq.syncing = 0
[root@localhost linux]# cat /dev/sndstat
PowerMac (AWACS rev 3) DMA sound driver:
	sound.format = 0x80 (unsigned 16 bit little)
	sound.speed = 44100Hz (phys. 44100Hz)
	sound.stereo = 0x1 (stereo)
	sq.block_size = 4096 sq.max_count = 4 sq.max_active = 4
	sq.count = 4 sq.rear_size = 2048
	sq.playing = 2 sq.syncing = 0
[root@localhost linux]# cat /dev/sndstat
PowerMac (AWACS rev 3) DMA sound driver:
	sound.format = 0x100 (unsigned 16 bit big)
	sound.speed = 44100Hz (phys. 44100Hz)
	sound.stereo = 0x1 (stereo)
	sq.block_size = 4096 sq.max_count = 4 sq.max_active = 4
	sq.count = 4 sq.rear_size = 2048
	sq.playing = 2 sq.syncing = 0

I've had the same results with both /dev/audio and /dev/dsp.


>
> I have tested (yesterday - on a screamer) with:
> 44.1k LE stereo
> 22050 LE stereo
> 11025 A & mu Mono
> 8000 mu (into /dev/audio as well)
>
> I'll increase the coverage as/when I have time (it was incidental to some
> other testing).
>

I saw your test program post, I'll merge in your p15b1 patch later today
and give it a try.

> What you could send me that would be *very* helpful is:
>
> a dump of any device-tree contents that relate to sound.


pci@f2000000/mac-io@17/davbus@14000/sound:
name             "sound"
device_type      "soundchip"
compatible       "screamer"
                 "awacs"
                 ""
model            "343S0184"
vendor-id        0000106b (4203)
device-id        0000000a (10)
#-detects        00000003
#-inputs         00000006
#-features       00000001
#-outputs        00000002
object-model-version 00000001
sub-frame        00000000
icon-id          ffffbf4d (-16563)
info-id          ffffbf44 (-16572)
name-id          ffffbf4d (-16563)
sample-rates     00000002 56220000 ac440000
default-monitor  6e6f6e65 (1852796517)


I take it that it supports only 22K and 44.1K sample rates?

Another problem that I've run into in trying various versions
of XMMS and eSound, is that any of the newer eSound RPM or SRPM
packages I've tried, other than the 0.2.17 RPM in LPPC2K,
have all played back at very high speed (with 44.1k samples).
Not just with XMMS, but esdplay as well, haven't pursued it yet.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
