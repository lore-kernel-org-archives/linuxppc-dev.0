Return-Path: <dgibson@ozlabs.org>
Date: Tue, 14 Aug 2007 17:48:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: gregkh@suse.de, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, stable-commits@vger.kernel.org
Subject: Re: patch powerpc-fix-size-check-for-hugetlbfs.patch queued to
	-stable tree
Message-ID: <20070814074833.GG8791@localhost.localdomain>
References: <1186551855.938.164.camel@localhost.localdomain>
	<20070813234218.4796D14540D0@imap.suse.de>
	<20070814064534.GE8791@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070814064534.GE8791@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 14, 2007 at 04:45:34PM +1000, David Gibson wrote:
> On Mon, Aug 13, 2007 at 04:26:27PM -0700, gregkh@suse.de wrote:
> > 
> > This is a note to let you know that we have just queued up the patch titled
> > 
> >      Subject: powerpc: Fix size check for hugetlbfs
> > 
> > to the 2.6.22-stable tree.  Its filename is
> > 
> >      powerpc-fix-size-check-for-hugetlbfs.patch
> > 
> > A git repo of this tree can be found at 
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > 
> > >From benh@kernel.crashing.org  Mon Aug 13 16:17:09 2007
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Wed, 08 Aug 2007 15:44:15 +1000
> > Subject: powerpc: Fix size check for hugetlbfs
> > To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
> > Cc: Paul Mackerras <paulus@samba.org>, stable@kernel.org
> > Message-ID: <1186551855.938.164.camel@localhost.localdomain>
> > 
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > My "slices" address space management code that was added in 2.6.22
> > implementation of get_unmapped_area() doesn't properly check that the
> > size is a multiple of the requested page size. This allows userland to
> > create VMAs that aren't a multiple of the huge page size with hugetlbfs
> > (since hugetlbfs entirely relies on get_unmapped_area() to do that
> > checking) which leads to a kernel BUG() when such areas are torn down.
> 
> Ok, I said I was going to look into a libhugetlbfs testcase for this.
> Doesn't appear there's specifically a testcase for misaligned size -
> I'll add one.
> 
> However, it seems the current kernel, on ppc64, gives a testcase
> failure on 'misaligned_offset', because it's not failing a mapping
> with a non-hugepage aligned file offset.  I'm not sure (yet) if this
> failure is also caused by the new slice code, but it seems a likely
> candidate.

I have written a new test for the handling of misaligned addresses,
lengths and offsets for libhugetlbfs.  With it I've verified that this
patch does correct a serious problem with length handling - without
the patch this new testcase causes an oops for me.  It's simpler than
the 'misaligned_offset' testcase in which the misaligned mapping was
just a step to triggering a different and much more subtle kernel bug
(where the misaligned mapping failed, but corrupted some pagetables in
the process).

But the testcase still fails because a mapping with misaligned offset
still succeeds.  Still don't know if this is related to the same slice
changes or not.  Need to do a bisect, but I'm putting it off because I
have some other bugs to chase.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
