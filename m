Message-ID: <3CD8BCF7.1090102@embeddededge.com>
Date: Wed, 08 May 2002 01:51:51 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 and skb implementation
References: <NCBBIINEHIPFGJPLBEIFGEKKDGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:

> If you have another 60X bus master, .....

Ah, right, now I remember.

> I do not know how to help you with hardware. I thought that the EST or
> Tundra eval cards had local RAM.

I had one of the original EST boards long ago.  When trying to use
the local RAM it would hang the CPM.  There are remnants of code in
the FCC driver that if enabled would keep the CPM buffer descriptors
and things in the local RAM.

> ... Do you believe moving SKB to local RAM has merit?

I wouldn't make any decisions without some benchmarks, but I suspect
CPM intensive access is more likely to benefit from using the local RAM.
Things like buffer descriptors and ATM control information will likely
win, I don't think SK bufs will because of the high processor core access.

> ... Any oppinion
> about the impact on the zero-copy implementation?

We should make the change to the receive side so this happens.  The
transmit doesn't copy.  I just copied the code from the 8xx long ago
and never made the change.  We can't properly do zero copy receive
on processors that don't have coherent caches due to alignment and
other information potentially shared in a cache line.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
