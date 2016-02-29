Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 8683E1A0E5B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 18:26:45 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 8/9] powerpc: simplify csum_add(a, b) in case a or b is
 constant 0
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
 <5549ecca2c921f34d076c47b5e2a91a3e78b20a7.1442876807.git.christophe.leroy@c-s.fr>
 <1445571207.701.152.camel@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Message-ID: <56D3F2B2.1040907@c-s.fr>
Date: Mon, 29 Feb 2016 08:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <1445571207.701.152.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/10/2015 05:33, Scott Wood a écrit :
> On Tue, 2015-09-22 at 16:34 +0200, Christophe Leroy wrote:
>> Simplify csum_add(a, b) in case a or b is constant 0
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/checksum.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/checksum.h
>> b/arch/powerpc/include/asm/checksum.h
>> index 56deea8..f8a9704 100644
>> --- a/arch/powerpc/include/asm/checksum.h
>> +++ b/arch/powerpc/include/asm/checksum.h
>> @@ -119,7 +119,13 @@ static inline __wsum csum_add(__wsum csum, __wsum
>> addend)
>>   {
>>   #ifdef __powerpc64__
>>        u64 res = (__force u64)csum;
>> +#endif
>> +     if (__builtin_constant_p(csum) && csum == 0)
>> +             return addend;
>> +     if (__builtin_constant_p(addend) && addend == 0)
>> +             return csum;
>>
>> +#ifdef __powerpc64__
>>        res += (__force u64)addend;
>>        return (__force __wsum)((u32)res + (res >> 32));
>>   #else
> How often does this happen?
>
>
In the following patch (9/9), csum_add() is used to implement 
csum_partial() for small blocks.
In several places in the networking code, csum_partial() is called with 
0 as initial sum.

Christophe
