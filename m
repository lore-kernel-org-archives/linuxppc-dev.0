Message-Id: <200008070903.KAA25166@hyperion.valhalla.net>
Date: Mon, 07 Aug 2000 10:03:23 +0100
Subject: Re: CDDA playback on Pismo (and other newer models)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>, Takashi Oe <toe@unlserve.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org,
        matthias pfisterer <matthias.pfisterer@gmx.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Mon, Aug 7, 2000,  Henry Worth  wrote:
> Takashi Oe wrote:
>>
>> On Sun, 6 Aug 2000, Henry Worth wrote:
>>
>> [...]
>> > This won't help in the esd case, it always sets the device to
>> > AFMT_S16_BE for 16 bit data on big endian systems (also doesn't deal
>> > with
>> > unsigned 16 bit data streams). Whereas the XMMS esd output plugin always
>> > passes the data through unchanged (little endian in the case of .wav).
>>
>> Does xmms' esd output plugin work with 16bit .wav at all on x86?  Since
>> sox works just fine with 16bit .wav, and it doesn't do any byte swapping
>> either as far as I know (which is not much admittedly), I'm very much
>> inclined to think xmms+esd is plain broken with respect to 16bit wav.
>>
>> Takashi Oe
>
> The esd daemon sets the output to native endiness, so on an x86
> everyone is little endian and all should be well, but I haven't
> tried it.

so long as the last thing in the chain (i.e. the one that talks to /dev/dsp)
is prepared to:

*either* re-set the AFMT of /dev/dsp
       (depending on the format of the stream presented to it)
*or* leave /dev/dsp AFMT at one setting
       AND do the necessary conversions

everything will be OK.

Of course, there are other solutions - but these would depend on each app
"knowing" that the server only accepts input in format "XXX" which seems
broken to me... (although it has a certain simplicity - if there's a way of
telling the client apps that this is the case).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
