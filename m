Date: Wed, 28 Mar 2001 10:15:52 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328091553.4B07DDB9FC@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yasso Kostas!!! (I thought you'd gone out of circulation),

>> > I have no idea if how AWACS' tx dbdma behaves, but it may be necessary to
>> > make the write to control register multi-step or something, i.e., clear
>> > RUN [in order to clear DEAD bit] and wait until RUN bit is cleared by hw,
>> > then set RUN|WAKE..
>>
>> OK... that is different (in detail) from what was tried before - I think
>> I'll ask for a volunteer to test this...  Peter?
>
> Thats more or less what i first tried (with no luck...)

The code I posted (this am) is a subtle modification of what you tried - I
have to admit I don't expect it to behave differently - but the savings
would be very good if it does...

>> >> If it would, then we could save all this hassle completely...
>> >>
>> >> BTW: I don't *think* it does because one of my testers tried a similar
>> >> method to the one you proposed and said it chopped up/repeated sound.
>>
>> > Hmm, I think it has to be either "chopped up" or "repeated" not both..  As
>> > far as dbdma is concerned, those two are quite different effects.
>>
>> Well, with fragments of a few tens of ms - it's all highly subjective.
>
> With any ide activity the dbdma commands can fail repeatedly for a looong time
> in my machine (some times up to 10secs).....

even with IRQs allowed using hdparm ?

>> I see it like this:
>>
>> The sound is chopped up (since some form of blocking has caused the problem
>> in the first place)  and then the "fix" causes part of the sound to be
>> repeated - I think this is the origin of the apparently conflicting report.
>
> If the failed command is ignored then we have the "chopped up" effect (a
> 3min song finishes in less than 30secs this way under heavy ide activity..)
> The "repeated" effect shows up if the packet is resend to dbdma.

well, OK - let's see if the (very slight) change to what you did makes any
difference.

> btw about the sound related macos patch for some powercomputing machines
> might have nothing to do with this problem. Sound works fine in macos in my
> PowerWave without it, so macos already handles it right.

The MacOS extension patch fixes a "PCI timing problem" - specifically
claimed to stop PCI-based-IDE/Sound interaction (which is what we are
seeing).

- maybe later versions of MacOS already have the extension "built-in".

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
