Date: Sun, 6 Aug 2000 08:26:40 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org,
        Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <200008060938.KAA25433@hyperion.valhalla.net>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000806081100.1409D-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Sun, 6 Aug 2000, Iain Sandoe wrote:

> OK - there's a lot of this in apps that came from x86 - they assume that the
> output is LE.

Is this really true?  What I have experienced over the years is quite the
opposite.  It is true that apps developed on x86 usually set the Linux
driver to accept AFMT_S16_LE; however, they often supply BE data on ppc
and LE data on x86.  For this reason, many apps from x86 camp just work if
AFMT_S16_LE in their codes were changed to AFMT_S16_NE.

>
> If you use my back-port - I "fixed" (kludged) the default dsp settings to
> 44.1k, 16 bit , stereo LE -- to be compatible with x86 progs that don't
> bother to set things up :-(

For those apps, AFMT_S16_BE as a default is more appropriate for the
reason above IMHO.

[...]
> > A quick test forcing the
> > AFMT_*_[LB]E
> > value to either value for the IOCTL doesn't make a difference.
>
> The awacs, screamer and burgundy chips *all* have an endian-swap capability
> AFAICT.  So, providing you tell the driver what you are supplying - it will
> work OK:

AWACS on NuBus PowerMacs doesn't support the byte swapping even though it
has the same revision number (2) as AWACS found on early PCI PowerMacs
which do support the byte swapping.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
