Message-ID: <3CACB5B7.4000702@routefree.com>
Date: Thu, 04 Apr 2002 12:21:11 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com> <20020404034809.GL21034@zax> <3CABD1E0.7020008@embeddededge.com> <20020404052349.GN21034@zax> <3CABEDE9.5020404@embeddededge.com> <20020404063051.GP21034@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What we ended up doing was adding a debug wrapper around the invalidate
routine that squealed whenever a non-aligned invalidation was attempted.
  This was/is a useful tool for finding potential problems - but can
create lots of false positives.  Unfortunately in order for something
like this to work, you have to have a consistent philosophy for handling
dma'able buffers where, when they are aligned and bloated that this
address and length is used for invalidation operations.  This gets into
the problem of sometimes wanting to know the true length and the
requested length and maybe not having both available.

It would be nice if there was more structure to enforce drivers and
other subsystems to do things right, mostly because things like
inadvertent line sharing are a real pain to track down.
	david


David Gibson wrote:
> On Thu, Apr 04, 2002 at 01:08:41AM -0500, Dan Malek wrote:
>
>>David Gibson wrote:
>>
>>
>>>Possibly a better approach would be to make the consistent_sync()
>>>function be more careful and flush rather than invalidate cachelines
>>>
>>That's basically what this patch does, with the overhead of always
>>writing instead of just invalidating.  We just went the whole circle
>>here, as this isn't a logically correct solution :-).
>>

> http://www.ozlabs.org/people/dgibson
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
