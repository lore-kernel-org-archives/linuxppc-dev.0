Message-ID: <3D5D88C5.9030402@embeddededge.com>
Date: Fri, 16 Aug 2002 19:20:37 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 reorder and invalidate dcache
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I wonder if the MPC860 really can reorder I/O memory accesses?

I don't believe so.  I have sloppily written code that would have
shown problems if it did, and have never seen it occur.

> .... affects performance somewhat.
> Is the wmb() required or can I skip it?

Can you actually quantify the performance difference and is it important?
I would strongly recommend using all of the proper memory/IO barriers since
you never know what will happen with a new version of processor.  It is
also nice to do this for someone that may wish to use the code in a more
general manner. :-)


> Is there a faster way to invalidate the dcache for a big(256KB) area than using invalidate_dcache_range().
> The area is PAGE aligned.

There are cache operations using SPRs unique to the 8xx that can do this, however,
I'm not sure it saves much over using the standard PowerPC functions. They are mostly
useful during initialization and for special static MMU applications.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
