Message-Id: <200008041305.OAA01797@hyperion.valhalla.net>
Date: Fri, 04 Aug 2000 14:05:11 +0100
Subject: Re: CDDA playback on Pismo (and other newer models)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[...]
>>From the the drive's spin-up sounds it seems to always be in
>>high-speed mode, but unlike the ATAPI driver, there is little
>>head movement noise.
>
> I think the problem is more with cdparanoia. I think it's more or less
> synchronous, it doesn't have a thread that collects datas while another
> outputs sounds. I've looked at cdparanoia sources some time ago, and I
> think and intermediate step of buffering is necessary.

>From my IRQ latency measurements I would think that there was *no* chance
without the intermediate step.  On my Lombard, CD access over IDE can mask
IRQs for 2 >>ms<<<  which also means you need to make sure the audio frag
sizes are sensible as well... i.e. don't try 2 frags of 256 bytes - it won't
work as things stand.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
