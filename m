Return-Path: <hugh_dickins@symantec.com>
Received: from silver.veritas.com (silver.veritas.com [143.127.12.111])
	by ozlabs.org (Postfix) with ESMTP id AA548679F2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 03:52:40 +1000 (EST)
Date: Wed, 17 May 2006 18:42:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
	when needed
In-Reply-To: <1147885316.26468.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
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
> sys_m{,un}lock and do_mlock all align memory references and the length
> of the mlock given by userspace to page boundaries.  If the page being
> mlocked is a hugepage instead of a normal page the start and finish of
> the mlock will still only be aligned to normal page boundaries.
> Ultimately upon the process exiting we will eventually call unmap_vmas
> which will call unmap_hugepage_range for all of the ranges.
> unmap_hugepage_range checks to make sure the beginning and the end of
> the range are actually hugepage aligned and if not will BUG().  Since we
> only aligned to a normal page boundary the end of the first range and
> the beginning of the second will likely (unless userspace passed of
> values already hugepage aligned) not be hugepage aligned and thus we
> bomb.

When did you test this?  It should have been fixed in 2.6.11 onwards
by split_vma()'s simple:

	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
		return -EINVAL;

Hugh
