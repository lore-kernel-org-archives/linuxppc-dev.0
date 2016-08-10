Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Rth5T0zzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:18:20 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: Remove one insn in __bswapdi2
To: Gabriel Paubert <paubert@iram.es>
References: <20160805112803.36D3B1A2399@localhost.localdomain>
 <20160810085605.GB2117@visitor2.iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1b899394-8df6-ac9b-c65e-ce71dbe96b1d@c-s.fr>
Date: Wed, 10 Aug 2016 12:18:15 +0200
MIME-Version: 1.0
In-Reply-To: <20160810085605.GB2117@visitor2.iram.es>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/08/2016 à 10:56, Gabriel Paubert a écrit :
> On Fri, Aug 05, 2016 at 01:28:02PM +0200, Christophe Leroy wrote:
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/misc_32.S | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
>> index e025230..e18055c 100644
>> --- a/arch/powerpc/kernel/misc_32.S
>> +++ b/arch/powerpc/kernel/misc_32.S
>> @@ -578,9 +578,8 @@ _GLOBAL(__bswapdi2)
>>  	rlwimi  r9,r4,24,0,7
>>  	rlwimi  r10,r3,24,0,7
>>  	rlwimi  r9,r4,24,16,23
>> -	rlwimi  r10,r3,24,16,23
>> +	rlwimi  r4,r3,24,16,23
>>  	mr      r3,r9
>> -	mr      r4,r10
>>  	blr
>>
>
> Hmmm, are you sure that it works? rlwimi is a bit special since the
> first operand is both an input and an output of the instruction.
>
>

Oops, you are right ...
