Date: Mon, 7 Aug 2000 15:18:21 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org,
        matthias pfisterer <matthias.pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <200008070903.KAA25166@hyperion.valhalla.net>
Message-ID: <Pine.SOL.4.10.10008071429060.8244-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, Iain Sandoe wrote:

> On  Mon, Aug 7, 2000,  Henry Worth  wrote:
> >
> > The esd daemon sets the output to native endiness, so on an x86
> > everyone is little endian and all should be well, but I haven't
> > tried it.
>
> so long as the last thing in the chain (i.e. the one that talks to /dev/dsp)
> is prepared to:
>
> *either* re-set the AFMT of /dev/dsp
>        (depending on the format of the stream presented to it)
> *or* leave /dev/dsp AFMT at one setting
>        AND do the necessary conversions
>
> everything will be OK.

In the case of the esd daemon it does the ioctls to set the format
to signed native endiness, and they even do some error checking.

>
> Of course, there are other solutions - but these would depend on each app
> "knowing" that the server only accepts input in format "XXX" which seems
> broken to me... (although it has a certain simplicity - if there's a way of
> telling the client apps that this is the case).
>
> Iain.
>

It looks like esd is going for simplicity. Since they are mixing
digital sound streams to integrate sound sources on the desktop,
they ultimately need to get all the incoming data streams into native
endiness to do the mixing. I assume they just chose to put the
burden on the clients (I'll be charitable and not assume LE blindness
and that the setting to native endiness was a quick hack when the
endiness issue was brought to their attention). They would also
need common sample rates, but I haven't looked into how much the
daemon will do to up/down-convert, but expect that is limited as
well.

I'll put together a patch for the XMMS esd plugin, but I
need to look into portability issues for the endiness test and
optimal byte swapping, any suggestions?  It could also
use an unsigned->signed conversion.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
