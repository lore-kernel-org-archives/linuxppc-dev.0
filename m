From: benh@kernel.crashing.org
To: Dan Malek <dan@embeddededge.com>, <acurtis@onz.com>
Cc: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: eieio rule-of-thumb?
Date: Thu, 23 May 2002 19:44:25 +0100
Message-Id: <20020523184426.19045@mailhost.mipsys.com>
In-Reply-To: <3CED26BB.2080700@embeddededge.com>
References: <3CED26BB.2080700@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>What doesn't make sense is why we use eieio at all......All of the
>mapped I/O space is marked uncached 'guarded' in the PTE, which enforces
>in-order load/store operations.  This should also prevent store gathering in
>bridges since they shouldn't see a burst write from a processor store
>operation.

Regarding eieio on uncached, Paul or Anton can tell you more about it,
I think there is still a case where guarded doesn't prevent a load
from moving accross a store.

Regarding the bridge, the while point of store gathering in bridges
is to make bursts when the CPU doesn't. That's what most bridges call
'write combine'. It's done, for example, but UniNorth rev >= 1.5 on
macs when targeting the AGP bus.

>If you want higher peformance programmed I/O access, then you should cache
>some of the space, and at that time you must use eieio if there are cached
>areas subject to out of order access problems.

And beware that eieio won't be a barrier between cacheable and non cacheable
space. So if you need your cacheable stores to be complete before you write
to non-cacheable space (a register for example), you need to use sync.

>On the 8xx and 8260 family, all of the I/O (including the internal memory
>space) is mapped uncached and guarded.  I've never used eieio nor seen
>any reason it was necessary.

I think it is on desktop CPUs, but again, here, Paul and Anton have more
knowledge than I do.

>Where you will see problems, especially on 4xx and potentially on 8xx,
>is the use of "regular" memory for control structures and special registers
>for other control.  You can write to memory, which gets stuck in pipelines,
>then whack a DCR (which seems to have some magical fast path update) causing
>the peripheral to start up before the pipelined writes have made it to
>memory.  I'm wondering if we aren't just lucky with the eieio side effects
>when a 'sync' would be the logically correct operator.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
