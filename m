Date: Sat, 31 Mar 2001 21:26:06 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I-cache flushing on the 7400
In-Reply-To: <20010331201550.A20735@ibrium.se>
Message-ID: <Pine.HPX.4.10.10103312111010.18988-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 31 Mar 2001, Samuel Rydh wrote:

>
> On Sat, Mar 31, 2001 at 07:51:55PM +0200, Gabriel Paubert wrote:
>
> > > 	LI_PHYS( r2,split_store_patch )
> > > 	stw     r4,0(r2)			// store instruction
> > > 	dcbst   0,r2				// Flush cache
> > > 	sync
> > > 	icbi    0,r2
> > > 	isync
> > >
> > > 	.... some instructions and then a rfi to split_store_patch ....
> > > 	rfi
> > >
> > > split_store_patch:
> > > 	nop
> > >
> >
> > It should, while actually the isync does not seem necessary since rfi
> > is a context synchronizing instruction (rfi and sc include implicitly the
> > equivalent of an isync).
>
> Yes, but in this case the rfi instruction is within the same cache-line
> as the nop. I think I need the extra isync to make sure the cache
> line in question is not touched before the invalidation is completed.

As I understand the doc, you should not need it. The rfi is executed
before the patched instruction, therefore the isync is redundant. It is
the sync instruction that guarantees that the invalidation is completed.
Even if the instructions up to the rfi and the patched instruction are in
the prefetch queue, they will be flushed by the rfi and loaded again into
the instruction cache after the context synchronization due to rfi.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
