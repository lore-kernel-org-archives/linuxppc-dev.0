Message-ID: <002f01c245e2$de2223e0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se> <3D5D88C5.9030402@embeddededge.com>
Subject: Re: MPC860 reorder and invalidate dcache
Date: Sat, 17 Aug 2002 13:40:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I wonder if the MPC860 really can reorder I/O memory accesses?
>
> I don't believe so.  I have sloppily written code that would have
> shown problems if it did, and have never seen it occur.
>
> > .... affects performance somewhat.
> > Is the wmb() required or can I skip it?
>
> Can you actually quantify the performance difference and is it important?

I could do a number of "time cp file1 file2" to measure the difference.
We do  logging every 15 min and SW upgrades. It would be nice if this went a little faster.

> I would strongly recommend using all of the proper memory/IO barriers since
> you never know what will happen with a new version of processor.  It is
> also nice to do this for someone that may wish to use the code in a more
> general manner. :-)

Point taken, but this is in the mtd flash map file which defines the layout of our flash in our custom board
so I don't think there is much to use in a general manner.

I may have some general changes to the enet.c file though, but these needs cleaning first.

>
> > Is there a faster way to invalidate the dcache for a big(256KB) area than using invalidate_dcache_range().
> > The area is PAGE aligned.
>
> There are cache operations using SPRs unique to the 8xx that can do this, however,
> I'm not sure it saves much over using the standard PowerPC functions. They are mostly
> useful during initialization and for special static MMU applications.

OK, maybe it would be faster to just invalidate the whole dcache?
I read somewhere that the 'sync' instruction is an expensive one and I don't understand
why it's used it in invalidate_dcache_range()

Finally(if I may):
Our app consists of a lot of processes that mostly pass messages(UNIX sockets) between eachother.
Do you think it's better to run the CPU in 66/66 MHz or (as we do today) 80/40 MHz?
Would the "pinned TLB" mode be helpful(we have plenty of memory,128MB)?

      Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
