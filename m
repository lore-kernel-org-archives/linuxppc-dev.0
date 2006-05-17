Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id D282767A04
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 05:59:33 +1000 (EST)
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage
	boundries when needed
From: Eric Paris <eparis@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
	<Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 15:59:24 -0400
Message-Id: <1147895964.26468.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, wli@holomorphy.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 18:42 +0100, Hugh Dickins wrote:
> On Wed, 17 May 2006, Eric Paris wrote:
> > sys_m{,un}lock and do_mlock all align memory references and the length
> > of the mlock given by userspace to page boundaries.  If the page being
> > mlocked is a hugepage instead of a normal page the start and finish of
> > the mlock will still only be aligned to normal page boundaries.
> > Ultimately upon the process exiting we will eventually call unmap_vmas
> > which will call unmap_hugepage_range for all of the ranges.
> > unmap_hugepage_range checks to make sure the beginning and the end of
> > the range are actually hugepage aligned and if not will BUG().  Since we
> > only aligned to a normal page boundary the end of the first range and
> > the beginning of the second will likely (unless userspace passed of
> > values already hugepage aligned) not be hugepage aligned and thus we
> > bomb.
> 
> When did you test this?  It should have been fixed in 2.6.11 onwards
> by split_vma()'s simple:
> 
> 	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
> 		return -EINVAL;
> 
> Hugh

You're right.  My initial BUG() problem was on pre 2.6.11.  I wrote this
patch and tested that it worked on 2.6.16 to allow the test program I
described to run successfully.  Admittedly this is the first time I
tested on unpatched 2.6.16 and as you said the mlock will fail with
"Invalid Argument" instead of BUG().  So the panic is gone post 2.6.11,
but the problem remains.  We still are rounding incorrectly for
hugepages in the sys_mlock and do_mlock functions.

This patch still solves the problem of the kernel currently being more
restrictive on what we accept from userspace for the length of the mlock
if it is a hugepage rather than a regular page.  With a regular page we
will round the value from userspace and happily go about our business of
mlocking.  For a hugepage it just rejects it if userspace doesn't align
it themselves.  This allows the kernel to do the same work for hugepages
that it does for normal pages.

-Eric
