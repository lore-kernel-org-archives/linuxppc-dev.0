To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Berlin <dan@www.cgsoftware.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 status
References: <Pine.LNX.4.33.0105042358480.6265-100000@www.cgsoftware.com>
	<20010505135008.31470@smtp.wanadoo.fr>
From: Daniel Berlin <dan@cgsoftware.com>
Date: 05 May 2001 12:09:50 -0400
In-Reply-To: <20010505135008.31470@smtp.wanadoo.fr> (Benjamin Herrenschmidt's message of "Sat, 5 May 2001 15:50:08 +0200")
Message-ID: <87lmobdbg1.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> >You can say whether you want the following swapped  or not (in any
> >combination, they are just flags)
> >
> >1. selfid handling
> >2. reading
> >3. writing
> >
> >
> >Pismo needs 2 and 3 to work right.
> >Other OHCI on PPC (TI) need 1, 2, and 3.
> >Your titanium probably needs 2 and 3, since i believe it's based on the
> >uninorth, just a newer revision, right?
>
> The titanium is the same logic board as the Pismo (well, almost). The
> last TiPb I had a chance to play with had the exact same UniNorth revision
> as the Pismo.
>
> When you say you need byteswap on read & write, is this for data packets
> read/written to/from memory (DMA) or is this for datas you feed to
> (read from) a FIFO ? Just curious...

It's for the actual packet data in the third and fourth quadlets, at
least right now.  It's necessary because motherboard implementations
aren't required to support the byte swapping flag that normally takes
care of this. And the uninorth doesn't.
DMA is another issue altogether.
>
> >It'll be on the 1394 list in about 10 minutes.
>
> Is it against the 1394 CVS or will the current 2.4.4 1394 code work fine
> with your patch as well ?

It's against 1394 CVS, because that's what was easiest to diff against
(cvs diff -c3p, hand edit, done).
I always run your latest kernel, so i'm sure it works there too.

There are some 2.4 specific optimizations I made (use tasklets rather
than bottom halves, use a kmem_cache for packet allocation [
kmem_caches in 2.2 have some problems]) that i'd include if you want
to put it in the kernel.


> In that later case, I'll include your patch in my
> kernels.



>
> Ben.
>

--
"If you were going to shoot a mime, would you use a silencer?
"-Steven Wright

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
