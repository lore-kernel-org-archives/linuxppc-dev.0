Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7287CDDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 18:42:43 +1000 (EST)
Date: Wed, 30 Jul 2008 01:41:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Munson <ebmunson@us.ibm.com>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-Id: <20080730014139.39b3edc5.akpm@linux-foundation.org>
In-Reply-To: <cover.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 12:17:10 -0700 Eric Munson <ebmunson@us.ibm.com> wrote:

> Certain workloads benefit if their data or text segments are backed by
> huge pages. The stack is no exception to this rule but there is no
> mechanism currently that allows the backing of a stack reliably with
> huge pages.  Doing this from userspace is excessively messy and has some
> awkward restrictions.  Particularly on POWER where 256MB of address space
> gets wasted if the stack is setup there.
> 
> This patch stack introduces a personality flag that indicates the kernel
> should setup the stack as a hugetlbfs-backed region. A userspace utility
> may set this flag then exec a process whose stack is to be backed by
> hugetlb pages.
> 
> Eric Munson (5):
>   Align stack boundaries based on personality
>   Add shared and reservation control to hugetlb_file_setup
>   Split boundary checking from body of do_munmap
>   Build hugetlb backed process stacks
>   [PPC] Setup stack memory segment for hugetlb pages
> 
>  arch/powerpc/mm/hugetlbpage.c |    6 +
>  arch/powerpc/mm/slice.c       |   11 ++
>  fs/exec.c                     |  209 ++++++++++++++++++++++++++++++++++++++---
>  fs/hugetlbfs/inode.c          |   52 +++++++----
>  include/asm-powerpc/hugetlb.h |    3 +
>  include/linux/hugetlb.h       |   22 ++++-
>  include/linux/mm.h            |    1 +
>  include/linux/personality.h   |    3 +
>  ipc/shm.c                     |    2 +-
>  mm/mmap.c                     |   11 ++-
>  10 files changed, 284 insertions(+), 36 deletions(-)

That all looks surprisingly straightforward.

Might there exist an x86 port which people can play with?
