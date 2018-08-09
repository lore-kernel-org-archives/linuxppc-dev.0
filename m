Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mJ316bK3zDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 16:18:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: rashmica <rashmicy@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
In-Reply-To: <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
 <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
Date: Thu, 09 Aug 2018 16:18:04 +1000
Message-ID: <87ftzo9i77.fsf@concordia.ellerman.id.au>
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

rashmica <rashmicy@gmail.com> writes:
> On 08/08/18 17:25, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>>> index 3f415d8101f3..626f580b4ff7 100644
>>> --- a/lib/test_hexdump.c
>>> +++ b/lib/test_hexdump.c
>>> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>>>  	"d14c", "9919", "b143", "0caf",
>>>  };
>>>  
>>> +static const char * const test_data_2_be[] __initconst = {
>>> +	"be32", "db7b", "0a18", "93b2",
>>> +	"70ba", "c424", "7d83", "349b",
>>> +	"a69c", "31ad", "9c0f", "ace9",
>>> +	"4cd1", "1999", "43b1", "af0c",
>>> +};
>>> +
>>>  static const char * const test_data_4_le[] __initconst = {
>>>  	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>>>  	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>>>  };
>>>  
>>> +static const char * const test_data_4_be[] __initconst = {
>>> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
>>> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
>>> +};
>>> +
>> Is there a reason we can't do it all at compile time?
>
> mpe I sent a patch doing that awhile ago and you obviously didn't like
> it because you never merged it :P

Sorry, I wasn't sure who should merge it, and never followed up.

cheers
