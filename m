Date: Wed, 28 Mar 2001 08:06:46 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328070644.8D1F9DB9D3@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 28, 2001, Takashi Oe wrote:
> On Tue, 27 Mar 2001, Iain Sandoe wrote:
>
>> I wish I knew whether it would resume... it's not clear from the
>> documentation I've got... (the IBM stuff).
>
> It may be implementation dependent.  MACE driver stops tx dma and resumes
> afterwards, so tx side of dbdma on MACE must support it.

are you sure it will re-start *part way* through a dbdma command (and not
just re-send the entire block)?   (the latter is what sound dma seems to
do).

It doesn't appear to make sense to resume part of a block on ethernet...
(i.e. once you've missed the Xmit deadline the packet is trashed - so you'll
have to re-send anyway).

BTW: the same mac-io chip is responsible for both sound & ethernet dbdma -
so it seems possibly unlikely that the behaviour would be different.

> I have no idea if how AWACS' tx dbdma behaves, but it may be necessary to
> make the write to control register multi-step or something, i.e., clear
> RUN [in order to clear DEAD bit] and wait until RUN bit is cleared by hw,
> then set RUN|WAKE..

OK... that is different (in detail) from what was tried before - I think
I'll ask for a volunteer to test this...  Peter?

>> If it would, then we could save all this hassle completely...
>>
>> BTW: I don't *think* it does because one of my testers tried a similar
>> method to the one you proposed and said it chopped up/repeated sound.
>
> Hmm, I think it has to be either "chopped up" or "repeated" not both..  As
> far as dbdma is concerned, those two are quite different effects.

Well, with fragments of a few tens of ms - it's all highly subjective.

I see it like this:

The sound is chopped up (since some form of blocking has caused the problem
in the first place)  and then the "fix" causes part of the sound to be
repeated - I think this is the origin of the apparently conflicting report.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
