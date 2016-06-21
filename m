Return-Path: <Yuri.Norov@caviumnetworks.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0085.outbound.protection.outlook.com [157.56.110.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYt7311QVzDqhv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 02:13:02 +1000 (AEST)
Date: Tue, 21 Jun 2016 18:35:31 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Kan Liang <kan.liang@intel.com>, Wang Nan
 <wangnan0@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
Message-ID: <20160621153531.GA32361@yury-N73SV>
References: <1466521000-11329-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1466521000-11329-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 08:26:40PM +0530, Madhavan Srinivasan wrote:
> When decoding the perf_regs mask in regs_dump__printf(),
> we loop through the mask using find_first_bit and find_next_bit functions.
> "mask" is of type "u64", but sent as a "unsigned long *" to
> lib functions along with sizeof().
> 
> While the exisitng code works fine in most of the case,
> the logic is broken when using a 32bit perf on a 64bit kernel (Big Endian).
> When reading u64 using (u32 *)(&val)[0], perf (lib/find_*_bit()) assumes it gets
> lower 32bits of u64 which is wrong. Proposed fix is to swap the words
> of the u64 to handle this case. This is _not_ endianess swap.
> 
> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> Cc: Yury Norov <ynorov@caviumnetworks.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
> Changelog v2:
> 1)Moved the swap code to a common function
> 2)Added more comments in the code
> 
> Changelog v1:
> 1)updated commit message and patch subject
> 2)Add the fix to print_sample_iregs() in builtin-script.c
> 
>  tools/include/linux/bitmap.h |  9 +++++++++

What about include/linux/bitmap.h? I think we'd place it there first.

>  tools/perf/builtin-script.c  | 16 +++++++++++++++-
>  tools/perf/util/session.c    | 16 +++++++++++++++-
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 28f5493da491..79998b26eb04 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -2,6 +2,7 @@
>  #define _PERF_BITOPS_H
>  
>  #include <string.h>
> +#include <limits.h>
>  #include <linux/bitops.h>
>  
>  #define DECLARE_BITMAP(name,bits) \
> @@ -22,6 +23,14 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>  #define small_const_nbits(nbits) \
>  	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
>  
> +static inline void bitmap_from_u64(unsigned long *_mask, u64 mask)

Inline is not required. Some people don't not like it. Underscored parameter in
function declaration is not the best idea as well. Try:
        static void bitmap_from_u64(unsigned long *bitmap, u64 mask)

> +{
> +	_mask[0] = mask & ULONG_MAX;
> +
> +	if (sizeof(mask) > sizeof(unsigned long))
> +		_mask[1] = mask >> 32;
> +}
> +
>  static inline void bitmap_zero(unsigned long *dst, int nbits)
>  {
>  	if (small_const_nbits(nbits))
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e3ce2f34d3ad..73928310fd91 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -412,11 +412,25 @@ static void print_sample_iregs(struct perf_sample *sample,
>  	struct regs_dump *regs = &sample->intr_regs;
>  	uint64_t mask = attr->sample_regs_intr;
>  	unsigned i = 0, r;
> +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];

If we start with it, I think we'd hide declaration machinery as well:

#define DECLARE_L64_BITMAP(__name) unsigned long __name[sizeof(u64)/sizeof(unsigned long)]
or
#define L64_BITMAP_SIZE (sizeof(u64)/sizeof(unsigned long))

Or both :) Whatever you prefer.

>  
>  	if (!regs)
>  		return;
>  
> -	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
> +	/*
> +	 * Since u64 is passed as 'unsigned long *', check
> +	 * to see whether we need to swap words within u64.
> +	 * Reason being, in 32 bit big endian userspace on a
> +	 * 64bit kernel, 'unsigned long' is 32 bits.
> +	 * When reading u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1],
> +	 * we will get wrong value for the mask. This is what
> +	 * find_first_bit() and find_next_bit() is doing.
> +	 * Issue here is "(u32 *)(&val)[0]" gets upper 32 bits of u64,
> +	 * but perf assumes it gets lower 32bits of u64. Hence the check
> +	 * and swap.
> +	 */
> +	bitmap_from_u64(_mask, mask);
> +	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
>  		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
>  	}
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5214974e841a..1337b1c73f82 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -940,8 +940,22 @@ static void branch_stack__printf(struct perf_sample *sample)
>  static void regs_dump__printf(u64 mask, u64 *regs)
>  {
>  	unsigned rid, i = 0;
> +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
>  
> -	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
> +	/*
> +	 * Since u64 is passed as 'unsigned long *', check
> +	 * to see whether we need to swap words within u64.
> +	 * Reason being, in 32 bit big endian userspace on a
> +	 * 64bit kernel, 'unsigned long' is 32 bits.
> +	 * When reading u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1],
> +	 * we will get wrong value for the mask. This is what
> +	 * find_first_bit() and find_next_bit() is doing.
> +	 * Issue here is "(u32 *)(&val)[0]" gets upper 32 bits of u64,
> +	 * but perf assumes it gets lower 32bits of u64. Hence the check
> +	 * and swap.
> +	 */

Identical comments... I'd prefer to see it in commit message, or
better in function description. For me it's pretty straightforward in
understanding what happens here in-place without comments.

> +	bitmap_from_u64(_mask, mask);
> +	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
>  		u64 val = regs[i++];
>  
>  		printf(".... %-5s 0x%" PRIx64 "\n",
> -- 
> 1.9.1
