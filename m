Message-ID: <3CAB3F0B.8080700@embeddededge.com>
Date: Wed, 03 Apr 2002 12:42:35 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Well, I'm not sure I'd want to pollute the tree with this sort of
> hack, but on the other hand it makes things work that wouldn't
> otherwise.

This has been floating around for a long time while we were searching
for the proper solution.  As you said, if you want things to work, you
have to do this.  This still isn't logically correct, it just makes
the window of error smaller.

This is one of several problems in the Linux kernel that has to be
solved for processors that don't have bus snooping.  All we have been
doing over time is making the problems less apparent, not solving them.
There are similar hacks for DMA into sk buffers, which still doesn't
work in forwarding/bridging applications (you won't notice the bugs
in endpoint only situations).

The real problem to be solved is any memory object that can be the target
for DMA has to be cache line aligned, and modulo cache line size for
incoherent processors.  Since few people work with this type of processor,
it is hard to get maintainers interested in making these general changes
(and polluting the Linux kernel with knowledge of cache line size).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
