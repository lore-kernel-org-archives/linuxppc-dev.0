Date: Fri, 19 Jan 2001 04:11:15 +0000
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010119040949.10F902F045@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Fri, Jan 19, 2001, Takashi Oe wrote:
> On 1/18/01 8:30 PM, Iain Sandoe wrote:

>> my only justification is a case of expediency:

I should have said temporary** expediency.

>> many apps ; one driver ; very, very few linux ppc audio developers.
>
> Do you have any hard number?  How many *popular* apps does the pismo change
> break?

well, I don't have a hard number - I guess a count off the stuff linked to
http://www.linuxdj.com/audio/lad/ might be quite accurate

- but if you do a quick check back over this list you will find that quite a
few 'popular' (including major ones like xmms + its plug-ins, arts, ecasound
etc.) one have  been mentioned. (even sox produces LE raw output by default
- yuck!).

Yes, the broken ones could/should all be fixed* (some have BTW) - any
volunteers?   (I could *very* easily make the driver support hardware-only
formats).

>I don't there are so many linux audio apps to begin with.

sadly, true - but there are more apps that _use_ audio - like kde - which
_is_ (I am told) broken for pismo (I don't have one) without LE data support
and, of course, games.

>> If and when ALSA is accepted into linux we can/will throw this current
>> driver away.  If it is built as a module - it has no lasting impact on the
>> kernel.
>
> I think ALSA will be in, but do you know for sure OSS will go away?
> Besides, people will be using 2.4 for a long time, and I don't think OSS
> will go away from 2.4 ever.

ALSA has a backward compatibility OSS layer - implemented according to the
kinds of rules that we both agree are desirable.

I expect ALSA will get "back-ported" to 2.4.0 - since (although it is not
currently, officially in linux) it is being developed on 2.4

- no OSS won't go away from 2.4 - I am sure - but development is likely to
stop - and people are likely to use an ALSA compatibility layer rather than
load/reload drivers.

====

Actually, I'm not sure why I'm debating ;-/

- I agree with you - and I have little use for the compressed formats
personally.

I am interested in professional quality audio on the right platform (i.e.
PPC)... I was working on the dmasound driver in order to understand the
hardware well enough to do an ALSA version (which of course has no such
translations internally) ;-)))

I guess sometimes it's nice to "keep end users happy" tho' :-)

iain.

---
* basically, to fix an OSS app that does not do its own conversion can be
quite a lengthy job... plumbing in the necessary provisions. endian-swapping
is a small task - rate conversion/decompression might not be.

of course, you avoid kernel bloat at the expense of application bloat -
which is solved by the following:

**It is my understanding that ALSA provides a mid-layer based on a
user-space lib.  This means that it is not necessary for each app to provide
the translations - whilst they are still executed in the correct state -
i.e. user.  No kernel bloat, no application bloat.
------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
