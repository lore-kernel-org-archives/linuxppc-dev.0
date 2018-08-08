Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lk1H2N6XzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 17:44:34 +1000 (AEST)
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1690d8af-3e67-e82b-ef2a-8adee6eaa497@c-s.fr>
Date: Wed, 8 Aug 2018 09:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <87mutxb9qy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/08/2018 à 09:25, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>> index 3f415d8101f3..626f580b4ff7 100644
>> --- a/lib/test_hexdump.c
>> +++ b/lib/test_hexdump.c
>> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>>   	"d14c", "9919", "b143", "0caf",
>>   };
>>   
>> +static const char * const test_data_2_be[] __initconst = {
>> +	"be32", "db7b", "0a18", "93b2",
>> +	"70ba", "c424", "7d83", "349b",
>> +	"a69c", "31ad", "9c0f", "ace9",
>> +	"4cd1", "1999", "43b1", "af0c",
>> +};
>> +
>>   static const char * const test_data_4_le[] __initconst = {
>>   	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>>   	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>>   };
>>   
>> +static const char * const test_data_4_be[] __initconst = {
>> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
>> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
>> +};
>> +
> 
> Is there a reason we can't do it all at compile time?

Codyingstyle suggests to use IS_ENABLED() as much as possible.
I checked symbols inside resulting vmlinux, only the BE ones are there 
so it has
the same effect as an #ifdef

Extract from Documentation/process/codying-style.rst:

Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
symbol into a C boolean expression, and use it in a normal C conditional:

.. code-block:: c

	if (IS_ENABLED(CONFIG_SOMETHING)) {
		...
	}

The compiler will constant-fold the conditional away, and include or exclude
the block of code just as with an #ifdef, so this will not add any runtime
overhead.  However, this approach still allows the C compiler to see the 
code
inside the block, and check it for correctness (syntax, types, symbol
references, etc).  Thus, you still have to use an #ifdef if the code 
inside the
block references symbols that will not exist if the condition is not met.

Christophe

> 
> eg:
> 
> static const char * const test_data_4[] __initconst = {
> #ifdef CONFIG_CPU_LITTLE_ENDIAN
> 	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> 	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
> #else
> 	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
> 	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
> #endif
> };
> 
> 
> cheers
> 
