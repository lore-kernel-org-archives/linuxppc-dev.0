Message-ID: <398D1D45.9A5BA852@ncal.verio.com>
Date: Sun, 06 Aug 2000 01:09:41 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <200008040916.KAA26622@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
>
> I've been using the xmms CVS tree (www.xmms.org and follow the links).  It
> works fine with .wavs of different sample rates etc.  [xmms --version ==
> 1.2.1].
>

Which output plugin do you use?  And was that on a Pismo?

Looking at eSound and the XMMS ESD output plugin, they simply can't work
with little endian formats like .wav on a big endian machine. The esd
daemon
uses, and sets the output device to, native endiness (there isn't even a
parm to indicate endiness of the incoming data buffer). The XMMS ESD
output plugin completely ignores endiness of the incoming data stream
and
passes it through unchanged (versions 0.9.5, 1.2.1, 1.2.2). A quick hack
to swap bytes in the ESD plugin fixed playback of .wav files. The small
files that had worked before were all 8-bit mono format.

OTOH, the OSS output plugin appears to correctly pass the data stream's
endiness to the sound device, but a quick hack to swap data bytes also
fixed its playback problems. I need to dig into the code some more, but
are we sure the AWACS Screamer in the Pismo isn't one of those variants
that only supports big-endian data? A quick test forcing the
AFMT_*_[LB]E
value to either value for the IOCTL doesn't make a difference.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
