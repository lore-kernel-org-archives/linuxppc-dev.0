Message-ID: <000f01c245f9$5429e440$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se> <3D5D88C5.9030402@embeddededge.com> <002f01c245e2$de2223e0$0200a8c0@telia.com> <3D5E508E.90504@embeddededge.com>
Subject: Re: MPC860 reorder and invalidate dcache
Date: Sat, 17 Aug 2002 16:21:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Every 15 minutes seems like lots of activity for flash.  Better do some
> math based upon your expected product lifetime and ensure the flash will
> work for that many write cycles.   A few milliseconds every 15 minutes
> doesn't seem to be worth special software.

You are rigth. I will check.
>
>
> > I read somewhere that the 'sync' instruction is an expensive one and I don't understand
> > why it's used it in invalidate_dcache_range()
>
> You are nit picking details that aren't likely to have any effect on your
> system performance.  You need to use 'sync' to ensure the processor pipelines
> are drained into cache before you push the lines to memory.  Ensure you have
> considered what will happen to your application after you completely invalidate
> the cache, as there is more stuff in there than the range of data buffers
> you are considering.  It isn't very costly to scan the cache and discover there
> isn't as much to be done.  It is more costly to invalidate lines you are using
> and reload them.

I do a lot of invalidate_dcache_range(). I have 2 mappings, one cached and one uncached. I
use the cached one when the FS  read data from the flash(this will burst read from
the flash). The other mapping is used for flash commands and to write data to flash.
Each time I read I do a invalidate_dcache_range() to pick up updates made from
the uncached mapping.

I was just hoping that the 'sync' instruction was an "accident", but now I know
better.

>
>
> > Our app consists of a lot of processes that mostly pass messages(UNIX sockets) between eachother.
> > Do you think it's better to run the CPU in 66/66 MHz or (as we do today) 80/40 MHz?
>
> You will have to test it with your application.  My experience has been the faster
> core speed was always the winner.

OK
>
> > Would the "pinned TLB" mode be helpful(we have plenty of memory,128MB)?
>
> Maybe.  Again you will have to test this.  With that much main memory it
> may not be helpful because you have to cover so much kernel space with
> page tables anyway.
OK

Thanks, for bearing with me.

      Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
