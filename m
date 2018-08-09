Return-Path: <rashmicy@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mBQD2qYDzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 12:04:16 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id j8-v6so1826261pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 19:04:16 -0700 (PDT)
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
From: rashmica <rashmicy@gmail.com>
Message-ID: <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
Date: Thu, 9 Aug 2018 12:04:07 +1000
MIME-Version: 1.0
In-Reply-To: <87mutxb9qy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/08/18 17:25, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>> index 3f415d8101f3..626f580b4ff7 100644
>> --- a/lib/test_hexdump.c
>> +++ b/lib/test_hexdump.c
>> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>>  	"d14c", "9919", "b143", "0caf",
>>  };
>>  
>> +static const char * const test_data_2_be[] __initconst = {
>> +	"be32", "db7b", "0a18", "93b2",
>> +	"70ba", "c424", "7d83", "349b",
>> +	"a69c", "31ad", "9c0f", "ace9",
>> +	"4cd1", "1999", "43b1", "af0c",
>> +};
>> +
>>  static const char * const test_data_4_le[] __initconst = {
>>  	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>>  	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>>  };
>>  
>> +static const char * const test_data_4_be[] __initconst = {
>> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
>> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
>> +};
>> +
> Is there a reason we can't do it all at compile time?

mpe I sent a patch doing that awhile ago and you obviously didn't like
it because you never merged it :P
http://patchwork.ozlabs.org/patch/620405/ I prefer this version because
of the IS_ENABLED



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
