Date: Tue, 27 Mar 2001 22:31:29 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010327213129.672B0DBA03@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Takashi,
On Tue, Mar 27, 2001, Takashi Oe wrote:
> On Tue, 27 Mar 2001, Iain Sandoe wrote:
>
>> Well, when I first started "looking after" the driver I though this too.
>>
>> but... the status in the controller relates to the currently active dbdma
>> command (I believe - please correct me if you know better ;-).
>>
>> When we get the IRQ for the command completion - a new chained cmd may (in
>> fact *should* if sound is not to have breaks)  have started.
>>
>> Therefore we *must* look at the stored result - because the one in the chip
>> doesn't have any relationship to the IRQ we are handling.
>>
>> The same would apply to *any* dbdma work that involved chained commands
>> AFAICT.
>
> Yes, in theory  :)  It doesn't apply to bmac case as I noted previously.
> I think it's better to check cmdptr register of dbdma channel for finding
> out how far ahead dbdma is.

I think this is a good point... if I compare them and find them equal (like
in your code snippet) then I can look in the status register safely.  We are
in the IRQ handler so ints are already masked.

I want to implement SNDCTL_DSP_GETI/OPTR soon anyway... so maybe as part of
that.

> As for the "DEAD" status, doesn't the dbdma stop right there?

I guess so.  I don't have a PowerComputing machine to check on - I'm relying
on two other guys helping out with testing...

>I'd think
> looking at "status" register would suffice.  Is "xfer_status" field
> serving any other purpose in your fix possibly?

I suspect you are right - and I don't remember if I actually read the status
register in my fix (I'm not on that machine right now)... I might well do.

However, the effect will only be noticed after the loop check the
xfer_status field and finds that it shows "DEAD" (IIRC).

>> Well, if we get horrendous IRQ hold-offs then maybe - but at the moment I
>> think that the residue information stored in the dbdma command buffer will
>> do.
>
> There is usually a res_count register (not the dbdma_cmd one) associated
> with each dbdma channel somewhere.  IIRC, unless dbdma is "FLUSH"ed, the
> res_count value may be off a bit.

Yes, OK that might be worth looking at - I'll see what I've done in my fix.

>> > Is it not possible to "fix" the command in place and let DBDMA go?
>>
>> That was my original idea too... but...
>>
>> It gets messy to do that - because the buffer start addresses are assigned
>> in XXXX_dbdma_setup()
>
> What happes if you just issue (RUN|WAKE|PAUSE|DEAD)<<16|(RUN|WAKE) to
> dbdma control register when DEAD condition is detected?  I wonder if it's
> possible to let dbdma pick up where it left off without touching any dbdma
> command..

I wish I knew whether it would resume... it's not clear from the
documentation I've got... (the IBM stuff).

If it would, then we could save all this hassle completely...

BTW: I don't *think* it does because one of my testers tried a similar
method to the one you proposed and said it chopped up/repeated sound.

anyone else know?

>> a spare dbdma command block costs 16 bytes of memory.
>
> Not 32?  No branch back to original command table?

duh ;-) bad memory - should have looked at the code (it's just allocated as
a standard dbdma cmd block - same as the others).

Anyway I was, exaggerating a bit - because there's another 4 bytes for the
pointer to the cmd ;-)))

but the point was that I don't think the extra memory usage for this comes
anywhere near what would be required for a fix based on re-setting the base
addresses each time.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
