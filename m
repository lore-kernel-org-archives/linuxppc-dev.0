Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Daniel Jacobowitz" <drow@false.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: Improved copy_page() function, about 30% speed up for mpc860!
Date: Tue, 4 Mar 2003 16:24:55 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLMEMJFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E64AB2B.6030804@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well, I suspect it's luck more than stable. :-)

Maybe :-)

>
> I suggest you debug the failure cases and determine what is really
> wrong.  We know from past history that the cache instructions on 8xx
> are troublesome and if we avoid them the system is truly stable.  The
> execution of the cache instructions is identical whether you are using
> them on kernel or user pages, the main difference is you are more likely
> to hit TLB refill/update cases when using user space pages, exactly
> one of the problem triggers.  If it's working on kernel pages and not
> user pages, or some other combinations, you are just being lucky.  The
> cache instructions will do the right thing if the mapping is present
> in the TLB (and you don't get a write/update miss) and the page is
> cached.  If you don't have the page cached or you get any TLB exception
> the results are unpredictable and the result varies depending upon
> silicon revision.

hmm, I found this comment in head_8xx.S:
	/* The EA of a data TLB miss is automatically stored in the MD_EPN
	 * register.  The EA of a data TLB error is automatically stored in
	 * the DAR, but not the MD_EPN register.  We must copy the 20 most
	 * significant bits of the EA from the DAR to MD_EPN before we
	 * start walking the page tables.  We also need to copy the CASID
	 * value from the M_CASID register.
	 * Addendum:  The EA of a data TLB error is _supposed_ to be stored
	 * in DAR, but it seems that this doesn't happen in some cases, such
	 * as when the error is due to a dcbi instruction to a page with a
	 * TLB that doesn't have the changed bit set.  In such cases, there
	 * does not appear to be any way  to recover the EA of the error
	 * since it is neither in DAR nor MD_EPN.  As a workaround, the
	 * _PAGE_HWWRITE bit is set for all kernel data pages when the PTEs
	 * are initialized in mapin_ram().  This will avoid the problem,
	 * assuming we only use the dcbi instruction on kernel addresses.
	 */

Does this workaround also work for dcbz on kernel addresses?

Also, will the Pinned TLB feature for 860 help here?
It is the DataTLBError exception that is causing(if I have understood
the problem correctly), so if the kernel always has a TLB for kernel
space addresses, dcbz and friends will work correctly for kernel addresses?

>
> This is something that is difficult to debug and we can't dismiss this
> with a solution of different copy functions.  The clear/copy functions
> for the 8xx should be identical to all other PowerPC cores, and if they
> don't work that way we need to determine why.  At least you have the
> knowledge that these instructions are troublesome.  It took me many months
> to discover this the first time, and perhaps they still misbehave.

Yes I am sure it's very hard to debug and probably over my head :-(
I will try a litte bit more though and see very it takes me.

      Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
