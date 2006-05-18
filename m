Return-Path: <hugh_dickins@symantec.com>
Received: from gold.veritas.com (gold.veritas.com [143.127.12.110])
	by ozlabs.org (Postfix) with ESMTP id A642667A65
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 21:13:56 +1000 (EST)
Date: Thu, 18 May 2006 12:13:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
	when needed
In-Reply-To: <1147895964.26468.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605181151120.6559@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
	<Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
	<1147895964.26468.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 17 May 2006, Eric Paris wrote:
> 
> This patch still solves the problem of the kernel currently being more
> restrictive on what we accept from userspace for the length of the mlock
> if it is a hugepage rather than a regular page.  With a regular page we
> will round the value from userspace and happily go about our business of
> mlocking.  For a hugepage it just rejects it if userspace doesn't align
> it themselves.  This allows the kernel to do the same work for hugepages
> that it does for normal pages.

You do have a point that there's an inconsistency there.  But we could
argue a long time what's inconsistent with what - I'd say it's mlock
being inconsistent with mprotect, munmap, msync, madvise, etc.  I
don't see an outright reason to change from the current behaviour.

You do realize that there's almost no point in mlocking a hugepage area
anyway?  (I wrote that first without the "almost", but now with hugepage
faulting, it does provide another way to fault in all the pages at once.)

Hugh
