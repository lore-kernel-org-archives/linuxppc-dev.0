Return-Path: <dgibson@ozlabs.org>
Date: Thu, 16 Aug 2007 13:53:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: gregkh@suse.de, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, stable-commits@vger.kernel.org
Subject: Re: patch powerpc-fix-size-check-for-hugetlbfs.patch queued to
	-stable tree
Message-ID: <20070816035325.GA3540@localhost.localdomain>
References: <1186551855.938.164.camel@localhost.localdomain>
	<20070813234218.4796D14540D0@imap.suse.de>
	<20070814064534.GE8791@localhost.localdomain>
	<20070814074833.GG8791@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070814074833.GG8791@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
> I have written a new test for the handling of misaligned addresses,
> lengths and offsets for libhugetlbfs.  With it I've verified that this
> patch does correct a serious problem with length handling - without
> the patch this new testcase causes an oops for me.  It's simpler than
> the 'misaligned_offset' testcase in which the misaligned mapping was
> just a step to triggering a different and much more subtle kernel bug
> (where the misaligned mapping failed, but corrupted some pagetables in
> the process).
> 
> But the testcase still fails because a mapping with misaligned offset
> still succeeds.  Still don't know if this is related to the same slice
> changes or not.  Need to do a bisect, but I'm putting it off because I
> have some other bugs to chase.

Ok, I've identified the cause of the problems with misaligned offset.
It's not with the slice code per se, but it did come in with BenH's
series of get_unmapped_area() reworks leading up to commit
4b1d89290b62bb2db476c94c82cf7442aab440c8.

Prior to that, checking that the pgoff was hugepage aligned was the
responsibility of prepare_hugepage_range().  But after that batch of
patches, prepare_hugepage_range() is only called for non-MAP_FIXED
mappings, hence the bug.

I'm not immediately sure how best to fix this:
	- Replace the prepare_hugepage_range() call for non-FIXED
mappings.  That will mean two different paths making calls to
prepare_hugepage_range(), which is a bit ugly.  Especially since the
call for the non-FIXED case will be for an area that is already
hugepage prepared (on powerpc, the only arch with non-trivial
"preparation" necessary) so we'll just be relying on the fact that
prepare_hugepage_range() is idempotent.
	- Remove the test from prepare_hugepage_range() and instead
put it in each of the hugepage get_unmapped_area() variants.  Removes
the ugliness above, traps the problem reasonably early, keeps the test
for pgoff alignment close to the test for address and length
alignment, but means making the check in each of a half-dozen or so
arch versions of hugetlb_get_unmapped_area()
	- Remove the test from prepare_hugepage_range() and instead
but it in the hugetlbfs ->mmap() callback.  Means the fix goes in one
place only, but it's far removed from the similar tests for address
and length alignment.  Also, the mmap() gets quite a long way in
before we catch the misalignment, and we have to roll-back creating
the vma and so forth.

Thoughts?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
