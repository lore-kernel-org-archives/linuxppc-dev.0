Message-ID: <3D5E508E.90504@embeddededge.com>
Date: Sat, 17 Aug 2002 09:33:02 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 reorder and invalidate dcache
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se> <3D5D88C5.9030402@embeddededge.com> <002f01c245e2$de2223e0$0200a8c0@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> We do  logging every 15 min and SW upgrades. It would be nice if this went a little faster.

Every 15 minutes seems like lots of activity for flash.  Better do some
math based upon your expected product lifetime and ensure the flash will
work for that many write cycles.   A few milliseconds every 15 minutes
doesn't seem to be worth special software.


> I read somewhere that the 'sync' instruction is an expensive one and I don't understand
> why it's used it in invalidate_dcache_range()

You are nit picking details that aren't likely to have any effect on your
system performance.  You need to use 'sync' to ensure the processor pipelines
are drained into cache before you push the lines to memory.  Ensure you have
considered what will happen to your application after you completely invalidate
the cache, as there is more stuff in there than the range of data buffers
you are considering.  It isn't very costly to scan the cache and discover there
isn't as much to be done.  It is more costly to invalidate lines you are using
and reload them.


> Our app consists of a lot of processes that mostly pass messages(UNIX sockets) between eachother.
> Do you think it's better to run the CPU in 66/66 MHz or (as we do today) 80/40 MHz?

You will have to test it with your application.  My experience has been the faster
core speed was always the winner.

> Would the "pinned TLB" mode be helpful(we have plenty of memory,128MB)?

Maybe.  Again you will have to test this.  With that much main memory it
may not be helpful because you have to cover so much kernel space with
page tables anyway.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
