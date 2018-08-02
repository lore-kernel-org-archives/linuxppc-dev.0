Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h4fP5hjYzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 19:30:37 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: fix always true/false warning in slice.c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, malat@debian.org,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
 <871scqwbbo.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1f090f15-eda3-90b1-2aab-ac73d9abb550@c-s.fr>
Date: Thu, 2 Aug 2018 09:30:31 +0000
MIME-Version: 1.0
In-Reply-To: <871scqwbbo.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/29/2018 02:55 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> This patch fixes the following warnings (obtained with make W=1).
>>
>> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
>> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (start < SLICE_LOW_TOP) {
> 
> Presumably only on 32-bit ?

Sure

> 
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 9530c6db406a..17c57760e06c 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>   			- (1u << GET_LOW_SLICE_INDEX(start));
>>   	}
>>   
>> -	if ((start + len) > SLICE_LOW_TOP) {
>> +	if (!slice_addr_is_low(end)) {
>>   		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>>   		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>>   		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> 
> This worries me.

I'll change it in v2 to:
  	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {


> 
> By casting before the comparison in the helper you squash the compiler
> warning, but the code is still broken if (start + len) overflows.
> 
> Presumably that "never happens", but it just seems fishy.
> 
> The other similar check in that file does:
> 
>    if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
> 
> Where SLICE_NUM_HIGH == 0 on 32-bit.
> 
> 
> Could we fix the less than comparisons with SLICE_LOW_TOP with something
> similar, eg:
> 
> 	if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {
> 
> ie. limit them to the 64-bit code?

That's not enough to make GCC happy:

arch/powerpc/mm/slice.c: In function ‘slice_range_to_mask’:
arch/powerpc/mm/slice.c:74:31: error: comparison is always true due to 
limited range of data type [-Werror=type-limits]
   if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {

Christophe


> 
> cheers
> 
