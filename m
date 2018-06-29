Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H1VN3hD4zF1PM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 12:55:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, malat@debian.org,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: fix always true/false warning in slice.c
In-Reply-To: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
References: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
Date: Fri, 29 Jun 2018 12:55:39 +1000
Message-ID: <871scqwbbo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch fixes the following warnings (obtained with make W=1).
>
> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (start < SLICE_LOW_TOP) {

Presumably only on 32-bit ?

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 9530c6db406a..17c57760e06c 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>  			- (1u << GET_LOW_SLICE_INDEX(start));
>  	}
>  
> -	if ((start + len) > SLICE_LOW_TOP) {
> +	if (!slice_addr_is_low(end)) {
>  		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>  		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>  		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;

This worries me.

By casting before the comparison in the helper you squash the compiler
warning, but the code is still broken if (start + len) overflows.

Presumably that "never happens", but it just seems fishy.

The other similar check in that file does:

  if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {

Where SLICE_NUM_HIGH == 0 on 32-bit.


Could we fix the less than comparisons with SLICE_LOW_TOP with something
similar, eg:

	if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {

ie. limit them to the 64-bit code?

cheers
