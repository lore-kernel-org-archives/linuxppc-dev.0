Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA5C42C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 15:08:12 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 09:38:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 50C2B3940048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 09:38:04 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2747uhx56295504
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 09:37:56 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s27483vB022785
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 09:38:03 +0530
Message-ID: <531945D1.7010503@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 09:36:41 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC/RFT v3 6/9] powerpc: move cacheinfo sysfs to generic
 cacheinfo infrastructure
References: <1392825976-17633-1-git-send-email-sudeep.holla@arm.com>
 <1392825976-17633-7-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1392825976-17633-7-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/19/2014 09:36 PM, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> This patch removes the redundant sysfs cacheinfo code by making use of
> the newly introduced generic cacheinfo infrastructure.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/cacheinfo.c | 831 ++++++----------------------------------
>  arch/powerpc/kernel/cacheinfo.h |   8 -
>  arch/powerpc/kernel/sysfs.c     |   4 -
>  3 files changed, 109 insertions(+), 734 deletions(-)
>  delete mode 100644 arch/powerpc/kernel/cacheinfo.h
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index 2912b87..05b7580 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -10,38 +10,10 @@
>   * 2 as published by the Free Software Foundation.
>   */
> 
> +#include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
> -#include <linux/cpumask.h>
>  #include <linux/kernel.h>
> -#include <linux/kobject.h>
> -#include <linux/list.h>
> -#include <linux/notifier.h>
>  #include <linux/of.h>
> -#include <linux/percpu.h>
> -#include <linux/slab.h>
> -#include <asm/prom.h>
> -
> -#include "cacheinfo.h"
> -
> -/* per-cpu object for tracking:
> - * - a "cache" kobject for the top-level directory
> - * - a list of "index" objects representing the cpu's local cache hierarchy
> - */
> -struct cache_dir {
> -	struct kobject *kobj; /* bare (not embedded) kobject for cache
> -			       * directory */
> -	struct cache_index_dir *index; /* list of index objects */
> -};
> -
> -/* "index" object: each cpu's cache directory has an index
> - * subdirectory corresponding to a cache object associated with the
> - * cpu.  This object's lifetime is managed via the embedded kobject.
> - */
> -struct cache_index_dir {
> -	struct kobject kobj;
> -	struct cache_index_dir *next; /* next index in parent directory */
> -	struct cache *cache;
> -};
> 
>  /* Template for determining which OF properties to query for a given
>   * cache type */
> @@ -60,11 +32,6 @@ struct cache_type_info {
>  	const char *nr_sets_prop;
>  };
> 
> -/* These are used to index the cache_type_info array. */
> -#define CACHE_TYPE_UNIFIED     0
> -#define CACHE_TYPE_INSTRUCTION 1
> -#define CACHE_TYPE_DATA        2
> -
>  static const struct cache_type_info cache_type_info[] = {
>  	{
>  		/* PowerPC Processor binding says the [di]-cache-*
> @@ -77,246 +44,115 @@ static const struct cache_type_info cache_type_info[] = {
>  		.nr_sets_prop    = "d-cache-sets",
>  	},
>  	{
> -		.name            = "Instruction",
> -		.size_prop       = "i-cache-size",
> -		.line_size_props = { "i-cache-line-size",
> -				     "i-cache-block-size", },
> -		.nr_sets_prop    = "i-cache-sets",
> -	},
> -	{
>  		.name            = "Data",
>  		.size_prop       = "d-cache-size",
>  		.line_size_props = { "d-cache-line-size",
>  				     "d-cache-block-size", },
>  		.nr_sets_prop    = "d-cache-sets",
>  	},
> +	{
> +		.name            = "Instruction",
> +		.size_prop       = "i-cache-size",
> +		.line_size_props = { "i-cache-line-size",
> +				     "i-cache-block-size", },
> +		.nr_sets_prop    = "i-cache-sets",
> +	},
>  };


Hey Sudeep,

After applying this patch, the cache_type_info array looks like this.

static const struct cache_type_info cache_type_info[] = {
        {
                /* 
                 * PowerPC Processor binding says the [di]-cache-*
                 * must be equal on unified caches, so just use
                 * d-cache properties.
                 */
                .name            = "Unified",
                .size_prop       = "d-cache-size",
                .line_size_props = { "d-cache-line-size",
                                     "d-cache-block-size", },
                .nr_sets_prop    = "d-cache-sets",
        },
        {
                .name            = "Data",
                .size_prop       = "d-cache-size",
                .line_size_props = { "d-cache-line-size",
                                     "d-cache-block-size", },
                .nr_sets_prop    = "d-cache-sets",
        },
        {
                .name            = "Instruction",
                .size_prop       = "i-cache-size",
                .line_size_props = { "i-cache-line-size",
                                     "i-cache-block-size", },
                .nr_sets_prop    = "i-cache-sets",
        },
};

and this function computes the the array index for any given cache type
define for PowerPC.

static inline int get_cacheinfo_idx(enum cache_type type)
{
        if (type == CACHE_TYPE_UNIFIED)
                return 0;
        else
                return type;
}

These types are define in include/linux/cacheinfo.h as

enum cache_type {
        CACHE_TYPE_NOCACHE = 0,
        CACHE_TYPE_INST = BIT(0),		---> 1
        CACHE_TYPE_DATA = BIT(1),		---> 2
        CACHE_TYPE_SEPARATE = CACHE_TYPE_INST | CACHE_TYPE_DATA,
        CACHE_TYPE_UNIFIED = BIT(2),
};

When it is UNIFIED we return index 0, which is correct. But the index
for instruction and data cache seems to be swapped which wrong. This
will fetch invalid properties for any given cache type.

I have done some initial review and testing for this patch's impact on
PowerPC (ppc64 POWER specifically). I am trying to do some code clean-up
and re-arrangements. Will post out soon. Thanks !

Regards
Anshuman
