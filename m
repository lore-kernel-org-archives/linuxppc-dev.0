Date: Wed, 28 Mar 2001 11:55:03 +0100
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328105501.E28EEDBA11@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Wed, Mar 28, 2001, Kostas Gewrgiou wrote:
> On Wed, 28 Mar 2001, Iain Sandoe wrote:

>> attached is a replacement for the dmasound_awacs tx_irq routine to test out
>> Takashi's idea of clearing the DEAD status and then re-starting dma.
>>
>> it is *not* a diff - you will have to replace the routine by cut-and-paste
>>
>> (I've done it this way because my current tree has lots of other changes
>> which aren't relevant to this test).
>>
>> I checked it builds - but can't test 'cos I don't have a PowerComputing
>> machine.
>>
>> Please try it with big-ish fragments - so that there is a chance of hearing
>> whether resumed blocks repeat sound.
>
> With a quick look it doesn't seem that it will work, you only need to return
> if you restart the frame otherwise the driver will deadlock,

we do restart the frame - with the:

    /* may as well try anyway - I guess all bets are off now */
    out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));

the difference from what you did is that I don't re-load the cmdptr register
- we are just going to see if the current state can be resumed.

It might lock up - but it's worth a try.

> Do we need the in_le32(&awacs_txdma->status) & RUN check ? isn't dbdma
> already inactive at that point ?

maybe - I think that the ACTIVE bit will be cleared.

but maybe not the RUN bit - because I think the transition *in the on-chip
register* from RUN to ~RUN acknowledges the clearing of the DEAD status.

then the command above restarts it...

well, that's what we're trying anyway - I've coded the emergency dbdma
method - so if this fails I'll post that instead.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
