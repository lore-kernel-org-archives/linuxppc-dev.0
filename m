Date: Fri, 04 Apr 2003 17:09:01 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <IGEFJKJNHJDCBKALBJLLKEKBFLAA.joakim.tjernlund@lumentis.se>
To: Dan Malek <dan@embeddededge.com>,
	Till Straumann <strauman@slac.stanford.edu>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEMCFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > The current implementation relies on TLB Miss always setting EPN
> > (and other hardware assist registers) correctly, and TLB Error
> > relies on DAR being set correctly.  Everything works fine until
> > you get a TLB Error on a dcbz/dcbt that doesn't properly update DAR.
> > In this case EPN isn't set correctly either.
>
> I just want to point out(again) that TLB Miss caused by most of the
> dcxx(dcbf, dcbi, dcbst, dcbz) instructions that end up in the slow path(DataAccess)
> don't work with the current impl. since DAR isn't set. The code fragment below
> will fix that(from my earlier patch). This won't affect the fast path at all
> since it all of it can be in the slow path.
>
> +	/* Copy 20 msb from EPN to DAR since the dcxx instructions fails
> +	 * update the DAR when they cause a DTLB Miss.
> +	 */
> +	mfspr	r21, MD_EPN
> +	rlwinm	r21, r21, 0, 0, 19
> +	mfspr	r20, DAR
> +	rlwinm	r20, r20, 0, 20, 31
> +	or	r20, r20, r21
> +	mtspr	DAR, r20
>
> It is hard to end up in slow path for kernel space addresses, but
> it's not impossible I guess. Comments?

hmm, no response from the maintainer(s). You don't agree?

Did another test. I tagged DAR with a bad address(0xdead0000) in
the TLB Miss handler(after the mtspr MD_RPN, r20) shortly before
rfi.

Now the kernel won't boot. It turns out it's consistent_alloc that is
doing a invalidate_dcache_range(). According to a comment, memory is allocated
from the vmalloc memory space. Doing a invalidate_dcache_range() on this memory
causes a DTLB error with the change bit cleared and since DAR isn't set by
dcbi, linux hangs.

Clearly, the DTLB exeception procedure still is buggy.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
