Return-Path: <kas@node.shutemov.name>
Received: from kirsi1.inet.fi (mta-out.inet.fi [195.156.147.13])
 by ozlabs.org (Postfix) with ESMTP id 737E71400BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 04:45:38 +1100 (EST)
Date: Tue, 25 Mar 2014 19:36:05 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
Message-ID: <20140325173605.GA21411@node.dhcp.inet.fi>
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 12:20:15PM +0530, Madhavan Srinivasan wrote:
> Kirill A. Shutemov with the commit 96bacfe542 introduced
> vm_ops->map_pages() for mapping easy accessible pages around
> fault address in hope to reduce number of minor page faults.
> Based on his workload runs, suggested FAULT_AROUND_ORDER
> (knob to control the numbers of pages to map) is 4.
> 
> This patch moves the FAULT_AROUND_ORDER macro to arch/ for
> architecture maintainers to decide on suitable FAULT_AROUND_ORDER
> value based on performance data for that architecture.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable.h |    6 ++++++
>  arch/x86/include/asm/pgtable.h     |    5 +++++
>  include/asm-generic/pgtable.h      |   10 ++++++++++
>  mm/memory.c                        |    2 --
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 3ebb188..9fcbd48 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -19,6 +19,12 @@ struct mm_struct;
>  #endif
>  
>  /*
> + * With a few real world workloads that were run,
> + * the performance data showed that a value of 3 is more advantageous.
> + */
> +#define FAULT_AROUND_ORDER	3
> +
> +/*
>   * We save the slot number & secondary bit in the second half of the
>   * PTE page. We use the 8 bytes per each pte entry.
>   */
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 938ef1d..8387a65 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -7,6 +7,11 @@
>  #include <asm/pgtable_types.h>
>  
>  /*
> + * Based on Kirill's test results, fault around order is set to 4
> + */
> +#define FAULT_AROUND_ORDER 4
> +
> +/*
>   * Macro to mark a page protection value as UC-
>   */
>  #define pgprot_noncached(prot)					\
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 1ec08c1..62f7f07 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -7,6 +7,16 @@
>  #include <linux/mm_types.h>
>  #include <linux/bug.h>
>  
> +
> +/*
> + * Fault around order is a control knob to decide the fault around pages.
> + * Default value is set to 0UL (disabled), but the arch can override it as
> + * desired.
> + */
> +#ifndef FAULT_AROUND_ORDER
> +#define FAULT_AROUND_ORDER	0UL
> +#endif

FAULT_AROUND_ORDER == 0 case should be handled separately in
do_read_fault(): no reason to go to do_fault_around() if we are going to
fault in only one page.

-- 
 Kirill A. Shutemov
