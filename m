Date: Wed, 28 Mar 2001 12:54:47 +0100
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328115447.EE3A9DB9E9@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wed, Mar 28, 2001, Kostas Gewrgiou wrote:
> On Wed, 28 Mar 2001, Iain Sandoe wrote:
>> > With a quick look it doesn't seem that it will work, you only need to
return
>> > if you restart the frame otherwise the driver will deadlock,
>>
>> we do restart the frame - with the:
>>
>>     /* may as well try anyway - I guess all bets are off now */
>>     out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
>>
>> the difference from what you did is that I don't re-load the cmdptr register
>> - we are just going to see if the current state can be resumed.
>>
>> It might lock up - but it's worth a try.
>
> Nope it doesn't restart the frame, thats why we need to either reload it
> and return or continue as if it played correctly.

ahhh.  I was wondering if you'd tried this.

Unfortunately you can't just re-load the frame with an adjusted count - you
need to bump the data start address as well - which is the reason for
introducing the emergency cmd buffer.

OK... well, I'll try and post the emergency dbdma cmd version soon.

> I was wondering again today why we get the DEAD status in the powercomputing
> machines everything was working fine until 2.2.9/10 (there were no changes
> in dmasound at that point) so some other change is causing this i can't
> imagine anything though :(

changes in PCI IDE drivers or bus arbitration control?

(the bug has the appearance of a bus lock-out preventing dma transfer in
time).

Some interesting figures (if I've got this right) - IIRC the minimum PCI dma
transfer is 64 bytes - which corresponds to 16 sample frames (stereo, 2
bytes per ch).

At 44k1 (fastest) this would occur every 363us (approx.).  That's a long
time for the PCI bus to be locked up for (depending on how far ahead the
controller tries to fetch the next block of data).

anybody able to check?

I don't think it's IRQ-blocking because the residue count in DEAD frames is
non-zero (if the frame had finished but IRQs were blocked too long - I think
the residue would have to be zero)...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
