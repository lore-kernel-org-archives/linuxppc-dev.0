Return-Path: <aarcange@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id AB3602C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 02:17:23 +1000 (EST)
Date: Thu, 16 Aug 2012 18:16:47 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 6/7] mm: make clear_huge_page cache clear only around
 the fault address
Message-ID: <20120816161647.GM11188@redhat.com>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org, Andi Kleen <ak@linux.intel.com>,
 Alex Shi <alex.shu@intel.com>, Robert Richter <robert.richter@amd.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kirill,

On Thu, Aug 16, 2012 at 06:15:53PM +0300, Kirill A. Shutemov wrote:
>  	for (i = 0; i < pages_per_huge_page;
>  	     i++, p = mem_map_next(p, page, i)) {

It may be more optimal to avoid a multiplication/shiftleft before the
add, and to do:

  	for (i = 0, vaddr = haddr; i < pages_per_huge_page;
  	     i++, p = mem_map_next(p, page, i), vaddr += PAGE_SIZE) {

>  		cond_resched();
> -		clear_user_highpage(p, addr + i * PAGE_SIZE);
> +		vaddr = haddr + i*PAGE_SIZE;

Not sure if gcc can optimize it away because of the external calls.

> +		if (!ARCH_HAS_USER_NOCACHE || i == target)
> +			clear_user_highpage(page + i, vaddr);
> +		else
> +			clear_user_highpage_nocache(page + i, vaddr);
>  	}


My only worry overall is if there can be some workload where this may
actually slow down userland if the CPU cache is very large and
userland would access most of the faulted in memory after the first
fault.

So I wouldn't mind to add one more check in addition of
!ARCH_HAS_USER_NOCACHE above to check a runtime sysctl variable. It'll
waste a cacheline yes but I doubt it's measurable compared to the time
it takes to do a >=2M hugepage copy.

Furthermore it would allow people to benchmark its effect without
having to rebuild the kernel themself.

All other patches looks fine to me.

Thanks!
Andrea
