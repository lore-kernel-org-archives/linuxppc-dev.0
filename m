Date: Fri, 04 Apr 2003 18:37:29 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E8DA82A.9070809@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Till Straumann <strauman@slac.stanford.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEMDFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > hmm, no response from the maintainer(s). You don't agree?
>
> It's interesting to watch these hacks, but I can't justify
> complicating a general purpose function with more bus cycles by
> emulating a functional problem.  By not using these instructions
> we have a working system that costs just a few more cycles during
> the memory copy/zero operations.  If we had _working_ dcbz
> instructions, it would be a gain to use them, but from a system
> perspective it is going to cost more to "fix up" these than
> the code that already exists.

Look a little harder. I am not talking just about dcbz, dcbi has
the same problem. As it stands today, there are real bugs w.r.t dcbi.

consistent_alloc() causes DTLB errors with a incorrect address in DAR.
Just force DAR to an invalid address in the DTLB Miss handler before
you leave it and see if you kernel boots.

> As I said in the past, I'm sensitive to the code in the TLB exception
> processing.  So do something to remove code and streamline the process
> and I'm really interested.  Do something to add more code and it's
> going to get placed pretty low in my pile of things to do.

Yes I know, but you are not reading what am writing. For instance,
the change below does not add to the fast path of the DTLB Miss handler and
it fixes a real problem:
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

Go back and think dcbi instead of dcbz.

     Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
