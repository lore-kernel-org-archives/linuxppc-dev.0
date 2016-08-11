Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s96j53LbQzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 22:27:21 +1000 (AEST)
Date: Thu, 11 Aug 2016 14:27:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] perf/core: Fix the mask in perf_output_sample_regs
Message-ID: <20160811122710.GP6879@twins.programming.kicks-ass.net>
References: <1467568918-24377-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467568918-24377-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Sorry, found it in my inbox while clearing out backlog..

On Sun, Jul 03, 2016 at 11:31:58PM +0530, Madhavan Srinivasan wrote:
> When decoding the perf_regs mask in perf_output_sample_regs(),
> we loop through the mask using find_first_bit and find_next_bit functions.
> While the exisitng code works fine in most of the case,
> the logic is broken for 32bit kernel (Big Endian).
> When reading u64 mask using (u32 *)(&val)[0], find_*_bit() assumes it gets
> lower 32bits of u64 but instead gets upper 32bits which is wrong.
> Proposed fix is to swap the words of the u64 to handle this case.

> This is _not_ endianness swap.

But it looks an awful lot like it..

> +++ b/kernel/events/core.c
> @@ -5205,8 +5205,10 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>  			struct pt_regs *regs, u64 mask)
>  {
>  	int bit;
> +	DECLARE_BITMAP(_mask, 64);
>  
> -	for_each_set_bit(bit, (const unsigned long *) &mask,
> +	bitmap_from_u64(_mask, mask);
> +	for_each_set_bit(bit, _mask,
>  			 sizeof(mask) * BITS_PER_BYTE) {
>  		u64 val;

> +++ b/lib/bitmap.c

> +void bitmap_from_u64(unsigned long *dst, u64 mask)
> +{
> +	dst[0] = mask & ULONG_MAX;
> +
> +	if (sizeof(mask) > sizeof(unsigned long))
> +		dst[1] = mask >> 32;
> +}
> +EXPORT_SYMBOL(bitmap_from_u64);

Looks small enough for an inline.

Alternatively you can go all the way and add bitmap_from_u64array(), but
that seems massive overkill.

Tedious stuff.. I can't come up with anything prettier :/
